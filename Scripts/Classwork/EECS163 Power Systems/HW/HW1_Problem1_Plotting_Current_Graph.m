Vm = 200;
t=0:.0001:0.01667; % wt from 0 to 2*pi
v=Vm*cos(377*t); % Instantaneous voltage
p = 800 + 1000*cos(754*t - 36.87*pi/180);% Instantaneous power
i=p./v; % Instantaneous current
wt=180/pi*377*t; % converting radian to degree
xline = zeros(1, length(wt)); % generates a zero vector
subplot(221), plot(wt, v, wt, xline), grid
xlabel('wt, degrees'), title('v(t)')
subplot(222), plot(wt, p, wt, xline), grid
xlabel('wt, degrees'), title('p(t)')
subplot(223), plot(wt, i, wt, xline), grid
xlabel('wt, degrees'), title('i(t)'), subplot(111)