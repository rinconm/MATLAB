close all
clear all
clc

n = 5/3*[1 -0.5];
d = [1 0.5];
z = exp(.01*j);
h = polyval(n,z)/polyval(d,z);
ymag = 5*abs(h)
yphase = 20 + angle(h)*180/pi