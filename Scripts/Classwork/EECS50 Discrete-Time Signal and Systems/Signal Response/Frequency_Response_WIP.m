[num,den]=ellip(3,1,20,0.4)
N=512;
[H,W]=freqz(num,den,N,'whole');
figure(1); plot(W./pi, abs(H));
xlabel('Normalized frequency,[rad/pi]');grid
title('Magnitude'), ylabel('H(e^{j\omega})')
range=(w>=pi/2)&(w<=3*pi/2);
figure(2)
plot([-0.4 0.6],[0 0],'k');hold on
plot([0 0], [-1 1],'k') %draw x-y axis
plot(10*H(range)); hold off
axis('square'); grid
xlabel('Re(10H(e^{j\omega}))')
ylabel('Im(10(e^{j\omega}))')
w1=w(1:N/2+1);
H1=H(1:N/2+1);
figure(3)
subplot(211), plot(w/pi,abs(H1))
title('magnitude phase'), ylabel('|H(e^{2\omega})|')
subplot(212); plot(w1/pi, unwrap(angle(H1)))
xlabel('normalized freq[rad/pi]');
ylabel('angle H(e^{2\omega})')
