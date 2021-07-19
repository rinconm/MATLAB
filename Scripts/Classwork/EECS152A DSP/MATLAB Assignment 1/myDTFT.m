function [H,wax] = myDTFT(h,N)
% Purpose: This function determines the discrete-time Fourier Transform 
%          of a discrete function and plots the magnitude and phase 
% Note: This function assumes that the input is in the form of a
%       1xN array (i.e. {1,2,3,...,N}) and assumes the first number 
%       in the array is the sample value at n=0.
syms W
if nargin < 2                       % If input arguments < 2
    N=length(h);                    % Fix N to the length of h
end
% Parameters
wax=-pi:pi/N:pi;                    % Set w range

% Function
s=size(h);                          % Determine number of samples
temp=sym(zeros(1,s(2)));            % Preallocate variable for speed

for k=0:1:s(2)-1                    % Create DTFT equation in array
   temp(k+1)=h(k+1)*exp(-1i*W*k);
end

Hw=sum(temp);                       % Symbolic H(w) result
H=double(subs(Hw,W,wax));           % H(w) values with W range
Hmag=abs(H);                        % |H(w| values
Hph=angle(H)*180/pi;                % <H(w) values in degrees

% Plots
subplot(2,1,1), plot(wax/pi,20*log10(Hmag));
xlabel('Normalized Frquency'), ylabel('|H(w)|'), title('Magnitude Response');
subplot(2,1,2), plot(wax/pi,Hph);
xlabel('Normalized Frequency'), ylabel('Angle of H(w)'), title('Phase Response');

end
