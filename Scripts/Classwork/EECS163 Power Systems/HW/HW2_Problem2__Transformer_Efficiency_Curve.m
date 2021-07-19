close all
clear all
clc

% Parameters of the Single-Phase Transformer
sm=150000;                          % Complex Power Rating
pf=0.8;                             % Power Factor = 0.8 lagging
theta=acosd(pf);                    % Power Factor Angle
stheta=theta;                       % Complex Power Angle
v1=2400;                            % V1
v2=240;                             % V2
a=v1/v2;                            % a (turn ratio)
rc1= 1000;                          % Rc1
xm1=1500;                           % Xm1
r1=0.2;                             % R1
x1=0.45;                            % X1
z1=x1+j*x1;                         % Z1 = R1 +jX1
r2=0.002;                           % R2
x2=0.0045;                          % X2
z2=r2+j*x2;                         % Z2 = R2 +jx2

disp('Part a')
v2p=a*(v2)                          % V2'
re1=r1+a^2*r2;                      % Re1
xe1=x1+a^2*x2;                      % Xe1
ze1=re1+j*xe1                       % Ze1 = Re1+jXe1
i2pm=sm/v2p                         % Magnitude of I2'
i2ptheta=-theta                     % Angle of I2'
i2p=i2pm*exp(j*i2ptheta*2*pi/360);  % I2'

disp('Part b')
v1l=v2p+i2p*ze1                     % V1 with load of 240V
vr=(abs(v1l)-abs(v2p))/abs(v2p)*100 % Voltage Rating

disp('Part c')
i2pn=i2pm*exp(-j*i2ptheta*2*pi/360);    % New I2'
v1ln=v2p+i2pn*ze1                       % New V1 with load of 240V
vr=(abs(v1ln)-abs(v2p))/abs(v2p)*100    % New Voltage Rating

disp('Part d')
pc=v1^2/rc1                             % Pc (Iron Loss)
pcu=(abs(i2p))^2*re1                    % Pcu (Copper Loss)
for i=1:100
    m(i)=((i/100)*sm*pf)/(((i/100)*sm*pf)+((i/100)^2*pcu)+pc)*100;            % Transformer Performance
end
plot(m);                                % Plot Efficiency Curve
title('Transformer Efficiency Curve');
xlabel('Percentage of Full-load Power, %')
ylabel('Efficiency, %')