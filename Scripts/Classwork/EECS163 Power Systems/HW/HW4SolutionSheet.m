%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format long

% Three-Phase Short Transmission Line
%
% Parameters
%

% Voltage Rating of Sending End in V
Vsr=69*10^3;

% Length of Line in km
l=16;

% Per Phase Series Impedance per km
z=0.125+1i*0.4375;

% Impedance per phase
Z=z*l;

% ABCD Test
A=1;
B=Z;
C=0;
D=1;

ABCD=[A B;
      C D];

%
% Function:
% Determine the sending end voltage, voltage regulation, the
% sending end power, and the transmission efficiency when the line
% delivers
%
% a)  70 MVA, 0.8 lagging power factor at 64 kV.

% Three-Phase Complex power at Receiving end in VA
Sr=70e6*exp(1i*acos(0.8));

% Voltage at Receiving end per-phase in V
VrLL=64e3;
Vr=(VrLL*exp(1i*0))/sqrt(3);

% Current-per-phase in A
Ir=conj(Sr)/(3*conj(Vr));
Im=abs(Ir);
Iangle=atand(imag(Ir)/real(Ir));

% Answers
disp('Answers for part a)')
disp('The sending end voltage in V is')
Vs=Vr+Z*Ir;
Vsm=abs(Vs)
Vsangle=atand(imag(Vs)/real(Vs))
VsmLL=Vsm*sqrt(3)

disp('The Voltage regulation is')
VR=(VsmLL-VrLL)/VrLL

disp('The transmission efficienty is')
Ss=3*Vs*conj(Ir);
n=real(Sr)/real(Ss)

% b) 120 MW, unity power factor at 64 kV.
% Receiving end Three-Phase Complex Power in VA
Sr=120e6*exp(1i*acos(1))

% Receiving end Voltage per-phase in V
VrLL=64e3;
Vr=(VrLL*exp(1i*0))/sqrt(3);

% Current-per-phase in A
Ir=conj(Sr)/(3*conj(Vr));
Im=abs(Ir);
Iangle=atand(imag(Ir)/real(Ir));

% Answers
disp('Answers for part b)')
disp('The sending end voltage in V is')
Vs=Vr+Z*Ir;
Vsm=abs(Vs)
Vsangle=atand(imag(Vs)/real(Vs))
VsmLL=Vsm*sqrt(3)

disp('The Voltage regulation is')
VR=(VsmLL-VrLL)/VrLL

disp('The transformer efficieny is')
Ss=3*Vs*conj(Ir);
n=real(Sr)/real(Ss)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format long

% Shunt Capacitor added to the receiving end to improve performance
% of Problem 1
% Determine the total Mvar and the capacitance per phase
% of the Y-connected capacitors when the sending end voltage is
% a) 69 kV

% Parameters

% Voltage at Sending End
VsmLL=69e3;
Vsm=VsmLL/sqrt(3);

% Length of Line in km
l=16;

% Impedance Per Phase Series per km
Zp=0.125+1i*0.4375;

% Impedance per phase
Z=Zp*l;

% Complex power at receiving end
Sr=70e6*exp(1i*acos(0.8));
Pr=real(Sr);
Qr=imag(Sr);

% Voltage at receiving end
VrLL=64e3*exp(1i*0);
VrmLL=abs(VrLL);
Vr=VrLL/sqrt(3);
Vrm=abs(Vr);

% ABCD Test
A=1;
B=Z;
C=0;
D=1;

ABCD=[A B;
      C D];

% Complex Power Flow Parameters
Am=abs(A);
Aangle=atand(imag(A)/real(A));
Bm=abs(B);
Bangle=atand(imag(B)/real(B));

% Solving for power factor angle delta
Vsangle=Bangle-acosd(Bm/(VsmLL*VrmLL)*((Am*VrmLL^2)/Bm*cosd(Bangle-Aangle)+Pr));

% Solving for three-phase reactive power of load (not including caps)
Ql=(VsmLL*VrmLL)/Bm*sind(Bangle-Vsangle)-(Am*VrmLL^2)/Bm*sind(Bangle-Aangle);

% Answers for part a
disp('Reactive Power Supplied by Capacitors is');
Qc=Qr-Ql
Sc=0-i*Qc;

% Impedance of Capacitors
Zc=Vrm^2/(conj(Sc)/3);

disp('Capacitance of the Capacitors is');
C=1/(1i*2*pi*60*Zc)

% b) 64 kV

% New Parameter

% Voltage at Sending End
VsmLL=64e3;
Vsm=VsmLL/sqrt(3);

% Solving for power factor angle delta
Vsangle=Bangle-acosd(Bm/(VsmLL*VrmLL)*((Am*VrmLL^2)/Bm*cosd(Bangle-Aangle)+Pr));

% Solving for three-phase reactive power of load (not including caps)
Ql=(VsmLL*VrmLL)/Bm*sind(Bangle-Vsangle)-(Am*VrmLL^2)/Bm*sind(Bangle-Aangle);

% Answers for part b
disp('Reactive Power Supplied by Capacitors is');
Qc=Qr-Ql
Sc=0-i*Qc;

% Impedance of Capacitors
Zc=Vrm^2/(conj(Sc)/3);

