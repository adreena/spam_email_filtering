function [Y,B,A,obj] = pca_kernel( K,k,beta )

[Q,S,V] = svd(K);
[t,dummy]=size(K);
Q=Q(:,1:k);

%XT ??
Y=Q;
[t,dummy]=size(Y);
B=(Y.'*Y)\Y.';
A=(K+beta*eye(t))\(B.'*(Y.'*Y));

obj=.5*trace((eye(t)-Y*B)*K*(eye(t)-Y*B).');
end

