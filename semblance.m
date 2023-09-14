function [vel,semb] = semblance(traces,t,x,v1,v2,n,window)
% function [vel,semb] = semblance(traces,t,x,v1,v2,n,window)
% This function calculates the semblance coherency measure type of 
% velocity spectra plot.
% traces = gather, t = timebase in seconds, x = offsets 
% v1 = initial velocity in m/s, v2 = final constant nmo velocity
% vel is the vector of output velocities which compares to the columns of output semb.
% The rows of semb are according to the time.
% n = number of trial velocities to calculate.
% window = number of time samples of window over which coherency is measured.

[m,N] = size(traces);
delv = (v2-v1)/(n-1);
subplot(1,3,1)
imagesc(x,t,traces)
title('gather')

semb = zeros(m,n);
vel = v1:delv:v2;


for i = 1:n
   junk = zeros(m+window,N);
   edge = round(window/2);
	junk(edge+1:m+edge,:) = nmo1(traces,t,x,vel(i)*ones(m,1));
	
   for k = 1:m
      numer = sum(sum(junk(k:k+window-1,:),2).^2);
      denom = sum(sum(junk(k:k+window-1,:).^2,2));
      if denom  ~= 0
         semb(k,i) = numer/denom;
      end % if
      
    end % k  
end % i

subplot(1,3,2)
imagesc(vel,t,semb), 
colormap parula
xlabel('Stacking Velocity m/s')
ylabel('Time seconds')

subplot(1,3,3), 
colormap parula
contour(vel,t,semb,15), xlabel('Stacking Velocity'), ylabel('Time seconds')
axis('ij')

out = 1;

return;
