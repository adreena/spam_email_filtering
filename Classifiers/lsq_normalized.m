function [A,B,obj] = lsq_normalized(K,Y,beta)

t = size(K,1);
[t,k] = size(Y);
l = sum(K,2);
q = 1./l;
s = sqrt(l);
r = 1./s;
sonesk = s(:,ones(1,k));
soneskY = sonesk.*Y;
B = (soneskY'*soneskY) \ Y';
A = sonesk.*(((r*r').*K + beta*eye(t)) \ (sonesk.*Y));

obj = (trace(q(:,ones(1,t)).*K) - trace(Y'*K*B'))/t/2;

