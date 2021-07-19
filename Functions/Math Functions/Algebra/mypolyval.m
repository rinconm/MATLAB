function result = mypolyval(p, x)
% This function takes a polynomial, either in array
% or symbolic format, and x-values for which we use
% to evaluate the polynomial and returns the original 
% polynomial and its roots
% Note: Polynomial in array must be input in
% descending order of degree

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
result=polyval(p,x);

% Display
fprintf('\n');
disp('The polynomial ');
pretty(P)
disp('evaluated with x value(s) of ');
x
disp('is');
end