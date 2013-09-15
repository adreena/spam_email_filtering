function [ yhat,value ] =  kernelclassify(Xtest,lambda,X,y,kernfun)
 yhat=sign((lambda.'* diag(y)*(kernfun(X,Xtest)))).';
value=(lambda.'* diag(y)*(kernfun(X,Xtest))).';
end
