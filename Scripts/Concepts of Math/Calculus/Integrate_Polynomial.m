%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Integral of a Polynomial with respect to x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
syms x C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Polynomial Coefficients in Descending Order
p=[3 0 -4 10 -25];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine size of polynomial
s=size(p,2);
% Create polynomial equation
c=flip(p);
P=0;
for i=s:-1:1
    dp=c(i)*x^(i-1);
    P=P+dp;
end
% Solve and create solution equation
q=polyint(p);
d=flip(q);
I=0;
for i=s:-1:1
    dI=d(i+1)*x^(i);
    I=I+dI;
end
I=I+C;

% Display result
disp('The Integral of')
pretty(P)
disp('is')
pretty(I)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Value of Integral of a Polynomial
%  with limits of integration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
syms x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Polynomial Coefficients in Descending Order
p=[3 0 -4 10 -25];
% Enter limits of integration (a=lower bound)
a=-1;
b=3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine size of polynomial
s=size(p,2);
% Create Polynomial equation
% Flip polynomial matrix for loop
c=flip(p);
P=0;
for i=s:-1:1
    dp=c(i)*x^(i-1);
    P=P+dp;
end
% Solve
q=polyint(p);
I=diff(polyval(q,[a b]));

% Display result
disp('Integrating')
pretty(P)
disp(['from ' num2str(a) ' to ' num2str(b) ' is']);
I