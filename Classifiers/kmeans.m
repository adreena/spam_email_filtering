function [Y,U,W,obj] = kmeans( X,k,beta )
[t,n]=size(X);

current_Y=zeros(t,k);
for i=1 :t
current_Y(i,randi(k,1,1))=1;
end

Last_Y=current_Y;
check=0;
    while check==0
        U=(current_Y.'*current_Y)\(current_Y.'*X);
        [m,b]=size(U);
        D= 0.5*diag(X*X.')*ones(m,1).'+0.5*ones(t,1)*diag(U*U.').'-X*U';
        for i=1:t
            [a,j]=min(D(i,:));
            temp=zeros(1,k);
            temp(1,j)=1;
            current_Y(i,:)=temp;
        end
        if current_Y==Last_Y
            check=1;
        else
           Last_Y=current_Y;
        end
    end
    Y=current_Y;
W =(X.'*X+beta*eye(n))\ (X.'*Y);
obj=0.5*trace((X-Y*U).'*(X-Y*U));
end

