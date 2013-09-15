function [Y,B,A,obj] = kmeans_normalized(K,k,beta)

maxiter = 1000;
TOL = 1e-8;
t = size(K,1);
l = sum(K,2);
q = 1./l;
s = sqrt(l);
r = 1./s;
onesk = ones(1,k);
onest = ones(1,t);
lonesk = l(:,onesk);
qonesk = q(:,onesk);
sonesk = s(:,onesk);
qonest = q(:,onest);
diagQKQ = diag((q*q').*K);
diagQKQonesk = diagQKQ(:,onesk);

% initialize Y randomly
y = ceil(k*rand(t,1));
Y = zeros(t,k);
Y((y-1)*t + (1:t)') = ones(t,1);
m = sum(lonesk.*Y)';
rm = 1./m;
B = rm(:,onest).*Y';
KBt = K*B';
obj = trace(qonest.*K)/t/2 - trace(KBt*Y')/t/2;

% main loop
for iter = 1:maxiter

	KBt = K*B';
	diagUUt = diag(B*KBt)';
	Dists =  (lonesk/2).*(diagQKQonesk + diagUUt(onest,:) - 2*qonesk.*KBt);
	[mindists,y] = min(Dists,[],2);
	objnew = mean(mindists);

	if obj - objnew < TOL, break; end

	obj = objnew;
	Y = zeros(t,k);
	Y((y-1)*t + (1:t)') = ones(t,1);
	m = sum(lonesk.*Y)';
	rm = 1./m;
	B = rm(:,onest).*Y';

end

A = sonesk .* (((r*r').*K + beta*eye(t)) \ ((sonesk.*B')*diag(sum(lonesk.*Y))));

