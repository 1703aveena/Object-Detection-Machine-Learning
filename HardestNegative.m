function [negD] = HardestNegative(dp, W, b, thres)
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

    load(strcat('C:/Users/AVEENA/ML/hw4/', '/trainAnno.mat'), 'ubAnno'); 
    
    ScoreValues = [];
    for i = 1:num_images
        imgs{i} = imread(strcat(strcat(filepath, '/'), image_struct(i).name));
        rects = HW4_Utils.detect(imgs{i}, W,b,0);
%         disp("rects");
%         disp(rects);
%         disp("rects size:");

        %disp(size(rects));
        rects(1:4,:) = cast(rects(1:4,:), 'uint8');
        I = rects(5,:) > 0; 
%         disp(size(I));
        rects(:, I==0) = [];
%         disp(size(rects));
        ubs = ubAnno{i};
        for j=1:size(ubs,2)
            overlap = HW4_Utils.rectOverlap(rects, ubs(:,j));                    
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

                break;
            end
        end
        ScoreValues = cat(2, ScoreValues, rects(5, :));

        nNeg2SamplePerIm = size(rects, 2);
        im = imgs{i};
        [D_i, R_i] = deal(cell(1, nNeg2SamplePerIm));
        for j=1:nNeg2SamplePerIm
            imReg = im(rects(2,j):rects(4,j), rects(1,j):rects(3,j),:);
            imReg = imresize(imReg, HW4_Utils.normImSz);
            R_i{j} = imReg;
            D_i{j} = HW4_Utils.cmpFeat(rgb2gray(imReg));                    
        end
        
        negD{i} = cat(2, D_i{:});                
        negRegs{i} = cat(4, R_i{:});       
        

    end
    negD;
    negD = cat(2, negD{:});
    negD = HW4_Utils.l2Norm(negD);

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
trainYsend1=trainYsend(:,1);%%Get one column


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

    
    
%     size(negD)  
end