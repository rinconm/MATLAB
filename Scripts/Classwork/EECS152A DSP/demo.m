% f(t)=sin(12*t), 0 <= t <= 2pi
t=0:0.01:2*pi;

%f=sin(t)
f=sin(12*t);

plot(t,f);

axis([0,2*pi,-2,2]); % set the boarder of the figure
plot(t,f);
axis([0,2*pi,-2,2]); % set the boarder of the figure
title('question 1 a');
xlabel('x-axis');
ylabel('y-axis');
legend('line');

% Create variables using piecewise function
t=-7:0.01:7;

f1=1 .* (t>=-1 & t<=1);

plot(t,f1);
axis([-7,7,0,2]);

f2=(2*t+1) .* (t>-3 & t<=1);
f3=(sin(12*t)) .* (t>= (-pi) & t <=pi);

f4=f2+f3;

plot(t,f2);

hold on             % To keep the function on plot
plot(t,f3,'r')      % r and g are for colorization
plot(t,f4,'g')
hold off
plot(t,f4)

% for loop (comput 1+2+...+100
s=0;
for i=1:100
    s=s+i;
end

% .m file
% call function