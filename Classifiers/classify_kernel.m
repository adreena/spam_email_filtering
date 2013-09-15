function [ C ] = classify_kernel(K,A) 
yhat=K.'*A;
C=Yhat2C(yhat);
end

