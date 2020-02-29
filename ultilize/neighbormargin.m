function margin=neighbormargin(X,Y,chit,cmiss)
%   function
%   [zr,yr,doubletLabels]=ConstructDoubletMatrix(X,Y,chit,cmiss)
%   Construct doublets set based on training instances.
%  
%   Input:
%  
%   X = training samples (each column is a sample)
%   Y = labels
%   chit = the number of hits for each sample
%   cmiss = the number of misses for each sample
%  
%   Output:
%  
%   zr = the constructed doublets set (each column is a doublet)
%   yr = the labels of each doublet in zr (in row vector form)
%   doubletLabels = the indexes of doublet elements in the training set (X)
%   (each column is a doublet)

[dim,sampleNum]=size(X);
zr=zeros(2*dim,(chit+cmiss)*sampleNum);
yr=zeros(1,(chit+cmiss)*sampleNum);
doubletLabels=zeros((chit+cmiss)*sampleNum,2);
indexzr=1;
for i=1:sampleNum
    HitDist=Inf*ones(sampleNum,1);
    MissDist=Inf*ones(sampleNum,1);
    %disp(num2str(i));
    Xik=X-X(:,i)*ones(1,sampleNum);
    Xik=Xik.^2;
    Distik=sum(Xik,1);
    SameLabel=find(Y==Y(i));
    DiffLabel=find(Y~=Y(i));
    HitDist(SameLabel)=Distik(SameLabel);
    MissDist(DiffLabel)=Distik(DiffLabel);
    HitDist(i)=Inf;
    [valuehit,SortedHitIndex]=sort(HitDist);
    [valuemiss,SortedMissIndex]=sort(MissDist);
    HitSet=SortedHitIndex(1:chit);
    MissSet=SortedMissIndex(1:cmiss);
    deltahit(i)=mean(valuehit(1:chit));
    deltamiss(i)=mean(valuemiss(1:cmiss));
    for k=union(HitSet',MissSet')
        doubletLabels(indexzr,:)=[i,k];
        zr(:,indexzr)=[X(:,i);X(:,k)];
        if Y(i)==Y(k)
            yr(indexzr)=-1;
        else
            yr(indexzr)=1;
        end
        indexzr=indexzr+1;
    end
end


hit=mean(deltahit);
miss=mean(deltamiss);
margin=miss-hit;