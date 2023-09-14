function [ seis_debias ] = debias( seis )
% remove DC bias of each trace and plot all DC bias
% seis data format: x axis is trace, y axis is time

[~,n] = size(seis); % n is trace number
DC = zeros(1,n);
%calculate average value per trace and mins from original trace
for i = 1:n
    DC(i) = mean(seis(:,i));
    seis_debias(:,i) = seis(:,i)-DC(i);
end
figure()
plot(DC); %plot trace average
title('DC bias of each trace','FontSize',14);
xlabel('trace number','FontSize',14);
ylabel('mean value','FontSize',14);
end

