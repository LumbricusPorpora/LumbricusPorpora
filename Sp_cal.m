%
% quich calculation for Sp conversion arrival
%

addpath /home/songyun/songyun/MyPage/project2/migration_table
load migration.mat

depth = [44.3]; 
dist = [69.24];
F = scatteredInterpolant(migration(:,1),migration(:,2),migration(:,3)); % interpolate
Vq = F (depth,dist) % get Sp arrival
