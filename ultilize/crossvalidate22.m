function [acc_mean,acc_std,result_label,real_label]=crossvalidate22(data,fold,method,k,lambda)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row column]=size(data);
for i=1:column-1
    data(:,i)=(data(:,i)-min(data(:,i)))/(max(data(:,i))-min(data(:,i)));
end

[row column]=size(data);
label=data(:,end);
classnum=max(label);
start1=1;
for i=1:classnum
    [a,b]=find(label==i);
    datai=data(a,:);      %select the i class data 
    [rr1,cc1]=size(datai);
    start1=1;
    %%%%%%%%%part the i class in (fold)%%%%%%%%%%%%%%%%%%%%%
    for j=1:fold-1
        a1=round(length(a)/fold);
        a2=a1-1;
        A=[a1 a2;1 1];
        b=[rr1 fold]';
        x=A\b;
        if (j<x(1)+1)
            everynum=a1;
        else
            everynum=a2;
        end
        start2=start1+everynum-1;       
        eval(['data' num2str(i) num2str(j) '=datai([start1:start2],:);']);
        start1=start2+1;
    end
    eval(['data' num2str(i) num2str(fold) '=datai([start1:length(a)],:);']);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

result_label=[];
real_label=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:fold
    eval(['part' num2str(j) '=[];']);
    for i=1:classnum
      eval(['part' num2str(j) '=[part' num2str(j) ';data' num2str(i) num2str(j) '];']);
    end   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:fold
    Samples=[];
     Labels=[];
     testS=[];
     testL=[];
    for i=1:fold
        
        if (i~=j)
            eval(['Samples=[Samples;part' num2str(i) '(:,1:column-1)];'])
            eval(['Labels=[Labels;part' num2str(i) '(:,column)];'])
        end
    end
    eval(['testS=part' num2str(j) '(:,1:column-1);'])
    eval(['testL=part' num2str(j) '(:,column);'])
    switch method
        case 'NGM'
            [accu_m(j),prelabels,number(j)]=CSVM(Samples',testS',Labels,testL,1,k);
           
    end   
    result_label=[result_label;prelabels];
    real_label=[real_label;testL];
end
acc_mean=mean(accu_m);
acc_std=std(accu_m);
% num=mean(number);