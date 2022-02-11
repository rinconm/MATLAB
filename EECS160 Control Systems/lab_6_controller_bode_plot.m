close all
clear all
clc
format
% ===================================================================
% File: lab_6_controller_bode_plot
% Purpose: Used to answer questions from Lab 6 Identification of
% Unknown Processes. Plots oscilloscope measurements to produce 
% bode plots for two parts, then I theorized the transfer function
% for each part. In the third part we measure the step response
% of the theorized closed-loop system to compare with lab results.
% calclations.
% Note: Remember to 'Run Section'
% ===================================================================
% -------------------------------------------------------------------
% Part 1: Plant System
% -------------------------------------------------------------------
% Parameters
% -------------------------------------------------------------------
% Enter Frequency [rad/s]
w = [1 2 4 6 8 10 20 40 60 80 100 200 400 600 800 1000 2000 4000 5000];
% Enter Magnitude [dB]
M = [27.5 27.4 26.9 26.1 25.3 24.4 20.3 15 11.5 9.1 7.2 1.02 -6.02 -10.5 -14.2 -17.2 -26.9 -37.1 -39.7];
% Enter Phase [degrees]
P = [-6 -12 -23 -34 -40 -48 -66 -81 -87 -90 -93 -103 -119 -130 -140 -145 -165 -180 -185];

% Enter Plant System Transfer Function (Measured From Bode Plot)
n = 23.7;
d = conv([1/10 1],[1/1000 1]);
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Display Bode Plot
subplot(2,1,1)
semilogx(w,M)
title('Bode Plot')
xlabel('Frequency [rad/s]')
ylabel('Magnitude [dB]')
subplot(2,1,2)
semilogx(w,P)
xlabel('Frequency [rad/s]')
ylabel('Phase [degrees]')

% Calculate and Display Bode Plot and Stability Margins from Measured
% Plant Transfer Function
G = tf(n,d);
figure()
margin(G)
% -------------------------------------------------------------------
%%
close all
clear all
clc
% -------------------------------------------------------------------
% Part 2: Controller + Plant (Open-Loop) System
% -------------------------------------------------------------------
% Parameters
% -------------------------------------------------------------------
% Enter Frequency [rad/s]
w = [1 2 4 6 8 10 20 40 60 80 100 200 400 600 800 1000 2000 4000 5000];
% Enter Magnitude [dB]
M = [15.4 15.4 15.4 15.4 15.4 15.4 15.4 15.4 15.4 15.4 15.8 15.9 16.4 16.8 17.4 17.9 19.2 19.7 19.9];
% Enter Phase [degrees]
P = 180 + [-180 -180 -180 -180 -180 -180 -180 -180 -180 -180 -177 -174 -170 -168 -165 -165 -168 -171 -176];

% Enter Controller + Plant Transfer Function (Measured From Bode Plot)
n = 5.9 * conv([1/10 1],[1/600 1]);
d = conv([1/10 1],[1/1000 1]);
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Display Results
subplot(2,1,1)
semilogx(w,M)
title('Bode Plot')
xlabel('Frequency [rad/s]')
ylabel('Magnitude [dB]')
subplot(2,1,2)
semilogx(w,P)
xlabel('Frequency [rad/s]')
ylabel('Phase [degrees]')

% Calculate and Display Bode Plot and Stability Margins from Measured
% Plant Transfer Function
G = tf(n,d);
figure()
margin(G)
% -------------------------------------------------------------------
%%
close all
clear all
clc
% -------------------------------------------------------------------
% Part 3: Controller + Plant (Closed-Loop) System Simulink Model
% -------------------------------------------------------------------
% Simulink Parameters
% -------------------------------------------------------------------
% Controller + Plant Transfer Function (From Plot Part 2)
n = 5.9 * conv([1/10 1],[1/600 1]);
d = conv([1/10 1],[1/1000 1]);
% -------------------------------------------------------------------
% Function
% -------------------------------------------------------------------
% Calculate Closed-Loop Transfer Function and Display Margin Plot
G = tf(n,d)
T=feedback(G,1)
margin(T)
% The rest is in simulink file