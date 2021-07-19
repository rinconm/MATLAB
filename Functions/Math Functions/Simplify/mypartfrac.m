function result = mypartfrac(num, den)
% Partial Fraction Expansion/Decomposition
% This function takes a polynomial fraction, either in array or
% symbolic format, and returns the partial fraction expression
% as a real expresssion and will return imaginary expression
% if it exists

% Determine size of numerator and denominator
syms x
sn=size(num);
sd=size(den);
% Set numerator and denominator if statement argument
a=max(sn);
b=max(sd);
% if numerator is expressed as array convert to
% symbolic expression, then check if denominator is
% expressed as array, if it is, convert to symbolic 
% expression, else create array of coefficents of 
% the numerator and denominator
if(a>1)
    % Create numerator symbolic equation
    N=poly2sym(num);
    % For residue formula
    n=num;
    if (b>1)
        % Create denominator symbolic equation
        D=poly2sym(den);
        % For residue formula
        d=den;
    else
        % Assign symbolic equation
        D=den;
        % Convert symbolic expression to double precision array
        c=double(coeffs(den));
        % Flip array for descending order polynomial
        d=flip(c);
    end
else
    % Assign symbolic equation
    N=num;
    % Convert symbolic expression to double precision array
    c=double(coeffs(num));
    % Flip array for descending order polynomial
    n=flip(c);
    if (b>1)
        % Create denominator symbolic equation
        D=poly2sym(den);
        % For residue formula
        d=den;
    else
        % Assign symbolic equation
        D=den;
        % Convert symbolic expresion to double precision array
        c=double(coeffs(den));
        % Flip array for descending order polynomial
        d=flip(c);
    end
end
% Combine numerator and denominator symbolic equation
P=N/D;
% Solve for roots of function
r=roots(n);
% Determine if roots are real
re=isreal(r);
% Solve for real expression
result=partfrac(P);

% Display results
fprintf('\n');
disp('The equation');
pretty(P)
disp('expands to');
fprintf('\n');
% Display Different results depending on if real expression
if (re==1)
    pretty(result)
else
    pretty(result(1))
    result(2)=partfrac(P,x, 'FactorMode', 'complex');
    disp('The complex expression is ');
    fprintf('\n');
    pretty(result(2))
    result=result.';
end
end