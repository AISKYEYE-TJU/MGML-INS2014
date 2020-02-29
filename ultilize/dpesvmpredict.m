function [predictLabels,accuracy]=dpesvmpredict(model,Xtrain,Xtest,Ytrain,Ytest,chit)
% function
% [predictLabels,accuracy]=dpesvmpredict(model,Xtrain,Xtest,Ytrain
% ,Ytest,k)
% Classify the testing set using k-NN strategy, based on Mahalanobis 
% distance trained by doublet-SVM, and obtain the recognition accuracy of the
% testing set.
%
% Input:
%
% model = the SVM model trained by 'svmtraintime' function
% Xtrain = the training set (each column is a training sample)
% Xtest = the testing set (each column is a testing sample)
% Ytrain = the labels of training samples
% Ytest = the labels of testing samples
% k = the number of nearest neighbors in k-NN strategy (usually equal to chit)
%
% Output:
%
% predictLabels = the classification labels of testing set
% accuracy = the recognition accuracy (%) of testing set
%
nSV=size(model.SVs,2);
dim=size(Xtrain,1);
SVs=uint16(full(model.SVs'));
M=zeros(dim,dim);
for i=1:nSV
    X1=Xtrain(:,SVs(i,1));
    X2=Xtrain(:,SVs(i,2));
    M=M+model.sv_coef(i)*(X1-X2)*(X1-X2)';
end
M=PosCone(M);
testSampleNum=size(Xtest,2);
trainSampleNum=size(Xtrain,2);
predictLabels=zeros(size(Ytest));
%objValue=zeros(size(Ytest));
for i=1:testSampleNum
    dist=zeros(1,trainSampleNum);
    for j=1:trainSampleNum
        dist(j)=(Xtest(:,i)-Xtrain(:,j))'*M*(Xtest(:,i)-Xtrain(:,j));
    end
    
    [~,minindex]=mink(dist(:),chit);
    %minindex= (dist==mindist);
    predictLabels(i)=mode(Ytrain(minindex));
    %objValue(i)=mindist;
end
correctNum=length(find(predictLabels==Ytest));
accuracy=correctNum/testSampleNum*100;
disp(strcat('recognition accuracy:',num2str(accuracy)));
end