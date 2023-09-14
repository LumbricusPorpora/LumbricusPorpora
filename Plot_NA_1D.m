%plot 1D profiles

%clear;close;
latlon=[62.5600 -114.6100]; %YKW3 station
zii=[40:5:450];

if exist('Fs','var')
else
    load F.interpolant.NA.mat
end;
    

%longitude 0 to 360
latlon(2)=mod(latlon(2),360);

%vs
ps=Fs(latlon(1)*ones(size(zii)),latlon(2)*ones(size(zii)),zii);

subplot(141);
plot(ps,zii);set(gca,'ydir','reverse','tickdir','out');
ylim([40 450]);axis tight; 
xlabel('Vs (m/s)');ylabel('Depth (km)');


%xi
px=Fx(latlon(1)*ones(size(zii)),latlon(2)*ones(size(zii)),zii);

subplot(142);
plot(px,zii);set(gca,'ydir','reverse','tickdir','out');
ylim([40 450]);axis tight; 
xlabel('\xi ');ylabel([]);

%g
pg=Fg(latlon(1)*ones(size(zii)),latlon(2)*ones(size(zii)),zii);

subplot(143);
plot(pg,zii);set(gca,'ydir','reverse','tickdir','out');
ylim([40 450]);axis tight; 
xlabel('dlnG (%) ');ylabel([]);

%
paz=Faz(latlon(1)*ones(size(zii)),latlon(2)*ones(size(zii)),zii);

subplot(144);
plot(paz,zii);set(gca,'ydir','reverse','tickdir','out');
ylim([40 450]);axis tight; 
xlabel('Fast Axis (\circ) ');ylabel([]);
