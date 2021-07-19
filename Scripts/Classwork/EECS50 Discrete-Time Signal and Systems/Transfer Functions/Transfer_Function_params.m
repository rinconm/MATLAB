close all
clear all
clc
format short g
syms
% Pole-zero Plot of H(z)
% Note: H(z) is represented as num(z)/den(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the numerator and denominator polynomial
% coefficients of H(z) in descending order
%num=[1 2 3 4];
%den=[1 5 2 2 9];
num=[4 3 2 1 2 3 4];
den=[1];
% Magnitude and Phase Plot variables
N=512;
Fs=8000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Transfer function H(z)
Hz=tf(num,den,-1);
% Find zeros and poles of H(z)
r=roots(num);
p=roots(den);
% Setup for Magnitude and Phase Plots
delta=[1 zeros(1,30)];
h=filter(num,den,delta);
cumsum(h);

% Display Results
disp('The Transfer function');
Hz
% Plot the Pole/Zero plot of Transfer Function
pzmap(Hz)
% Plot the Magnitude and Phase Plots
figure;freqz(num,den,N,Fs)
title('Magnitude and Phase Plot of H(Z)')
disp('has zeroes at');
r
disp('and poles at');
p