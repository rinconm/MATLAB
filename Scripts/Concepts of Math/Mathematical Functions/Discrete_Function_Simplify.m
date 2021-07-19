close all
clear all
clc
format
syms n
% Simplify f[n]
% This script takes a function, simplifies it regularly
% and with assumption of integer variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:10
    % Ask for function
    f=input('Enter f[n]: ');
    fprintf('\n');
    % Use intsimplify function
    F=discsimplify(f);
end
% Test 
% sin(2*n*pi)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = discsimplify(f)
% This function takes a function, simplifies it regularly
% and with assumption of integer variable
% Solve
syms n
result(1)=simplify(f);
% Solve with assumption
assume(n,'integer')
result(2)=simplify(f);
% Check if results are equivalent
equ=isequal(result(1),result(2));

% Display one result or both depending on if they're equal
fprintf('\n');
disp('The equation');
pretty(f)
disp('simplifies to');
fprintf('\n');
if (equ==1)
    result(2)=[];
    pretty(result(1))
    disp('assuming n as an integer has no change!');
else
    result(1)=result(2);
    result(2)=[];
    pretty(result(1))
end
end