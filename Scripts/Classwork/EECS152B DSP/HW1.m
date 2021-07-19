close all
clear all
clc
% Fullfill dB Constraints with FIR filters and and IIR filter
%
% FIR Filter using Window method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter sample range (-X,X)
n=[-43:43];                         % Sample range

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=length(n);                        % Length of filter
n=n++0.00000001;                    % To avoid dividing by zero
h1=1.118*sin(0.215*pi*n)./(pi*n);   % h of LPF
hlp=0.628*sin(0.116*pi*n)./(pi*n);  % hlp for bandpass shift
h2=2*hlp.*cos(0.5*pi*n);            % h of BPF
h3=1.118*cos(pi*n).*sin((pi-0.785*pi)*n)./(pi*n);   % h of HPF
h=h1+h2+h3;                         % Cascade the filters
w=(hamming(length(n)))';            % Hamming window in row vector
hw=h.*w;                            % Window h
[H,wax]=dtft(hw,1000);              % DTFT of hw and w axis

% Plot Constraints
plot([0 .2],[1 1], 'r')
hold
plot([0 0.2],[-1 -1],'r')
plot([0.25 0.35],[-40 -40],'r')
plot([0.4 0.6],[-4 -4],'r')
plot([0.4 0.6],[-6 -6],'r')
plot([0.65 0.75],[-40 -40],'r')
plot([0.8 1],[1 1],'r')
plot([0.8 1],[-1 -1],'r')
axis([0 1 -70 5])
grid on
% Display Results
plot(wax/pi,20*log10(abs(H)), 'k')   % Magnitude Response
title(['Window Method Filter with N = ' num2str(N) ' taps'])
xlabel('Normalized Frequency')
ylabel('Gain (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FIR Filter using Parks-McClellan algorithm (firpm)
close all
clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Length of Filter Desired
N=57;
% Enter Corner Frequencies in Vector format
F=[0 0.199 0.25 0.35 0.402 0.598 0.65 0.75 0.801 1];
% Enter Magnitude Gain at the Corner Frequencies
A=[1 1 0 0 0.57 0.57 0 0 1 1];
% Weighting Function
W=[1 9 2 9 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=N-1;                                      % Adjust N for function
h=firpm(N,F,A,W);                           % Impulse response
N=length(h);                                % Check length of filter
[H,wax]=dtft(h,1000);                       % DTFT of h

% Plot Constraints
plot([0 .2],[1 1], 'r')
hold
plot([0 0.2],[-1 -1],'r')
plot([0.25 0.35],[-40 -40],'r')
plot([0.4 0.6],[-4 -4],'r')
plot([0.4 0.6],[-6 -6],'r')
plot([0.65 0.75],[-40 -40],'r')
plot([0.8 1],[1 1],'r')
plot([0.8 1],[-1 -1],'r')
axis([0 1 -70 5])
grid on
% Display Results
plot(wax/pi,20*log10(abs(H)), 'k')          % Magnitude Response
t=['Parks-McClellan Method Filter with N = ' num2str(N) ' taps'];
title(t)
xlabel('Normalized Frequency')
ylabel('Gain (dB)')

% Check results with firpmord
f=[0.2 0.25 0.35 0.40 0.6 0.65 0.75 0.8];
a=[1 0 0.566 0 1];
dev=[0.1 0.01 0.045 0.01 0.1];
[n,fo,mo,w]=firpmord(f,a,dev);
h=firpm(n,fo,mo,w);
[H,wax]=dtft(h,1000);
N=length(h);
figure(2);
% Plot Constraints
plot([0 .2],[1 1], 'r')
hold
plot([0 0.2],[-1 -1],'r')
plot([0.25 0.35],[-40 -40],'r')
plot([0.4 0.6],[-4 -4],'r')
plot([0.4 0.6],[-6 -6],'r')
plot([0.65 0.75],[-40 -40],'r')
plot([0.8 1],[1 1],'r')
plot([0.8 1],[-1 -1],'r')
axis([0 1 -70 5])
grid on
% Display results
plot(wax/pi,20*log10(abs(H)), 'k')          % Magnitude Response
title(['Filter using firpmord with N = ' num2str(N) ' taps'])
xlabel('Normalized Frequency')
ylabel('Gain (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IIR Filter using Cascaded Elliptical Filters (ellip)
close all
clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter LPF Passband and Stopband Corner Frequencies
Wp1=0.2;
Ws1=0.25;

% Enter BPF Passband and Stopband Corner Frequencies
Wp2=[0.4 0.6];
Ws2=[0.35 0.65];

% Enter HPF Passband and Stopband Corener Frequencies
Wp3=0.8;
Ws3=0.75;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LP elliptic IIR filter
Rp=1.8;                                     % Passband ripple
Rs1=46;                                     % Stopband ripple
Rs1=Rs1+1;                                  % Account for dB shift
[N1,Wp1]=ellipord(Wp1,Ws1,Rp,Rs1);          % Find filter order
[b1,a1]=ellip(N1,Rp,Rs1,Wp1);               % H num and den coeff
G1=1.11;                                    % For dB Shift
b1=G1*b1;                                   % dB shift
% BP elliptic IIR filter
Rs2=37;                                     % Stopband ripple
[N2,Wp2]=ellipord(Wp2,Ws2,Rp,Rs2);
[b2,a2]=ellip(N2,Rp,Rs2,Wp2);
G2=0.625;
b2=G2*b2;
% HP elliptic IIR filter
[N3,Wp3]=ellipord(Wp3,Ws3,Rp,Rs1);
[b3,a3]=ellip(N3,Rp,Rs1,Wp3,'high');
b3=G1*b3;
% Parallel Connection
b=conv(conv(b1,a2),a3)+conv(conv(b2,a1),a3)+conv(conv(a1,a2),b3);
a=conv(conv(a1,a2),a3);
[H,wax]=freqz(b,a,1000);                    % H(w) and w axis
N=max([N1 N2 N3]);                          % Order of filter

% Plot Constraints
plot([0 .2],[1 1], 'r')
hold
plot([0 0.2],[-1 -1],'r')
plot([0.25 0.35],[-40 -40],'r')
plot([0.4 0.6],[-4 -4],'r')
plot([0.4 0.6],[-6 -6],'r')
plot([0.65 0.75],[-40 -40],'r')
plot([0.8 1],[1 1],'r')
plot([0.8 1],[-1 -1],'r')
axis([0 1 -70 5])
grid on
% Display Results
plot(wax/pi,20*log10(abs(H)),'k')               % Magnitude Response
t=['IIR Elliptic Filter with N = ' num2str(N) ' taps'];
title(t)
xlabel('Normalized Frequency')
ylabel('Gain (dB)')
figure(2);
plot(wax/pi,angle(H), 'k')                      % Phase Response
title('Phase Response of Elliptic Filter')
xlabel('Normalized Frequency')
ylabel('Angle of H(w)')
figure(3);
[gd,w]=grpdelay(b,a,1000);                      % Group Delay
plot(w/pi,gd)
title('Group Delay of Elliptic Filter')
xlabel('Normalized Frequency')
ylabel('Samples')
