%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% Gauss Seidel Power Flow Solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
% Admittance of buses
y12=1/(1i*(1/30));
y21=y12;
y13=1/(1i*0.0125);
y31=y13;
y23=1/(1i*0.05);
y32=y23;
% Scheduled Loads on Buses 2 and 3
S2sch=-(400+1i*320)/100;
P2sch=real(S2sch);
Q2sch=imag(S2sch);
S3sch=-(300+1i*270)/100;
P3sch=real(S3sch);
Q3sch=imag(S3sch);
% Voltage at bus 1 (Slack Bus)
V1=1+1i*0;
% Initial Voltage Guess on Buses 2 & 3
V2=1+1i*0;
V3=1+1i*0;
% Indicate tolerance
tol=1e-4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution Part a
% Calculating Bus Admittance Matrix
Y=[y12+y13  -y12    -y13;
    -y21   y21+y23  -y23;    
    -y31    -y32   y31+y23];
% Main Loop
ITER=0;
err=inf;
while err > tol
    % Update V2
    V2next=((P2sch-1i*Q2sch)/conj(V2)-Y(2,1)*V1-Y(2,3)*V3)/Y(2,2);
    dV2=V2-V2next;
    V2=V2next;
    % Update V3
    V3next=((P3sch-1i*Q3sch)/conj(V3)-Y(3,1)*V1-Y(3,2)*V2)/Y(3,3);
    dV3=V2-V2next;
    V3=V3next;
    % UPDATE ITERATION COUNT
    ITER=ITER+1;
    % COMPUTER ERROR
    err=max(max(abs(dV2./V2)), max(abs(dV3./V3)));
    while ITER < 3
        disp(['After ' num2str(ITER) ' iteration(s),']);
        disp(['the Voltage at Buses 2 and 3, is']);
        V2
        V3
        break
    end
end
% DISPLAY ANSWER
disp(['After ' num2str(ITER) ' iterations,']);
disp(['the Voltage at Buses 2 and 3, is']);
V2
V3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution Part b
% Slack Bus Real and Reactive Power in MVA
P1=real(conj(V1)*(V1*Y(1,1)+Y(1,2)*V2+Y(1,3)*V3))*100;
Q1=-imag(conj(V1)*(V1*Y(1,1)+Y(1,2)*V2+Y(1,3)*V3))*100;
% Line Currents in pu
I12=y12*(V1-V2);
I21=-I12;
I13=y13*(V1-V3);
I31=-I13;
I23=y23*(V2-V3);
I32=-I23;
% Line Complex Power Flow in MVA
S12=V1*conj(I12)*100;
S21=V2*conj(I21)*100;
S13=V1*conj(I13)*100;
S31=V3*conj(I31)*100;
S23=V2*conj(I23)*100;
S32=V3*conj(I32)*100;
% Line Losses in MVA
SL12=S12+S21;
SL13=S13+S31;
SL23=S23+S32;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 1 Part c
close all
clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
% Admittance of buses
y12=1/(1i*(1/30));
y21=y12;
y13=1/(1i*0.0125);
y31=y13;
y23=1/(1i*0.05);
y32=y23;
% Scheduled Loads on Buses 2 and 3
S2sch=-(400+1i*320)/100;
P2sch=real(S2sch);
Q2sch=imag(S2sch);
S3sch=-(300+1i*270)/100;
P3sch=real(S3sch);
Q3sch=imag(S3sch);
% Voltage at bus 1 (Slack Bus)
V1=1+1i*0;
% Initial Voltage Guess on Buses 2 & 3
V2=1+1i*0;
V3=1+1i*0;
% Indicate Power Accuracy
tol=1e-5;
% Indicate Accelaration Factor
alpha=1.00;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution Part a
% Calculating Bus Admittance Matrix
Y=[y12+y13  -y12    -y13;
    -y21   y21+y23  -y23;    
    -y31    -y32   y31+y23];
% Main Loop
ITER=0;
err=inf;
while err > tol
    % Update V2
    V2cal=((P2sch-1i*Q2sch)/conj(V2)-Y(2,1)*V1-Y(2,3)*V3)/Y(2,2);
    V2next=V2+alpha*(V2cal-V2);
    dV2=V2-V2next;
    V2=V2next;
    % Update V3
    V3cal=((P3sch-1i*Q3sch)/conj(V3)-Y(3,1)*V1-Y(3,2)*V2)/Y(3,3);
    V3next=V3+alpha*(V3cal-V3);
    dV3=V2-V2next;
    V3=V3next;
    % UPDATE ITERATION COUNT
    ITER=ITER+1;
    % COMPUTER ERROR
    err=max(max(abs(dV2./V2)), max(abs(dV3./V3)));
    while ITER < 3
        disp(['After ' num2str(ITER) ' iteration(s),']);
        disp(['the Voltage at Buses 2 and 3, is']);
        V2
        V3
        break
    end
