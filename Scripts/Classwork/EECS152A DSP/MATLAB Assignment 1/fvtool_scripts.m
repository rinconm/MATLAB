%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 3a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% Plot the magnitude and phase response of H(w)
% with fixed single order pole and varying single 
% order zero
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter values of a (zero)
a=[-3 -1 -0.5 0.65 0.7 0.8 1 1.5 3];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixed single order pole
d=[1 -0.7];
% Determine number of values to test
s=size(a);

% Frequency Response generation for different zeroes
for i=1:1:s(2)
    n=[1 -a(i)];
    fvtool(n,d)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 3b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% Plot the magnitude response and zero-pole plot of
% H(w) with a complex conjugate pair of zeros and 
% varying values for a second order pole
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter values of c (pole)
c=[-0.9 -0.2 0.2 0.7 0.95];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixed numerator
b1=[1 -(sqrt(2)/2+1i*sqrt(2)/2)];
b2=[1 -(sqrt(2)/2-1i*sqrt(2)/2)];
n=conv(b1,b2);
% Determine number of values to test
s=size(c);

% Frequency Response generation for different poles
for i=1:1:s(2)
    a1=[1 -c(i)];
    a2=[1 -c(i)];
    d=conv(a1,a2);
    fvtool(n,d)
end