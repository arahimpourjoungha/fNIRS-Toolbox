function Gtbl_onset = GLeveltbl_onset(Gtbl_onset)
%%%%%%%%%%%Adding Makey-Makey delay time to Onset%%%%%%%%%%%%% 
for k=11:20 %   
for j=1:10
Gtbl_onset.channel_1(k,1).onset(j)=Gtbl_onset.channel_1(k,1).onset(j)-0.025;
Gtbl_onset.channel_2(k,1).onset(j)=Gtbl_onset.channel_2(k,1).onset(j)-0.025;
Gtbl_onset.channel_3(k,1).onset(j)=Gtbl_onset.channel_3(k,1).onset(j)-0.025;
Gtbl_onset.channel_4(k,1).onset(j)=Gtbl_onset.channel_4(k,1).onset(j)-0.025;

end
%Gtbl_onset.channel_3(k,1).onset=sort([Gtbl_onset.channel_1(k,1).onset;Gtbl_onset.channel_2(k,1).onset]);
%Gtbl_onset.channel_4(k,1).onset=sort([Gtbl_onset.channel_3(k,1).onset;Gtbl_onset.channel_4(k,1).onset]);

end



%%%%%%%%%%change the number of onsets and shift it to -3%%%%%%%%%%%%%%%%
%val1=zeros(150,10);
%val2=zeros(150,10);
%valc3=zeros(120,10);
%valc4=zeros(120,10);
% 
% for k=1:10
%     for z=0:9 
% for m=1:3
%     if m==1  
%         val1(m+(z*15),k)=Gtbl_onset.channel_1(k,1).onset(1+(z*12))-3;
%         val2(m+(z*15),k)=Gtbl_onset.channel_2(k,1).onset(1+(z*12))-3;
%         valc3(m+(z*12),k)=Gtbl_onset.channel_3(k,1).onset(1+(z*12));
%         valc4(m+(z*12),k)=Gtbl_onset.channel_4(k,1).onset(1+(z*12));
% 
%     end
%     if m==2  
%         val1(m+(z*15),k)=Gtbl_onset.channel_1(k,1).onset(1+(z*12))-2;
%         val2(m+(z*15),k)=Gtbl_onset.channel_2(k,1).onset(1+(z*12))-2;
%         valc3(m+(z*12),k)=Gtbl_onset.channel_3(k,1).onset(2+(z*12));
%         valc4(m+(z*12),k)=Gtbl_onset.channel_4(k,1).onset(2+(z*12));
%     end
%     if m==3  
%         val1(m+(z*15),k)=Gtbl_onset.channel_1(k,1).onset(1+(z*12))-1;
%         val2(m+(z*15),k)=Gtbl_onset.channel_2(k,1).onset(1+(z*12))-1;
%         valc3(m+(z*12),k)=Gtbl_onset.channel_3(k,1).onset(3+(z*12));
%         valc4(m+(z*12),k)=Gtbl_onset.channel_4(k,1).onset(3+(z*12));
%         
%     end
% end
%     
% for m=4:15
%       val1(m+(z*15),k)=Gtbl_onset.channel_1(k,1).onset(m-3+(z*12));
%       val2(m+(z*15),k)=Gtbl_onset.channel_4(k,1).onset(m-3+(z*12));
%       valc3((m-3)+(z*12),k)=Gtbl_onset.channel_4(k,1).onset(m-3+(z*12));
%       valc4((m-3)+(z*12),k)=Gtbl_onset.channel_4(k,1).onset(m-3+(z*12));
%       
%       
% end
%     end
%     valc3(:,k)=Gtbl_onset.channel_3(k,1).onset;
%     valc4(:,k)=Gtbl_onset.channel_4(k,1).onset;
% end
% %%%%%%%%%%%reducing the number of onsets%%%%%%%%%%%%%%%%%%
% Rval1=zeros(10,10);
% Rval2=zeros(10,10);
% Rvalc3=zeros(10,10);
% Rvalc4=zeros(10,10);
% 
% for k=1:10 
%      for j=0:9
%       Rval1(j+1,k)=val1((j*15)+1,k);
%       Rval2(j+1,k)=val2((j*15)+1,k);
%      end    
%      for j=0:9
%       Rvalc3(j+1,k)=valc3((j*12)+1,k);
%       Rvalc4(j+1,k)=valc4((j*12)+1,k);
%      end
%      
% Gtbl_onset.channel_1(k,1).onset=Rval1(:,k);
% Gtbl_onset.channel_2(k,1).onset=Rval2(:,k);
% 
% Gtbl_onset.channel_3(k,1).onset=sort(Rvalc3(:,k));
% 
% Gtbl_onset.channel_4(k,1).onset=sort(Rvalc4(:,k));       
% end

%%%%%%%%%%%%%%%%%%%%%Correcting duration value%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for h=11:20
   
