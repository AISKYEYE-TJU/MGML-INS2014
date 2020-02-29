function  [result,accu]=MGML_test(Xtrain,Xtest,Ytrain,Ytest,chit,deltaset)
result=[];
for i=1:length(deltaset)
delta=deltaset(i);
[accu(i),prelabels]=CSVM(Xtrain,Xtest,Ytrain,Ytest,chit,delta);
result=[result,prelabels];
end