function stat_sort=all_p(im,th,sz)
pk_all=[];
a=double(imread('CAT1_10-11 7.503ms_25s_0thiol00021.gif'));
[~,~,~,N]=size(a);
for i=1:N;
[b,gb,bb]=bpass(a(:,:,:,i),1,4);
b0=im2uint8(b);
%b0=255-b0;g
pk=pkfnd(b,15,4);
[d3,~]=size(pk);
pk_i=[pk,i*ones(d3,1)];
pk_all=[pk_all;pk_i];
%figure;%imshow(b);
%imshow has a number of default settings intended for displaying images;
%colormap('gray'),imagesc(a);%imshow(b);
%figure;%imshow(b);
%colormap('gray'),imagesc(b);%imshow(b);
%hold on
end
scatter(pk_all(:,1),pk_all(:,2),'g');
sorted=sort(pk_all,1);  %sort all particles according to x axis.
pk_stat=[];     % store all particles, first row is x-axis, second is y-axis, third time-axis, last group one particles in different time.
ds=6;
pk_final=[];     % to store the final statistics particles.
i=1;    % all the group of particles
while 1
    index=find(sorted(:,1)>(sorted(1,1)-ds)&sorted(:,1)<(sorted(1,1)+ds)&sorted(:,2)>(sorted(1,2)-ds)&sorted(:,2)<(sorted(1,2)+ds));
    if ~isempty(index)
        pk_all_i=[sorted(index,:),i*ones];
        pk_stat=[pk_stat;pk_all_i];
        sorted(index,:)=[];   %empty the same coordinate particles 
    end
    if isempty(sorted)
        break
    end
end
cons=1;
for j=1:i
    index=find(pk_stat(:,4)==i);
    [len,~]=size(index);
    if len>1
        pk_series=sort(pk_stat(index,:),3);
        temp_k=1;
        for k=2:index
            if pk_series(k,3)-pk_series(k-1,3)>10
                pk_final_i=[pk_series(k,1),pk_series(k,2),pk_series(k-1,3)-pk(temp_k,3),cons];
                pk_final=[pk_final;pk_final_i];
                temp_k=k;   
                cons=cons+1;
            end
        end
    elseif len==1
        pk_final_i=[pk_stat(index,1),pk_stat(index,2),0,cons];
        pk_final=[pk_final;pk_final_i];
        cons=cons+1;
    end
end
stat_sort=sort(pk_final,3);
end
