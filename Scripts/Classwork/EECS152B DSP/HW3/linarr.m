function [A,D,D2,W,T]=linarr(m,ang,sep)
% This function creates steering vectors for adaptive beamforming
% for a m-array of antennas
%
% Input 
% m: Number of Antennas
% ang: Angle of "Steering Vector" or "Array Response"(degrees)
% sep: Value of Delta in spatial frequency formula

% Spatial Frequency Formula
% ws=2*pi*d*sind(theta)    where d is a fraction of lambda(wavelength)

% Output
% A: Steering Vector
% D: 
% D2: 
% W: 
% T: 

if nargin < 3
  sep=0.5;
end
rang=sin(ang(:)*pi/180);
cang=cos(ang(:)*pi/180);
j=sqrt(-1);
r=[0:m-1]';
T=2*pi*r*sep*rang';
A=exp(-j*T);
if nargout > 1  
  W=2*pi*r*sep*cang';
  D=-j*W.*A;
  D2=(j*T-W.*W).*A;
end
