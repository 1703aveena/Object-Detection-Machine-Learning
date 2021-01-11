function [alpha, HardNeg, prec, rec, Objective_function,Objective_function1, valap] = Question_4_4_2(iterations, filepath)
    [trD, trLb, valD, valLb, trRegs, valRegs] = HW4_Utils.getPosAndRandomNeg();
    P_Ind = trLb == 1;
    PosD = trD(P_Ind);
    N_ind = trLb == -1;
    NegD = trD(N_ind);
    k = size(unique(trLb),1);
    C = 0.1;
   
    
    %Quadratic Programming
    [alpha, W, b] = SVM_quad_4_4_2(trD, trLb, C, 0);
%     size(alpha)
    
   
    %Normalise X -> divide all by 0.1
trainX_norm=trainX.*0.010;


trainYsend=zeros(n,4);
for i=1 : 4;
   %%Change the yclass which are not equal to i
   yj=zeros(n,1);
   for j=1:n;
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


for i=1:4;
   %%Get Y for ith classifier 
   trainYi=trainYsend(:,i);
   [w,bias]=getClassifier(trainX,trainYi,C);
   weightM(i,:)=w;
   biasM(i,:)=bias;   
end

Ypred=zeros(size(testX,1),1);
for i=1:size(testX,1);
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

    
    prev_best_ap = -inf;
    Objective_function = zeros(1, iterations);
    Objective_function1= zeros(1, iterations);
    valap = zeros(1, iterations);
    for j = 1:iterations
        j
       trD = trD(I);
       trLb = trLb(I);
        trD(:, I==0) = [];
        trLb(I==0, :) = [];
        HardNeg = HardestNegative(filepath, W, b, 0.2);
        Neg_Labels = -ones(size(HardNeg,2), 1);
        trD = cat(2, trD, HardNeg);
        trLb = cat(1, trLb, Neg_Labels);
%         size(trD)
%         size(trLb)
        [alpha, W, b, objectiveFn] = SVM_quad_4_4_2(trD, trLb, C, 0);
        I = (alpha > threshold & trLb == -1) | trLb == 1;
        disp('Hardmining and quad ');
        
        %%%%%
        Result = W'*trD + b;
        i = Result >= 1.0;
        Result(i) = 1;
        i = Result < 1.0;
        Result(i) = -1;

        Diff = trLb - Result';
        n = size(trLb, 1);
        Accuracy = ((n - nnz(Diff))/n)*100;
        Accuracy
        %%%%%
        
        
        %%%%%%%%%%
        Result = W'*valD + b;
        i = Result >= 1.0;
        Result(i) = 1;
        i = Result < 1.0;
        Result(i) = -1;

        Diff = valLb - Result';
        n = size(valLb, 1);
        Accuracy_val = ((n - nnz(Diff))/n)*100;
        Accuracy_val
        %%%%%%%%%%
        
        HW4_Utils.genRsltFile(W, b, 'val', 'C:/Users/AVEENA/ML/hw4/Output_4_4_3');
        [val_ap, prec, rec] = HW4_Utils.cmpAP('C:/Users/AVEENA/ML/hw4/Output_4_4_3', 'val');
        j
        val_ap
        
        if(val_ap > prev_best_ap)
            prev_best_ap = val_ap;
            HW4_Utils.genRsltFile(W, b, 'test', 'C:/Users/AVEENA/ML/hw4/Output_4_4_3_test_best');
        end
        Objective_function1(1,j) =objectiveFn
    end

    
    HW4_Utils.genRsltFile(W, b, 'test', 'C:/Users/AVEENA/ML/hw4/Output_4_4_3_test_final');

    %Normalise X -> divide all by 0.1
trainX_norm=trainX.*0.010;


trainYsend=zeros(n,4);
for i=1 : 4;
   %%Change the yclass which are not equal to i
   yj=zeros(n,1);
   for j=1:n;
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


for i=1:4;
   %%Get Y for ith classifier 
   trainYi=trainYsend(:,i);
   [w,bias]=getClassifier(trainX,trainYi,C);
   weightM(i,:)=w;
   biasM(i,:)=bias;   
end

Ypred=zeros(size(testX,1),1);
for i=1:size(testX,1);
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




end