close all
clear all
clc
syms x
% Evaluating a Polynomial with input x values
% This function takes a polynomial, either in array
% format or symbolic representation, and x-values for
% which we use to evaluate the polynomial and returns
% the original polynomial and its roots
% Note: Polynomial in array must be input in
% descending order of degree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:10
    % Ask for polynomial
    p=input('Enter polynomial: ');
    fprintf('\n');
    % Ask for x values
    n=input('Enter number of x values: ');
    fprintf('\n');
    % Assign x values
    for i=1:n
        xval(i)=input(['x(' num2str(i) ') = ']);
        fprintf('\n');
    end
    % Use mypolyval function
    y=mypolyval(p, xval)
end
% Test
% p:  x^2+4*x+4
% xval:  [1 3 5]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = mypolyval(p, xval)
% Determine size of polynomial input
s=size(p);
% Set if statement argument
a=max(s);
% if polynomial is expressed as array convert to
% symbolic expression, else convert symbolic 
% polynomial to a double precision array
if(a>1)
    % Create polynomial symbolic equation
    P=poly2sym(p);
else
    % For Display purpose
    P=p;
    % Convert polynomial to double precision array
    c=double(coeffs(p));
    % Flip array for descending order polynomial
    p=flip(c);
end
% Solve
result=polyval(p,xval);

% Display
disp('The polynomial ');
pretty(P)
disp('evaluated with x value(s) of ');
xval
disp('is');
end