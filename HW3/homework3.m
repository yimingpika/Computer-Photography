I1 = imread('/Users/yimingdai/Desktop/HW3/IMG_20181023_174558.jpg');%no flash
I2 = imread('/Users/yimingdai/Desktop/HW3/IMG_20181023_174612.jpg');%flash
figure,imshow(I1);title('original no flash image');
figure,imshow(I2);title('original flash image');
select1 = I1(400:1424,400:1168,:,:);
select2 = I2(400:1424,400:1168,:,:);
I11 = select1; %no flash image
I22 = select2; %flash
figure,imshow(I11);title('original no flash cut image');
figure,imshow(I22);title('original flash cut image');

% Denoise each color channel separately.
%no flash
red_1 = I11(:,:,1); % Red channel
green_1 = I11(:,:,2); % Green channel
blue_1 = I11(:,:,3); % Blue channel

red_1_grey = im2double(red_1);
green_1_grey = im2double(green_1);
blue_1_grey = im2double(blue_1);

sigmaSpatial1  = 16;sigmaRange1 = 0.05;
sigmaSpatial2  = 16;sigmaRange2 = 0.15;
sigmaSpatial3  = 16;sigmaRange3 = 0.25;
sigmaSpatial4  = 32;sigmaRange4 = 0.05;
sigmaSpatial5  = 32;sigmaRange5 = 0.15;
sigmaSpatial6  = 32;sigmaRange6 = 0.25;
sigmaSpatial7  = 64;sigmaRange7 = 0.05;
sigmaSpatial8  = 64;sigmaRange8 = 0.15;
sigmaSpatial9  = 64;sigmaRange9 = 0.25;
%red channel
output_red_1_1 = bilateralFilter(red_1_grey, sigmaSpatial1, sigmaRange1);
figure,subplot(3,3,1),imshow(output_red_1_1,[]);title('channel red, sigma_s=16, sigma_r=0.05');
output_red_1_2 = bilateralFilter(red_1_grey, sigmaSpatial2, sigmaRange2);
subplot(3,3,2),imshow(output_red_1_2,[]);title('sigma_s=16, sigma_r=0.15');
output_red_1_3 = bilateralFilter(red_1_grey, sigmaSpatial3, sigmaRange3);
subplot(3,3,3),imshow(output_red_1_3,[]);title('sigma_s=16, sigma_r=0.25');
output_red_1_4 = bilateralFilter(red_1_grey, sigmaSpatial4, sigmaRange4);
subplot(3,3,4),imshow(output_red_1_4,[]);title('sigma_s=32, sigma_r=0.05');
output_red_1_5 = bilateralFilter(red_1_grey, sigmaSpatial5, sigmaRange5);
subplot(3,3,5),imshow(output_red_1_5,[]);title('sigma_s=32, sigma_r=0.15');
output_red_1_6 = bilateralFilter(red_1_grey, sigmaSpatial6, sigmaRange6);
subplot(3,3,6),imshow(output_red_1_6,[]);title('sigma_s=32, sigma_r=0.25');
output_red_1_7 = bilateralFilter(red_1_grey, sigmaSpatial7, sigmaRange7);
subplot(3,3,7),imshow(output_red_1_7,[]);title('sigma_s=64, sigma_r=0.05');   
output_red_1_8 = bilateralFilter(red_1_grey, sigmaSpatial8, sigmaRange8);
subplot(3,3,8),imshow(output_red_1_8,[]);title('sigma_s=64, sigma_r=0.15');
output_red_1_9 = bilateralFilter(red_1_grey, sigmaSpatial9, sigmaRange9);
subplot(3,3,9),imshow(output_red_1_9,[]);title('sigma_s=64, sigma_r=0.25');
%green channel
output_green_1_1 = bilateralFilter(green_1_grey, sigmaSpatial1, sigmaRange1);
figure,subplot(3,3,1),imshow(output_green_1_1,[]);title('channel green, sigma_s=16, sigma_r=0.05');
output_green_1_2 = bilateralFilter(green_1_grey, sigmaSpatial2, sigmaRange2);
subplot(3,3,2),imshow(output_green_1_2,[]);title('sigma_s=16, sigma_r=0.15');
output_green_1_3 = bilateralFilter(green_1_grey, sigmaSpatial3, sigmaRange3);
subplot(3,3,3),imshow(output_green_1_3,[]);title('sigma_s=16, sigma_r=0.25');
output_green_1_4 = bilateralFilter(green_1_grey, sigmaSpatial4, sigmaRange4);
subplot(3,3,4),imshow(output_green_1_4,[]);title('sigma_s=32, sigma_r=0.05');
output_green_1_5 = bilateralFilter(green_1_grey, sigmaSpatial5, sigmaRange5);
subplot(3,3,5),imshow(output_green_1_5,[]);title('sigma_s=32, sigma_r=0.15');
output_green_1_6 = bilateralFilter(green_1_grey, sigmaSpatial6, sigmaRange6);
subplot(3,3,6),imshow(output_green_1_6,[]);title('sigma_s=32, sigma_r=0.25');
output_green_1_7 = bilateralFilter(green_1_grey, sigmaSpatial7, sigmaRange7);
subplot(3,3,7),imshow(output_green_1_7,[]);title('sigma_s=64, sigma_r=0.05');  
output_green_1_8 = bilateralFilter(green_1_grey, sigmaSpatial8, sigmaRange8);
subplot(3,3,8),imshow(output_green_1_8,[]);title('sigma_s=64, sigma_r=0.15');
output_green_1_9 = bilateralFilter(green_1_grey, sigmaSpatial9, sigmaRange9);
subplot(3,3,9),imshow(output_green_1_9,[]);title('sigma_s=64, sigma_r=0.25');
%blue channle
output_blue_1_1 = bilateralFilter(blue_1_grey, sigmaSpatial1, sigmaRange1);
figure,subplot(3,3,1),imshow(output_blue_1_1,[]);title('channel blue, sigma_s=16, sigma_r=0.05');
output_blue_1_2 = bilateralFilter(blue_1_grey, sigmaSpatial2, sigmaRange2);
subplot(3,3,2),imshow(output_blue_1_2,[]);title('sigma_s=16, sigma_r=0.15');
output_blue_1_3 = bilateralFilter(blue_1_grey, sigmaSpatial3, sigmaRange3);
subplot(3,3,3),imshow(output_blue_1_3,[]);title('sigma_s=16, sigma_r=0.25');
output_blue_1_4 = bilateralFilter(blue_1_grey, sigmaSpatial4, sigmaRange4);
subplot(3,3,4),imshow(output_blue_1_4,[]);title('sigma_s=32, sigma_r=0.05'); 
output_blue_1_5 = bilateralFilter(blue_1_grey, sigmaSpatial5, sigmaRange5);
subplot(3,3,5),imshow(output_blue_1_5,[]);title('sigma_s=32, sigma_r=0.15');
output_blue_1_6 = bilateralFilter(blue_1_grey, sigmaSpatial6, sigmaRange6);
subplot(3,3,6),imshow(output_blue_1_6,[]);title('sigma_s=32, sigma_r=0.25');
output_blue_1_7 = bilateralFilter(blue_1_grey, sigmaSpatial7, sigmaRange7);
subplot(3,3,7),imshow(output_blue_1_7,[]);title('sigma_s=64, sigma_r=0.05');
output_blue_1_8 = bilateralFilter(blue_1_grey, sigmaSpatial8, sigmaRange8);
subplot(3,3,8),imshow(output_blue_1_8,[]);title('sigma_s=64, sigma_r=0.15');
output_blue_1_9 = bilateralFilter(blue_1_grey, sigmaSpatial9, sigmaRange9);
subplot(3,3,9),imshow(output_blue_1_9,[]);title('sigma_s=64, sigma_r=0.25');
%RGB image
back_to_original_img1_1 = cat(3, output_red_1_1, output_green_1_1, output_blue_1_1);
figure,subplot(3,3,1),imshow(back_to_original_img1_1,[]);title('sigma_s=16, sigma_r=0.05');
back_to_original_img1_2 = cat(3, output_red_1_2, output_green_1_2, output_blue_1_2);
subplot(3,3,2),imshow(back_to_original_img1_2,[]);title('sigma_s=16, sigma_r=0.15');
back_to_original_img1_3 = cat(3, output_red_1_3, output_green_1_3, output_blue_1_3);
subplot(3,3,3),imshow(back_to_original_img1_3,[]);title('sigma_s=16, sigma_r=0.25');
back_to_original_img1_4 = cat(3, output_red_1_4, output_green_1_4, output_blue_1_4);
subplot(3,3,4),imshow(back_to_original_img1_4,[]);title('sigma_s=32, sigma_r=0.05');
back_to_original_img1_5 = cat(3, output_red_1_5, output_green_1_5, output_blue_1_5);
subplot(3,3,5),imshow(back_to_original_img1_5,[]);title('sigma_s=32, sigma_r=0.15');
back_to_original_img1_6 = cat(3, output_red_1_6, output_green_1_6, output_blue_1_6);
subplot(3,3,6),imshow(back_to_original_img1_6,[]);title('sigma_s=32, sigma_r=0.25');
back_to_original_img1_7 = cat(3, output_red_1_7, output_green_1_7, output_blue_1_7);
subplot(3,3,7),imshow(back_to_original_img1_7,[]);title('sigma_s=64, sigma_r=0.05');
back_to_original_img1_8 = cat(3, output_red_1_8, output_green_1_8, output_blue_1_8);
subplot(3,3,8),imshow(back_to_original_img1_8,[]);title('sigma_s=64, sigma_r=0.15');
back_to_original_img1_9 = cat(3, output_red_1_9, output_green_1_9, output_blue_1_9);
subplot(3,3,9),imshow(back_to_original_img1_9,[]);title('sigma_s=64, sigma_r=0.25');

