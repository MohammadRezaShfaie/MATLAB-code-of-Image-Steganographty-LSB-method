
hid_pic=imread('encrypted_Image10.jpg');
[n1,m1]=size(hid_pic);
m1=m1/3;

ct=1;
temp = zeros(L/bitnumber,1);
%temp=Message;
for i=1:n1
    for j=1:m1
        for k=1:3
            temp(ct,1)=temp(ct,1)+mod(hid_pic(i,j,k),2^bitnumber);
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

for i=1:L/bitnumber
        for j=1:bitnumber  
        w(j,1)=mod(temp(i),2);
        temp(i)=fix(temp(i)/2);
        end
    if i~=1
        f=cat(1,f,w);
    else
        f=w;
    end
end

c=0; jj=0;
fileID=fopen('output10.txt','w');
for i=1:L
    c=c+f(i,1)*(2^jj);
    jj=jj+1;
    if jj==8
        jj=0;
        fwrite(fileID,c,'char');
        c=0;
    end
end
fclose(fileID);
    
            