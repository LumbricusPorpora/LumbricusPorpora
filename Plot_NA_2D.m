%plotting depth cross-sections.



%%
%depth cross-section along a great circle path.

%specify starting/ending points (lat1,lon1,lat2,lon2) and # of points in
%between
latlon=gcwaypts(67.5,-122.55,34,-85,83);%nearly North-south profile
%specify depth vectory
zii=[40:5:450];

%the profiles are stored in ps, px, pg and paz which have the dimension as
%length(latlon) by length(zii0). 

%no need to change lines blow.

%%
if exist('Fs','var')
else
    load F.interpolant.NA.mat
end;

latlon(:,2)=mod(latlon(:,2),360);
dis0=distance(latlon(1,1),latlon(1,2),latlon(:,1),latlon(:,2));
nz=length(zii);
nx=length(latlon);

%for nx*nz by 3 vector for interpolation
latloni=zeros(nx*nz,3);
for i=1:nz,
    latloni((i-1)*nx+1:i*nx,:)=[latlon ones(nx,1)*zii(i)];
end;
%
clf;colormap(flipud(jet(16)));
%az

%these lines illustrate how to get the values along the profile. The
%interpolation takes some time.
paz=Faz(latloni(:,1),latloni(:,2),latloni(:,3));
paz=reshape(paz,nx,nz);
px=Fx(latloni(:,1),latloni(:,2),latloni(:,3));
px=reshape(px,nx,nz);
pg=Fg(latloni(:,1),latloni(:,2),latloni(:,3));
pg=reshape(pg,nx,nz);
ps=Fs(latloni(:,1),latloni(:,2),latloni(:,3));
ps=reshape(ps,nx,nz);

%%
%plotting. Note the example profile goes nearly north-south so latitude is
%used as the x axis. You can use dis0 here too.
%
figure(2)
subplot(4,1,4);%anisotropy direction
imagesc(latlon(:,1),zii,paz'); 
set(gca,'xdir','reverse');colorbar('vert');ylim([40 450]);
xtick0=get(gca,'xtick');
ht(4)=text(xtick0(end),300,'Fast axis'); %note this line may not work for all cases.
%xi
subplot(4,1,2);%radial anisotorpy
imagesc(latlon(:,1),zii,px'); 
caxis([.94 1.06])
set(gca,'xdir','reverse');colorbar('vert');ylim([40 450]);
ht(2)=text(xtick0(end),300,'\xi'); %note this line may not work for all cases.

%xi
subplot(4,1,3);%azimuthal anisotropy strength
imagesc(latlon(:,1),zii,pg');
set(gca,'xdir','reverse');colorbar('vert');ylim([40 450]);
ht(3)=text(xtick0(end),300,'dlnG'); %note this line may not work for all cases.

%dlnvs
subplot(4,1,1);%vs
imagesc(latlon(:,1),zii,ps');caxis([4200 4800]);
set(gca,'xdir','reverse');colorbar('vert');ylim([40 450]);
set(findobj(gcf,'type','axes'),'tickdir','out');
ht(1)=text(xtick0(end),300,'Vs'); %note this line may not work for all cases.


set(ht,'color','k','fontweight','bold');%again this may not work