function result = myfactor(p)
% This function takes a polynomial, either in array
% format or symbolic representation, finds the roots
% and returns the original polynomial and its roots
% Note: Polynomial in array must be input in 
% descending order of degree

syms x temp
% Determine size of polynomial input
s=size(p);
% Set if statement argument
a=max(s);
% if polynomial is expressed as array convert to
% symbolic expression, else create array
if(a>1)
    % Create polynomial symbolic equation
    P=poly2sym(p);
else
    % For display purpose
    P=p;
    % Convert polynomial to double precision array
    c=double(coeffs(p));
    % Flip array for descending order polynomial
    p=flip(c);
end
% Solve for roots
r=roots(p);
% Determine if roots are real
re=isreal(r);

% Display
fprintf('\n');
disp('The polynomial')
pretty(P)
disp('factors to')
fprintf('\n');
% Display Different results depending on if roots are
% real and integer, real and not integer, or complex
if (re==1)
    % Determine if roots are integers
    int=double(rem(r,1)==0);
    if (int==1)
        % Factor symbolic equation
        F=factor(P);
        % Create factored symbolic equation
        result=prod(F);
        pretty(result)
    else
        % Determine size of roots array
        sr=size(r,1);
        for i=1:sr
            temp(i)=(x-r(i));
        end
        % Create factored symbolic equation
        result=prod(temp);
        pretty(result)
    end
else
    % Determine size of roots array
    sr=size(r,1);
    for i=1:sr
        temp(i)=(x-r(i));
    end
    % Create factored symbolic equation
    result=prod(temp);
    pretty(result)
end
end