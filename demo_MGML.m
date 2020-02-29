load data_uci
fold=10;
k=3;
method='NGML';
lambda=0.1;
result1=crossvalidation(glass,fold,method,k,lambda);
result2=crossvalidation(heart,fold,method,k,lambda);
result3=crossvalidation(horse,fold,method,k,lambda);
result4=crossvalidation(iono,fold,method,k,lambda);
result5=crossvalidation(sonar,fold,method,k,lambda);
result6=crossvalidation(wine,fold,method,k,lambda);

load data_uci
fold=10;
k=3;
method='MGML';
lambda=0.1;
result1=crossvalidation(glass,fold,method,k,lambda);
result2=crossvalidation(heart,fold,method,k,lambda);
result3=crossvalidation(horse,fold,method,k,lambda);
result4=crossvalidation(iono,fold,method,k,lambda);
result5=crossvalidation(sonar,fold,method,k,lambda);
result6=crossvalidation(wine,fold,method,k,lambda);
