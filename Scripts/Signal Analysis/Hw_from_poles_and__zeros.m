close all
clear all
clc
format
% To plot the Frequency Response H(w) from the pole and zero locations
% Note: We represent Hw as n/d where n is the numerator and d is the 
%       denominator, n is represented as b1*b2*...*bn, and d is
%       represented as a1*a2*...*am, r represents zero location, p 
%       represents pole location and G represents Gain. Finally, we 
%       will input the pole and zero in cartesian coordinates for 
%       complex values
%       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms W                                  % angular frequency w variable
syms G                                  % Gain variable for Hw
% Parameters
w=-pi:pi/100:pi;                       % Set <H(w) w range
% Enter G if any (default is 1)
Gain=4;

% Enter coefficients of the factor form of the zero locations
% (1-r*z^-1) -> [1 -r]
b1=[1 -exp(-1i*3*pi/4)];
b2=[1 -exp(1i*3*pi/4)];

% Enter coefficients of the factor form of the root locations
% (1-p*z^-1) -> [1 -p];
a1=[1 -0.5];
a2=[1 -0.5];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create Hw symbolic form equation
b1w=b1(1)+b1(2)*exp(-1i*W);
b2w=b2(1)+b2(2)*exp(-1i*W);
a1w=a1(1)+a1(2)*exp(-1i*W);
a2w=a2(1)+a2(2)*exp(-1i*W);
temp=G*b1w*b2w/(a1w*a2w);
HW=Gain*b1w*b2w/(a1w*a2w);
Hw=double(subs(HW,W,w));                % H(w) values with w range
Hmag=abs(Hw);                           % |H(w| values
Hph=angle(Hw)*180/pi;                   % <H(w) values in degrees
% Multiply the factors to get Hw form for freqz and fvtool
n=Gain*conv(b1,b2);
d=conv(a1,a2);

% Display
disp('The Transfer Function')
pretty(temp)
str=['with G = ',num2str(Gain)];
disp(str)
% Plots
figure
subplot(2,1,1), plot(w,Hmag);
xlabel('Radians'), ylabel('|H(w)|'), title('Magnitude Response');
subplot(2,1,2), plot(w,Hph);
xlabel('Radians'), ylabel('Angle of H(w)'), title('Phase Response');
figure
freqz(n,d)
fvtool(n,d)
