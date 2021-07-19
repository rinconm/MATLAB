close all
clear all
clc
% Solve and Plot Difference Equation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter sample index
ni=[0:20];
% Enter initial value
y(1)=1000;
% Enter difference equation in Function: Solve Loop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine sample size
s=size(ni,2);
% Solve Loop
for n=2:s;
y(n)=(1.2*y(n-1)-100)*((n-1)>=0)+1,000*(n==0);
end

% Display Results
disp('The values and plot of y[n] are');
y
stem(ni,y,'fill'),grid