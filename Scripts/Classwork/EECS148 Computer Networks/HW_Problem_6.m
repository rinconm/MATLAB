close all
clear all
clc
format long
% Solving for P(X>=51)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P(X>=51) = (1 - P(x<51))

% initialize sum
sum=0;
for i=0:50
   temp=nchoosek(120,i)*(0.1)^i*(0.9)^(120-i)
   sum=sum+temp;
end
result=1-sum;

% Display result
disp('Probability of P(X>=51) = ,');
result