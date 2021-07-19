close all
clear all
clc
% Design a Digital Lowpass Filter to satisfy specs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Wp and Ws (Passband and Stopband Edge)
% Note: These frequency values are normalized from 0 to
% 1 to represent ranges from -pi to pi
Wp=0.4;
Ws=0.6;

% Enter Rp and Rs dB (Passband and Stopband Attenuation)
Rp=0.5;
Rs=50;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve for Butterworth order and cutoff frequency
[N, Wn]=buttord(Wp, Ws, Rp, Rs);
% Solve for the Direct-Form Coefficients
[B,A]=butter(N,Wn);
% Display Frequency Response
freqz(B,A)
