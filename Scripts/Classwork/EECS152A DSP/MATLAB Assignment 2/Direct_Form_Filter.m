close all
clear all
clc
% % Direct Form realization of IIR and FIR filters
% -----------------------------------------------
%  y = filtr(b,a,x)
%  y = output sequence
%  b = 1 by N matrix of real coefficients of Numerator
%  a = 1 by M matrix of real coefficients of Denominator
%  x = input sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter numerator and denominator coefficients 
b=[1 1/2 1/4 1/8 1/16 1/32];
a=[1 -1/3 -1/9 -1/27 -1/81 -1/243];

% Enter Input Sequence
x=ones(1,21);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
y=filter(b,a,x)

% Display Results
n=0:1:20;
stem(n,y)
xlabel('n')
ylabel('y(n)')