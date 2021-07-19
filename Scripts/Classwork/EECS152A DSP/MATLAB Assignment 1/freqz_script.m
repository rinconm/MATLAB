close all
clear all
clc
% Plot Magnitude and Phase response using freqz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter numerator and denominator of H(z) if expanded
n=[2 1 0];
d=[1 0.25 -0.25];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
[h,w]=freqz(n,d,'whole');               % Solve for Hw

% Plots
subplot(2,1,1), plot(w,abs(h));
xlabel('Radians'), ylabel('|H(w)|'), title('Magnitude Response');
subplot(2,1,2), plot(w,angle(h)*180/pi);
xlabel('Radians'), ylabel('<H(w)|'), title('Phase Response');