function [ traces_out ] = nmo1( traces,timebase,x,Vrms)

 [a,b] = size(traces);%a 为道上每采样点  b为道数
% N = length(vrms);

%corresponding function relationship for interpolate
% tt = [0,T0, tmax]; %new time seriescontain t0
% vv = [vrms(1), vrms, vrms(N)];
%doing interpolate
% timebase = (0:a-1)*dt; % sample time series
% Vrms = interp1(tt,vv,timebase,'linear');
dt = 0.002;
traces_out = zeros(a,b);
% t = (0:1:a)*dt;

for j = 1:b  %对第b道
    for i = 1:a   % each row
        temp1 = ( timebase(i).^2 + (x(j)/Vrms(i)).^2 );
        tau = (temp1)^0.5;
        t_location = round(tau/dt)+1;
         if t_location >a
            traces_out(i,j) = 0;
        else
            traces_out(i,j) = traces(t_location,j);
        end

    end
end
end

