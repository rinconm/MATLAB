close all
clear all
clc
syms x1 x2
% Solving for x in f(x)=y using Newton-Raphson Method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number of Significant Figures
n=5;
% Input function(s) f and [y]
f1=x1+x2;
f2=x1*x2;
f=[f1;
   f2];
y=[15;
   50];
% Make initial guess for x1 and x2
x1val=4;
x2val=9;
x=[4;
   9];
% Indicate tolerance
tol=10e-4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Jacobian Matrix
J=jacobian(f,[x1, x2]);
% Solve Loop
ITER=0;
err=inf;
while err > tol
    %Calculate value of function f at x
    fval=[subs(f1,[x1, x2], [x(1), x(2)]);
          subs(f2,[x1, x2], [x(1), x(2)])];
    % Calculate value of Jacobian matrix
    Jval=subs(J,[x1,x2],[x(1),x(2)]);
    % Update [x]
    xnext=x+Jval\(y-fval);
    dx=x-xnext;
    x=xnext;
    % Update iteration count
    ITER=ITER+1;
    % Compute error
    err=max(abs(dx./x));
end
% Converting x to required significant figures
x = x - rem(x,10^-(n-1));

% Display result
disp(['After ' num2str(ITER) ' iterations...']);
x