function [] = plt(X,Y,C,d)
% plot first d dimensions of X
% showing the clusterings given by C
%	Y - colors
%	C - symbols

t = size(X,1);
I = randperm(t);

colors = 'grbcmykgrb';
symbols = '.ox+*sdv^p';

clf
axis square
hold

for i = 1:t
	if d == 2
		plot(X(I(i),1),X(I(i),2),[colors(find(Y(I(i),:))) symbols(find(C(I(i),:)))]);
	elseif d ==3
		plot3(X(I(i),1),X(I(i),2),X(I(i),3),[colors(find(Y(I(i),:))) symbols(find(C(I(i),:)))]);
	end
end

hold

