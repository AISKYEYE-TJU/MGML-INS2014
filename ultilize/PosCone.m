function posM=PosCone(M)
[V D]=eig(M);
D=max(D,0);
posM=V*D*inv(V);
end