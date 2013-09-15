function [] = pltdig(X,Y,C,d)
% plot first d dimensions of X
% showing the clusterings given by C
%	Y - symbols
%	C - colors

t = size(X,1);
mins = min(X);
maxs = max(X);
colors  = 'grkymrkkcb';
symbols = '0123456789';

clf
if d == 2
	axis([mins(1) maxs(1) mins(2) maxs(2)]);
elseif d == 3
	axis([mins(1) maxs(1) mins(2) maxs(2) mins(3) maxs(3)]);
end
axis square
hold

for i = 1:t
	if d == 2
		text(X(i,1),X(i,2),symbols(find(Y(i,:))),'color',colors(find(C(i,:))));
	elseif d ==3
		text(X(i,1),X(i,2),X(i,3),symbols(find(Y(i,:))),'color',colors(find(C(i,:))));
	end

end

hold
