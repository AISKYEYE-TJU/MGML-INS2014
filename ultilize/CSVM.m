function [accuracy,prelabels,number]=CSVM(Xtrain,Xtest,Ytrain,Ytest,chit,delta)

[yr,doubletLabel]=ConstructDoubletMatrix_neighhood(Xtrain,Ytrain,delta);
[SVM_model,~]=svmtraintime(yr',doubletLabel,Xtrain'*Xtrain,'-t 5 -h 0 -f 1');
[prelabels,accuracy]=dpesvmpredict(SVM_model,Xtrain,Xtest,Ytrain,Ytest,chit);
number=SVM_model.totalSV;