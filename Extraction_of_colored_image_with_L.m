

clear
bitnumber = input("how many bits of cover image do you want to replace? (from 1 to 7)");

hid_pic=imread('tiger_image_RGB3_withL.jpg');
[n1,m1]=size(hid_pic);
m1=m1/3;

ct=1;
LengthOFmessage = zeros(ceil(32/bitnumber),1);
for i=1:n1
    for j=1:m1
        for k=1:3
            LengthOFmessage(ct,1)=LengthOFmessage(ct,1)+mod(hid_pic(i,j,k),2^bitnumber);
            if (ct==(ceil(32/bitnumber)))
                break;
            end
            ct=ct+1;
        end
        if (ct==(ceil(32/bitnumber)))
            break;
        end
    end
    if(ct==(ceil(32/bitnumber)))
        break
    end
end

count=1;
for j=1:ceil(32/bitnumber)
    for i=1:bitnumber
    LL(count,1)= mod(LengthOFmessage(j),2);
    LengthOFmessage(j)=fix(LengthOFmessage(j)/2);
    count=count+1;
    end
end

L=0;
for i=1:32
    L=L+(LL(i)*(2^(i-1)));
end

L=L+32;
add=mod(L,bitnumber);
L=L+bitnumber-add;

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

for i=33:64
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
for i=65:L
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

Image=uint8(Image);

imwrite(Image,'output_tiger_image_RGB3_withL.jpg','bmp') ;
             