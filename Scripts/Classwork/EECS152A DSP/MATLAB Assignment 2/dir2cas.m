function [G,B,A] = dir2cas(b,a)
% DIRECT-form to CASCADE-form conversion (cplxpair version)
% -------------------------------------------------------------------
% This function converts a DIRECT-form transfer function H(z) in the 
% form of B/A where B is the numerator and A is the denominator and 
% converts to second order cascade form: G(A1/B1+A2/B2+...+AK/BK)
% [G,B,A] = dir2cas(b,a)
%  G = gain coefficient
%  B = K by 3 matrix of real coefficients containing bk's
%  A = K by 3 matrix of real coefficients containing ak's
%  b = numerator polynomial coefficients of DIRECT form
%  a = denominator polynomial coefficients of DIRECT form

b0=b(1);                    % Compute gain coefficient of numerator
b=b/b0;                     % Normalize numerator polynomial
a0=a(1);                    % Compute gain coefficient of denominator
a=a/a0;                     % Normalize denominator polynomial
G=b0/a0;                    % Gain
M=length(b);                % Size of numerator b
N=length(a);                % Size of denominator a
if N > M                    % Pad array b with zeros if N > M
	b=[b zeros(1,N-M)];
elseif M > N                % Pad array a with zeros if M > N
	a=[a zeros(1,M-N)];     % and set N = M for if variable
    N=M;
end
K=floor(N/2);               % Set a check variable
B=zeros(K,3);               % Preallocate B variable
A=zeros(K,3);               % Preallocate A variable
if K*2 == N                 % Check if number of terms is even
	b=[b 0];                % and if not, pad 0
	a=[a 0];
end
broots=cplxpair(roots(b));  % Find roots of b and a and organize
aroots=cplxpair(roots(a));  % into complex-pairs first, then real #s
for i=1:2:2*K               % Create Cascade Form coefficients
	Brow=broots(i:1:i+1,:); 
	Brow=real(poly(Brow));  
	B(fix((i+1)/2),:)=Brow; 
	Arow=aroots(i:1:i+1,:); 
	Arow=real(poly(Arow));  
	A(fix((i+1)/2),:)=Arow; 
end
