function tbl_onset = ChangeOnset(tbl_onset)
%%%%%%%%%%%Adding Makey-Makey delay time to Onset%%%%%%%%%%%%%     
       for j=1:120
tbl_onset.channel_1(1,1).onset(j)=tbl_onset.channel_1(1,1).onset(j)-0.025;
tbl_onset.channel_2(1,1).onset(j)=tbl_onset.channel_2(1,1).onset(j)-0.025;
tbl_onset.channel_3(1,1).onset(j)=tbl_onset.channel_3(1,1).onset(j)-0.025;
tbl_onset.channel_4(1,1).onset(j)=tbl_onset.channel_4(1,1).onset(j)-0.025;
       end
               
     
%%%%%%%%%%change the number of onsets and shift it to -3%%%%%%%%%%%%%%%%
val1=zeros(150,1);
val2=zeros(150,1);
valc3=zeros(120,1);
valc4=zeros(120,1);
    for z=0:9 
for m=1:3
    if m==1  
        val1(m+(z*15),1)=tbl_onset.channel_1(1,1).onset(1+(z*12))-3;
        val2(m+(z*15),1)=tbl_onset.channel_2(1,1).onset(1+(z*12))-3;
        valc3(m+(z*12),1)=tbl_onset.channel_3(1,1).onset(1+(z*12));
        valc4(m+(z*12),1)=tbl_onset.channel_4(1,1).onset(1+(z*12));

    end
    if m==2  
        val1(m+(z*15),1)=tbl_onset.channel_1(1,1).onset(1+(z*12))-2;
        val2(m+(z*15),1)=tbl_onset.channel_2(1,1).onset(1+(z*12))-2;
        valc3(m+(z*12),1)=tbl_onset.channel_3(1,1).onset(2+(z*12));
        valc4(m+(z*12),1)=tbl_onset.channel_4(1,1).onset(2+(z*12));
    end
    if m==3  
        val1(m+(z*15),1)=tbl_onset.channel_1(1,1).onset(1+(z*12))-1;
        val2(m+(z*15),1)=tbl_onset.channel_2(1,1).onset(1+(z*12))-1;
        valc3(m+(z*12),1)=tbl_onset.channel_3(1,1).onset(3+(z*12));
        valc4(m+(z*12),1)=tbl_onset.channel_4(1,1).onset(3+(z*12));
        
    end
end
    
for m=4:15
      val1(m+(z*15),1)=tbl_onset.channel_1(1,1).onset(m-3+(z*12));
      val2(m+(z*15),1)=tbl_onset.channel_2(1,1).onset(m-3+(z*12));
      valc3((m-3)+(z*12),1)=tbl_onset.channel_3(1,1).onset(m-3+(z*12));
      valc4((m-3)+(z*12),1)=tbl_onset.channel_4(1,1).onset(m-3+(z*12));
      
      
end
    end
    valc3=tbl_onset.channel_3(1,1).onset;
    valc4=tbl_onset.channel_4(1,1).onset;  
%%%%%%%%%%%reducing the number of onsets%%%%%%%%%%%%%%%%%%
Rval1=zeros(10,1);
Rval2=zeros(10,1);
Rvalc3=zeros(10,1);
Rvalc4=zeros(10,1);
     for j=0:9
      Rval1(j+1,1)=val1((j*15)+1);
      Rval2(j+1,1)=val2((j*15)+1);
     end    
     for j=0:9
      Rvalc3(j+1,1)=valc3((j*12)+1);
      Rvalc4(j+1,1)=valc4((j*12)+1);
     end
     
tbl_onset.channel_1(1,1).onset=Rval1;
tbl_onset.channel_2(1,1).onset=Rval2;
SR3=Rvalc3;
tbl_onset.channel_3(1,1).onset=sort(SR3);
SR4=Rvalc4;
tbl_onset.channel_4(1,1).onset=sort(SR4);       
        

%%%%%%%%%%%%%%%%%%%%%Correcting duration value%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
tbl_onset.channel_1(1,1).dur=[15;15;15;15;15;15;15;15;15;15];
tbl_onset.channel_2(1,1).dur=[15;15;15;15;15;15;15;15;15;15];
tbl_onset.channel_3(1,1).dur=[12;12;12;12;12;12;12;12;12;12];
tbl_onset.channel_4(1,1).dur=[12;12;12;12;12;12;12;12;12;12];
     
     
%%%%%%%%%%%%%Changing number of amplitude values%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Reducing the number of amplitude and durations%%%%%%%%%%%%%%
tbl_onset.channel_1(1,1).amp=[1;1;1;1;1;1;1;1;1;1];
tbl_onset.channel_2(1,1).amp=[1;1;1;1;1;1;1;1;1;1];
tbl_onset.channel_3(1,1).amp=[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];
tbl_onset.channel_4(1,1).amp=[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];