back_to_original_img1 = cat(3, output_red_1_8, output_green_1_8, output_blue_1_8);
figure,imshow(back_to_original_img1);title('denoised no flash cut image');

%no flash large image
red_11 = I1(:,:,1); % Red channel
green_11 = I1(:,:,2); % Green channel
blue_11 = I1(:,:,3); % Blue channel


red_11_grey = im2double(red_11);
green_11_grey = im2double(green_11);
blue_11_grey = im2double(blue_11);

output_red_11 = bilateralFilter(red_11_grey, sigmaSpatial8, sigmaRange8);
output_green_11 = bilateralFilter(green_11_grey, sigmaSpatial8, sigmaRange8);
output_blue_11 = bilateralFilter(blue_11_grey, sigmaSpatial8, sigmaRange8);
back_to_original_img11 = cat(3, output_red_11, output_green_11, output_blue_11);
figure,imshow(back_to_original_img11);title('denoised no flash image');

% flash large image
red_2 = I2(:,:,1); % Red channel
green_2 = I2(:,:,2); % Green channel
blue_2 = I2(:,:,3); % Blue channel


red_2_grey = im2double(red_2);
green_2_grey = im2double(green_2);
blue_2_grey = im2double(blue_2);

output_red_2 = bilateralFilter(red_2_grey, sigmaSpatial8, sigmaRange8);
output_green_2 = bilateralFilter(green_2_grey, sigmaSpatial8, sigmaRange8);
output_blue_2 = bilateralFilter(blue_2_grey, sigmaSpatial8, sigmaRange8);
back_to_original_img2 = cat(3, output_red_2, output_green_2, output_blue_2);
figure,imshow(back_to_original_img2);title('denoised flash image');

% 
F_d = back_to_original_img2;% denoised flash image
A_d = back_to_original_img11;% denoised no flash image
F = I2;% flash image
A_f(:,:,:) = double(A_d(:,:,:)).*(double(F(:,:,:))+0.02)./(double(F_d(:,:,:))+0.02);
figure,imshow(A_f(:,:,:)/255.0);title('fused image');
figure,imshow(A_f(:,:,:));title('fused image (wrong)');


