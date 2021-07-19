close all
clear all
clc
format long

%{
% Problem 1
Sb=190.5e6;
Vb=220e3;
Sl=0.025*Sb;
p=2.84e-8;
L=63e3;
inchconv=39.3701;
milconv=1/0.001;

Il=Sb/(sqrt(3)*Vb);
R=Sl/(3*(Il)^2);
r=sqrt((p*L)/(pi*R));
d=2*r;

dinch=d*inchconv
dmil=dinch*milconv
A=dmil^2
%}

%{
% Problem 2
Dab=5;
Dac=10;
Daap=20;
Dabp=25;
Dbc=5;
Dbap=15;
Dbbp=20;
Dcap=10;
Dcbp=15;
Dapbp=5;
ra=0.5e-2;
rap=2.5e-2;

rpa=ra*exp(-1/4);
GMD=(Daap*Dabp*Dbap*Dbbp*Dcap*Dcbp)^(1/6);
GMRx=(rpa^3*Dab^2*Dac^2*Dbc^2)^(1/9);
rpap=rap*exp(-1/4);
GMRy=(rpap^2*Dapbp^2)^(1/4);
Lx=0.2*log(GMD/GMRx);
Ly=0.2*log(GMD/GMRy);

L=Lx+Ly
%}

%{
% Problem 3
% Old Configuration
d=3.625e-2;
rp=1.439e-2;
Dab=11;
Dac=22;
Dbc=11;

r=d/2;
GMD=(Dab*Dac*Dbc)^(1/3);
L=0.2*log(GMD/rp);
C=0.0556/(log(GMD/r));
Lold=L;
Cold=C;

% New Configuration
d=2.1793e-2;
rp=0.8839e-2;
l=45e-2;
Dab=14;
Dac=28;
Dbc=14;

r=d/2;
GMD=(Dab*Dac*Dbc)^(1/3);
rb=(r*l^2)^(1/3);
GMRl=(rp*l^2)^(1/3);
L=0.2*log(GMD/GMRl);
C=0.0556/(log(GMD/rb))
Lnew=L;
Cnew=C;

% Answer
Lpchange=(Lold-Lnew)/Lold*100
Cpchange=(Cold-Cnew)/Cold*100
%}

% Problem 4
%Parameters
d=4.4069e-2;
r=d/2;
Ds=1.7374e-2;
l=45e-2;
Sa1a2=16;
Sb1b2=24;
Sc1c2=17;
H12=10;
H23=9;
H13=19;
%Distances between conductors
Da1a2=sqrt((Sa1a2+(Sc1c2-Sa1a2)/2)^2+H13^2);
Da1b1=sqrt(((Sb1b2-Sa1a2)/2)^2+H12^2);
Da1b2=sqrt((Sa1a2+(Sb1b2-Sa1a2)/2)^2+H12^2);
Da1c1=sqrt(((Sc1c2-Sa1a2)/2)^2+H13^2);
Da1c2=Sa1a2;
Da2b1=sqrt((Sc1c2+(Sb1b2-Sc1c2)/2)^2+H23^2);
Da2b2=sqrt(((Sb1b2-Sc1c2)/2)^2+H23^2);
Da2c1=Sc1c2;
Da2c2=sqrt(((Sc1c2-Sa1a2)/2)^2+H13^2);
Db1b2=Sb1b2;
Db1c1=sqrt(((Sb1b2-Sc1c2)/2)^2+H23^2);
Db1c2=sqrt((Sa1a2+(Sb1b2-Sa1a2)/2)^2+H12^2);
Db2c1=sqrt((Sc1c2+(Sb1b2-Sc1c2)/2)^2+H23^2);
Db2c2=sqrt(((Sb1b2-Sa1a2)/2)^2+H12^2);
Dc1c2=sqrt((Sa1a2+(Sc1c2-Sa1a2)/2)^2+H13^2);
%Distances between groups
D_AB=(Da1b1*Da1b2*Da2b1*Da2b2)^(1/4);
D_BC=(Db1c1*Db1c2*Db2c1*Db2c2)^(1/4);
D_AC=(Da1c1*Da1c2*Da2c1*Da2c2)^(1/4);
%Equivalent GMD
GMD=(D_AB*D_BC*D_AC)^(1/3);
%Inductance Calculations
Dsb=sqrt(Ds*l);
D_SA=sqrt(Dsb*Da1a2);
D_SB=sqrt(Dsb*Db1b2);
D_SC=sqrt(Dsb*Dc1c2);
GMR_L=(D_SA*D_SB*D_SC)^(1/3);
L=0.2*log(GMD/GMR_L)

%Capacitance Calculations
rb=sqrt(r*l);
r_A=sqrt(rb*Da1a2);
r_B=sqrt(rb*Db1b2);
r_C=sqrt(rb*Dc1c2);
GMR_C=(r_A*r_B*r_C)^(1/3);
C=0.0556/(log(GMD/GMR_C))
