for i=0:50
    %imread when minimum sensitivity setting
    filename1 = sprintf('/Users/yimingdai/Desktop/Data/Min/%d.dng',i);
    t1 = Tiff(filename1,'r');
    im1 = read(t1);
    im1 = im2uint8(im1);
    select1 = im1(1:1000,1000:2000);
    img1(i+1,:,:) = select1;
    %imread when maximum sensitivity setting
    filename2 = sprintf('/Users/yimingdai/Desktop/Data/Max/%d.dng',i);
    t2 = Tiff(filename2,'r');
    im2 = read(t2);
    im2 = im2uint8(im2);
    select2 = im2(1:1000,1000:2000);
    img2(i+1,:,:) = select2;
end

%the image is too large, sample a part of them
cut1=double(im1-min(min(im1)))/double(max(max(im1))-min(min(im1)));
cut2=double(im2-min(min(im2)))/double(max(max(im2))-min(min(im2)));
figure,imshow(cut1(1:1000,1000:2000));
figure,imshow(cut2(1:1000,1000:2000));

%plot a histogram of these pixel values for a given pixel
h(1:51) = double(img1(:,500,700));
h(52:102) = double(img2(:,500,700));
figure,hist(h)
title('histogram of a given pixel')
h(1:51) = double(img1(:,425,725));
h(52:102) = double(img2(:,425,725));
figure,hist(h)
title('histogram of a given pixel')
h(1:51) = double(img1(:,600,500));
h(52:102) = double(img2(:,600,500));
figure,hist(h)
title('histogram of a given pixel')

%calucate mean and variance of each pixel
for a=1:1000
    for b=1:1000
        total1=0;
        total2=0;
        bb1=0;
        bb2=0;
        for k=1:50
            total1=total1+double(img1(k,a,b));
            total2=total2+double(img2(k,a,b)); 
        end
		aa1 = total1/50;
        aa2 = total2/50;
        mean1(a,b)=aa1;%mean of minimum sentivity
        mean2(a,b)=aa2;%mean of maximum sentivity
        
        for k=1:50
        bb1 = bb1+(double(img1(k,a,b))-aa1)^2;
        bb2 = bb2+(double(img2(k,a,b))-aa2)^2;
        end
        var1(a,b)= bb1/50;%variance of minimum sentivity
        var2(a,b)= bb2/50;%variance of maximum sentivity
    end
end

figure,imshowpair(mean1,var1,'montage')
title('mean and variance image of minimum sensitivity setting')
figure,imshowpair(mean2,var2,'montage')
title('mean and variance image of maximum sensitivity setting')

%show a few original images I captured
raw(:,:)=img1(15,:,:);
figure,imagesc(raw)
title('one of original images of minimum sensitivity setting')
raw(:,:)=img1(40,:,:);
figure,imagesc(raw)
title('one of original images of minimum sensitivity setting')
raw(:,:)=img2(15,:,:);
figure,imagesc(raw)
title('one of original images of maximum sensitivity setting')
raw(:,:)=img2(40,:,:);
figure,imagesc(raw)
title('one of original images of maximum sensitivity setting')

%round the mean values to the nearest integer
for a=1:1000
    for b=1:1000
        mean1(a,b)=round(mean1(a,b));
        mean2(a,b)=round(mean2(a,b));
    end
end

%calculate the average variance for the same mean value
for i=0:255
    location1=find(mean1==i);
    average_var1=mean(var1(location1));
    var1(location1)=average_var1;
    
    location2=find(mean2==i);
    average_var2=mean(var2(location2));
    var2(location2)=average_var2;
end
%delete some index
locate=find(mean2>60);
mean2(locate)=[];
var2(locate)=[];

%plot the mean vs. the variance
p1 = polyfit(mean1,var1,1);
x1=linspace(min(min(mean1)),max(max(mean1)));
y1=polyval(p1,x1);
figure,plot(mean1,var1,'*',x1,y1);
title('the mean vs. the variance of minimum sensitivity setting')

p2 = polyfit(mean2,var2,1);
x2=linspace(min(min(mean2)),max(max(mean2)));
y2=polyval(p2,x2);
figure,plot(mean2,var2,'*',x2,y2);
title('the mean vs. the variance of maximum sensitivity setting')

%camera gain of minimum sensitivity setting
g1=p1(1);
outstring1 = ['camera gain of minimum sensitivity setting is: ',num2str(g1)];
disp(outstring1);%0.01245

%camera gain of maximum sensitivity setting
g2=p2(1);
outstring2 = ['camera gain of maximum sensitivity setting is: ',num2str(g2)];
disp(outstring2);%0.098135

%one of the step to caculate sigma_read & sigma_adc
% m=2;
% n=polyval(p1,m);
% disp(n)   %0.0877
% o=20;
% p=polyval(p2,o);
% disp(p)   %2.4328

%calculate sigma_read & sigma_adc
syms sigma_read sigma_adc;
[sigma_read, sigma_adc]=solve(0.0877==2*0.01245+sigma_read*0.01245^2+sigma_adc,2.4328==20*0.098135+sigma_read*0.098135^2+sigma_adc, sigma_read,sigma_adc);
read=double(sigma_read);  
adc=double(sigma_adc);
outstring3 = ['sigma_read is: ',num2str(read)]; %result is 0.056137
outstring4 = ['sigma_adc is: ',num2str(adc)];   %result is 42.9846
disp(outstring3);
disp(outstring4);

%SNR
snr1=double(mean1./sqrt(var1));
snr2=double(mean2./sqrt(var2));

figure,plot(mean1,snr1,'o');
title('SNR as a function of mean pixel value of minimum sensitivity setting')
figure,plot(mean2,snr2,'o');
title('SNR as a function of mean pixel value of maximum sensitivity setting')


