close all
clear all
clc
syms theta
% Assignment 2 Adaptive Beamforming
% With an antennae array in mind, design filters to pass signals
% from certain directions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas and Spacing as a fraction of lambda
M=20; d=1/2;
% Enter Angles of Passband in degrees
t1=-5; t2=15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency Formula
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
mid=(t2+t1)/2; w0=double(subs(ws,mid)); % Center of Passband (rads)
wc=double(subs(ws,t2-mid));             % Cutoff Frequency (rads)
wt=0.17;                                % Transition region for firpm
hlp=firpm(M-1,[0 wc/pi-1/10*wt wc/pi+9/10*wt 1],[1 1 0 0],[1 10]);
hbp=hlp.*exp(1i*w0*n);                  % Complex BPF from LPF
G=1.1; h=G*hbp;                         % Gain factor and h[n]
[H,wax]=dtft(h,512);                    % Frequency Response
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
% Plot Constraints
figure(1)
hold
plot([-5 15],[2 2],'r')
plot([-5 15],[-2 -2],'r')
plot([-5 -5],[-60 2],'r') 
plot([15 15],[-60 2],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')


% 2
m=-n;                                   % Time Reversal
h2=G*hlp.*exp(1i*w0*m);                 % Time Reversed h[n]
[H2,wax]=dtft(h2,512);                  % Time Reversed H(z)
% Plot Constraints
figure(2)
hold
plot([-15 5],[2 2],'r')
plot([-15 5],[-2 -2],'r')
plot([5 5],[-60 2],'r') 
plot([-15 -15],[-60 2],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H2)),'b')
title('Spatial Frequency Response')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3a using firpm
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas and Spacing as a fraction of lambda
M=20; d=1/2;
% Enter Angles of Passband in degrees
t1=-5; t2=15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency Formula
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
w01=double(subs(ws,t1+0.707));          % Freq shift to -5
w02=double(subs(ws,t2-0.707));          % Freq shift to 15 degrees
wc=double(subs(ws,0.5));                % 1 Degree Range wc for LPF
hlp=firpm(M-1,[0 wc-1/2*wc wc+1/2*wc 1],[1 1 0 0],[10 1]);
hbp1=hlp.*exp(1i*w01*n);                % Complex BPF 1 from LPF
hbp2=hlp.*exp(1i*w02*n);                % Complex BPF 2 from LPF
G=2.11; h1=G*hbp1; h2=G*hbp2; h=h1+h2;  % Gain factor and h[n]
[H,wax]=dtft(h,512);                    % Frequency Response
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
% Plot Constraints
figure(2)
hold
plot([-5 -5],[-60 0],'r') 
plot([15 15],[-60 0],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response using firpm')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3a using Windowing
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas and Spacing as a fraction of lambda
M=20; d=1/2;
% Enter Angles of Passband in degrees
t1=-5; t2=15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency Formula
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
w01=double(subs(ws,t1));                % Freq shift to -5
w02=double(subs(ws,t2));                % Freq shift to 15 degrees
wc=double(subs(ws,0.5));                % 1 Degree Range wc for LPF
hlp=sin(wc*n)./(pi*n);                  % LPF
hbp1=hlp.*exp(1i*w01*n);                % Complex BPF 1 from LPF
hbp2=hlp.*exp(1i*w02*n);                % Complex BPF 2 from LPF
G=11.2; h1=G*hbp1; h2=G*hbp2; h=h1+h2;  % Gain factor and h[n]
w=hamming(M); hw=h.*w';                 % Windowing h[n]
[H,wax]=dtft(hw,512);                   % Frequency Response
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
% Plot Constraints
figure(1)
hold
plot([-5 -5],[-60 0],'r') 
plot([15 15],[-60 0],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response using Windowing')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3b using firpm
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas and Spacing as a fraction of lambda
M=20; d=1/2;
% Enter Angles of Passband in degrees
t1=0.5; t2=9.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency Formula
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
w01=double(subs(ws,t1+1.55));           % Freq shift to -5
w02=double(subs(ws,t2-1.55));           % Freq shift to 15 degrees
wc=double(subs(ws,0.5));                % 1 Degree Range wc for LPF
hlp=firpm(M-1,[0 wc-1/2*wc wc+1/2*wc 1],[1 1 0 0],[10 1]);
hbp1=hlp.*exp(1i*w01*n);                % Complex BPF 1 from LPF
hbp2=hlp.*exp(1i*w02*n);                % Complex BPF 2 from LPF
G=1.9; h1=G*hbp1; h2=G*hbp2; h=h1+h2;   % Gain factor and h[n]
[H,wax]=dtft(h,512);                    % Frequency Response
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
% Plot Constraints
figure(2)
hold
plot([0 0],[-60 0],'r') 
plot([10 10],[-60 0],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response using firpm')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3b using Windowing
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas and Spacing as a fraction of lambda
M=20; d=1/2;
% Enter Angles of Passband in degrees
t1=-1.5; t2=11.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency Formula
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
w01=double(subs(ws,t1-0.1));            % Freq shift to -5
w02=double(subs(ws,t2+0.1));            % Freq shift to 15 degrees
wc=double(subs(ws,0.5));                % 1 Degree Range wc for LPF
hlp=sin(wc*n)./(pi*n);                  % LPF
hbp1=hlp.*exp(1i*w01*n);                % Complex BPF 1 from LPF
hbp2=hlp.*exp(1i*w02*n);                % Complex BPF 2 from LPF
G=11.1; h1=G*hbp1; h2=G*hbp2; h=h1+h2;  % Gain factor and h[n]
w=hamming(M); hw=h.*w';                 % Windowing h[n]
[H,wax]=dtft(hw,512);                   % Frequency Response
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
% Plot Constraints
figure(1)
hold
plot([-1.5 -1.5],[-60 0],'r') 
plot([11.5 11.5],[-60 0],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response using Windowing')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3c using firpm
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas and Spacing as a fraction of lambda
M=400; d=1/2;
% Enter Angles of Passband in degrees
t1=4.5; t2=5.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency Formula
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
w01=double(subs(ws,t1+0.112));          % Freq shift to -5
w02=double(subs(ws,t2-0.112));          % Freq shift to 15 degrees
wc=double(subs(ws,0.1));                % 0.2 Degree Range wc for LPF
hlp=firpm(M-1,[0 wc-1/2*wc wc+1/2*wc 1],[1 1 0 0],[10 1]);
hbp1=hlp.*exp(1i*w01*n);                % Complex BPF 1 from LPF
hbp2=hlp.*exp(1i*w02*n);                % Complex BPF 2 from LPF
G=0.9; h1=G*hbp1; h2=G*hbp2; h=h1+h2;   % Gain factor and h[n]
[H,wax]=dtft(h,1024);                   % Frequency Response
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
% Plot Constraints
figure(2)
hold
plot([4.5 4.5],[-60 0],'r') 
plot([5.5 5.5],[-60 0],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response using firpm')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3c using Windowing
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas and Spacing as a fraction of lambda
M=300; d=1/2;
% Enter Angles of Passband in degrees
t1=4.5; t2=5.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency Formula
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
w01=double(subs(ws,t1));                % Freq shift to -5
w02=double(subs(ws,t2));                % Freq shift to 15 degrees
wc=double(subs(ws,0.1));                % 0.2 Degree Range wc for LPF
hlp=sin(wc*n)./(pi*n);                  % LPF
hbp1=hlp.*exp(1i*w01*n);                % Complex BPF 1 from LPF
hbp2=hlp.*exp(1i*w02*n);                % Complex BPF 2 from LPF
G=3.65; h1=G*hbp1; h2=G*hbp2; h=h1+h2;  % Gain factor and h[n]
w=hamming(M); hw=h.*w';                 % Windowing h[n]
[H,wax]=dtft(hw,1024);                  % Frequency Response
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
% Plot Constraints
figure(1)
hold
plot([4.5 4.5],[-60 0],'r') 
plot([5.5 5.5],[-60 0],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response using Windowing')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter number of antennas and spacing betweeen antennas as a 
% fraction of lambda
M=20; d=1/4;
% Enter angles of passband in degrees
t1=-5; t2=15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*d*sind(theta);                     % Norm Spatial Frequency
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
mid=(t2+t1)/2; w0=double(subs(ws,mid)); % Center of Passband (rads)
wc=double(subs(ws,t2-mid));             % Cutoff Frequency (rads)
wt=0.265;                               % Transition region for firpm
hlp=firpm(M-1,[0 wc/pi-1/10*wt wc/pi+9/10*wt 1],[1 1 0 0],[1 10]);
hbp=hlp.*exp(1i*w0*pi*n);               % Complex BPF from LPF
G=1.265; h=G*hbp;                       % Gain factor and h[n]
[H,wax]=dtft(h,512);                    % Frequency Response
H=H(wax>=-d*2*pi&wax<=d*2*pi);          % Adjust Frequency Response
wax=wax(wax>=-d*2*pi&wax<=d*2*pi);      % for the spatial frequency
thax=(180/pi)*asin(wax/(d*2*pi));       % Modified Degree Axis
% Plot Constraints
figure(1)
hold
plot([-5 15],[2 2],'r') 
plot([-5 15],[-2 -2],'r')
plot([-5 -5],[-60 2],'r') 
plot([15 15],[-60 2],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5
close all
clear all
clc
syms theta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter number of antennas and spacing betweeen antennas as a 
% fraction of lambda
M=20; d=1;
% Enter angles of passband in degrees
t1=-5; t2=15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
ws=2*pi*d*sind(theta);                  % Spatial Frequency
n=-(M-1)/2:1:(M-1)/2; n=n+10^-9;        % Sample Range
mid=(t2+t1)/2; w0=double(subs(ws,mid)); % Center of Passband (rads)
wc=double(subs(ws,t2-mid));             % Cutoff Frequency (rads)
wt=0.17;                                % Transition region for firpm
hlp=firpm(M-1,[0 wc/pi-1/10*wt wc/pi+9/10*wt 1],[1 1 0 0],[1 50]);
hbp=hlp.*exp(1i*w0*n);                  % Complex BPF from LPF
G=1.1; h=G*hbp;                         % Gain factor and h[n]
[H,wax]=dtft(h,512);                    % Frequency Response
%apply the periodicity to get the whole spatial frequencyresponse between -90 and 90 degrees
%Hf in (-pi,0) will be the same as that between (pi,2pi) whose
%corresponding theta is in [30 90] degrees (FROM HW solution
H1=H(wax>=-pi&wax<=0);
wax1=wax(wax>=-pi&wax<=0)+2*pi;
thax=(180/pi)*asin(wax/(d*2*pi));       % Degree Axis
thax1=(180/pi)*asin(wax1/(d*2*pi));
figure(1)
hold
plot(thax1,20*log10(abs(H1)), 'k')
H2=H(wax>=0&wax<=pi);
wax2=wax(wax>=0&wax<=pi)-2*pi;
thax2=(180/pi)*asin(wax2/(d*2*pi));
plot(thax2,20*log10(abs(H2)), 'k')
% Plot Constraints
plot([-5 15],[2 2],'r') 
plot([-5 15],[-2 -2],'r')
plot([-5 -5],[-60 2],'r') 
plot([15 15],[-60 2],'r')
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)),'k')
title('Spatial Frequency Response')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')

