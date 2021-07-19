close all
clear all
clc
% Solving for x in Ax=y using Gauss Seidel Method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input [A] and [y]
A=[10 -1  2  0;
   -1 11 -1  3;
    2 -1 10 -1;
    0  3 -1  8];
y=[  6;
    25;
   -11;
    15];
% Make initial guess [x]
x=zeros(4,1);
% Input tolerance error
tol=1e-4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine matrix size
[M,N]= size (A);
if M~=N
    error ('A is not a square matrix!');
end
% Check for diagonally dominant
for m=1:M
    row=abs(A(m,:));
    d=sum(row)-row(m);
    if row(m)<= d
        error('[A] is not diagonally dominant!');
    end
end
% Calculate diagonal matrix [D] (Lower part of [A])
D=tril(tril(A));
% Solve Loop
ITER=0;
err=inf;
while err > tol
    % Update [x]
    dx=D\(y-A*x);
    x=x+dx;
    ITER=ITER+1;
    % Compute Error
    err=max(abs(dx./x));
end

% Display result
disp(['After ' num2str(ITER) ' iterations...']);
x
