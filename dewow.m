function [ seis_dew,seis_aver ] = dewow( seis )
%calculatetrace average, and use average value from ever trace.
[m,n] = size(seis); % m 为采样点数， n为道号
% A = zeros(m,1); %average of all traces

for i = 1:m
    seis_aver(i,1) = mean(seis(i,:),2);
end

for j = 1:n
    seis_dew(:,j) = seis(:,j)-seis_aver;
end

% figure() %plot average value
% plot(t,seis_aver);  %plot average of all traces
% title('averaged trace','FontSize',14);
% xlabel('sample time(sec)','FontSize',14);
% ylabel('amplitude','FontSize',14);

end

