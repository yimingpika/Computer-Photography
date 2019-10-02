load('/Users/yimingdai/Documents/MATLAB/debevec_response.mat'); % g
B = [0.03125, 0.0626, 0.125, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024];
B = log(B);
for j = 1:16
    imgPath = strcat('/Users/yimingdai/Desktop/Memorial_SourceImages/',num2str(j),'.png');
    img = imread(imgPath);
    I(j,:,:,:)=img(:,:,:); 
end
img = imread('/Users/yimingdai/Desktop/Memorial_SourceImages/1.png');
[m,n,~]=size(img);
amount = m*n;
E = zeros(amount,3);

for a = 0:255
    for j = 1:16
        for k =1:3
            img1(:,:) = I(j,:,:,k); 
            img2 = img1(:)';
            index = find(img2 == a);
            E(index, k) = E(index, k) +g(a+1,k)-B(j);
        end
    end
end
E = E./16;
Et = reshape(E, [m,n,3]);

for k = 1:3
    figure,imagesc(Et(:,:,k));
    axis ij
    axis image
    colormap('jet');
    colorbar;
end
