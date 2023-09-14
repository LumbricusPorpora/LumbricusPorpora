function [ seis_agc ] = AGC( seis,N )
% this is auto gain control operation, 
%need to input time window ,parameter'n' means the number of amplitude
%which participed in calculating RMS. true time window is (n-1)dt.
%The time window can only be an even multiple of the sampling
%interval,which means n is odd number.

[~,q] = size (seis);  % p = sample interval; q = trace number
C1 = seis.^2;  %doing square in advanced.
% N =15;  %������ƽ���Ĳ�����������Ӧʱ����СΪv-1����dt����ֵֻ����������

for i = 1:q
    C2(:,i) = smooth(C1(:,i),N);
end
 C3 = C2.^0.5;
 seis_agc = seis./C3;%calculate new seismic dataset
 seis_agc(1,:) = 0; %first sample point of all traces can`t be calculate because divisors are 0.set zero.

end

