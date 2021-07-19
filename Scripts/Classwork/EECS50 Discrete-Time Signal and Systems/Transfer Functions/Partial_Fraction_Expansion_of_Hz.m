close all
clear all
clc
format short g
syms
% Partial-fraction Expansion on Transfer Function
% H(z) with multiple poles
% Note: H(z) is represented as num(z)/den(z).
%       Also, the degree of the numerator must be
%       less than the degree of the denominator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the numerator and denominator polynomial
% coefficients of H(z) in descending order
% num=[1 2 3];
% den=[1 5 2 7];
num=[1 0 0];
den=[1 0 -1]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Transfer function H(z)
Hz=tf(num, den,-1);
% Solve for roots, poles, and gain of H(z)
[r,p,k]=residue(num,den)

% Display Results
disp('Transfer function');
Hz
disp('has residue, poles, and gain of');
r
p
k

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extra: Converting the partial fraction expansion
%        back to polynomial coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[num,den] = residue(r,p,k);