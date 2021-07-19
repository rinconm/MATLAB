%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% Newton Raphson Power Flow Solution for slack bus with 
% two PQ buses configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Admittance of buses
y12=10-20*1i;
y13=10-30*1i;
y23=16-32*1i;
% Voltage magnitude and angle at bus 1 and guesses for 2, and 3
V(:,1)=[1.05;
           1;
           1];
ang(:,1)=[0;
          0;
          0];
% Scheduled Loads on Buses 1, 2, and 3
P(:,1)=[     0;
        -2.566;
        -1.386];
Q(:,1)=[     0;
        -1.102;
        -0.452];    
% Indicate Tolerance
tol=1e-4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create change in Active and Reacitve Power per iteration with respect
% to the scheduled load matrix
delP(:,1)=zeros(3,1);
delQ(:,1)=zeros(3,1);
% Calculating Bus Admittance Matrix & Angles
Y=[y12+y13  -y12    -y13;
    -y12   y12+y23  -y23;    
    -y13    -y23   y13+y23];
theta=angle(Y);
% Solve Loop
for i=1:1:100
    % Update P2 and dP2
    P(2,i+1)= V(2,i)*V(1,i)*abs(Y(2,1))*cos(theta(2,1)-ang(2,i)+ang(1,i))...
             +V(2,i)*V(2,i)*abs(Y(2,2))*cos(theta(2,2)-ang(2,i)+ang(2,i))...
             +V(2,i)*V(3,i)*abs(Y(2,3))*cos(theta(2,3)-ang(2,i)+ang(3,i));    
    delP(2,i+1)=P(2,1)-P(2,i+1);
    % Update Q2 and dQ2
    Q(2,i+1)=-V(2,i)*V(1,i)*abs(Y(2,1))*sin(theta(2,1)-ang(2,i)+ang(1,i))...
             -V(2,i)*V(2,i)*abs(Y(2,2))*sin(theta(2,2)-ang(2,i)+ang(2,i))...
             -V(2,i)*V(3,i)*abs(Y(2,3))*sin(theta(2,3)-ang(2,i)+ang(3,i));
    delQ(2,i+1)=Q(2,1)-Q(2,i+1);
    % Update P3 and dP3
    P(3,i+1)= V(3,i)*V(1,i)*abs(Y(3,1))*cos(theta(3,1)-ang(3,i)+ang(1,i))...
             +V(3,i)*V(2,i)*abs(Y(3,2))*cos(theta(3,2)-ang(3,i)+ang(2,i))...
             +V(3,i)*V(3,i)*abs(Y(3,3))*cos(theta(3,3)-ang(3,i)+ang(3,i));
    delP(3,i+1)=P(3,1)-P(3,i+1);
    % Update Q3 and dQ3
    Q(3,i+1)=-V(3,i)*V(1,i)*abs(Y(3,1))*sin(theta(3,1)-ang(3,i)+ang(1,i))...
             -V(3,i)*V(2,i)*abs(Y(3,2))*sin(theta(3,2)-ang(3,i)+ang(2,i))...
             -V(3,i)*V(3,i)*abs(Y(3,3))*sin(theta(3,3)-ang(3,i)+ang(3,i));
    delQ(3,i+1)=Q(3,1)-Q(3,i+1);
    % Calculate Jacobian Matrices
    % Jacobian 1
    J11= V(2,i)*V(1,i)*abs(Y(2,1))*sin(theta(2,1)-ang(2,i)+ang(1,i))...
        +V(2,i)*V(3,i)*abs(Y(2,3))*sin(theta(2,3)-ang(2,i)+ang(3,i));
    J12=-V(2,i)*V(3,i)*abs(Y(2,3))*sin(theta(2,3)-ang(2,i)+ang(3,i));
    J21=-V(3,i)*V(2,i)*abs(Y(3,2))*sin(theta(3,2)-ang(3,i)+ang(2,i));
    J22= V(3,i)*V(1,i)*abs(Y(3,1))*sin(theta(3,1)-ang(3,i)+ang(1,i))...
        +V(3,i)*V(2,i)*abs(Y(3,2))*sin(theta(3,2)-ang(3,i)+ang(2,i));
    % Jacobian 2
    J13= V(1,i)*abs(Y(2,1))*cos(theta(2,1)-ang(2,i)+ang(1,i))...
      +2*V(2,i)*abs(Y(2,2))*cos(theta(2,2))...
        +V(3,i)*abs(Y(2,3))*cos(theta(2,3)-ang(2,i)+ang(3,i));
    J14= V(2,i)*abs(Y(2,3))*cos(theta(2,3)-ang(2,i)+ang(3,i));
    J23= V(3,i)*abs(Y(3,2))*cos(theta(3,2)-ang(3,i)+ang(2,i));
    J24= V(1,i)*abs(Y(3,1))*cos(theta(3,1)-ang(3,i)+ang(1,i))...
        +V(2,i)*abs(Y(3,2))*cos(theta(3,2)-ang(3,i)+ang(2,i))...
      +2*V(3,i)*abs(Y(3,3))*cos(theta(3,3));
    % Jacobian 3
    J31= V(2,i)*V(1,i)*abs(Y(2,1))*cos(theta(2,1)-ang(2,i)+ang(1,i))...
        +V(2,i)*V(3,i)*abs(Y(2,3))*cos(theta(2,3)-ang(2,i)+ang(3,i));
    J32=-V(2,i)*V(3,i)*abs(Y(2,3))*cos(theta(2,3)-ang(2,i)+ang(3,i));
    J41=-V(3,i)*V(2,i)*abs(Y(3,2))*cos(theta(3,2)-ang(3,i)+ang(2,i));
    J42= V(3,i)*V(1,i)*abs(Y(3,1))*cos(theta(3,1)-ang(3,i)+ang(1,i))...
        +V(3,i)*V(2,i)*abs(Y(3,2))*cos(theta(3,2)-ang(3,i)+ang(2,i));
    % Jacobian 4
    J33=-V(1,i)*abs(Y(2,1))*sin(theta(2,1)-ang(2,i)+ang(1,i))...
      -2*V(2,i)*abs(Y(2,2))*sin(theta(2,2))...
        -V(3,i)*abs(Y(2,3))*sin(theta(2,3)-ang(2,i)+ang(3,i));
    J34=-V(2,i)*abs(Y(2,3))*sin(theta(2,3)-ang(2,i)+ang(3,i));
    J43=-V(3,i)*abs(Y(3,2))*sin(theta(3,2)-ang(3,i)+ang(2,i));
    J44=-V(1,i)*abs(Y(3,1))*sin(theta(3,1)-ang(3,i)+ang(1,i))...
        -V(2,i)*abs(Y(3,2))*sin(theta(3,2)-ang(3,i)+ang(2,i))...
      -2*V(3,i)*abs(Y(3,3))*sin(theta(3,3));
    % Total Jacobian
    J=[J11 J12 J13 J14;
       J21 J22 J23 J24;
       J31 J32 J33 J34;
       J41 J42 J43 J44];
    % Solve for change in angles and magnitudes of buses 2 and 3
    del=J\[delP(2,i+1);
           delP(3,i+1);
           delQ(2,i+1);
           delQ(3,i+1)];
    % Update Non-changing V1 matrix
    V(1,i+1)=V(1,i);
    ang(1,i+1)=ang(1,i);
    % Update V2 and V3
    ang(2,i+1)=ang(2,i)+del(1);
    ang(3,i+1)=ang(3,i)+del(2);
    V(2,i+1)=V(2,i)+del(3);
    V(3,i+1)=V(3,i)+del(4);
    % Check if iteration difference is lower than tolerance
    err=max(abs([delP(:,i+1);delQ(:,i+1)]));
    if (err<tol)
        break
    end
