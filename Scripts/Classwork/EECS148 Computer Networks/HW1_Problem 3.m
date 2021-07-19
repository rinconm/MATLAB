close all
clear all
clc
% Solving for what is the minimuz size for N that
% ensures that B < 2%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number of Significant Figures
n=5;
% Average # of active phone calls at any time
% to/from outside building
y=50*0.05;
% Indicate percentage of B
p=0.02;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize N to start while loop at N=0
N=-1;
% Initialize while variable B
B=1;
while B > p
    N=N+1;
    % Initialize den=0 for for loop
    den=0;
    % Create Denominator
    for n=0:N
        temp=2.5^n/factorial(n);
        % Solve for Denominator
        den=den+temp;
    end
    % Solve for Numerator
    num=2.5^N/factorial(N);
    % B = check
    B=num/den;
end

% Display result
disp('For B < 2%,');
N