Gtbl_onset.channel_1(h,1).dur=[15;15;15;15;15;15;15;15;15;15];
Gtbl_onset.channel_2(h,1).dur=[15;15;15;15;15;15;15;15;15;15];
Gtbl_onset.channel_3(h,1).dur=[12;12;12;12;12;12;12;12;12;12];
Gtbl_onset.channel_4(h,1).dur=[12;12;12;12;12;12;12;12;12;12];
     
    
%%%%%%%%%%%%%Changing number of amplitude values%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Reducing the number of amplitude and durations%%%%%%%%%%%%%%
Gtbl_onset.channel_1(h,1).amp=[1;1;1;1;1;1;1;1;1;1];
Gtbl_onset.channel_2(h,1).amp=[1;1;1;1;1;1;1;1;1;1];
Gtbl_onset.channel_3(h,1).amp=[1;1;1;1;1;1;1;1;1;1];
Gtbl_onset.channel_4(h,1).amp=[1;1;1;1;1;1;1;1;1;1];

 end
%%%%%%%%%%%
%Gtbl_onset.channel_1(1,1).onset=sort([Gtbl_onset.channel_1(1,1).onset;Gtbl_onset.channel_2(1,1).onset]);
%Gtbl_onset.channel_1(2,1).onset=sort([Gtbl_onset.channel_1(2,1).onset;Gtbl_onset.channel_2(2,1).onset]);
%Gtbl_onset.channel_1(3,1).onset=sort([Gtbl_onset.channel_1(3,1).onset;Gtbl_onset.channel_2(3,1).onset]);
%Gtbl_onset.channel_1(4,1).onset=sort([Gtbl_onset.channel_1(4,1).onset;Gtbl_onset.channel_2(4,1).onset]);
%Gtbl_onset.channel_1(5,1).onset=sort([Gtbl_onset.channel_1(5,1).onset;Gtbl_onset.channel_2(5,1).onset]);
%Gtbl_onset.channel_1(6,1).onset=sort([Gtbl_onset.channel_1(6,1).onset;Gtbl_onset.channel_2(6,1).onset]);
%Gtbl_onset.channel_1(7,1).onset=sort([Gtbl_onset.channel_1(7,1).onset;Gtbl_onset.channel_2(7,1).onset]);
%Gtbl_onset.channel_1(8,1).onset=sort([Gtbl_onset.channel_1(8,1).onset;Gtbl_onset.channel_2(8,1).onset]);
%Gtbl_onset.channel_1(9,1).onset=sort([Gtbl_onset.channel_1(9,1).onset;Gtbl_onset.channel_2(9,1).onset]);
%Gtbl_onset.channel_1(10,1).onset=sort([Gtbl_onset.channel_1(10,1).onset;Gtbl_onset.channel_2(10,1).onset]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gtbl_onset.channel_3(1,1).onset=sort([Gtbl_onset.channel_3(1,1).onset;Gtbl_onset.channel_4(1,1).onset]);
%Gtbl_onset.channel_3(2,1).onset=sort([Gtbl_onset.channel_3(2,1).onset;Gtbl_onset.channel_4(2,1).onset]);
%Gtbl_onset.channel_3(3,1).onset=sort([Gtbl_onset.channel_3(3,1).onset;Gtbl_onset.channel_4(3,1).onset]);
%Gtbl_onset.channel_3(4,1).onset=sort([Gtbl_onset.channel_3(4,1).onset;Gtbl_onset.channel_4(4,1).onset]);
%Gtbl_onset.channel_3(5,1).onset=sort([Gtbl_onset.channel_3(5,1).onset;Gtbl_onset.channel_4(5,1).onset]);
%Gtbl_onset.channel_3(6,1).onset=sort([Gtbl_onset.channel_3(6,1).onset;Gtbl_onset.channel_4(6,1).onset]);
%Gtbl_onset.channel_3(7,1).onset=sort([Gtbl_onset.channel_3(7,1).onset;Gtbl_onset.channel_4(7,1).onset]);
%Gtbl_onset.channel_3(8,1).onset=sort([Gtbl_onset.channel_3(8,1).onset;Gtbl_onset.channel_4(8,1).onset]);
%Gtbl_onset.channel_3(9,1).onset=sort([Gtbl_onset.channel_3(9,1).onset;Gtbl_onset.channel_4(9,1).onset]);
%Gtbl_onset.channel_3(10,1).onset=sort([Gtbl_onset.channel_3(10,1).onset;Gtbl_onset.channel_4(10,1).onset]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gtbl_onset.channel_2(1,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(2,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(3,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(4,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(5,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(6,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(7,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(8,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(9,1).onset=zeros(20,1);
%Gtbl_onset.channel_2(10,1).onset=zeros(20,1);
%%%%%%%%%%%%%%%%%
%Gtbl_onset.channel_4(1,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(2,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(3,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(4,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(5,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(6,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(7,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(8,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(9,1).onset=zeros(20,1);
%Gtbl_onset.channel_4(10,1).onset=zeros(20,1);
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%



