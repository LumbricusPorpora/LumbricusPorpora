%maps. note in plotting Matlab mapping toolbox is used.
%specify lat/lon range and depth
di=0.5;%lat/lon interval
[xii yii]=ndgrid([30:di:50],[-125:di:-95]);
z0=100; %depth at 100 km;


%
yii=mod(yii,360);
zii=ones(size(xii)).*z0;


vsi=Fs(xii,yii,zii); %Fs/Fg/Faz too

%using mapping tool box
origin = [40 -110];
flatlimit = [-10 10];
flonlimit = [-12.5 10];
clf;
ax = worldmap('USA');
set(gca, 'Visible', 'off')
setm(gca,'origin',origin,'flatlimit',flatlimit,'flonlimit',flonlimit, ...
    'plinelocation',[10],'mlinelocation',[10])
coast=load('coast');
plotm(coast.lat,coast.long,'k');
states = shaperead('usastatelo', 'UseGeoCoords', true);

hf=framem;set(hf,'linewidth',.5,'visible','on');
geoshow( states,'FaceColor','none','edgecolor','k');


hg=geoshow(vsi,[1/di 50 -125],'displaytype','texturemap');
hb=colorbar('vert');
