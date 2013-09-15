function [C] = classify_normalized(K,A)

l = sum(K,2);
q = 1./l;
C = Yhat2C(((q*q').*K)*A);