end
% DISPLAY ANSWER
disp(['After ' num2str(ITER) ' iterations,']);
disp(['the Voltage at Buses 2 and 3, is']);
V2
V3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
format
% Newton Raphson Power Flow Solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
% Admittance of buses
y12=-1i*40;
y21=y12;
y13=-1i*20;
y31=y13;
y23=-1i*20;
y32=y23;
% Scheduled Loads on Buses 2 and 3
P2sch=(400)/100;
S3sch=-(500+1i*400)/100;
P3sch=real(S3sch);
Q3sch=imag(S3sch);
% Voltage at bus 1 (Slack Bus)
V1=1+1i*0;
V1mag=abs(V1);
delta1=angle(V1);
% Initial Voltage Guess on Buses 2 & 3
V2=1.05+1i*0;
V3=1+1i*0;
V2mag=abs(V2);
delta2=angle(V2);
V3mag=abs(V3);
delta3=angle(V3);
% INDICATE TOLERANCE
tol=1e-4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution
% Calculating Bus Admittance Matrix & Angles
Y=[y12+y13  -y12    -y13;
    -y21   y21+y23  -y23;    
    -y31    -y32   y31+y23];
theta=angle(Y);
% Main Loop
ITER=0;
err=inf;
while err > tol
    % Calculate dP dQ Matrix
    % Update P2 and dP2
    P2=V2mag*V1mag*abs(Y(2,1))*cos(theta(2,1)-delta2+delta1)...
        +V2mag^2*abs(Y(2,2))*cos(theta(2,2))...
        +V2mag*V3mag*abs(Y(2,3))*cos(theta(2,3)-delta2+delta3);    
    dP2=P2sch-P2;
    % Update P3 and dP3
    P3=V3mag*V1mag*abs(Y(3,1))*cos(theta(3,1)-delta3+delta1)...
        +V3mag*V2mag*abs(Y(3,2))*cos(theta(3,2)-delta3+delta2)...
        +V3mag^2*abs(Y(3,3))*cos(theta(3,3));
    dP3=P3sch-P3;
    % Update Q3 and dQ3
    Q3=-V3mag*V1mag*abs(Y(3,1))*sin(theta(3,1)-delta3+delta1)...
        -V3mag*V2mag*abs(Y(3,2))*sin(theta(3,2)-delta3+delta2)...
        -V3mag^2*abs(Y(3,3))*sin(theta(3,3));
    dQ3=Q3sch-Q3;
    % dP dQ Matrix
    dPdQ=[dP2;
          dP3;
          dQ3];
    % Calculate Jacobian Matrices
    % Jacobian 1
    pP2pd2=V2mag*V1mag*abs(Y(2,1))*sin(theta(2,1)-delta2+delta1)...
            +V2mag*V3mag*abs(Y(2,3))*sin(theta(2,3)-delta2+delta3);
    pP2pd3=-V2mag*V3mag*abs(Y(2,3))*sin(theta(2,3)-delta2+delta3);
    pP3pd3=V3mag*V1mag*abs(Y(3,1))*sin(theta(3,1)-delta3+delta1)...
            +V3mag*V2mag*abs(Y(3,2))*sin(theta(3,2)-delta3+delta2);
    pP3pd2=-V3mag*V2mag*abs(Y(3,2))*sin(theta(3,2)-delta3+delta2);
    % Jacobian 2
    pP2pV3=V2mag*abs(Y(2,3))*cos(theta(2,3)-delta2+delta3);
    pP3pV3=2*V3mag*abs(Y(3,3))*cos(theta(3,3))...
             +V2mag*abs(Y(3,2))*cos(theta(3,2)-delta3+delta2);
    % Jacobian 3
    pQ3pd2=-V3mag*V2mag*abs(Y(3,2))*cos(theta(3,2)-delta3+delta2);
    pQ3pd3=V3mag*V1mag*abs(Y(3,1))*cos(theta(3,1)-delta3+delta1)...
            +V3mag*V2mag*abs(Y(3,2))*cos(theta(3,2)-delta3+delta2);
    % Jacobian 4
    pQ3pV3=-2*V3mag*abs(Y(3,3))*sin(theta(3,3))...
             -V1mag*abs(Y(3,1))*sin(theta(3,1)-delta3+delta1)...
             -V2mag*abs(Y(3,2))*sin(theta(3,2)-delta3+delta2);
    % Total Jacobian
    J=[pP2pd2 pP2pd3 pP2pV3;
       pP3pd2 pP3pd3 pP3pV3;
       pQ3pd2 pQ3pd3 pQ3pV3];
    ddeltadV3=J\dPdQ;
    % UPDATE V2
    delta2=delta2+ddeltadV3(1);
    V2=V2mag*exp(1i*delta2);
    % UPDATE V3
    delta3=delta3+ddeltadV3(2);
    V3mag=V3mag+ddeltadV3(3);
    V3=V3mag*exp(1i*delta3);
    % UPDATE ITERATION COUNT
    ITER=ITER+1;
    % COMPUTER ERROR
    err=max(abs(dPdQ));
    while ITER < 3
        disp(['After ' num2str(ITER) ' iteration(s),']);
        disp(['the Voltage at Buses 2 and 3, is']);
        V2mag
        V2ang=delta2*360/(2*pi)
        V3mag
        V3ang=delta3*360/(2*pi)
        break
    end
