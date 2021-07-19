function [result] = mysimplifyFraction(f)
% This function simplifies numerical and symbolic fractions
% Solve in two ways
result(1)=simplifyFraction(f);
result(2)=simplifyFraction(f, 'Expand', true);
% Check if results are equivalent
equ=isequal(result(1),result(2));

% Display one result or both depending on if they're equal
fprintf('\n');
disp('The equation');
pretty(f)
disp('can be simplified to');
fprintf('\n');
if (equ==1)
    result(2)=[];
    pretty(result);
else
    pretty(result(1))
    disp('or...');
    fprintf('\n');
    pretty(result(2))
    result=result.';
end
end