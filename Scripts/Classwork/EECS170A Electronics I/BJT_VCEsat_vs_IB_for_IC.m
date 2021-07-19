close all
clear all
clc
format
% Plot the Collector-Emitter Saturation Voltage (VCE(sat)) vs.
% Base Current (IB) for a given IC of a BJT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Given Parameters
aF=0.975;                               % Alpha_F
aR=0.150;                               % Alpha_R
IC=5;                                   % Collector Current
T=300;                                  % Temperature

% Enter Base Current Range and Step Size
IB=0.15:0.01:1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
kT=0.0259/300*T;
r=size(IB);
VCEsat=zeros(1,r(2));
for i=1:1:r(2)
 VCEsat(i)=kT*log(((IC*(1-aR)+IB(i))/(aF*IB(i)-(1-aF)*IC)*aF/aR));
end

% Display Results
plot(IB,VCEsat)
text2="Collector-Emitter Saturation Voltage (VCE(sat) vs. ";
text3="Source-to-Drain Voltage (V_S_D) for the BJT";
titletext(1,1)=text2;
titletext(2,1)=text3;
title(titletext)
xlabel('I_B (A)'), ylabel('V_C_E(sat) (V)'), grid on
