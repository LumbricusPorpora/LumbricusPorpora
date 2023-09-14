function [ks,freqs,z] = fkview(traces,t,offset)
% Function [k,f,z] = fkview(traces,t,offset)
% This function provides two images of the top half of the 2D FFT 
% of a set of traces.  The first image is of the magnitude of the data 
% and the second is in a decibel scale format.
% Program written by D. Schmitt, latest update January 2000.
% This program is provided freely but the author and his institution take
% no responsibility for use of this software.
% traces are the m X n matrix of the data with each trace per column
% t is the m long timebase associated with the traces
% offset is the n long vector giving the positions in m of the traces along
% the 2D profile. 

[m,n] = size(traces); 
tt = ones(m,1); temp = hanning(41); tt(1:21) = temp(1:21); 
tt(m-20:m) = temp(21:41);  
[x,y] = meshgrid(hanning(n),tt);  tracemask = x.*y;
traces = tracemask.*traces;  % smooth out some rough edges for ffting later, applied twice.
clear tracemask

delt = t(2)-t(1); fnyq = 1/(2*delt); delf = 2*fnyq/m;
freqs = -fnyq:delf:fnyq - delf;
delx = abs(offset(2)-offset(1)); knyq = 2*pi/(2*delx); delk = knyq/n;
ks = -knyq:delk:knyq-delk;

M = pow2(nextpow2(m)); % Note - program runs more easily if dimensions are power of 2
N = pow2(nextpow2(n));
newtraces = zeros(M,N); 
newtraces(floor((M-m)/2+1):floor((M+m)/2),floor((N-n)/2+1):floor((N+n)/2)) = traces;
% imagesc(newtraces)
clear traces tracemask

z = fft2(newtraces);  
z = fftshift(z); 
z = abs(z(1:M/2+1,:));  

imagesc(ks,freqs(1:m/2+1),z);
ylabel('frequency (Hz)','FontSize',14); xlabel('Spatial Wavenumber (radians/m)','FontSize',14)
title('F-K plot, amplitude magnitude scale','FontSize',14)

figure
scale = max(max(z)); 
imagesc(ks,freqs(1:m/2+1),20*log(z/scale));
% colormap parula
lim1 = 0; 
lim2 = -150;
caxis([lim2 lim1]);  %set value range

ylabel('frequency (Hz)','FontSize',14); xlabel('Spatial Wavenumber (radians/m)','FontSize',14)
title('F-K dB scale','FontSize',14), colorbar

freqs = freqs(1:m/2+1);  % Send only plot scale to be used for updates if necessary.






