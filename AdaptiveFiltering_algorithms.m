clc;close all;clear all;
f = 5000;
t = 0:1/f:2-1/f;
d1 = 5*sin(2*pi*30*t)+5*sin(2*pi*20*t);
u = d1+randn(1,length(d1));
h = fir2(9,[0 0.3 0.3 1],[1 1 0 0]);
g = filter(h,1,u);
M = 10;
del = 10;
lamda = 0.997;
P = (1/del)*(eye(M));
w = zeros(M,1);
w1 = zeros(M,1);
d = [zeros(1,M-1),u];
mu = 0.001;
w2 = zeros(M,1);w3 = zeros(M,1);
 
% RLS and LMS algorithms
 for i = 1:length(d)-M
     r = flip(d(i:i+M-1));
     t = lamda + r*P*r'; 
     K = P*r'/t;
     e(i) = g(i)-(w'*r');
     w1 = w + K*e(i);
     P1 = (1/lamda)*(P-K*r*P);
     P = P1;
     w = w1;
     y(i) = w'*d(i:i+M-1)';
     w3= w2 + mu*r'*(g(i)-w2'*r');
     e1(i) = g(i)-(w2'*r');
     w2 =w3;
      y1(i) = w2'*d(i:i+M-1)';
end

figure;
subplot(311);stem(h);title('plant weight');
subplot(312);stem(w);title('RLS filter weight');
subplot(313);stem(w2);title('LMS filter weight');
figure;
subplot(411);plot(u);title('input');
subplot(412);plot(g);title('Desired signal;Plant output');
subplot(413);plot(y1);title('LMS output');
subplot(414);plot(e1);title('Error signal');


 