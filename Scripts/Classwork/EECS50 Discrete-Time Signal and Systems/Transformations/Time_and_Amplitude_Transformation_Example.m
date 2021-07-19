close all
clear all
clc
% This MATLAB program performs the time and amplitude transformation for
% Example 9.4.
% Establish vectors of sufficient length for both x(n) and n.
n=[-10:20];
x=zeros(1,length(n));
% Enter nonzero values for x(n).
x(10)=2; x(11)=1; x(13)=2;
% Plot x(n).
figure(1),stem(n(1,5:17),x(1,5:17),'fill'),grid,xlabel('n'),ylabel('x(n)')
for k = 3:21
xt(k)=3-2*x(13-n(k));
end
figure(2),stem(n(1,5:17),xt(1,5:17),'fill'),grid,xlabel('n'),ylabel('xt(n)')