function [yr,doubletLabels]=ConstructDoubletMatrix_neighhood(X,Y,delta)
%   function
%   [zr,yr,doubletLabels]=ConstructDoubletMatrix(X,Y,chit,cmiss)
%   Construct doublets set based on training instances.
%  
%   Input:
%  
%   X = training samples (each column is a sample)
%   Y = labels
%   delta is the neighborhood size
%   Output:
%  
%   zr = the constructed doublets set (each column is a doublet)
%   yr = the labels of each doublet in zr (in row vector form)
%   doubletLabels = the indexes of doublet elements in the training set (X)
%   (each column is a doublet)

[dim,sampleNum]=size(X);
indexzr=1;
for i=1:sampleNum
    %disp(num2str(i));
    Xik=X-X(:,i)*ones(1,sampleNum);
    Xik=Xik.^2;
    Distik=sum(Xik,1);
    Distik(i)=Inf;
    SortedHitIndex=find(Distik<=delta);
    
    for k=1:length(SortedHitIndex)
        doubletLabels(indexzr,:)=[i,SortedHitIndex(k)];
        if Y(i)==Y(SortedHitIndex(k))
            yr(indexzr)=-1;
        else
            yr(indexzr)=1;
        end
        indexzr=indexzr+1;
    end
end
end