disp('Capacitance of the Capacitors is');
C=1/(1i*2*pi*60*Zc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format long

% Three-Phase Medium transmission Line

% Parameters

% Rated Voltage at sending end
Vsrm=230e3;

% Voltage at receiving end
VrLL=220e3*exp(1i*0);
Vr=VrLL/sqrt(3);

% Three-phase complex power at receiving end
Sr=200e6*exp(1i*(acos(0.8)));

% Series impedance per phase per km
z=0.05+1i*0.45;

% Shunt Admittance per phase per km
y=1i*3.4e-6;

% Length of line in km
l=80;

% Series Impedance per phase
Z=z*l;

% Shunt Admittance per phase
Y=y*l;

% Using the nominal ? model, determine the transmission line ABCD 
% constants. Find the sending end voltage and current, voltage 
% regulation, the sending end power and the transmission efficiency 
% when the line delivers 200 MVA, 0.8 lagging power factor at 220 kV.

% Current at receiving end
Ir=conj(Sr)/(3*conj(Vr));
Irm=abs(Ir);
Irangle=atand(imag(Ir)/real(Ir));

% Answers
disp('The ABCD constants are')
A=1+(Z*Y)/2
B=Z
C=Y*(1+(Z*Y)/4)
D=1+(Z*Y)/2

disp('The Voltage at the sending end is')
Vs=A*Vr+B*Ir
Vsm=abs(Vs)
Vsangle=atand(imag(Vs)/real(Vs))
VsmLL=sqrt(3)*Vsm

disp('The Current at the sending end is')
Is=C*Vr+D*Ir
Ism=abs(Is)
Isangle=atand(imag(Is)/real(Is))

disp('The Three-phase Complex power at the sending end is')
Ss=3*Vs*conj(Is)
Ssm=abs(Ss)
Ssangle=atand(imag(Ss)/real(Ss))

% Magnitude No load Voltage at recieving end
VrNL=VsmLL/A;

% Full load Voltage at receiving end
VrFL=VrLL;

disp('The Voltage Rating is')
VR=(abs(VrNL)-abs(VrFL))/(abs(VrFL))

disp('The transformer efficiency is')
n=real(Sr)/real(Ss)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format long

% Three-Phase Transposed Long Line with series capacitors

% Paramaters

% Frequency
f=60;
omega=2*pi*f;

% Rated Voltage at sending end
Vsr=765e3;

% Conductor Diameter and radius
d=3.625e-2;
r=d/2;

% Conductor GMR
Ds=1.439e-2;

% Bundle Spacing
s=45e-2;

% Distance betweeen Groups A, B, and C
DAB=14;
DBC=14;
DAC=28;

% Length of Transmission line in km
l=400;

% Compensation ratio of reactance
compr=0.4;

% Three-phase Complex Power at receiving end
Sr=2000e6*exp(1i*(acos(0.8)));

% Voltage at Receiving End
VrLL=735e3*exp(1i*0);
Vr=VrLL/sqrt(3);

% Current at receiving end
Ir=conj(Sr)/(3*conj(Vr));
Irm=abs(Ir);
Irangle=atand(imag(Ir)/real(Ir));

% Geometric Mean Distance between Groups A, B, and C
GMD=(DAB*DBC*DAC)^(1/3);

% Geometric Mean Radius for Inductance
GMRL=1.09*(s^3*Ds)^(1/4);

% Geometric Mean Radius for Capacitance
GMRC=1.09*(s^3*r)^(1/4);

% Inductange per Phase per length in mH/km
Ll=0.2*log(GMD/GMRL);

% Capacitance per phase per length in uF/km
epsilon=8.85e-12;
Cl=0.0556/log(GMD/GMRC);

% Imaginary part of the Propagation Constant radians/km
beta=omega*sqrt(Ll*Cl*10^-9);

% Wavelength of the Voltage Waveform in km
lambda=(2*pi)/beta;

% Characteristic Impedance
Zc=sqrt((Ll*10^-3)/(Cl*10^-6));

% Old equivalent Reactance for pi model X'
Xp=Zc*sin(beta*l);

% Surge Impedance Loading
SIL=Vsr^2/Zc;

% Old ABCD Constants of the line
A=cos(beta*l);
B=1i*Xp;
C=1i*1/Zc*sin(beta*l);
D=cos(beta*l);

% The Series capacitor reactance per phase
Xser=compr*Xp;

% The new equivalent pi circuit parameters
Zp=1i*(Xp-Xser);
Yp=1i*2/Zc*tan(beta*l/2);

% New ABCD Constants of the line
A=1+Zp*Yp/2;
B=1i*imag(Zp);
C=Yp*(1+Zp*Yp/4);
D=1+Zp*Yp/2;

% Answers
disp('The Voltage at the sending end is')
Vs=A*Vr+B*Ir;
Vsm=abs(Vs)
Vsangle=atand(imag(Vs)/real(Vs))
VsLL=sqrt(3)*Vs;

disp('The Current at the sending end is')
Is=C*Vr+D*Ir;
Ism=abs(Is)
Isangle=atand(imag(Is)/real(Is))

disp('The Three-phase power at the sending end is')
Ss=3*Vs*conj(Is)
Ssm=abs(Ss)
Ssangle=atand(imag(Ss)/real(Ss))

disp('The Voltage regulation is')
VR=(abs(VsLL)/abs(A)-abs(VrLL))/abs(VrLL)