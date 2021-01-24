%%%%%%%%%%Group Level%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
raw=nirs.io.loadDirectory('data',{'group','subject'});
demo=readtable(fullfile('data','demographics.xlsx'));
Gtbl_onset=nirs.createStimulusTable(raw);
%Gtbl_onset= GonsetdataChange_diffIntervalonset(Gtbl_onset)
%Gtbl_onset= GonsetdataChange_SameOnset_diff_Interval(Gtbl_onset)
Gtbl_onset= GLeveltbl_onset_EEGfNIRS(Gtbl_onset)%fNIRSEEG onset stimulus
Gtbl_onset1=Gtbl_onset;
Gtbl_onset= GLeveltbl_onset_MRIfNIRS(Gtbl_onset)%fNIRSEEG onset stimulus 
Gtbl_onset2=Gtbl_onset;
%Gtbl_onset= GonsetdataChange_SameInterval_diff_Onset(Gtbl_onset)
job=nirs.modules.ChangeStimulusInfo;
job.ChangeTable=Gtbl_onset;
job=nirs.modules.AddDemographics
job.demoTable=demo
%job.run(raw);

raw.draw
%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
job = nirs.modules.OpticalDensity;
job = nirs.modules.BeerLambertLaw(job);
job=nirs.modules.ChangeStimulusInfo(job);
job.ChangeTable=Gtbl_onset;
hb = job.run(raw);
job=nirs.modules.RenameStims;
job.listOfChanges={'channel_1'  'Synchronization_Pacing_Block-Design';'channel_3'  'Synchronization_Continuation_Block-Design';'channel_2' 'Syncopation_Pacing_Block-Design';'channel_4' 'Syncopation_Continuation_Block-Design';'channel_5'  'Synchronization_Pacing_Alternating-Design';'channel_7'  'Synchronization_Continuation_Alternating-Design';'channel_6' 'Syncopation_Pacing_Alternating-Design';'channel_8' 'Syncopation_Continuation_Alternating-Design'};
hb_with_demo=job.run(hb)
%figure;hb_with_demo.draw
%%%%%%%%%%1) Canonical HRF%%%%%%%%%%%
job = nirs.modules.GLM;
job.type='AR-IRLS'
ARStats=job.run(hb_with_demo)
%ARStats.draw('tstat',[],'p<0.05')
 
%%%%%%probe info Standard 10-10%%%%%
%probe.defaultdrawfcn = '3D mesh (superior)';
ARStats.probe.defaultdrawfcn = '3D mesh (superior)';
figure;raw.probe.draw
% probe=nirs.util.phoebe2toolbox('1_EA_Test.SD',[760 850]);
ARStats(1).probe.defaultdrawfcn='3D mesh (superior)';
%   
% probe=nirs.util.phoebe2toolbox('2_Ashi_Test.SD',[760 850]);
ARStats(2).probe.defaultdrawfcn='3D mesh (superior)';
% 
% probe=nirs.util.phoebe2toolbox('3_69493.SD',[760 850]);
ARStats(3).probe.defaultdrawfcn='3D mesh (superior)'
%   
% probe=nirs.util.phoebe2toolbox('4_66820.SD',[760 850]);
ARStats(4).probe.defaultdrawfcn='3D mesh (superior)'
% 
% probe=nirs.util.phoebe2toolbox('5_69199.SD',[760 850]);
ARStats(5).probe.defaultdrawfcn='3D mesh (superior)'
% 
% probe=nirs.util.phoebe2toolbox('6_70015.SD',[760 850]);
ARStats(6).probe.defaultdrawfcn='3D mesh (superior)'
% 
% probe=nirs.util.phoebe2toolbox('7_62971.SD',[760 850]);
ARStats(7).probe.defaultdrawfcn='3D mesh (superior)'
% 
% probe=nirs.util.phoebe2toolbox('8_56578.SD',[760 850]);
ARStats(8).probe.defaultdrawfcn='3D mesh (superior)'
% 
% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(9).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(10).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(11).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(12).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(13).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(14).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(15).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(16).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(17).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(18).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(19).probe.defaultdrawfcn='3D mesh (superior)'

% probe=nirs.util.phoebe2toolbox('9_56515.SD',[760 850]);
ARStats(20).probe.defaultdrawfcn='3D mesh (superior)'


%%%%%%%%%%%%%%%%
%% 2) If you wanted to do an HRF-deconvolution, you could do this
bas = nirs.design.basis.FIR;
bas.isIRF=true;  % this will convolve the FIR model with the duration of the task.  
% otherwise, you are estimating the whole response window
bas.nbins='16s';  % you can specify nbins as a number or in seconds (string with "s")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

