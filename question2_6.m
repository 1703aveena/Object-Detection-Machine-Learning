
%%[predY]=getPredY([],[],[],[]);
%%Step1. Load data from csv
trainX = csvread("TrainFeaturesupdated.csv",1,2);
trainY = csvread("TrainLabelsupdated.csv",1,2);

testX = csvread("TestFeaturesupdated.csv",1,1);

valX = csvread("ValFeaturesupdated.csv",1,2);
valY = csvread("ValLabelsupdated.csv",1,2);


trainx=trainX;
valx=valX;
trainy=trainY;
valy=valY;

trainX=[trainX;valX];
trainY=[trainY;valY];



n=size(trainY,1);  %%%%%number of datapoints
f=size(trainX,2);%%%Number of features

C=0.1%%0.05 -1347

weightM=zeros(4,f);
biasM=zeros(4,1);


%Normalise X -> divide all by 0.1
trainX_norm=trainX/norm(trainX,2);%trainX.*0.050;% 
%%%valX=valX/norm(valX,2);

trainYsend=zeros(n,4);
for i=1 : 4
   %%Change the yclass which are not equal to i
   yj=zeros(n,1);
   for j=1:n
       yi=trainY(j,:);
       if( yi == i)
           yj(j,:)=1;
       else
           yj(j,:)=-1;
       end
   end %changed Y according to  the class
   trainYsend(:,i)=yj;%%[trainYsend,yj];
       
   
end
trainYsend;
%%trainYsend1=trainYsend(:,1);%%Get one column


for i=1:4
   %%Get Y for ith classifier 
   trainYi=trainYsend(:,i);
   [w,bias]=getClassifier(trainX,trainYi,C);
   weightM(i,:)=w;
   biasM(i,:)=bias;   
end





% %%%%
% 
% Ypredval=zeros(size(valX,1),1);
% for i=1:size(valX,1)
%    %%For each x get the 4 yPreds
%    xi=valX(i,:);
%    max=-999999;
%    maxClass=0;
%    for j=1:4
%        wi=weightM(j,:);
%        bi=biasM(j,:);
%        ypredi=wi*xi' +bi;
%        if( ypredi > max)
%            max=ypredi;
%            maxClass=j;
%        end
%    end
%    Ypredval(i,:)=maxClass;
% end
% 
% 
% %%%%
Ypred=zeros(size(testX,1),1);
for i=1:size(testX,1)
   %%For each x get the 4 yPreds
   xi=testX(i,:);
   max=-999999;
   maxClass=0;
   for j=1:4
       wi=weightM(j,:);
       bi=biasM(j,:);
       ypredi=wi*xi' +bi;
       if( ypredi > max)
           max=ypredi;
           maxClass=j;
       end
   end
   Ypred(i,:)=maxClass;

end

Ypredval=zeros(size(valX,1),1);
for i=1:size(valX,1)
   %%For each x get the 4 yPreds
   xi=valX(i,:);
   max=-999999;
   maxClass=0;
   for j=1:4
       wi=weightM(j,:);
       bi=biasM(j,:);
       ypredi=wi*xi' +bi;
       if( ypredi > max)
           max=ypredi;
           maxClass=j;
       end
   end
   Ypredval(i,:)=maxClass;
end

correctLabels=0;
for i=1:size(Ypredval,1)
    if(Ypredval(i,:)==valY(i,:))
        correctLabels=correctLabels+1;
    end
end
disp('correct labels');
disp(correctLabels);


function [w,bias]=getClassifier(X,Y,C)
%%load q2_1_data.mat

%X=trD.'; %Transpose
%Xt=trD;
%trLb = Y
%Y=trLb;
%Yt=Y';
%C=0.1
[w,bias,objectiveVal,alpha]=question1(X,Y,C);
% w
% bias
% objectiveVal



end 



function[ w,b,obj,alpha] =question1(X,Y,C)
    Y=double(Y);
    Yt=Y';
    Xt=X';
    feature=size(X,2); %Features of X
    datapoints=size(X,1);


    K=X*Xt;
    %H=diag(Y).*(K).*diag(Y)
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
    
    bias=0
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