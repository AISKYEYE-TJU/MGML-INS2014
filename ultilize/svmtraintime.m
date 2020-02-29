function [model1,trainTime]=svmtraintime(yr,indexs,kernelMatrix,para)
%   function
%   [model,trainTime]=svmtraintime(yr,doubletLabel,kernelMatrix,para)
%  
%   Input:
%  
%   yr = labels of doublets or triplets (For doublet (xi,xj), if xi and xj share the same label, then yr = -1, otherwise yr = 1. For triplets, yr = 1.)
%   indexs = the indexes of doublet or triplet elements in the training set
%   (each column is a doublet or a triplet)
%   kernelMatrix = the standard kernel cache which is equal to X'*X, where
%   X is the original training set, each column is a sample.
%   para = 
%   -s svm_type : set type of SVM (default 0)
%   	0 -- C-SVC
%   	1 -- nu-SVC
%   	2 -- one-class SVM
%   	3 -- epsilon-SVR
%   	4 -- nu-SVR
%   -t kernel_type : set type of kernel function (default 2)
%   	0 -- linear: u'*v
%   	1 -- polynomial: (gamma*u'*v + coef0)^degree
%   	2 -- radial basis function: exp(-gamma*|u-v|^2)
%   	3 -- sigmoid: tanh(gamma*u'*v + coef0)
%   	4 -- precomputed kernel (kernel values in training_instance_matrix)
%   	5 -- M-norm kernel for doublets
%   	6 -- M-norm kernel for triplets
%   -d degree : set degree in kernel function (default 3)
%   -g gamma : set gamma in kernel function (default 1/num_features)
%   -r coef0 : set coef0 in kernel function (default 0)
%   -c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
%   -n nu : set the parameter nu of nu-SVC, one-class SVM, and nu-SVR (default 0.5)
%   -p epsilon : set the epsilon in loss function of epsilon-SVR (default 0.1)
%   -m cachesize : set cache memory size in MB (default 100)
%   -e epsilon : set tolerance of termination criterion (default 0.001)
%   -h shrinking : whether to use the shrinking heuristics, 0 or 1 (default 1)
%   -b probability_estimates : whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
%   -wi weight : set the parameter C of class i to weight*C, for C-SVC (default 1)
%   -v n : n-fold cross validation mode
%   -f binary classification : set the binary classification mode, 0 or 1 (default 0)
%   -q : quiet mode (no outputs)
%  
%   Output:
%  
%   model.SVs = the support vectors (each row is a support vector)
%   model.sv_coef = the coefficients of support vectors in SVM dual problem
%   trainTime = the training time (in seconds)
%  
%   Some additional notes:
%  
%   If you use this function to solve the doublet-SVM problem, you should
%   select the kernel type as 'M-norm kernel for doublets', i.e. '-t 5'. If you want to
%   solve the triplet-SVM problem, you should select the kernel type as
%   'M-norm kernel for triplets', i.e. '-t 6'.

start1=cputime;
model1=svmtrain(yr,indexs,kernelMatrix,para);
end1=cputime;
trainTime=end1-start1;
%disp(num2str(end1-start1));
end