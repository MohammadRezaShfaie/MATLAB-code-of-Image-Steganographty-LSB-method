
clear
close
bitnumber = input("how many bits of cover image do you want to replace? (from 1 to 7)");

    
candidate_Image=imread('colorful.jpg');

[m,n]=size(candidate_Image);
n=n/3;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     

file = fopen('message.txt');

% read message as binary array and determining its size(L)
[Message,L] = fread(file,'ubit1');

add=mod(L,bitnumber);

if add ~=0 
    zero=zeros(bitnumber-add,1);
    Message=cat(1,Message,zero);
end

L=length(Message);

T=0 ; j=0; p=1;
for i=1:L
    T=T+(Message(i,1)*(2^j));
    j=j+1;
    if j==bitnumber
        NewMessage(p,1)=T;
        p=p+1;
        j=0;
        T=0;
    end
end
    

if (m*n*3<L/bitnumber)
    msg=msgbox('your picture is too small','error','modal');
    pause(1);
    if (ishandle(msg))
        close(msg);
    end   
end   



latest_data=candidate_Image;

count=1;

for i=1:m 
    for j=1:n
        for k=1:3
            latest_data(i,j,k)=candidate_Image(i,j,k)-mod(candidate_Image(i,j,k),2^bitnumber)+ NewMessage(count,1);  
            if(count==(L/bitnumber))
               break;
            end   
            count=count+1;
        end
        if (count==L/bitnumber)
            break;
        end
    end
    if (count==L/bitnumber)
        break;
    end
end

imwrite(latest_data,'colorfull_text8.jpg','bmp') ;

subplot(2,1,1)
  Red = candidate_Image(:,:,1);
  Green = candidate_Image(:,:,2);
  Blue = candidate_Image(:,:,3);
  [yRed, x] = imhist(Red);
  [yGreen, x] = imhist(Green);
  [yBlue, x] = imhist(Blue);
      
         
         bar(yRed, 'Red') ,hold on , bar(yGreen, 'Green'), hold on ,bar( yBlue, 'Blue');
         title(sprintf('Histogram of Cover image  %d bits (colorfull)', bitnumber));             

 subplot(2,1,2) 
  Red = latest_data(:,:,1);
  Green = latest_data(:,:,2);
  Blue = latest_data(:,:,3);
  [yRed, x] = imhist(Red);
  [yGreen, x] = imhist(Green);
  [yBlue, x] = imhist(Blue);
  
         
         bar(yRed, 'Red') ,hold on , bar(yGreen, 'Green'), hold on ,bar( yBlue, 'Blue');
        
         title(sprintf('Histogram of Stego image  %d bits (colorfull)', bitnumber));

% MSE  computation

MSE = immse(candidate_Image ,latest_data )

% PSNR computation

PSNR = 10*log((255^2)/MSE)

% BER  computation

candidate_Image_double = double(candidate_Image);
latest_data_double = double(latest_data);

x=1;
for i=1:m 
    for j=1:n
        for k=1:3
            for jj=0:7
            cid(x,1)=mod(candidate_Image_double(i,j,k),2);
            ldd(x,1)=mod(latest_data_double(i,j,k),2);
            x=x+1;
            candidate_Image_double(i,j,k)=fix(candidate_Image_double(i,j,k)/2);
            latest_data_double(i,j,k)=fix(latest_data_double(i,j,k)/2);
            end
        end
    end
end

BER = (nnz((cid-ldd)))/(length(cid))



         