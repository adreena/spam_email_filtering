function [lambda,obj,iter] = svm_2cd(kernfun,X,y,beta)
% Greedy coordinate ascent algorithm for 2 class SVM
%
% Solves 
% max_{0<=lambda<=1} 
%	sum(lambda) - lambda' diag(y) K diag(y) lambda / (2beta)

% constants
t = length(y);
maxiters = 1000*t;
TOL = 1e-8;
c = beta ./ diag(kernfun(X,X));
M = diag(y)*kernfun(X,X)*diag(y);

% initialize
lambda = zeros(t,1);
grad = ones(t,1);
obj = 0;

%%% main loop %%%
for iter = 1:maxiters

	% compute all coordinatewise improvements
	lambdaplus = min(1, max(0, lambda + c.*grad));
	steps = lambdaplus - lambda;
	improvements = steps.*grad - steps.^2./c/2;

	% check termination
	if sum(improvements) < TOL, break, end

	% greedy update
	[maximprove,imax] = max(improvements);
	lambda(imax) = lambdaplus(imax);
	grad = grad - M(:,imax)*steps(imax)/beta;
	obj = obj + maximprove;

end
