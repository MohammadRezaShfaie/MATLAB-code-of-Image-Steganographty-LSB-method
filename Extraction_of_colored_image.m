
hid_pic=imread('baboon_image_RGB7.jpg');
[n1,m1]=size(hid_pic);
m1=m1/3;

ct=1;
temp = zeros(L/bitnumber,1);


for ii=1:n1
    for jj=1:m1
        for k=1:3
            temp(ct,1)=temp(ct,1)+mod(hid_pic(ii,jj,k),2^bitnumber);
            if (ct==L/bitnumber)
                break;
            end
            ct=ct+1;
        end
        if (ct==L/bitnumber)
            break;
        end
    end
    if(ct==L/bitnumber)
        break
    end
end

for ii=1:L/bitnumber
        for jj=1:bitnumber  
        w(jj,1)=mod(temp(ii),2);
        temp(ii)=fix(temp(ii)/2);
        end
    if ii~=1
        f=cat(1,f,w);
    else
        f=w;
    end
end

    

c=0; jj=0; z=1;

for i=1:32
    c=c+f(i,1)*(2^jj);
    jj=jj+1;
    if jj==8
        size(1,z)=c;
        z=z+1;
        jj=0;
        c=0;
    end
end

c=0; jj=0; z=1;
for i=33:L
    c=c+f(i,1)*(2^jj);
    jj=jj+1;
    if jj==8
        output(z,1)=c;
        z=z+1;
        jj=0;
        c=0;
    end
end


roww=size(1:2);
coll=size(3:4);

LRGB=length(output);
LR=LRGB/3;

for i=1:LR
    RR(1,i)=output(i);
    GG(1,i)=output(LR+i);
    BB(1,i)=output((2*LR)+i);
end

z=1;
for i=1:roww
    for j=1:coll
        Image(i,j,1)=RR(1,z);
        Image(i,j,2)=GG(1,z);
        Image(i,j,3)=BB(1,z);
        z=z+1;
    end
end

imwrite(Image,'output_baboon_image_RGB7.jpg','bmp') ;
             