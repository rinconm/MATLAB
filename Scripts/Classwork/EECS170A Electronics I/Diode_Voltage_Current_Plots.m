close all
clear all
clc
format
% Diode Voltage-Current Plots from Experiment 3
% Data Collected using LTspice XVII
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ordinary p-n junction diode (Type: Silicon Part No:1N914)
V1=[0.808948 0.785921 0.757006 0.74229 0.724089 0.71281 0.699096 0.681237 0.654719 0.651165 0.647351 0.643235 0.638762 0.633859 0.628439 0.622378 0.615503 0.607562 0.598177 0.586727 0.57214 0.552332 0.522805 0.473779 0.395351 0.299441 0.199938 0.0999939 -0.999999 -2 -3 -4 -5 -10 -15 -20];
I1=[63.9702 47.3803 30.81 24.1924 17.5864 14.2906 11.003 7.72921 4.48427 4.16278 3.84216 3.52255 3.20413 2.88714 2.57187 2.25874 1.94832 1.64146 1.33941 1.04424 0.759534 0.492227 0.257316 8.74028e-2 1.5496e-2 1.86461e-3 2.05245e-4 2.03742e-6 -2.521e-6 -2.522e-6 -2.523e-6 -2.524e-6 -2.525e-6 -2.53e-6 -2.535e-6 -2.54e-6];

% Zener diode (Part No: 1N750)
V2=[0.839458 0.827268 0.811525 0.803306 0.792921 0.786354 0.778214 0.767286 0.750093 0.747662 0.745011 0.742093 0.73885 0.735202 0.731035 0.726178 0.720384 0.713235 0.703999 0.691249 0.671863 0.638603 0.579873 0.495445 0.399167 0.299859 0.199977 0.0999962 -0.99996 -1.99944 -2.99279 -3.92105 -4.00259 -4.08083 -4.15552 -4.22645 -4.29336 -4.35566 -4.41181 -4.45907 -4.49554 -4.52239 -4.61761 -4.66862 -4.69347 -4.72893 -4.75127];
I2=[63.8685 47.2424 30.6283 23.989 17.3569 14.0455 10.7393 7.44238 4.16636 3.84113 3.51663 3.19302 2.8705 2.54933 2.22988 1.91274 1.59872 1.28922 0.986668 0.695837 0.427124 0.204658 6.70887e-2 1.51843e-2 2.77644e-3 4.68624e-4 7.78209e-5 1.2621e-5 -1.33629e-4 -1.85207e-3 -2.4049e-2 -0.263164 -0.324703 -0.397246 -0.481617 -0.578517 -0.688804 -0.814456 -0.960624 -1.13645 -1.34821 -1.59204 -4.60797 -11.1046 -17.6884 -34.2369 -50.8291];

% Schottky diode (Part No: 1N5818)
V3=[0.274591 0.263395 0.247897 0.239456 0.228616 0.221753 0.213343 0.202455 0.18695 0.18497 0.182878 0.18066 0.178299 0.175778 0.173071 0.170151 0.166981 0.163513 0.15969 0.155429 0.15062 0.145107 0.138656 0.130897 0.121205 0.1084 0.0899253 0.05918 -0.99049 -1.99049 -2.99049 -3.99049 -4.99049 -9.99049 -14.9905 -19.9905];
I3=[65.7514 49.122 32.507 25.8685 19.2379 15.9275 12.6222 9.32515 6.0435 5.71677 5.39041 5.06447 4.739 4.41407 4.08976 3.76616 3.4434 3.12162 2.80103 2.4819 2.1646 1.84964 1.53781 1.23034 0.929317 0.638668 0.366916 0.136067 -3.17e-2 -3.17e-2 -3.17e-2 -3.17e-2 -3.17e-2 -3.17e-2 -3.17e-2 -3.17e-2];

% Light-emitting diode (LED) (Part No: NSCW100)
V4=[4.15489 3.9354 3.66769 3.53027 3.35054 3.22672 3.04917 2.7234 1.98532 1.88999 1.79321 1.69542 1.59692 1.49793 1.39861 1.29907 1.19938 1.09959 0.999724 0.899817 0.799879 0.699921 0.599949 0.499967 0.39998 0.299988 0.199994 0.0999975 -0.999995 -1.99999 -2.99999 -3.99999 -4.99999 -10 -15 -20];
I4=[52.817 36.882 21.1077 14.8991 8.83154 5.91092 3.16942 0.921993 4.8929e-2 3.33753e-2 2.2629e-2 1.52767e-2 1.02813e-2 6.90374e-3 4.62759e-3 3.09718e-3 2.06976e-3 1.38073e-3 9.18959e-4 6.09641e-4 4.02507e-4 2.6383e-4 1.70998e-4 1.08861e-4 6.72726e-5 3.94384e-5 2.08102e-5 8.3433e-6 -1.65769e-5 -1.68765e-5 -1.68829e-5 -1.6884e-5 -1.6885e-5 -1.689e-5 -1.6895e-5 -1.69e-5];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display Results
%plot(V1,I1)
%xlabel('Voltage (V)'), ylabel('Current (mA)'), title('Ordinary Diode Part No:1N914');
%plot(V2,I2)
%xlabel('Voltage (V)'), ylabel('Current (mA)'), title('Zener Diode Part No: 1N750');
%plot(V3,I3)
%xlabel('Voltage (V)'), ylabel('Current (mA)'), title('Schottky Diode Part No: 1N5818');
plot(V4,I4)
xlabel('Voltage (V)'), ylabel('Current (mA)'), title('Light-emitting Diode Part No: NSCW100');