end
% Convert Voltage Phase from radians to degree
angd=ang*(360/(2*pi));
% Convert Phasor Voltages to Cartesian Coordinates
cart=V(:,i+1).*exp(1i*ang(:,i+1));
% Solve for Slack Bus Real and Reactive Power in MVA
S1=conj(cart(1))*(Y(1,1)*cart(1)+Y(1,2)*cart(2)+Y(1,3)*cart(3))*100;
P1=real(S1);
Q1=-imag(S1);
% Solve for Line Currents in pu
I12=y12*(cart(1)-cart(2));
I21=-I12;
I13=y13*(cart(1)-cart(3));
I31=-I13;
I23=y23*(cart(2)-cart(3));
I32=-I23;
% Solve for Real and Reactive Power Flow in MVA
S12=cart(1)*conj(I12)*100;
S21=cart(2)*conj(I21)*100;
S13=cart(1)*conj(I13)*100;
S31=cart(3)*conj(I31)*100;
S23=cart(2)*conj(I23)*100;
S32=cart(3)*conj(I32)*100;
% Line Losses in MVA
SL12=S12+S21;
SL13=S13+S31;
SL23=S23+S32;

% Display Answer
disp(['After ' num2str(i) ' iterations,']);
disp('Complex Power Flow Solved:');
fprintf('\n');
disp( 'Bus 1');
disp(['      V = ' num2str(V(1,i+1)) ' angle ' num2str(angd(1,i+1)) ' degrees pu']);
disp(['        = ' num2str(cart(1)) ' pu']);
disp(['      P = ' num2str(P1) ' MW']);
disp(['      Q = ' num2str(Q1) ' MVAR']);
disp( 'Bus 2');
disp(['      V = ' num2str(V(2,i+1)) ' angle ' num2str(angd(2,i+1)) ' degrees pu']);
disp(['        = ' num2str(cart(1)) ' pu ']);
disp(['      P = ' num2str(P(2,i+1)*100) ' MW']);
disp(['      Q = ' num2str(Q(2,i+1)*100) ' MVAR']);
disp( 'Bus 3');
disp(['      V = ' num2str(V(3,i+1)) ' angle ' num2str(angd(3,i+1)) ' degrees pu']);
disp(['        = ' num2str(cart(1)) ' pu ']);
disp(['      P = ' num2str(P(3,i+1)*100) ' MW']);
disp(['      Q = ' num2str(Q(3,i+1)*100) ' MVAR']);
fprintf('\n');
disp( 'Real & Reactive Power Flow:');
disp(['      S12 = ' num2str(S12) ' MVA']);
disp(['      S21 = ' num2str(S21) ' MVA']);
fprintf('\n');
disp(['      S13 = ' num2str(S13) ' MVA']);
disp(['      S31 = ' num2str(S31) ' MVA']);
fprintf('\n');
disp(['      S23 = ' num2str(S23) ' MVA']);
disp(['      S32 = ' num2str(S32) ' MVA']);
fprintf('\n');
disp( 'Line Losses:');
disp(['      SL12 = ' num2str(SL12) ' MVA']);
disp(['      SL13 = ' num2str(SL13) ' MVA']);
disp(['      SL23 = ' num2str(SL23) ' MVA']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% Gauss Seidel Power Flow Solution for slack bus with
% one PQ and PV bus configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Admittance of buses
y12=10-20*1i;
y13=10-30*1i;
y23=16-32*1i;
% Cartesian voltage in pu at bus 1 and guesses for 2, and 3
V(:,1)=[1.05+1i*0;
           1+1i*0;
        1.04+1i*0];
% Scheduled Loads on Buses 1, 2, and 3
P(:,1)=[ 0;
        -4;
         2];
Q(:,1)=[   0;
        -2.5;
           0];    
% Indicate Tolerance
tol=1e-4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating Bus Admittance Matrix & Angles
Y=[y12+y13  -y12    -y13;
    -y12   y12+y23  -y23;    
    -y13    -y23   y13+y23];
% Create Bus 3 Complex voltage matrix
V3imag(1,:)=0;
V3real(1,:)=0;
% Solve Loop
for i=1:1:100
    % Update Non-changing V1 matrix and V2
    V(1,i+1)=V(1,i);
    V(2,i+1)=(((P(2,i)-1i*Q(2,i))/conj(V(2,i)))-(Y(2,1)*V(1,i)+Y(2,3)*V(3,i)))/Y(2,2);
    % Update P2, Q2, and P3
    P(2,i+1)=P(2,i);
    Q(2,i+1)=Q(2,i);
    P(3,i+1)=P(3,i);
    % Update Q3 and V3
    Q(3,i+1)=-imag(conj(V(3,i))*(V(3,i)*Y(3,3)+Y(3,1)*V(1,i)+Y(3,2)*V(2,i+1)));
    V3imag(i+1)=imag((((P(3,i+1)-1i*Q(3,i+1))/conj(V(3,i)))-(Y(3,1)*V(1,i)+Y(3,2)*V(2,i+1)))/Y(3,3));
    V3real(i+1)=sqrt((V(3,1))^2-(V3imag(i+1))^2);
    V(3,i+1)=V3real(i+1)+1i*V3imag(i+1);
    % Check if iteration difference is lower than tolerance
    err=max(abs([V(2,i+1)-V(2,i) V(3,i+1)-V(3,i)]));
    if (err<tol)
        break
    end
end
% Convert Voltage from Cartesian to Polar
Vmag=abs(V(:,i+1));
ang=angle(V(:,i+1))*(360/(2*pi));
% Solve for Slack Bus Real and Reactive Power in MVA
S1=conj(V(1,i+1))*(Y(1,1)*V(1,i+1)+Y(1,2)*V(2,i+1)+Y(1,3)*V(3,i+1))*100;
P1=real(S1);
Q1=-imag(S1);
% Solve for Line Currents in pu
I12=y12*(V(1,i+1)-V(2,i+1));
I21=-I12;
I13=y13*(V(1,i+1)-V(3,i+1));
I31=-I13;
I23=y23*(V(2,i+1)-V(3,i+1));
I32=-I23;
% Solve for Real and Reactive Power Flow in MVA
S12=V(1,i+1)*conj(I12)*100;
S21=V(2,i+1)*conj(I21)*100;
S13=V(1,i+1)*conj(I13)*100;
S31=V(3,i+1)*conj(I31)*100;
S23=V(2,i+1)*conj(I23)*100;
S32=V(3,i+1)*conj(I32)*100;
% Line Losses in MVA
SL12=S12+S21;
SL13=S13+S31;
SL23=S23+S32;

% Display Answer
disp(['After ' num2str(i) ' iterations,']);
disp('Complex Power Flow Solved to tolerance 1e-4:');
fprintf('\n');
disp( 'Bus 1');
disp(['      V = ' num2str(Vmag(1)) ' angle ' num2str(ang(1)) ' degrees pu']);
disp(['        = ' num2str(real(V(1,i+1))) ' pu']);
disp(['      P = ' num2str(P1) ' MW']);
disp(['      Q = ' num2str(Q1) ' MVAR']);
disp( 'Bus 2');
disp(['      V = ' num2str(Vmag(2)) ' angle ' num2str(ang(2)) ' degrees pu']);
disp(['        = ' num2str(V(2,i+1)) ' pu ']);
disp(['      P = ' num2str(P(2,i+1)*100) ' MW']);
disp(['      Q = ' num2str(Q(2,i+1)*100) ' MVAR']);
disp( 'Bus 3');
disp(['      V = ' num2str(Vmag(3)) ' angle ' num2str(ang(3)) ' degrees pu']);
disp(['        = ' num2str(V(3,i+1)) ' pu ']);
disp(['      P = ' num2str(P(3,i+1)*100) ' MW']);
disp(['      Q = ' num2str(Q(3,i+1)*100) ' MVAR']);
fprintf('\n');
disp( 'Real & Reactive Power Flow:');
disp(['      S12 = ' num2str(S12) ' MVA']);
disp(['      S21 = ' num2str(S21) ' MVA']);
fprintf('\n');
disp(['      S13 = ' num2str(S13) ' MVA']);
disp(['      S31 = ' num2str(S31) ' MVA']);
fprintf('\n');
disp(['      S23 = ' num2str(S23) ' MVA']);
disp(['      S32 = ' num2str(S32) ' MVA']);
fprintf('\n');
disp( 'Line Losses:');
disp(['      SL12 = ' num2str(SL12) ' MVA']);
disp(['      SL13 = ' num2str(SL13) ' MVA']);
disp(['      SL23 = ' num2str(SL23) ' MVA']);