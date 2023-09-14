function [ seis_gain ] = gain( seis, t, offset, n )
% applying a time dependent gain to seismic data
% gain parameter n need to larger than 1.
% t is time series of data which is twt file
gt = t.^n;  %time-independent gain function
[~,q] = size(seis);  % q is trace number

for i = 1:q
    seis_gain(:,i) = seis(:,i).*gt;
end

% figure()  
% subplot(211)  %plot new dataset after gaining
% imagesc(offset,t,seis_gain);
% colormap Gray
% colorbar  
% max = 1e-21; 
% min = -max;
% caxis([min max]);  %set value range
% xlabel('position(m)','FontSize',14);
% ylabel('two way travel time(sec)','FontSize',14);
% title('displaying data after simple gain operation, n=2.5','FontSize',14);
% 
% subplot(212)  %plot new dataset before gaining
% imagesc(offset,t,seis);
% colormap Gray
% colorbar  
% max = 1e-21; 
% min = -max;
% caxis([min max]);  %set value range
% xlabel('position(m)','FontSize',14);
% ylabel('two way travel time(sec)','FontSize',14);
% title('displaying data before simple gain operation','FontSize',14);
end

