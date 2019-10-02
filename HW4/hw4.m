l1=0.1;l2=0.5;l3=1;l4=2;l5=3;l6=4;l7=5;
ZZ=(0:255);
B = [4300800, 8601600, 17203200, 34406400, 137625600];
B = log(B);
g = zeros(256,3);
lE = zeros(1000,3);

for j=1:5  
    imgPath = strcat('/Users/yimingdai/Desktop/Pic/',num2str(j),'.jpg');
    img = imread(imgPath);
%     figure,imshow(img);
%     select = img(200:300,200:300,:,:);
%     figure,imshow(select);
%     select = img(380:480,1:100,:,:);
%     figure,imshow(select);
    I(j,:,:,:)=img(:,:,:); 
end

% choose a random subset of 1000 pixels
m = 480; n = 640;
amount = m*n;
p = randperm(amount);
p1 = p(1:1000);
Z = zeros(1000, 5, 3);

% red channel
for j = 1:5
    img1(:,:) = I(j,:,:,1); 
    img2 = img1(:)';
    Z(:,j,1) = img2(p1);
end
[g(:,1),lE(:,1)]=gsolve(Z(:,:,1),B,l7);
X = lE(:,1) + B;
figure,plot(g(:,1),ZZ,'b');xlabel('log exposure'),ylabel('pixel value');
title('response curve for red channel when l=5');
hold on
plot(X,Z(:,:,1),'.');
hold off

% [g(:,1),lE(:,1)]=gsolve(Z(:,:,1),B,l1);
% figure,subplot(2,2,1),plot(g(:,1),ZZ,'b');xlabel('log exposure'),ylabel('pixel value');
% title('response curve for red channel when l=0.1');
% [g(:,1),lE(:,1)]=gsolve(Z(:,:,1),B,l3);
% subplot(2,2,2),plot(g(:,1),ZZ,'b');xlabel('log exposure'),ylabel('pixel value');
% title('response curve for red channel when l=1');
% [g(:,1),lE(:,1)]=gsolve(Z(:,:,1),B,l5);
% subplot(2,2,3),plot(g(:,1),ZZ,'b');xlabel('log exposure'),ylabel('pixel value');
% title('response curve for red channel when l=3');
% subplot(2,2,4),plot(g(:,1),ZZ,'b');xlabel('log exposure'),ylabel('pixel value');
% title('response curve for red channel when l=5');

% green channel
for j = 1:5
    img1(:,:) = I(j,:,:,2); 
    img2 = img1(:)';
    Z(:,j,2) = img2(p1);
end
[g(:,2),lE(:,2)]=gsolve(Z(:,:,2),B,l7);
X = lE(:,2) + B;
figure,plot(g(:,2),ZZ,'b');xlabel('log exposure'),ylabel('pixel value');
title('response curve for green channel when l=5');
hold on
plot(X,Z(:,:,2),'.');
hold off
% blue channel
for j = 1:5
    img1(:,:) = I(j,:,:,3); 
    img2 = img1(:)';
    Z(:,j,3) = img2(p1);
end
[g(:,3),lE(:,3)]=gsolve(Z(:,:,3),B,l7);
X = lE(:,3) + B;
figure,plot(g(:,3),ZZ,'b');xlabel('log exposure'),ylabel('pixel value');
title('response curve for blue channel when l=5');
hold on
plot(X,Z(:,:,3),'.');
hold off

% recover radiance image
E = zeros(amount,3);
for a = 0:255
    for j = 1:5
        for k =1:3
            img1(:,:) = I(j,:,:,k); 
            img2 = img1(:)';
            index = find(img2 == a);
            E(index, k) = E(index, k) +g(a+1,k)-B(j);
        end
    end
end
E = E./5;
Et = reshape(E, [m,n,3]);

figure,imagesc(Et(:,:,1));
axis ij
axis image
colormap('jet');
colorbar;title('Recovered radiance image of red channel');

figure,imagesc(Et(:,:,2));
axis ij
axis image
colormap('jet');
colorbar;title('Recovered radiance image of green channel');

figure,imagesc(Et(:,:,3));
axis ij
axis image
colormap('jet');
colorbar;title('Recovered radiance image of blue channel');


E_max = max(max(max(E)));
E_min = min(min(min(E)));

E_norm = (E-E_min)./(E_max-E_min);
E_norm = E_norm.^10;

E_norm_t = reshape(E_norm, [m,n,3]);
figure,imshow(E_norm_t);title('E_norm image (original)');

E_gamma = E_norm.^0.01;
E_gamma_t = reshape(E_gamma, [m,n,3]);
figure,subplot(3,3,1),imshow(E_gamma_t);title('gamma=0.01');

E_gamma = E_norm.^0.05;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,2),imshow(E_gamma_t);title('gamma=0.05');

E_gamma = E_norm.^0.08;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,3),imshow(E_gamma_t);title('gamma=0.08');

E_gamma = E_norm.^0.12;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,4),imshow(E_gamma_t);title('gamma=0.12');

E_gamma = E_norm.^0.15;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,5),imshow(E_gamma_t);title('gamma=0.15');

E_gamma = E_norm.^0.17;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,6),imshow(E_gamma_t);title('gamma=0.17');

E_gamma = E_norm.^0.2;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,7),imshow(E_gamma_t);title('gamma=0.2');

E_gamma = E_norm.^0.25;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,8),imshow(E_gamma_t);title('gamma=0.25');

E_gamma = E_norm.^0.3;
E_gamma_t = reshape(E_gamma, [m,n,3]);
subplot(3,3,9),imshow(E_gamma_t);title('gamma=0.3');



% E_gamma = E_norm.^0.12;
% E_gamma_t = reshape(E_gamma, [m,n,3]);
% figure,imshow(E_gamma_t);
% select = E_gamma_t(200:300,200:300,:,:);
% figure,imshow(select);
% select = E_gamma_t(380:480,1:100,:,:);
% figure,imshow(select);
% 
% E_gamma = E_norm.^0.17;
% E_gamma_t = reshape(E_gamma, [m,n,3]);
% figure,imshow(E_gamma_t);
% select = E_gamma_t(200:300,200:300,:,:);
% figure,imshow(select);
% select = E_gamma_t(380:480,1:100,:,:);
% figure,imshow(select);

L = rgb2gray(E_norm);
sum = 0;
for i = 1:amount
    sum = sum+log(L(i));
end
L_avg = exp(sum/amount);

a = [0.09 0.18, 0.36, 0.72];
for i =1:4
    T = (a(i)./L_avg).*L;
    T_max = max(max(T));
    L_tone = T.*(1+T./(T_max).^2)./(1+T);
    M = L_tone./L;
    E_new = M.*E_norm;
    E_new = reshape(E_new, [m,n,3]);
    figure,imshow(E_new);
    select = E_new(200:300,200:300,:,:);
    figure,imshow(select);
    select = E_gamma_t(380:480,1:100,:,:);
    figure,imshow(select);
end
