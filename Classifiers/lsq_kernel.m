function [A,B,obj] = ls_kernel(K,Y,beta)

    B=(Y.'*Y)\Y.';
    [t,s]=size(K);
    A=(K+beta*eye(t))\(B.'*(Y.'*Y));
    [t,dummy]=size(Y);
    obj=0.5 * trace((eye(t)-Y*B)*K*(eye(t)-Y*B).');

     t1=(K+beta*eye(s))*A;
     t2=Y;
     t3=B.'*Y.'*Y;
end

