close all
clear all
%%%%%%%%%Raw Data%%%%%%%%%%%%%%%

raw=nirs.io.loadNIRx('C:\Users\NIRScout_User\Desktop\Sending Ted\Raw Data')
tbl_onset=nirs.createStimulusTable(raw);
tbl_onset= ChangeOnset(tbl_onset)
job=nirs.modules.ChangeStimulusInfo;
job.ChangeTable=tbl_onset;

raw.draw(1)

%% this would do the same stim timing changes
job = nirs.modules.RemoveStimGaps;
job.maxDuration=2;  % remove any events closer then 2s
raw2=job.run(raw);
raw2=nirs.design.change_stimulus_duration(raw2,'channel_1',12);
raw2=nirs.design.change_stimulus_duration(raw2,'channel_2',15);
raw2=nirs.design.change_stimulus_duration(raw2,'channel_3',12);
raw2=nirs.design.change_stimulus_duration(raw2,'channel_4',15);

% note, I didn't spend the time to figure out exactly what yours shifts 
% and durations are, but you get the idea. 
raw2=nirs.design.shift_stimulus_onset(raw2,'channel_1',-0.025);
raw2=nirs.design.shift_stimulus_onset(raw2,'channel_2',-2);
raw2=nirs.design.shift_stimulus_onset(raw2,'channel_3',-3);
raw2=nirs.design.shift_stimulus_onset(raw2,'channel_4',-0.025);


figure;raw.probe.draw

% so, the probe is already in 3D (its a class nirs.core.probe1020).  By
% default, it will draw in 2D, but you change the default behavior using 
raw.probe.defaultdrawfcn = '10-20';
% -or-
raw.probe.defaultdrawfcn = '3D mesh (superior)';
figure;raw.probe.draw


% Phoebe does not store wavelength in their SD variable. Supply it to
% overwrite the default 690/850
probe1020=nirs.util.phoebe2toolbox('PHOEBE.SD',[760 850]);
probe1020.defaultdrawfcn = '3D mesh (superior)';
%raw.probe=probe1020;
% I liked the NIRx head a bit more then the Pheobe one, but it could be
% that my code needs a bit of work.  This is only the 3rd example of pheobe
% data that I have encountered.

%%%%%%%%%preprocessing%%%%%%%%%%%%%%%%
job = nirs.modules.OpticalDensity;
job = nirs.modules.BeerLambertLaw(job);
job=nirs.modules.ChangeStimulusInfo(job);
job.ChangeTable=tbl_onset;
hb = job.run(raw);
job=nirs.modules.RenameStims;
job.listOfChanges={'channel_1'  'Synchronization_Pacing';'channel_3'  'Synchronization_Cont';'channel_2' 'Synchopation_Pacing';'channel_4' 'Synchopation_Cont'};
hb = job.run(hb);
figure;hb.draw
%%%%%%%%%%Subject Level%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
job = nirs.modules.GLM;
job.type='AR-IRLS';
ARStats=job.run(hb);

% the probe will inhierit the draw orientation from the "raw" variable
%ARStats.probe.defaultdrawfcn='3D mesh';

% This bit of code doesn't actually do anything. It just drawing the
% canonical HRF shape
bas=nirs.design.basis.Canonical
figure; bas.draw



%% If you wanted to do an HRF-deconvolution, you could do this
bas = nirs.design.basis.FIR;
bas.isIRF=true;  % this will convolve the FIR model with the duration of the task.  
% otherwise, you are estimating the whole response window
bas.nbins='16s';  % you can specify nbins as a number or in seconds (string with "s")
job = nirs.modules.Resample;
job.Fs=0.5;  % note the GLM runs like O(N^2) so this will be ~64x faster
job = nirs.modules.GLM(job);
job.basis('default')=bas;

ARStatsFIR=job.run(hb);

HRF=ARStatsFIR.HRF('tstat');  % this is now the full deconvolution model
ARStatsFIR.ttest('Synchronization_Pacing[6:12s]').draw;  % this draws the stats over a window of time
ARStatsFIR.ttest('Synchronization_Pacing[canonical]').draw; 

%% 

ARStats.draw('tstat',[],'p<0.05')

figure;ARStats.draw('beta',[],'p<0.05');

% you can return the response as a time-course using the "HRF" function
HRF = ARStats.HRF;
% or 
HRF = ARStats.HRF('tstat');  % this uses the tstat instead of beta to draw the HRF.

% this will draw the HRF according to the probe layout
lines=nirs.viz.plot2D(HRF);
% I found the lines to be too crowded on your probe, so this
% makes the lines all thinner.
set(vertcat(lines{:}),'linewidth',1);
% you can also use
% lines=nirs.viz.plot2D(HRF,false,true);  
% to draw all the conditions in one plot, but too crowded

r1=ARStats.ttest('Synchronization_Pacing-Synchronization_Cont')
r2=ARStats.ttest('Synchronization_Cont-Synchronization_Pacing')
r3=ARStats.ttest('Synchopation_Pacing-Synchopation_Cont')
r4=ARStats.ttest('Synchopation_Cont-Synchopation_Pacing')

figure;r1.draw('tstat',[],'p<0.05')
figure;r2.draw('tstat',[],'p<0.05')
figure;r3.draw('tstat',[],'p<0.05')
figure;r4.draw('tstat',[],'p<0.05')

