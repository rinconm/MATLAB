close all
clear all
clc
format
% Plot the Diode Current versus Source-to-Drain Voltage of an
% Ideal p-Channel MOSFET with different Source-to-Gate voltages
% given certain parameters (EECS170A HW8 Problem 10.38 parts a-c)
% Part a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Given Parameters
VT=-0.35;           % Threshold Voltage (V)
up=210;             % Hole Mobility (cm^2/V-s)
tox=11e-7;          % Oxide Thickness (cm)
W=35e-6;            % Channel Width (m)
L=1.2e-6;           % Channel Length (m)
Kox=3.9;            % Oxide Dielectric Constant
e0=8.85e-14;        % Permittivy of Free Space Constant (F/cm)

% Enter Source-to-Drain Voltage Range and Index Range (V)
VSD=0:3/100:3;

% Enter Source-to-Gate Voltages of Interest (V)
VSG=[0 0.6 1.2 1.8 2.4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
eox=Kox*e0;         % Permittivy of the Oxide (F/cm)
Cox=eox/tox;        % Oxide Capacitance (F/cm^2)
Kp1=up*Cox*W/(2*L); % Conduction parameter (A/V^2)
Kp=Kp1*10^3;        % KP converted for mA range (mA/V^2)
% Current Definition Loop
s=size(VSG);        % Determine number of VSG values
r=size(VSD);        % Determine number of VSD values (range)
Ltext1="V_S_G = ";        % Legend preset
ID=zeros(s(2),r(2));      % Preallocate variables for speed
Ltext=strings(s(2)+1,1);
VSDsat=zeros(s(2),1);
ISDsat=zeros(s(2),1);
for i=1:1:s(2)
 if VSG(i)>abs(VT)  % Check if MOSFET is turned on
  for j=1:1:r(2)    % Turned on and will define ID due to bias
   VSDsat(i)=VSG(i)+VT;        % Find Source-to-Drain Saturation
   ISDsat(i)=Kp*(VSDsat(i))^2; % voltage and current
   if VSD(j)<VSDsat(i)         % Triode Region current
     ID(i,j)=Kp*(2*(VSG(i)+VT)*VSD(j)-VSD(j)^2);
   else                        % Saturation Region current
     ID(i,j)=ISDsat(i);
   end
  end
 else                          % Turned off and no diode current
  VSDsat(i)=0;
  ISDsat(i)=0;
 end
 Ltext(i)= Ltext1 + num2str(VSG(i)); % Legend String
end
Ltext(i+1)='V_S_D(sat)';            % Add VSD(sat) to Legend String
% Display Results
plot(VSD,ID)
hold
plot(VSDsat,ISDsat,'bd');
text2="Diode Current (I_D) vs. Source-to-Drain Voltage (V_S_D)";
text3=" for a p-Channel MOSFET";
titletext=text2+text3;
title(titletext)
xlabel('V_S_D (V)'), ylabel('I_D (mA)'), grid on
legend(Ltext)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part b) Plot sqrt(ID(sat)) for the Source-to-Gate Voltage range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format 
% Enter Given Parameters
VT=-0.35;           % Threshold Voltage (V)
up=210;             % Hole Mobility (cm^2/V-s)
tox=11e-7;          % Oxide Thickness (cm)
W=35e-6;            % Channel Width (m)
L=1.2e-6;           % Channel Length (m)
Kox=3.9;            % Oxide Dielectric Constant
e0=8.85e-14;        % Permittivy of Free Space Constant (F/cm)

% Enter Source-to-Gate Voltages of Interest (V)
VSG=[0 0.6 1.2 1.8 2.4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
eox=Kox*e0;         % Permittivy of the Oxide (F/cm)
Cox=eox/tox;        % Oxide Capacitance (F/cm^2)
% Current Definition Loop
s=size(VSG);        % Determine number of VSG values
sqrtIDsat=zeros(1,s(2));  % Preallocate variable for speed
for i=1:1:s(2)
 if VSG(i)>abs(VT)
  sqrtIDsat(1,i)=sqrt(W*up*Cox/(2*L))*(VSG(i)+VT);
 end
end
% Define zero current for the threshold voltage and include
% VT in range if not already
if VSG(1,:)~=abs(VT)
 sqrtIDsat=sort([sqrtIDsat 0]);
 VSG=sort([VSG abs(VT)]);
end

% Display Results
plot(VSG,sqrtIDsat)
text1="sqrt(I_D(sat))";
text2=" vs. Source-to-Drain Voltage V_S_D for a p-Channel MOSFET";
titletext=text1+text2;
title(titletext)
xlabel('V_S_G (V)'), ylabel('I_D(sat) (sqrt(A)'), grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part c) Plot ID vs VSG for 0<=VSG<=2.4 and for VSD=0.1V
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format 
% Enter Given Parameters
VT=-0.35;           % Threshold Voltage (V)
up=210;             % Hole Mobility (cm^2/V-s)
tox=11e-7;          % Oxide Thickness (cm)
W=35e-6;            % Channel Width (m)
L=1.2e-6;           % Channel Length (m)
Kox=3.9;            % Oxide Dielectric Constant
e0=8.85e-14;        % Permittivy of Free Space Constant (F/cm)

% Enter Source-to-Drain Voltage
VSD=0.1;

% Enter Source-to-Gate Voltage Range (V)
VSG=0:2.4/100:2.4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
eox=Kox*e0;         % Permittivy of the Oxide (F/cm)
Cox=eox/tox;        % Oxide Capacitance (F/cm^2)
Kp1=up*Cox*W/(2*L); % Conduction parameter (A/V^2)
Kp=Kp1*10^3;        % KP converted for mA range (mA/V^2)
% Current Definition Loop
r=size(VSG);        % Determine number of VSG values (range)
for i=1:1:r(2)
 if VSG(i)>abs(VT)
      if VSD<(abs(VSG(i))-abs(VT))     % Triode Region
       ID(1,i)=Kp*(2*(VSG(i)+VT)*VSD-VSD^2);
      else
       ID(1,i)=Kp*(VSG(i)+VT)^2;
      end
 else
  ID(1,i)=0;
 end
end

% Display Results
plot(VSG,ID)
text1="Diode Current (I_D) vs. Source-to-Gate Voltage (V_S_G)";
text2=" for a p-Channel MOSFET and V_S_D = ";
text3=num2str(VSD);
titletext=text1+text2+text3;
title(titletext)
xlabel('V_S_G (V)'), ylabel('I_D (mA)'), grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EXTRA:
%{
Figuring out Alternate Solution (Without loops)
https://www.youtube.com/watch?v=RCzbs7U9YRE
VSD2=VSD(0 <= VSD & VSD <= 0.25);
VSD2p=VSD(0.25 <= VSD & VSD <= 3);
function ID2=piecewise(VSD)
ID2(find(0 <= VSD & VSD < 0.25))=(KP*(0.5*VSD2-VSD2^2);
ISD2(find(0.25 <= VSD & VSD <= 3))=0.060;

plot(VSD,ID1)
hold
plot(VSD,ID2)
%}
