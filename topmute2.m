function [ traces_out ] = topmute2( traces, timebase,offset, x, t )
%input:
% x: location offset
% t: when start to cut
%timebase is column vector
new_time =  interp1(x,t,offset,'linear'); 
[a,b] = size(traces);
traces_out = traces;
for i = 1: b
    for j = 1:a
        if timebase(j) <new_time(i)
            traces_out(j,i) = 0;
       end
    end
end
end

