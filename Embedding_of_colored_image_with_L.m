

clear
close

Image=imread('RGB.jpg');


I = rgb2gray( Image );

[row,col]=size(I);

k=1;
for i=1:row
    for j=1:col
        R(k,1)=Image(i,j,1);
        G(k,1)=Image(i,j,2);
        B(k,1)=Image(i,j,3);
        k=k+1;
    end
end

a=cat(1,R,G);
a=cat(1,a,B);

row1=row;
for j=1:2
    rowarray(j,1)=mod(row1,2^8);
    row1=fix(row1/2^8);
end

rowarray=uint8(rowarray);

col1=col;
for j=1:2
    colarray(j,1)=mod(col1,2^8);
    col1=fix(col1/2^8);
end

colarray=uint8(colarray);

sizeOFimage=cat(1,rowarray,colarray);
a=cat(1,sizeOFimage,a);

La=length(a);

aa=a;
aa=double(aa);
z=0;j=1;
for i=1:(8*La)
    Message(i,1)=mod(aa(j),2);
    aa(j)=fix(aa(j)/2);
    z=z+1;
    if(z==8)
        j=j+1;
        z=0;
    end
end

       

bitnumber = input("how many bits of cover image do you want to replace? (from 1 to 7)");

    
candidate_Image=imread('tiger.jpg');

[n,m]=size(candidate_Image);
m=m/3;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     

L=length(Message);

L1=L;
for j=1:32
    Larray(j,1)=mod(L1,2);
    L1=fix(L1/2);
end

Larray=double(Larray);

  
Message=cat(1,Larray,Message);  
    
L=L+32;



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

for i=1:n 
    for j=1:m
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


imwrite(latest_data,'tiger_image_RGB3_withL.jpg','bmp') ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DCT%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% candidate_Image_gray=rgb2gray(candidate_Image);
% latest_data_gray=rgb2gray(latest_data);
% 
% subplot(2,1,1)
%       CIG=dct2(double(candidate_Image_gray));
%       bar(log(abs(CIG)));
%       title(sprintf('DCT of Cover image  %d bits (colorful)', bitnumber));  
%       
% subplot(2,1,2) 
%       LDG=dct2(double(latest_data_gray));
%       bar(log(abs(LDG))); 
%       title(sprintf('DCT of Stego image  %d bits (colorful)', bitnumber));
%          

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Histogram%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % subplot(2,1,1)
% %   Red = candidate_Image(:,:,1);
% %   Green = candidate_Image(:,:,2);
% %   Blue = candidate_Image(:,:,3);
% %   [yRed, x] = imhist(Red);
% %   [yGreen, x] = imhist(Green);
% %   [yBlue, x] = imhist(Blue);
% %       
% %          
% %          bar(yRed, 'Red') ,hold on , bar(yGreen, 'Green'), hold on ,bar( yBlue, 'Blue');
% %          title(sprintf('Histogram of Cover image  %d bits (colorful)', bitnumber));             
% % 
% %  subplot(2,1,2) 
% %   Red = latest_data(:,:,1);
% %   Green = latest_data(:,:,2);
% %   Blue = latest_data(:,:,3);
% %   [yRed, x] = imhist(Red);
% %   [yGreen, x] = imhist(Green);
% %   [yBlue, x] = imhist(Blue);
% %   
% %          
% %          bar(yRed, 'Red') ,hold on , bar(yGreen, 'Green'), hold on ,bar( yBlue, 'Blue');
% %         
% %          title(sprintf('Histogram of Stego image  %d bits (colorful)', bitnumber));
% %          
% %          
% %          
% %          
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Metrics computation%%%%%%%%%%%%%%%%%%%%%%%%
% % % MSE  computation
% % 
% % MSE = immse(candidate_Image ,latest_data )
% % 
% % % PSNR computation
% % 
% % PSNR = 10*log((255^2)/MSE)
% % 
% % % BER  computation
% % 
% % candidate_Image_double = double(candidate_Image);
% % latest_data_double = double(latest_data);
% % 
% % x=1;
% % for i=1:n 
% %     for j=1:m
% %         for k=1:3
% %             for jj=0:7
% %             cid(x,1)=mod(candidate_Image_double(i,j,k),2);
% %             ldd(x,1)=mod(latest_data_double(i,j,k),2);
% %             x=x+1;
% %             candidate_Image_double(i,j,k)=fix(candidate_Image_double(i,j,k)/2);
% %             latest_data_double(i,j,k)=fix(latest_data_double(i,j,k)/2);
% %             end
% %         end
% %     end
% % end
% % 
% % BER = (nnz((cid-ldd)))/(length(cid))
% % 
% % 
% % 
% % 
% % 
