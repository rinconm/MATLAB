close all
clear all
clc
format short g
syms z
% Pole-zero Plot of H(z)
% Note: Difference equation is represented as
% a_0*y[n]+a_1y[n-1]+a_2y[n-2]=
% b_0*x[n]+b_1x[n-1]+b_2x[n-2]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter a and b coefficients
%a=[1 0.2 0.8];
%b=[0.3 0.6 0.2];
a=[1 -4 5];
b=[2 -3 0];
% Magnitude and Phase Plot variables
N=512;
Fs=8000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Transfer function H(z)
Hz=tf(b,a,-1);
% Solve for roots and poles of H(z)
r=roots(b);
p=roots(a);
% Setup for Magnitude and Phase Plots
delta=[1 zeros(1,30)];
h=filter(b,a,delta);
cumsum(h);

% Display Results
disp('The difference equation');
disp([num2str(a(1)) '*y[n] + ' num2str(a(2)) '*y[n-1] + ' num2str(a(3)) 'y[n-2]='])
disp([num2str(b(1)) '*x[n] + ' num2str(b(2)) '*x[n-1] + ' num2str(b(3)) 'x[n-2]'])
disp('Has Transfer function');
Hz
% Plot the Pole/Zero plot of Transfer Function
pzmap(Hz)
% Plot the Magnitude and Phase Plots
figure;freqz(b,a,N,Fs)
title('Magnitude and Phase Plot of H(Z)')
disp('has zeros at');
r
disp('and poles at');
p
