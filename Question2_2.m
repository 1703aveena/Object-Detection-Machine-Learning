
load q2_1_data.mat
%trD = Xt
X=trD.'; %Transpose
Xt=trD;
%trLb = Y
Y=trLb;
Yt=Y';
C=0.1
[w,bias,objectiveVal,alpha]=question1(X,Y,C);
w
bias
objectiveVal

predYdata=(w*valD +bias);
predY=sign(predYdata);
predYt=predY';




%%Confusion Matrix
confusion_matrix=confusionmat(valLb,predY);
truePostive=confusion_matrix(1,1);
trueNegative=confusion_matrix(2,2);

falsePostive=confusion_matrix(1,2);
falseNegative=confusion_matrix(2,1);
confusion_matrix
%%%%Accuracy
accuracy=(truePostive+trueNegative) / (truePostive+trueNegative+falsePostive+falseNegative);

%%%Objective value
rows=size(valLb,1);
sumGn=0;
predYdataT=predYdata';
svectors=0;
for i=1:rows;
    valLbi=valLb(i,:);
    predYdatai=predYdataT(i,:);
    gFn=valLbi*predYdatai;
    if gFn>0
        sumGn=sumGn+(1-gFn);
        svectors=svectors+1;
    end
end

wnorm=norm(w);

obj=0.5*square(wnorm) + C*sumGn;

svectors



%%gFn=sum(1-())

accuracy
function[ w,b,obj,alpha] =question1(X,Y,C)
    Y=double(Y);
    Yt=Y';
    Xt=X';
    feature=size(X,2); %Features of X
    datapoints=size(X,1);

    K=zeros(size(X1,1),size(X2,1));%Gram Matrix
  
    K=X*Xt;
    H=(X*X').*(Y*Y');

    f=-ones(datapoints,1);
    f=f.';

    Aeq = Y.';
    beq = [0];%zeros(datapoints,1)%%or just [0]??
    lb=zeros(datapoints,1);
    
    ub=ones(datapoints,1);
    upperBound=C.*ub;
   

    [alpha,obj,flag] = quadprog(H,f,[],[],Aeq,beq,lb,upperBound);
    
    %%%%%%%%%%%%%%%%%%%%%%
    %%Find weights=w and Bias=b
    %%w
    
    w=alpha'*diag(Y)*X;

    %%Find bias
    [~,svectors]=max(min(alpha,C-alpha));
    b=Y(svectors)-K(svectors,:)*diag(Y)*alpha;
    
    
    %Find objective function
    obj=-obj;
    
    
    w=zeros(1,feature);
    for c = 1:datapoints;
       alphai=alpha(c,:);
       Xi=X(c,:);
       Yi=Y(c,:);
       alpha_yx=alphai.*Yi.*Xi;
       w=w +  alpha_yx;
    end    
    
    %bias=0
    sum=0
    for i = 1:datapoints;
      Yi=Y(i,:);
      for j = 1:datapoints;
        Yj=Y(j,:);
        alphaj=alpha(j,:);
        Xj=X(j,:);
        Xi=X(i,:);
        Xti=Xi.';
        XiXj=Xj*Xti;
        val1=(alphaj.*Yj.*XiXj);
        val=Yi - val1;
        %val1
        %val
        sum=sum+val;
      end
    end

    bias=sum;
    bias
    w

end

