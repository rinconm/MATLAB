close all
clear all
clc
% 1-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas, Total Number of Array Samples and 
% Initial ABF Samples
m=16;
N=100000;
T=100;
% Enter Angles of Desired and Interfering Signals
angd=10;
angi=[-15 20];
% Enter Gain of Interfering and Noise Signals
Gi=100;
Gn=0.05;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load hw3data.mat                        % Load Sound Files
% Solve
ad=linarr(m,angd); Ai=linarr(m,angi);   % Steering Vectors
noise=randn(m,N)+j*randn(m,N);          % Noise Signal
sd=ad*thermo(1:N)';                     % Desired Signal
si=Ai*[babble(1:N)';jetnoise(1:N)'];    % Interfering Signal
X=sd+Gi*si+Gn*noise;                    % Input Signal
Rxx=X*X'/T; Rxxi=inv(Rxx);              % Covariance Matrices
g=Rxxi*ad/(ad'*Rxxi*ad);                % Conjugate transpose of h(n)
[H,wax]=dtft(conj(g),1024);             % DTFT of g(n)
thax=(180/pi)*asin(wax/pi);             % Degree Axis Convesion
y=g'*X;                                 % Output Signal
% Plot Constraints
figure()
hold
xline(angd,'--b','HandleVisibility','off');
xline(angi(1),'--r','HandleVisibility','off');
xline(angi(2),'--r','HandleVisibility','off');
axis([-90 90 -60 5])
grid on
% Display Results
plot(thax,20*log10(abs(H)), 'k')
title('Spatial Frequency Response of Adaptive Beamformer')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')
sound(real(y(1,:)),22000);

%%
close all
clear all
clc
% 1-3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas, Total Number of Array Samples 
% and initial ABF Samples
m=[16 50];
N=100000;
T=100;
% Enter Angles of Desired and Interfering Signals
angd=10;
angi=[-15 10.1];
% Enter Gain of Interfering and Noise Signals
Gi=100;
Gn=0.05;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load hw3data.mat                                % Load Sound Files
% Solve for 16 Antennas
ad1=linarr(m(1),angd); Ai1=linarr(m(1),angi);   % Steering Vectors
noise1=randn(m(1),N)+j*randn(m(1),N);           % Noise Signal
sd1=ad1*thermo(1:N)';                           % Desired Signal
si=Ai1*[babble(1:N)';jetnoise(1:N)'];           % Interfering Signal
X1=sd1+Gi*si+Gn*noise1;                         % Input Signal
Rxx1=X1*X1'/T; Rxxi1=inv(Rxx1);                 % Covariance Matrices
g1=Rxxi1*ad1/(ad1'*Rxxi1*ad1);                  % conj(h(n)) Trans.
[H1,wax]=dtft(conj(g1),1024);                   % DTFT of h(n) trans.
thax1=(180/pi)*asin(wax/pi);                    % Degree Axis
y1=g1'*X1;                                      % Output Signal
% Solve for 50 Antennas
ad2=linarr(m(2),angd); Ai2=linarr(m(2),angi);   % Steering Vectors
noise2=randn(m(2),N)+j*randn(m(2),N);           % Noise Vector
sd2=ad2*thermo(1:N)';                           % Desired Signal
si2=Ai2*[babble(1:N)';jetnoise(1:N)'];          % Interfering Signal
X2=sd2+Gi*si2+Gn*noise2;                        % Input Signal
Rxx2=X2*X2'/T; Rxxi2=inv(Rxx2);                 % Covariance Matrices
g2=Rxxi2*ad2/(ad2'*Rxxi2*ad2);                  % conj(h(n)) Trans.
[H2,wax]=dtft(conj(g2),1024);                   % DTFT of g(n)
thax2=(180/pi)*asin(wax/pi);                    % Degree Axis
y2=g2'*X2;                                      % Output Signal
% Plot Constraints
figure()
hold
xline(angd,'--b','HandleVisibility','off');
xline(angi(1),'--r','HandleVisibility','off');
xline(angi(2),'--r','HandleVisibility','off');
axis([-90 90 -40 30])
grid on
% Display Results
plot(thax1,20*log10(abs(H1)), 'k')
plot(thax2,20*log10(abs(H2)), 'b')
title('Spatial Frequency Response of Adaptive Beamformer')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')
legend('m=16','m=50')
grid
% Sound Output
sound(real(y1(1,:)),22000);
pause(4.55)
sound(real(y2(1,:)),22000);

%%
% Part 2: 1
close all
clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas, Total Number of Array Samples and
% Adaptive Beamformer Samples
m=16;
N=100000;
% Enter Initial Beamformer Samples & epsilon for exponentnial
% forgetting
T=100;
e=0.08;
% Enter Angles of Desired and Interfering Signals
angd=10;
angi=[-15 20 0];
% Enter Gain of Interfering and Noise Signals
Gi=100;
Gn=0.05;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load hw3data.mat                            % Load Sound Files
% Solve for Initial T Samples
ad=linarr(m,angd); Ai=linarr(m,angi);       % Steering Vectors
noise=randn(m,N)+j*randn(m,N);              % Noise Signal
sd=ad*thermo(1:N)';                         % Desired & Interfering
si=Ai*[babble(1:N)';jetnoise(1:N)';zeros(1,N/2) seasons(1:N/2)'];
X=sd+Gi*si+Gn*noise;                        % Input Signal
Rxx=X(:,1:100)*X(:,1:100)'/T; Rxxi=inv(Rxx);% Covariance Matrices
g=Rxxi*ad/(ad'*Rxxi*ad);                    % Conj(h(n)) transposed
[H,wax]=dtft(conj(g),1024);                 % DTFT of h(n) transposed
thax=(180/pi)*asin(wax/pi);                 % Degree Axis
y(1:100)=g'*X(:,1:100);                     % Output Signal
sview=N/2-50; eview=N/2+45;                 % Viewing Window of H(z)
for i=101:1:N
    if i>=sview && i<=eview
        % Solve
        Rxx=(1-e)*Rxx+e*X(:,i)*X(:,i)';
        Rxxi=inv(Rxx);
        g=Rxxi*ad/(ad'*Rxxi*ad);
        y(i)=g'*X(:,i);
        [H,wax]=dtft(conj(g),1024);
        % Plot Constraints
        figure(1)
        hold
        xline(angd,'--b','HandleVisibility','off');
        xline(angi(1),'--r','HandleVisibility','off');
        xline(angi(2),'--r','HandleVisibility','off');
        if i >= N/2
            xline(angi(3),'--r','HandleVisibility','off');
        end
        axis([-90 90 -60 5])
        grid on
        % Plot Results
        plot(thax,20*log10(abs(H)), 'k')
        title('Spatial Frequency Response')
        xlabel('Angle (Degrees)')
        ylabel('Magnitude (dB)')
        getframe;
        hold
        pause(0.1)
        clf
        continue
    end
    % Solve
    Rxx=(1-e)*Rxx+e*X(:,i)*X(:,i)';
    Rxxi=inv(Rxx);
    g=Rxxi*ad/(ad'*Rxxi*ad);
    y(i)=g'*X(:,i);
end
hold
% Final Plot
xline(angd,'--b','HandleVisibility','off');
xline(angi(1),'--r','HandleVisibility','off');
xline(angi(2),'--r','HandleVisibility','off');
xline(angi(3),'--r','HandleVisibility','off');
axis([-90 90 -60 5])
grid on
[H,wax]=dtft(conj(g),1024);
plot(thax,20*log10(abs(H)), 'k')
title('Spatial Frequency Response')
xlabel('Angle (Degrees)')
ylabel('Magnitude (dB)')
getframe;
% Sound Output
sound(real(y(1,:)),22000);

%%
% Part 2: 2-4
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Number of Antennas, Total Number of Array Samples and
% Adaptive Beamformer Samples
m=16;
N=100000;
% Enter Initial Beamformer Samples & epsilon for Exponential
% Forgetting
T=100;
e=0.09;
% Enter Angles of Desired and Interfering Signals
angd=10;
angi=[-15 20];
% Enter Rate of Change of Degree of Interfering Signal and Number of
% Frames Captured
slope=[.08 -.08];
f=100;
% Enter Gain of Interfering and Noise Signals
Gi=100;
Gn=0.05;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve
load hw3data.mat                        % Load Sound Files
% Initial Beamformer
ad=linarr(m,angd); Ai=linarr(m,angi);   % Steering Vectors
noise=randn(m,N)+j*randn(m,N);          % Noise Vector
sd=ad*thermo(1:T)';                     % Desired Signal
si=Ai*[babble(1:T)';jetnoise(1:T)'];    % Interfering Signals
X=sd+Gi*si+Gn*noise(:,1:T);             % Input Signal
Rxx=X*X'/T; Rxxi=inv(Rxx);              % Covariance Matrices
g=Rxxi*ad/(ad'*Rxxi*ad);                % Conj(h(n)) transposed
[H,wax]=dtft(conj(g),1024);             % DTFT of g(n)
thax=(180/pi)*asin(wax/pi);             % Degree Axis
y=g'*X;                                 % Output Signal
for i=101:1:N
    % Adjust Angles for Degree Axis upon Full Revolution
    if angi(1)>270
       angi(1)=angi(1)-360; 
    end
    if angi(2)<-270
       angi(2)=angi(2)+360;
    end
    if angi(1)<-270
       angi(1)=angi(1)+360; 
    end
    if angi(2)>270
       angi(2)=angi(2)-360;
    end
    % Solve
    angi=angi+slope;
    ad=linarr(m,angd); Ai=linarr(m,angi);
    sd=ad*thermo(i)'; si=Ai*[babble(i)';jetnoise(i)'];
    X(:,i)=sd+Gi*si+Gn*noise(:,i);
    Rxx=(1-e)*Rxx+e*X(:,i)*X(:,i)'; Rxxi=inv(Rxx);
    g=Rxxi*ad/(ad'*Rxxi*ad);
    y(i)=g'*X(:,i);
end
% Sound Output
sound(real(y(1,:)),22000);