job = nirs.modules.Resample;
job.Fs=0.5;  % note the GLM runs like O(N^2) so this will be ~64x faster
job=nirs.modules.MixedEffects;
job.formula='beta~-1+group:cond+(1|subject)'
%job = nirs.modules.GLM(job);
%StatsFIR=job.run(hb_with_demo);
%?job.basis('default')=bas;
GroupStats_fixed=job.run(ARStats);

HRF=GroupStats_fixed.HRF('tstat');  % this is now the full deconvolution model
%%
%%%%%%%%%%%%%%
GroupStats_fixed.draw('tstat',[],'q<0.05')
GroupStats_fixed.draw('beta',[],'q<0.05')
%%%%%%

%GroupStats_fixed.probe.defaultdrawfcn='10-20';
%GroupStats_fixed.draw
%GroupStats_1=GroupStats_fixed.ttest('Synchronization_Pacing')
%GroupStats_1.draw
%GroupStats_2=GroupStats_fixed.ttest('Synchronization_Continuation')
%GroupStats_2.draw
%GroupStats_3=GroupStats_fixed.ttest('Syncopation_Pacing')
%GroupStats_3.draw
%GroupStats_4=GroupStats_fixed.ttest('Syncopation_Continuation')
%GroupStats_4.draw
%ARStatsFIR.ttest('Synchronization_Pacing[6:12s]').draw;  % this draws the stats over a window of time
%ARStatsFIR.ttest('Synchronization_Pacing[canonical]').draw; 
%ARStatsFIR.ttest('Syncopation_Pacing[canonical]').draw; 
%ARStatsFIR.ttest('Synchronization_Continuation[canonical]').draw; 
%ARStatsFIR.ttest('Syncopation_Continuation[canonical]').draw; 
lines=nirs.viz.plot2D(HRF);
% I found the lines to be too crowded on your probe, so this
% makes the lines all thinner.
set(vertcat(lines{:}),'linewidth',1);
% you can also use
% lines=nirs.viz.plot2D(HRF,false,true);  
% to draw all the conditions in one plot, but too crowded


r1=GroupStats_fixed.ttest('Synchronization_Continuation-Synchronization_Pacing');
r2=GroupStats_fixed.ttest('Synchronization_Continuation:group_Block-Design-Synchronization_Continuation:group_Alternating-Design');
r3=GroupStats_fixed.ttest('Syncopation_Continuation-Syncopation_Pacing');
%r4=GroupStats_fixed.ttest('Syncopation_Continuation-Syncopation_Pacing'); 
figure;r1.draw('tstat',[],'p<0.05')
figure;r2.draw('tstat',[],'p<0.05')
figure;r3.draw('tstat',[],'p<0.05')
%figure;r4.draw('tstat',[],'p<0.05')

%r5=GroupStats_fixed.ttest('Synchronization_Pacing-Syncopation_Pacing');
r6=GroupStats_fixed.ttest('Syncopation_Pacing-Synchronization_Pacing');
%r7=GroupStats_fixed.ttest('Synchronization_Continuation-Syncopation_Continuation');
r8=GroupStats_fixed.ttest('Syncopation_Continuation-Synchronization_Continuation'); 
figure;r6.draw('tstat',[],'p<0.05')
%figure;r6.draw('tstat',[],'p<0.05')
figure;r8.draw('tstat',[],'p<0.05')
%figure;r8.draw('tstat',[],'p<0.05')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Image Reconstruction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-1' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-2' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-3' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-4' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-5' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-6' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-7' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-8' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-9' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

probe = nirs.registration.atlasview2probe1020([pwd filesep 'Subj-10' filesep 'atlasViewer.mat']);
mesh_atlasviewer = probe.getmesh;

% These next two lines peel off the scalp and preserves the fiducials for registration 
mesh_atlasviewer(2).fiducials = mesh_atlasviewer(1).fiducials;
mesh_atlasviewer = mesh_atlasviewer(2);

% This registers the AtlasViewer mesh to the original 1020 probe
GroupStats_fixed.probe = GroupStats_fixed.probe.register_mesh2probe(mesh_atlasviewer);
% Redraw stats using the AtlasViewer mesh
GroupStats_fixed.draw('tstat',[],'p<0.05')

close all;
GroupStats_fixed.draw('tstat',[],'p<0.05');

figure;GroupStats_fixed.draw('beta',[],'p<0.05');

