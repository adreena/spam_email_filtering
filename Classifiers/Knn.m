function [distance] = Knn(Msubset ,Xtest )
[h,dummy]=size(Msubset);

distance=zeros(h,1);
% computing the center of Msubset

center=mean(Msubset);
distance=sqrt(sum((center-Xtest).^2));

end

