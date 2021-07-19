close all
clear all
clc
disp('Calculating The Transformer Efficiency and Regulation')
kva=input('KVA RATING = ');
v1=input('V1 = ');
v2=input('V2 = ');
disp('Enter the values of OPEN CIRCUIT')
vo=input('Enter the open circuit voltage Vo in Volts = ');
io=input('Enter the open circuit current Io in Amperes = ');
wo=input('Enter the open circuit power Wo in Watts = ');
disp('Enter the values of SHORT CIRCUIT')
vsc=input('Enter the short circuit voltage VSC in Volts = ');
isc=input('Enter the short circuit current ISC in Amperes = ');
wsc=input('Enter the short circuit power WSC in Watts = ');
disp('Power Factor')
cosqo=wo/(io*vo)
disp('Component Current')
ic=io*cosqo
disp('Magnetizing Current')
s=acosd(0.1);
sinq0=sind(s);
im=io*sinqo
disp('Value of Ro')
ro=vo/ic
disp('Reactance of Xo')
xo=vo/im
disp('Now for SHORT circuit')
disp('Resistance')
r1e=wsc/(isc*isc)
disp('Impedance')
z1e=vsc/isc
disp('Reactance')
x=r1e*r1e;
y=z1e*z1e;
c=y-x;
x1e=sqrt(c)
z=input('"0" for lagging power factor and "1" for leading power factor : ');
switch(z)
    case 0
        cosq2=input('Power Factor on lagging for efficiency = ');
        cosq=input('Power Factor on lagging for Regulation = ');
        disp('VOLTAGE REGULATION OF A TRANSFORMER')
        d=acosd(cosq);
        sinq=sind(d); 
R=((isc*r1e*cosq+isc*x1e*sinq)/v1)*100 
    case 1
        cosq2=input('Power Factor on leading for efficiency = ');
        cosq=input('Power Factor on leading for Regulation = ');
        disp('VOLTAGE REGULATION OF A TRANSFORMER')
        d=acosd(cosq);
        sinq=sind(d);
        R=((isc*r1e*cosq- isc*x1e*sinq)/v1)*100 
end
disp('EFFICIENCY OF A TRANSFORMER')
n=((kva*cosq2)/(kva*cosq2+wo+wsc))*100
for i=1:100
m(i)=(i/100)*((kva*cosq2)/((i/100)*(kva*cosq2)+wo+wsc*(i/100)^2))*100;
    Rg(i)=(((i/100)*isc*r1e*cosq-(i/100)*isc*x1e*sinq)/v1)*100;
end
subplot(2,1,1)
plot(m);
title('Efficiency'); 
subplot(2,1,2)
plot(Rg);
title('Regulation');