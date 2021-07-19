close all
clear all
clc
format short g
syms
% Impulse response h[n] for a LTI system from 
% Transfer Function H(z)
% Note: H(z) is represented as num(z)/den(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the numerator and denominator polynomial
% coefficients of H(z) in descending order
%num=[4 1];
%den=[1 -1 0.5];
num=[1 0 0];
den=[1 0 -1];
% Define sample range
n=0:20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Transfer function H(z)
Hz=tf(num,den,-1);
% Define h[n]
hn=dimpulse(num,den,n+1);
hn=hn.';

% Display Results
disp('Transfer function');
Hz
stem(n, hn, 'filled');grid
title('Discrete-time Impulse Response of LTI System')
ylabel('h[n]')
xlabel('n')
disp('              h[n] Table');
disp('            n           h[n]');
[n' hn']