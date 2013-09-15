



clc
clear
load 'ED_dataset.mat';
%load 'image_dataset.mat'
%load data_unsup.mat
X1=Xtrain;
y1=ytrain;
 [t,dummy]=size(X1);
%Xtest=Xtrain;
ytest;
Xtest;
y1=y1+1;
%ytest=y1;
ytest=ytest+1;
M=[X1,y1];
[s,v]=size(Xtest);
yhat=zeros(s,1);
[te,dummy]=size(ytest);
yHat=zeros(te,1);
beta = 1;
kernfun1 = @(X1,X2) polykernel(X1,X2,2);
kernfun2 =@(X1,X2) gausskernel(X1,X2,8.5);



    
        %----------------------------------------------
        % making the matrix of 1,-1 for each class
        %----------------------------------------------
        M=-ones(t,10);
        for i=1:10,
            for j=1:t
              if y1(j,1)==i
                  M(j,i)=1;
              end
            end 
        end
        [te,dummy]=size(ytest);
        yHat=zeros(te,1);
        %-----------------------------------------------
        %calling the fast 2-SVM classifier; this mehtod is based on (1 vs all)
        %-----------------------------------------------
        tic
        for i=1:2,    
            [l,obj,iter] = svm_2cd(kernfun2,X1,M(:,i),beta);
            [yhat,value]=kernelclassify(Xtest,l/beta,X1,M(:,i),kernfun2);
            ind=find(yhat==1);
            value=abs(value);

            [c,dummy]=size(ind);
            if c~=0
                  yHat(ind,:)=i;

            end
        end   

        %------------------------------------------------
        % call kNN for unclassified datapoints
        %------------------------------------------------
         founds=find(yHat~=0);
         unfounds=find(yHat==0);
         if unfounds ~=0
                 yHat_retrain=yHat;
                 Xtest_retrain=Xtest;
                 yHat_retrain(founds,:)=[];
                 Xtest_retrain(founds,:)=[];
                 M=[X1,y1];
                 M=sortrows(M,1253);
                 [s,dummy]=size(Xtest_retrain);
                 yhat=zeros(s,1);
                 for i=1:s
                   for j=1:2
                       Msubset=find(M(:,v+1)==j);
                       result(1,j)=Knn(M(Msubset,1:v),Xtest_retrain(i,:));
                   end
                       [dummy,class]=min(result);
                       yHat_retrain(i,1)=class;
                 end
                 yHat(unfounds,:)=yHat_retrain;
         end
         

        timetot = toc;
        [z,dummy]=size(yHat);
        counter_test=0;
        for i=1:z
            if yHat(i,1)~=ytest(i,1)
                counter_test=counter_test+1;
            end
        end        
        
        
        
        
        
% subset=find(yHat~=ytest);       
accuracy=((z-counter_test)/z)*100;


Leg_spam=0;
for i=1:z
    if (ytest(i,1)==2) &&(yHat(i,1)==1)
        Leg_spam=Leg_spam+1;
    end
end

false_negative=Leg_spam;
ll=size(find(ytest==2));
true_negative=ll(1,1)-Leg_spam;
Spam_leg=0;
for i=1:z
    if (ytest(i,1)==1) &&(yHat(i,1)==2)
        Spam_leg=Spam_leg+1;
    end
end
ss=size(find(ytest==1));
false_positive=Spam_leg;
true_positive=ss(1,1)-Spam_leg;
size_test=z;

A= (true_negative+true_positive)/(true_negative+true_positive+false_negative+false_positive)
P=true_positive/(true_positive+false_positive)
R=(true_positive)/(true_positive+false_negative)
F1=(2*P*R)/(P+R)
%--------------------------------------------




%-------------------------------------------

%b_dataset1
% Leg_spam=0;
% for i=1:z
%     if (ytest(i,1)==2) &&(yHat(i,1)~=2)
%         Leg_spam=Leg_spam+1;
%     end
% end
% 
% false_negative=Leg_spam;
% true_negative=240-Leg_spam;
% Spam_leg=0;
% for i=1:z
%     if (ytest(i,1)==1) &&(yHat(i,1)~=1)
%         Spam_leg=Spam_leg+1;
%     end
% end
% false_positive=Spam_leg;
% true_positive=141-Spam_leg;
% size_test=z
% timetot
% iter
% 
% A= (true_negative+true_positive)/(true_negative+true_positive+false_negative+false_positive)
% P=true_positive/(true_positive+false_positive)
% R=(true_positive)/(true_positive+false_negative)
% F1=(2*P*R)/(P+R)