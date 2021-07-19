close all
clear all
clc
syms x1 x2 x3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NUMBER OF DECIMAL PLACES
n=4;
% DEFINE f AND [y]
f1=x1^3-10*x1+x2-x3;
f2=x2^3+10*x2+2*x1-2*x3;
f3=x1+x2-10*x3+2*sin(x3);
f=[f1;
   f2;
   f3];
y=[-3;
    5;
   -5];
% MAKE INITIAL GUESS
x=[1;
   1;
   1];
% INDICATE TOLERANCE
tol=1e-4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Jacobian matrix
J=jacobian(f,[x1, x2, x3]);
% Solve Loop
ITER=0;
err=inf;
while err > tol
    % Calculate value of function at x
    fval=[subs(f1,[x1, x2, x3], [x(1), x(2), x(3)]);
          subs(f2,[x1, x2, x3], [x(1), x(2), x(3)]);
          subs(f3,[x1, x2, x3], [x(1), x(2), x(3)])];
    % Calculate value of Jacobian Matrix
    Jval=subs(J,[x1,x2,x3],[x(1),x(2),x(3)]);
    % Update [x]
    xnext=vpa(x+Jval\(y-fval));
    dx=x-xnext;
    x=xnext;
    % Update iteration count
    ITER=ITER+1;
    % Compute error
    err=max(abs(dx./x));
end
% Converting x to required significant figures
x = x - rem(x,10^-(n));

% Display result
disp(['After ' num2str(ITER) ' iterations...']);
x