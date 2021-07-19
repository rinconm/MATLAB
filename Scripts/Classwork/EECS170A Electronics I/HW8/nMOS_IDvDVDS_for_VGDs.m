close all
clear all
clc
format
% PLOT a Normalized nMOS Diode Current (ID) vs Drain-to-Source
% (VDS) for varying VGD where VGD=VGS+VDS (Voltage source in series
% from drain-to-gate terminal)
% Note: Due to insufficient parameters given we will % express a 
% normalized IDvVDS graph (in terms of VT), more specifically: 
% ID/Kn=VGS/VT for given VGD/VT so that VGS and VD are in terms of 
% threshold voltage VT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter VGD/VT Values
VGDVT=[0 1/2 2];

% Enter VDS/VT Range
VDSVT=0:5/100:5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
s=size(VGDVT);
r=size(VDSVT);
% Current Loop
Ltext1="V_G_D = ";              % Preallocation for speed
Ltext2="*V_T";
Ltext=strings(s(2),1);
VGSVT=zeros(s(2),r(2));
IDKn=zeros(s(2),r(2));
for i=1:1:s(2)
 for j=1:1:r(2)
  VGSVT(i,j)=VGDVT(i)+VDSVT(j);     % Define VGSVT
  if VGSVT(i,j)>1                   % Check if MOSFET is turned on
    if VGSVT(i,j)>VDSVT(j)+1        % If in Triode Mode
      IDKn(i,j)=2*(VGSVT(i,j)-1)*VDSVT(j)-VDSVT(j)^2;
    else                            % If in Saturation Mode
     IDKn(i,j)=(VGSVT(i,j)-1)^2;
    end
  else                              % MOSFET is off
  end 
 end
 Ltext(i)= Ltext1+num2str(VGDVT(i))+Ltext2; % Legend String
end

% Display Results
text2="Diode Current (I_D) vs. Drain-to-Source Voltage (V_D_S)";
text3=" for an n-Channel MOSFET";
titletext=text2+text3;
plot(VDSVT,IDKn)
title(titletext)
xlabel('V_D_S (V_T)'), ylabel('I_D/Kn (VT^2)'), grid on
legend(Ltext)
