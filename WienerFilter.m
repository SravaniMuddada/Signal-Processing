clc;
close all;
fs = 1000;
t = 0:1/fs:2-1/fs;
M = 100;
d = sin(2*pi*80*t)+cos(2*pi*70*t);
u = d +rand(1,length(d));
u1 = mean(u);
U = u-u1;
r1 = xcorr(U,U,M-1,'unbiased');
r = r1(M:1:end);
P1 = xcorr(U,d,M-1,'unbiased');
P = P1(M:1:2*M-1);
R = toeplitz(r);
w= inv(R)*P';

f =[zeros(1,M),U];
for i = 1:length(U)
    y(i) = w'*(f(i:i+M-1))';
end
e = y-d;
subplot(5,1,1);plot(d); title('Desired signal d(n)');
subplot(5,1,2);plot(U);title('Desired signal + noise; U(n)');
subplot(5,1,3);plot(w);title(' optimum weight vector; w(n)');
subplot(5,1,4);plot(y);title('Output signal; y(n)');
subplot(5,1,5);plot(e);title('Error; e(n)');
