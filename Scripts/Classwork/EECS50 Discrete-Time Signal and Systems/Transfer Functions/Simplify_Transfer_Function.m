close all
clear all
clc
format short g
syms z
% Transfer Function H(z)
% Note: H(z) is represented as num(z)/den(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the numerator and denominator polynomial
% coefficients of H(z) in descending order
%num=[1 -3 5 2 0];
%den=[2 0 5 -3 1 -2 3 -1];
num=[4 0.25 -0.5];
den=[1 0.25 -0.125];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Transfer function H(z)
Hz=tf(num,den,-1);
% Find zeros, poles, and gain of H(z)
[r,p,k]=tf2zp(num,den);
% Find size of zero and pole matrix
sr=size(r,1);
sp=size(p,1);
% Simplify H(z)
for i=1:sr
    dn(i)=z-double(r(i));
end
for i=1:sp
    dd(i)=z-p(i);
end
n=prod(dn);
d=prod(dd);
Hz2=vpa(k*n/d);

% Display Results
disp('The Transfer function')
Hz
disp('is simplified to');
pretty(Hz2)