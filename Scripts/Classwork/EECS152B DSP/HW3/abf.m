function [y,g] = abf(T,m,N,angd,angi,slope,namp,iamp,e,f)
% This function designs an Adaptive BeamFormer
% Gives the output of a desired signal (Homer Voice) from a desired
% angle, and blocks out interfering signals that move at a linear
% rate
%
% T: Initial samples of array data
% M: Number of Antennas in array
% N: Total samples to generate
% angd: Angle of Desired Signal (degrees) (Can be vector)
% angi: Angle of Interfering Signal (degrees) (Can be vector)
% slope: Difference in angle per sample of the Interfering Signal(s)
% namp: Amplitude of noise signal
% iamp: Amplitude of interfering signal
% e: Exponential Forgetting Factor (ratio of new data/old data)
% f; Frames Displayed (Default of 100)
% 
% y: Output of ABF (spatial filter)
% g: Conjugate transpose of the Impulse Respone h(n)
%
load hw3data.mat                        % Load Sound Files
% Initial Beamformer
if nargin < 10                          % If input arguments < 2
    f=100;                              % Fix f to 100
end
ad=linarr(m,angd); Ai=linarr(m,angi);   % Steering Vectors
noise=randn(m,N)+j*randn(m,N);          % Noise Vector
sd=ad*thermo(1:T)';                     % Desired Signal
si=Ai*[babble(1:T)';jetnoise(1:T)'];    % Interfering Signals
X=sd+iamp*si+namp*noise(:,1:T);         % Input Signal
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
    X(:,i)=sd+iamp*si+namp*noise(:,i);
    Rxx=(1-e)*Rxx+e*X(:,i)*X(:,i)'; Rxxi=inv(Rxx);
    g=Rxxi*ad/(ad'*Rxxi*ad);
    y(i)=g'*X(:,i);
    % Plot H(z) f times
    rem=mod(i*f,N);
    if rem==0
        clf
        figure(1)
        hold
        xline(angd,'--b','HandleVisibility','off');
        xline(angi(1),'--r','HandleVisibility','off');
        xline(angi(2),'--r','HandleVisibility','off');
        axis([-90 90 -60 5])
        title('Spatial Frequency Response of Adaptive Beamformer')
        xlabel('Angle (Degrees)')
        ylabel('Magnitude (dB)')
        grid on
        [H,wax]=dtft(conj(g),1024);
        plot(thax,20*log10(abs(H)), 'k')
        getframe;
        pause(0.25)
        hold
    end
end
% Sound Output
sound(real(y(1,:)),22000);
end
