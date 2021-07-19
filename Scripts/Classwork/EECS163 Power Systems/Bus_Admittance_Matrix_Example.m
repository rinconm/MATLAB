% INITIALIZE MATLAB
close all
clear all
clc
format long
syms H(z);

%
% PARAMETERS
%

Ybus=[-1i*8.5  1i*2.5    1i*5     0;
       1i*2.5 -1i*8.75   1i*5     0;
       1i*5     1i*5   -1i*22.5 1i*12.5;
       0         0       1i*12.5 -1i*12.5;];
Ibus=[-1i*1.1;
      -1i*1.25;
             0;
             0;];

%
% FUNCTION: Solve Vbus=Ybus^-1*Ibus
%

Vbus=Ybus\Ibus
