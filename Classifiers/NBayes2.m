function [ yhat,probs ] = NBayes2( Leg,Spam, xtest )

[te,f]=size(xtest);
[sM,dummy]=size(Leg);
[sN,dummy]=size(Spam);
yhat=zeros(te,1);
probs=zeros(te,1);
pM_features=zeros(1,f);

for j=1:te
        for i=1:f
            counter=find(Leg(:,i)==xtest(j,i));
            [s,dummy]=size(counter);
            pM_features(1,i)=s;
        end
        pM_features=pM_features/sM;

        pNotM_features=zeros(1,f);
        for i=1:f
            counter1=find(Spam(:,i)==xtest(j,i));
            [s,dummy]=size(counter1);
            pNotM_features(1,i)=s;
        end
        pNotM_features=pNotM_features/sN;

        pM= sM/(sM+sN);
        pNotM=sN/(sM+sN);
         %omiting zero features
        findzeros=[pM_features;pNotM_features];
        temp=prod(findzeros,1);
        omit=find(temp==0);
        pM_features(:,omit)=[];
        pNotM_features(:,omit)=[];
        
        post_M=prod(pM_features,2)*pM;
        %post_classNotM
        post_NotM=prod(pNotM_features,2)*pNotM;

        is_M=post_M/(post_M+post_NotM);
        is_NotM=post_NotM/(post_M+post_NotM);
        if is_M>=is_NotM
            yhat(j,1)=1;
            probs(j,1)= is_M;
        else
            yhat(j,1)=-1;
            probs(j,1)= is_NotM;
        end
end

end