end
% DISPLAY ANSWER
disp(['After ' num2str(ITER) ' iterations,']);
disp(['the Phasor Voltage at Buses 2 and 3, is']);
V2mag
V2ang=delta2*360/(2*pi)
V3mag
V3ang=delta3*360/(2*pi)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% Fast Decoupled Power Flow Solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
% Admittance of buses
y12=-1i*40;
y21=y12;
y13=-1i*20;
y31=y13;
y23=-1i*20;
y32=y23;
% Scheduled Loads on Buses 2 and 3
P2sch=(400)/100;
S3sch=-(500+1i*400)/100;
P3sch=real(S3sch);
Q3sch=imag(S3sch);
% Voltage at bus 1 (Slack Bus)
V1=1+1i*0;
V1mag=abs(V1);
delta1=angle(V1);
% Initial Voltage Guess on Buses 2 & 3
V2=1.05+1i*0;
V3=1+1i*0;
V2mag=abs(V2);
delta2=angle(V2);
V3mag=abs(V3);
delta3=angle(V3);
% INDICATE TOLERANCE
tol=1e-4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution
% Calculating Bus Admittance Matrix & Angles
Y=[y12+y13  -y12    -y13;
    -y21   y21+y23  -y23;    
    -y31    -y32   y31+y23];
theta=angle(Y);
% Calculate B' and B'' Matrix
Bp=[imag(Y(2,2)) imag(Y(2,3));
    imag(Y(3,2)) imag(Y(3,3))];
B2p=imag(Y(2,2));

% Main Loop
ITER=0;
err=inf;
while err > tol
    % Calculate dP/abs(V) and dQ/abs(V) Matrix
    % Update P2 and dP2
    P2=V2mag*V1mag*abs(Y(2,1))*cos(theta(2,1)-delta2+delta1)...
        +V2mag^2*abs(Y(2,2))*cos(theta(2,2))...
        +V2mag*V3mag*abs(Y(2,3))*cos(theta(2,3)-delta2+delta3);    
    dP2=P2sch-P2;
    % Update P3 and dP3
    P3=V3mag*V1mag*abs(Y(3,1))*cos(theta(3,1)-delta3+delta1)...
        +V3mag*V2mag*abs(Y(3,2))*cos(theta(3,2)-delta3+delta2)...
        +V3mag^2*abs(Y(3,3))*cos(theta(3,3));
    dP3=P3sch-P3;
    % Update Q3 and dQ3
    Q3=-V3mag*V1mag*abs(Y(3,1))*sin(theta(3,1)-delta3+delta1)...
        -V3mag*V2mag*abs(Y(3,2))*sin(theta(3,2)-delta3+delta2)...
        -V3mag^2*abs(Y(3,3))*sin(theta(3,3));
    dQ3=Q3sch-Q3;
    % dP/abs(V) Matrix
    temp1=dP2/V2mag;
    temp2=dP3/V3mag;
    dPabsV=[temp1;
            temp2];
    % dQ/abs(V) Matrix
    dQabsV=dQ3/V3mag;
    % Calculate ddelta matrix
    ddelta=-Bp\dPabsV;
    % Calculate dV matrix
    dV=-B2p\dQabsV;
    % UPDATE V2
    delta2=delta2+ddelta(1);
    V2=V2mag*exp(1i*delta2);
    % UPDATE V3
    delta3=delta3+ddelta(2);
    V3mag=V3mag+dV;
    V3=V3mag*exp(1i*delta3);
    % UPDATE ITERATION COUNT
    ITER=ITER+1;
    % dP dQ Matrix
    dPdQ=[dP2;
          dP3;
          dQ3];
    % COMPUTER ERROR
    err=max(abs(dPdQ));
    while ITER < 3
        disp(['After ' num2str(ITER) ' iteration(s),']);
        disp(['the Voltage at Buses 2 and 3, is']);
        V2mag
        V2ang=delta2*(360/(2*pi))
        V3mag
        V3ang=delta3*(360/(2*pi))
        break
    end
end
% DISPLAY ANSWER
disp(['After ' num2str(ITER) ' iterations,']);
disp(['the Phasor Voltage at Buses 2 and 3, is']);
V2mag
V2ang=delta2*(360/(2*pi))
V3mag
V3ang=delta3*(360/(2*pi))