% you can return the response as a time-course using the "HRF" function
HRF = GroupStats_fixed.HRF;
% or 
HRF = GroupStats_fixed.HRF('tstat');  % this uses the tstat instead of beta to draw the HRF.

% this will draw the HRF according to the probe layout
lines=nirs.viz.plot2D(HRF);
% I found the lines to be too crowded on your probe, so this
% makes the lines all thinner.
set(vertcat(lines{:}),'linewidth',1);
% you can also use
% lines=nirs.viz.plot2D(HRF,false,true);  
% to draw all the conditions in one plot, but too crowded

r1=GroupStats_fixed.ttest('Synchronization_Pacing-Synchronization_Cont')
r2=GroupStats_fixed.ttest('Synchronization_Cont-Synchronization_Pacing')
r3=GroupStats_fixed.ttest('Syncopation_Pacing-Syncopation_Cont')
r4=GroupStats_fixed.ttest('Syncopation_Cont-Syncopation_Pacing')

figure;r1.draw('tstat',[],'p<0.05')
figure;r2.draw('tstat',[],'p<0.05')
figure;r3.draw('tstat',[],'p<0.05')
figure;r4.draw('tstat',[],'p<0.05')


%% Image reconstruction

% First, create a montage folder using NIRx NIRSITE 2.0, and save
% everything that it offers

% Then, create files to be read by AtlasViewer
nirs.util.nirsite2atlasviewer('C:\Users\NIRScout_User\Desktop\NIRS_Toolbox\EEGfNIRS_Data\Subj-10\MontageFingertapping')

% Then, run AtlasViewer and generate mesh and Jacobian

% Convert AtlasViwer output into fNIRS toolbox
nirs.util.atlasviewer2toolbox('C:\Users\NIRScout_User\Desktop\NIRS_Toolbox\EEGfNIRS_Data\Subj-10\MontageFingertapping')

% Load the forward model
[Jacobian, mesh, probe] = nirs.io.loadSensDotMat(['C:\Users\NIRScout_User\Desktop\NIRS_Toolbox\EEGfNIRS_Data\Subj-10\MontageFingertapping\atlasViewer_analyzir.mat']);

% Reconstruction job
j = nirs.modules.ImageReconMFX();
j.jacobian('default') = Jacobian;
j.probe('default') = GroupStats_fixed.probe; % probe
j.mesh = mesh;
j.formula = 'beta ~ -1 + cond';
prior.hbo = zeros(size(Jacobian.hbo,2),1);
prior.hbr = zeros(size(Jacobian.hbr,2),1);
j.prior('default') = prior;
j.basis=nirs.inverse.basis.gaussian(mesh,20);
j.mask=[];
imagestats = j.run(GroupStats_fixed);
imagestats.draw('tstat',[], 'p<0.2', 'beta>.999', 'front');
%%%%%%%%%%%GUI Projection%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AtlasViewerGUI 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Region of interest(ROI)%%%
%% Regions of interest
% You can manually specify regions of interest by listing specific source-detector pairings.  
          
% PFC left
MeasList=[2 12;...
          2 2];
Region{1} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% PFC rigth
MeasList=[16 12;...
          16 18];
Region{2} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% SMA left
MeasList=[3 1;...
          3 10];
Region{3} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% SMA rigth
MeasList=[3 11;...
          3 10];
Region{4} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% M1 left
MeasList=[1 10;...
          1 3;
          1 1];
Region{5} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% M1 rigth
MeasList=[10 10;...
          10 13;
          10 11];
Region{6} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% preSMA 
MeasList=[3 12];
Region{7} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});



% IFG left
MeasList=[4 2];
Region{8} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% IFG right
MeasList=[12 18];
Region{9} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

% A1
MeasList=[7 6;...
          6 6;
          14 17;
          15 17];
Region{10} = table(MeasList(:,1),MeasList(:,2),'VariableNames',{'source','detector'});

c = eye(10);
c(3,:) = [];

%nirs.util.write_xls('IndividualROIStats.xls',ROItable,'Sheet1')

% Export Individual ROI Stats
for i =1:length(ARStats)
    
    % Calculate stats with the ttest function
    ContrastStats = ARStats(i).ttest;

    ROItable = nirs.util.roiAverage(ContrastStats,Region,{'PFC_left','PFC_right','SMA_left','SMA_right','M1_left','M1_right','preSMA','IFG_left','IFG_right', 'A1'});
    
    filesep_idx = strfind(ARStats(i).description,filesep);
    subj_string = ARStats(i).description(filesep_idx(end-1)+1:filesep_idx(end)-1);
    nirs.util.write_xls('IndividualROIStats.xls',ROItable,subj_string)
end 








