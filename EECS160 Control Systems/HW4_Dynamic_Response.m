
% Purpose: These 3 programs are used to verify the results of HW4
% problems 3.27, 3.35, and 3.36 in Feedback Control of Dynamic
% Systems textbook
% Note: To run each program individually, click on 'Run Section'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.27: Unity Feedback System - Verifying Overshoot and Settling Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Compensator Variables to Verify
K = 113;                % Compensator Gain
a = 67.2;               % Compensator Pole (s = -a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_c = tf(K,[1 a]);      % Compensator Transfer Function
G_p = tf(100,[1 25]);   % Plant Transfer Function
G_o = G_c*G_p;          % Open-Loop Gain (Forward Gain)
T = feedback(G_o,1);    % Closed-Loop Gain (Total Gain)
% Display Results
step(T)                 % Step Response of System
stepinfo(T)             % Step Response Specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3.35: Position Servo System - Verifying Overshoot and Settling
%        Time (Individually)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter K Variable
K = [0.5 1 2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create System Transfer Functions for Varying K Values
i = 1;                          
for i = 1:3
    T(i) = tf(0.2*K(i),[1 0.104 0.2*K(i)]);
    i = i+1;
end
% Display Results
step(T(1),T(2),T(3))                    % Step Response of Systems
legend('K = 0.5','K = 1','K = 2')
SI_0_5 = stepinfo(T(1))                 % T1 Specifications
SI_1 = stepinfo(T(2))                   % T2 Specifications
SI_2 = stepinfo(T(3))                   % T3 Specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3.36: Satellite Tracking System - Verifying Overshoot and Settling
%        Time (Individually)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter K Variable
K = [200 400 1000 2000];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create System Transfer Functions for Varying K Values
i = 1;                          
for i = 1:4
    T(i) = tf(K(i)*1.667e-6,[1 1/30 K(i)*1.667e-6]);
    i = i+1;
end
% Display Results
step(T(1),T(2),T(3),T(4))               % Step Response of Systems
legend('K = 200','K = 400','K = 1000','K = 2000')
SI_200 = stepinfo(T(1))                 % T1 Specifications
SI_400 = stepinfo(T(2))                 % T2 Specifications
SI_1000 = stepinfo(T(3))                % T3 Specifications
SI_2000 = stepinfo(T(4))                % T4 Specifications
