pp1=pk_final(:,3);
un1=unique(pp1);
nn1=histc(pp1,un1);
indexC=find(pk_final(:,1)==411&pk_final(:,2)==143);
pk_final(indexC,:)
%figure
%plot(un,nn)
figure
plot(un1(4:size(nn1)),nn1(4:size(nn1)))