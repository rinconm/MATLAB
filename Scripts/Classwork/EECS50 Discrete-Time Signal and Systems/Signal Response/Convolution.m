close all
clear all
clc
% Solve y[n]=x[n]*h[n] by Convolution
% Note: x[n], h[n], and y[n] contain the constants
%       of the Delta function sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter x[n] and its range
%x=[1 2 2 1 2];
%nx=[-2:2];
x=[5 1 1 2 1 1];
nx=[0:5];
% Enter h[n] and its range
%h=[2 2 -1 1 2 2 1];
%nh=[-3:3];
h=hn;
nh=[0:20];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Specify the lower and upper bounds of y[n]
nmin=min(nx)++min(nh);
nmax=max(nx)+max(nh);
% Solve for y[n]
y=conv(x,h);
% Define y[n] range
n=[nmin:nmax];

% Plot y[n]
stem(n, y, 'fill');grid
title('Plot of x[n]*h[n]')
ylabel('y[n]')
xlabel('n')
disp('    y[n] Table');
disp('     n     y');
[n' y']