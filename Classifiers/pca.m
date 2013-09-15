function [ Y,U,W,obj] = pca( X,k,beta )

[Q,S,V] = svd(X*X.');
Q=Q(:,1:k);
Y=Q;
U=Q.'*X;
A=Y*U; 
W=(X.'*X)\(X.'*Q);
[t,n]=size(X);
F=(X.'*X +beta*eye(n))*W; 
E=X.'*Y;  
G= U.'*(Y.'*Y);

obj=.5*trace((X-Y*U).'*(X-Y*U));
end
