clc ; clear ; close all
%% migration data for 220 km
% this code aim to generate data table for move out/t to d migration.
% for event depth 0 km, calculate Sp arrival time in different
% epicentral distance and different depth.
% for the true event, its Sp arrival time can be find by using interpolation with this table.  


%% add path and taup
addpath E:\研究生\课题\code\seizmo
startup_seizmo
%% migration for 220km
depth = 0;  % variable
dist = 55;
% dist = (55:0.1:80);% distance range, distance interval is 0.1 degree
MIG55 = [];% name variable

temp1 = tauppath('m',prem,'phases','S','depth',depth,'degrees',dist);
 
for i = 1:l
    MIG55(i).dist = dist(i);
    
end
%% S phase arrival time for layer 220km
for ii =1:l
    MIG55(ii).S1 = tauppierce('m',prem,'phases','S','depth',depth,...
     'degrees',dist(ii));
   
end
%% find the distance from source to the incident point
% record it as dis_220
for i = 1:l
    [x1,~] = find(MIG55(ii).S1.pierce.depth == 220);
    MIG55(i).S1.x1 = x1(end);
    MIG55(i).S1.dis_220 = MIG55(i).S1.pierce.distance(MIG55(i).S1.x1);
    
end
%%  calculate S wave travel time
% assume a new event happen at the incident point on layer 220km
% from new source s wave and p wave has travel time difference
for i = 1:l
    MIG55(i).phase2.st_220 = MIG55(i).S1.pierce.time(end)-MIG55(i).S1.pierce.time( MIG55(i).S1.x1);
    
end
%% P wave travel time
% new epicentral distance
for ii = 1:l
    MIG55(ii).phase2.dist2 = MIG55(ii).dist - MIG55(ii).S1.dis_220;
    
end
%% p arrival
for i = 1:l
    MIG55(i).phase2.P = tauptime('m',prem,'phases','p','depth',220,...
     'degrees', MIG55(i).phase2.dist2);    
 
end
%% 
for i = 1:l
    MIG55(i).phase2.pt_220 = MIG55(i).phase2.P.time;
    MIG55(i).S_p = MIG55(i).phase2.st_220 - MIG55(i).phase2.pt_220;
    
end
%%
filename = 'mig_dep5.mat'; % name variable
save(filename,'MIG5'); % name variable







