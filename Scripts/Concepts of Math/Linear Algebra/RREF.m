close all
clear all
clc
% Obtain the Reduced Row Echelon Form of Matrix A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input constants of matrix A
A=[ 2  3 -1 5;
   -4  6  8 7;
   10 12 14 9];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
Arref=rref(A);

% Display
disp('The Matrix');
A
disp('has row reduced echelon form of');
Arref