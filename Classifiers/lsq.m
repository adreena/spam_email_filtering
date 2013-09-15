function [ U,W,obj ] = lsq( X,Y,beta )
   
    [t,s]=size(X);
    I=eye(s);
    
    U=((Y.'*Y)\Y.')*X;
    W=(X.'*X+beta*I)\(U.'*(Y.'*Y));
    obj=0.5*trace((X-Y*U).'*(X-Y*U));
    
    t1=(X.'*X+beta*eye(s))*W;
    t2=X.'*Y;
    t3=U.'*Y.'*Y;
    
    
end

