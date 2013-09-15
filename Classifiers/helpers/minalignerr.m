function [err,P] = minalignerr(Y,Yhat)
%
% Compute optimal permutation matrix P to make Yhat*P look as close as
% possible to Y, assuming both Y and Yhat are boolean s.t. sum(Y,2)==1, 
% sum(Yhat,2)==1.
% In particular, solves
%		max_P tr(Y'*Yhat*P) s.t. P>=0, P1=1, 1'P=1'
%
% Note: have to comment in correct Matlab or Octave version of LP solver below
%

[t,k] = size(Y);

% add symmetry breaking to ensure linprog returns an integral solution
TOL = 1e-4;
Rtmp = rand(t,k);
Rtmp = Rtmp./repmat(sum(Rtmp,2),1,k);
Ytmp = (1 - TOL)*Yhat + TOL*Rtmp;

f = -vec(Ytmp'*Y);
k2 = k^2;
lb = zeros(k2,1);
ub = ones(k2,1);
Aeq1 = repmat(eye(k),1,k);
cells = num2cell(ones(k),2);
Aeq2 = blkdiag(cells{:});
Aeq = [Aeq1; Aeq2];
beq = ones(2*k,1);

% Matlab
[p,negmatch,flag] = linprog(f,[],[],Aeq,beq,lb,ub,[],optimset('display','off'));
% Octave
%[p,negmatch,flag] = glpk(f,Aeq,beq,lb,ub,repmat('S',2*k,1));

P = reshape(p,k,k);
F = Yhat'*Y;
match = trace(P'*F);
err = 1 - match/t;

