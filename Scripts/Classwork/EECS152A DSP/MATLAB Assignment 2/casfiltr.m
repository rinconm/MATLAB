function y = casfiltr(G,B,A,x)
% CASCADE form realization of IIR and FIR filters
% -----------------------------------------------
% y = casfiltr(b0,B,A,x);
%  y = output sequence
%  G = gain coefficient of CASCADE form
%  B = K by 3 matrix of real coefficients containing bk's
%  A = K by 3 matrix of real coefficients containing ak's
%  x = input sequence
%
[K,L] = size(B);    % Set K to number of cascaded systems
N = length(x);      % Set N to size of input
w = zeros(K+1,N);   % Preallocate w variable K+1 x N
w(1,:) = x;         % Set first row of variable w to the input
for i = 1:1:K       % Filter function on each system in order
    w(i+1,:) = filter(B(i,:),A(i,:),w(i,:));
end                 % Note: We use the output as the input
y = G*w(K+1,:);     % Output
