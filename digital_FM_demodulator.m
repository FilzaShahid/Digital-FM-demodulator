f = loadFile("rf_data.dat");      % sampling frequency is 2.048 MHz

xt = decimate(f,8);               % sampling frequency changed to 256 KHz

xn = xt ./ abs(xt);          % normalizing the signal to make time varying amplitude constant 

%creating digital differentiator;  
b = [1 -1];                       % numerator coefficients
a = [1];                          % denominator coefficients
xn_diff = filter(b,a,xn);         % differentiating the signal to obtain m[n]
[H,w] = freqz(b,a);               % frequency response of Differentiator
[grp_delay,w_grp] = grpdelay(b,a);% Group Delay of Differentiator

mn = xn_diff .* conj(xn);         % multiplying with conjugate of normalized xn to remove the exponential term 

aud = imag(mn);                   % select imaginary part or multiply with -j to obtain original message

audio = decimate(aud,8);          % decimating the frequency further to 32 KHz

%applying the low pass filter to avoid any kind of distortions
lpf = designfilt('lowpassfir','FilterOrder',5,'CutoffFrequency',32,'Samplerate',70);
final = filter(lpf,audio);

sound(final,32000)                % playing the obtained message signal at 32 KHz

%plotting
subplot(3,1,1);
plot(w/pi,20*log(abs(H)))         % Magnitude of Differentiator frequency response in dBs
grid on;
title("Magnitude of Frequency Response"); 
xlabel("Normalized Frequency (pi rad/sample)");
ylabel("Magnitude in dB");
subplot(3,1,2);
plot(w/pi,angle(H)*(180/pi))      % Phase of Differentiator frequency response in degrees
grid on;
title("Phase of Frequency response");
xlabel("Normalized Frequency (pi rad/sample)");
ylabel("Phase in Degrees");
subplot(3,1,3);
plot(w_grp/pi,grp_delay)           % Group delay of differentiator frequency response
grid on;
title("Group Delay of Phase of Frequency response");
xlabel("Normalized Frequency (pi rad/sample)");
ylabel("Group Delay in samples")

 
