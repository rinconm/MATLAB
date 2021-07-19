function [H,W] = dtft(h,N)
% This function calculates the Discrete Time Fourier Transform
% at N equally spaced frequencies
% [H,W] = dtft(h,N) 
% 
% h: finite-length input vector, whose length is L and the first
%    value is h[0]
% N: number of frequencies for evaluation over [-pi,pi)
%    ==> Constraint: N >= L
%     (if N not included, it is assumed to be equal to length of h)
% H: H(w) values (complex) in Magnitude value (not dB)
% W: Vector of freqs where DTFT is computed

if nargin < 2                   % If input arguments < 2
    N=length(h);                % Fix N to the length of h
end
N = fix(N);                     % Round N down to nearest whole #
L = length(h);                  % Length of input h vector
h = h(:);                       % Transpose input h vector
if( N < L )                     % Error if samples > length of h
   error('DTFT: # of data samples cannot exceed # of freq samples')
end
W = (2*pi/N)*[0:(N-1)]';        % [0 ... (2pi-N)]/N transposed W vect
mid = ceil(N/2)+1;              % Midpoint+1 value of N for shift
W(mid:N) = W(mid:N)-2*pi;       % Move [pi,2pi) to [-pi,0)
W = fftshift(W);                % Rearrage W to [-pi,pi]
H = fftshift(fft(h,N));         % Find DFT using FFT and rearrange
                                % to be centered at [-pi,pi]