close all
clear all
clc
format short g
syms
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
% Prepare numerator to long divide
n=5;
num=[num zeros(1,n-1)];
% Long divide numerator by denominator
[q,r]=deconv(num,den);
% Prepare to add quotient with remainder
sq=size(q,2);
start=sq+1;
sr=size(r,2);
for i=start:sr
    q(i)=0;
end
% Place answer in divided variable
result=q+r;

% Display Results
disp('The Transfer function')
Hz
disp('long divididing its numerator');
disp('by denominator yields');
result