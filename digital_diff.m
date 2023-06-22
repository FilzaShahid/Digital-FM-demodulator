function y = digital_diff(x)

b = [1 -1];
a = [1];
y = filter(b,a,x);

%plotting 
[H,w] = freqz(b,a);
subplot(2,1,1);
plot(w/pi,abs(H))
title("Magnitude of Frequency Response") 
subplot(2,1,2);
plot(w/pi,angle(H)*(180/pi))
title("Phase of Frequency response")