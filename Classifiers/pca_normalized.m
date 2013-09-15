function [Y,B,A,obj] = pca_normalized(K,k,beta)

t = size(K,1);
l = sum(K,2);
q = 1./l;
s = sqrt(l);
r = 1./s;
RKR = (r*r').*K;
[Q,D] = eig(RKR);
[dsort,isort] = sort(diag(D),'descend');
Qk = Q(:,isort(2:k+1));
Y = r(:,ones(1,k)).*Qk;
B = Y';
A = ((s*s').*inv(RKR + beta*eye(t)))*Y;

obj = (trace(q(:,ones(1,t)).*K) - trace(Y'*K*B'))/t/2;

