function [result,reallbel]=MGML_train(Xtrain,Ytrain,deltaset)
result=[];
data=[Xtrain',Ytrain];
for i=1:length(deltaset)
delta=deltaset(i);
[acc_mean(i),~,predictLabels,reallbel]=crossvalidate22(data,10,'NGM',delta);
result=[result,predictLabels];
end

