% % load video data
v = VideoReader('/Users/yimingdai/Desktop/1.mp4');
n = 0;
while hasFrame(v)
    video = readFrame(v);
    video_gray = rgb2gray(video);
    n = n + 1; %calculate frame number
    f(n,:,:) = video_gray;
    f_c(n,:,:,:)=video;
end

% temp(:,:) = f(1,:,:);
% % figure,imshow(temp);
template1(:,:) = f(1,500:550,950:1000);
% figure,imshow(template1);
% win_temp1(:,:) = f(1,300:800,850:1350);
% figure,imshow(win_temp1);

% refocus on a new object
template2(:,:) = f(1,850:900,700:750);
% figure,imshow(template2);
% win_temp2(:,:) = f(1,550:950,500:900);
% figure,imshow(win_temp2);

% window1 = (300:800,850:1350)
% window2 = (550:950,500:900)

% template size 50*50

for i = 1:n
    win1(:,:) = f(i,300:800,850:1350);
    A1 = normxcorr2(template1, win1);
    A1_max = max(max(A1));
    [row1(i), col1(i)] = find(A1 == A1_max);
    win2(:,:) = f(i,550:950,500:900);
    A2 = normxcorr2(template2, win2);
    A2_max = max(max(A2));
    [row2(i), col2(i)] = find(A2 == A2_max);
end
figure,plot(col1, row1, '*-'),xlabel('X Pixel Shift'), ylabel('Y Pixel Shift'), title('Pixel shift for each frame of video case1');
figure,plot(col2, row2, '*-'),xlabel('X Pixel Shift'), ylabel('Y Pixel Shift'), title('Pixel shift for each frame of video case2');

% gray image
% P = zeros(1080, 1920);
% for i=1:5:n
%     xform = [ 1 0 0; 
%         0 1 0;
%         -col1(i) -row1(i) 1 ];
%     tform_translate = maketform('affine', xform);
%     tmp = squeeze(f(i,:,:));
%     cb_trans= imtransform(tmp, tform_translate, 'XData', [1 size(tmp,2)], 'YData', [1 size(tmp,1)], 'FillValues', 255);
%     tmp_p(:,:) = im2double(cb_trans);
%     P(:,:) = P(:,:) + tmp_p(:,:);
% end

% color image
P = zeros(1080, 1920, 3);
for i=1:5:n
    xform = [ 1 0 0; 
        0 1 0;
        -col1(i) -row1(i) 1 ];
    tform_translate = maketform('affine', xform);
    tmp = squeeze(f_c(i,:,:,:));
    cb_trans= imtransform(tmp, tform_translate, 'XData', [1 size(tmp,2)], 'YData', [1 size(tmp,1)], 'FillValues', 255);
    P(:,:,:,i) = im2double(cb_trans);
end
figure, imshow(mean(P,4)*10,[]), title("synthetic aperture photograph 1");

P = zeros(1080, 1920, 3);
for i=1:5:n
    xform = [ 1 0 0; 
        0 1 0;
        -col2(i) -row2(i) 1 ];
    tform_translate = maketform('affine', xform);
    tmp = squeeze(f_c(i,:,:,:));
    cb_trans= imtransform(tmp, tform_translate, 'XData', [1 size(tmp,2)], 'YData', [1 size(tmp,1)], 'FillValues', 255);
    P(:,:,:,i) = im2double(cb_trans);
end
figure, imshow(mean(P,4)*10,[]), title("synthetic aperture photograph 2");
