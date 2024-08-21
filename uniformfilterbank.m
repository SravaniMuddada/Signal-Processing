% M-channel analysis(uniform) filter bank
clc;
close all;
M = 5;
wc = 1/M;
[input,fs] = audioread('record.m4a');
x = transpose(input(:,1));

t =1:length(x);
h = fir2(1000,[0 wc wc 1],[1 1 0 0]);
   for n =1:M
    X = h(n:M:end);
        for j = 1:length(X)
        E(n,j) = X(1,j);
        end
   end
   for i = 1:M
       u1 = zeros(1,((M-1)*(length(E)-1)+length(E)));
        u1(1:M:end) = E(i,:);
         E1(i,:) = u1;
       
   end
   for i = 1:M-1
       for j = 1:length(E1)-i
       E2(i+1,j+i) = E1(i+1,j);
       end
   end
   E2(1,:) = E1(1,:);
 for n = 1:M
    for k = 1:M
       D(n,k) = exp((-1i*(2*pi)*(k-1)*(n-1))/M);
    end
 end
H = D*E2;
[P,N] = size(H);
  for i = 1:P
     hold on;
     freqz(H(i,:),1,'whole');
  end
 hold off;
y = zeros(P,length(input));
for i = 1:P
    y(i,:) = filter(E2(i,:),1,x);
end
v = M*D*y;
for i = 1:P
     hold on;
     subplot(5,1,i);
     plot(t,v(i,:));
     %title('sub band signals using analysis filter');
    
 end
hold off
v1 = sum(v);
plot(t,x);
title('input signal');
plot(t,v1);
title('Sum of sub-band signals');

    

    

   