clc; clear ; close all

%% deal with move out databaset
% put all data in to one cell structure
% prepare to do the interplation

addpath  /home/songyun/songyun/MyPage/project2/migration_table
mig = {};
a = (5:5:200);% depth
m = length(a);

%% read in all structures
for i  =1:m
    %mig{i,1} = a(i);
    eval(['load mig_dep' num2str(a(i)) '.mat']);
end
%% 
for i = 1:m
    mig{i,1} = a(i);
    eval([' mig{' num2str(i) ',2}=MIG' num2str(a(i)) '']);
end
%%
[~,n] = size(mig{1,2});
%%
for i = 1:m
    for j = 1:n
        mig{i,3}(j,1) = mig{i,1};
        mig{i,3}(j,2) = mig{i,2}(j).dist;
        mig{i,3}(j,3) = mig{i,2}(j).S_p;
    end
    
end

%%
migration = {};
for i = 1:m
    migration{i,1}= mig{i,3};
end

migration = cell2mat(migration);
filename = 'migration.mat';
save(filename,'migration');

%% deal with s receiver function database
% all traces and their headers are contained in 'temp3_info'
addpath /home/songyun/songyun/MyPage/project2/migration_table/test_data
load temp3_info.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instruction for data 'temp3_info.mat'
% 1.  this mat file contain a 3*N cell
% 2.  cell{1,:} are epicentral distance. it must be aligned from small to
%      large.
% 3.  cell{2,:} are event depth. corrsponding to distance.
% 4.  cell{3,:} are corresponding S receiver function.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% deal with receiver function data
% transfer data into a structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instruction for new structure 'temp3'
% temp3 has dimenson of N*3field
% Nth receiver function relate to temp3(N) which including fields: 
%       1. distance
%       2. event depth
%       3. traces
% receiver function`s sequence is decided by distance (from small to large, easy to doing moveout)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% copy data
temp3 = [];
[~,l] = size(temp3_info);
for i  = 1:l
    temp3(i).event_depth = temp3_info{2,i};
    temp3(i).distance = temp3_info{1,i};
    temp3(i).traces = temp3_info{3,i};
end
%% delete event with depth deeper than 200km
for i = 1:l
    if  temp3(i).event_depth > 200
        temp3(i) = [];
%         temp3(i).event_depth = [];
%         temp3(i).traces = [];
%         temp3(i).distance = [];
    end
end


%%  interpolation
% interpolate 'temp3.mat' using 'migration.mat'
% temp3: Xq , Yq
% migration: X , Y , V
[~,ll] = size(temp3);
for i = 1:ll
    xq_depth(i) = temp3(i).event_depth;
    yq_distance(i) = temp3(i).distance;
end

%% using interpolation on 2D sactter data set
F = scatteredInterpolant(migration(:,1),migration(:,2),migration(:,3));
Vq = F (xq_depth,yq_distance);
%%
for i =1:ll
    temp3(i).Sptime = Vq(i);
end

%% move out for 220km depth
time = (-25:0.01:80);
for i = 1:ll
    temp3(i).shift = temp3(i).Sptime - temp3(1).Sptime;
%     temp3(i).Sptime2 = temp3(i).Sptime - temp3(i).shift;
    temp3(i).time = time - temp3(i).shift;
end

%% plot
figure()
% subplot(121)
for i = 1:ll
    plot(temp3(i).time,temp3(i).traces*5+i*10,'LIneWidth',2)
    hold on
end

% subplot(122)
% for i = 1:ll
%     plot(temp3(i).distance,i*10-5,'o','MarkerSize',10);
%     hold on
% end
% % set(gca,'box','off','ytick',[]);
% set(gca,'ytick',[],'yticklabel',[]);
% 
% 

%% simple weight stacking
% noise window and signal window
% calculate SNR
% add weight for each rf
for i = 1:ll
    temp3(i).noisewindow = temp3(i).traces(1,1:1000);
    temp3(i).signalwindow = temp3(i).traces(2000:3000);
    temp3(i).noisemax = max(abs(temp3(i).noisewindow));
    temp3(i).signalmax = max(abs(temp3(i).signalwindow));
    temp3(i).SNR = temp3(i).signalmax/temp3(i).noisemax;
    temp3(i).SNR = sqrt(temp3(i).SNR);
    temp3(i).weight_traces =  temp3(i).traces* temp3(i).SNR;
end
%% new time axis
for i = 1:ll
    temp(i,1) = temp3(i). time(1); % first time point of each rf
    temp(i,2) = temp3(i). time(end); % last time point of each rf
end
%%  cut un-uniform part of each time axis
dt = 0.01;
tstart = ceil(max(temp(:,1))); % select latest start time
tfinal = floor(min(temp(:,2))); % select earlest end time
temp3().time2 = (tstart:dt:tfinal);
%% cut traces
temp3(1).time2 = roundn(temp3(1).time2,-2);
%
left = cell(ll,1);
right = cell(ll,1);
Time = {};
%
for i = 1:ll
    temp3(i).time = roundn(temp3(i).time,-2);
    left{i} = find(temp3(i).time == tstart);
    right{i} = find(temp3(i).time == tfinal);
    temp3(i).traces2 = temp3(i).weight_traces(left{i}:right{i});
end

%% sum
sum = 0;
for i = 1:ll
    sum = sum+temp3(i).traces2;
end
sum = sum/ll;

%% plot stacking
figure()
plot(temp3(1).time2,sum);

%% plot all
figure()
subplot(4,4,[1:3,5:7,9:11])
for i = 1:ll
    plot(temp3(i).time,temp3(i).traces*5+i*10,'LIneWidth',1.3)
    hold on
end
set(gca,'Xlim',[-30 90])

subplot(4,4,[4,8,12])
for i = 1:ll
    plot(temp3(i).distance,i*10-5,'o','MarkerSize', 8);
    hold on
end
% set(gca,'box','off','ytick',[]);
set(gca,'ytick',[],'yticklabel',[]);

subplot(4,4,[13:15])
plot(temp3(1).time2,sum);
set(gca,'Xlim',[-30 90])



