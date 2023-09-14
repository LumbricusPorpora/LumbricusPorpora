function [ seis2 ] = equalization(seis )
% do normalization to all trace, final energy of each trace will become one
% after operation.
[~,n] = size(seis); % n is trace number
seis1 = seis.^2;
for i = 1:n
    en(i) = sum(seis1(:,i));  % energy of trace i
    seis2(:,i) = seis(:,i)./(sqrt(en(i))); %original Amp divide square of energy
end

% evaluate, check if the energy is 1 after equalization in every trace
seis3 = seis2.*seis2;
for j =1:n
    seis4(j) = sum(seis3(:,j));
end
a = all(~(diff(seis4)));
if a~= 0
    disp('An error occurred');
end

x = 1:3104;


figure()
subplot (211)
plot(en);
xlabel('trace number','FontSize',14);
ylabel('energy(J)','FontSize',14);
title('energy per trace before equalization','FontSize',14);
subplot (212)
plot(x,seis4);
xlabel('trace number','FontSize',14);
ylabel('energy(J)','FontSize',14);
title('energy per trace after equalization','FontSize',14);
end

