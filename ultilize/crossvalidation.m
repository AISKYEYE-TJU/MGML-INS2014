function resu=crossvalidation(data,fold,method,k,lambda)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row column]=size(data);
for i=1:column-1
    data(:,i)=(data(:,i)-min(data(:,i)))/(max(data(:,i))-min(data(:,i)));
end

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
        case 'MGML'
           margin=neighbormargin(Samples',Labels,1,k);
           deltaset=margin*[0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.5 2.0];
           [resultt,reallabel]=MGML_train(Samples',Labels,deltaset);
           resultl=MGML_test(Samples',testS',Labels,testL,1,deltaset);
           accu_m(j)=sparse_classifier_l1w(lambda,resultt,resultl,reallabel,testL,'yes');
           
         case 'NGML'
           margin=neighbormargin(Samples',Labels,1,k);
           deltaset=margin*[0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.5 2.0];
           [~,accu(:,j)]=MGML_test(Samples',testS',Labels,testL,1,deltaset); 
    end   
    
end

 switch method
          case 'MGML'
           acc_mean=mean(accu_m);
           std_mean=std(accu_m);
         case 'NGML'
          result=mean(accu');
          stdar=std(accu');
          [acc_mean,index]=max(result);
          std_mean=stdar(index);
 end   
 resu=[acc_mean,std_mean]; 