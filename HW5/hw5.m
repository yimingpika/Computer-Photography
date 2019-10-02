img = imread('/Users/yimingdai/Desktop/pic5/14.jpg');
[x,y,~]=size(img);
I = zeros(x,y,25);

for k = 1:25  
    imgPath = strcat('/Users/yimingdai/Desktop/pic5/',num2str(k),'.jpg');
    img = imread(imgPath);
    II(:,:,:,k) = img(:,:,:);
    pic = rgb2gray(img);
    I(:,:,k) = pic(:,:);
end

v = [1120, 1405, 1762, 2210, 2773, 3478, 4363, 5473, 6866, 8612, 10803, 13552, 17000, 21325, 26750, 33555, 42092, 56614, 70768, 88460, 110575, 138219, 172773, 215966, 269957]; 
u = zeros(1,25);
m = zeros(1,25);
f = 2.95;
for k = 1:25
    u(k) = f*v(k)/(v(k) - f);
end
for k = 1:25
    m(k) = u(25)/u(k);
end

for k = 1:25
    I1(:,:,k) = I(:,:,k)*m(k);
end

for k = 1:25
    for i = 1:3
        II(:,:,i,k) = II(:,:,i,k)*m(k);
    end
end
[x1,y1,~]=size(I1);

% Compute a depth map from the focal stack 
L = 1/6*[1 4 1; 4 -20 4; 1 4 1];
M = zeros(x1,y1,25);
I_filter = imfilter(I1, L,'conv');
for k = 1:25
    for i = 1:x1
        for j = 1:y1  
            for a = i-5:i+5    % K
                for b = j-5:j+5
                    if a < 1 || b < 1 || a >1944 || b > 2592
                        continue
                    else
                        M(i,j,k) = M(i,j,k) + I_filter(a,b,k).^2;
                    end
                end
            end
        end
    end    
end

% finding the index into the focal stack D(x,y)
% where the focus is maximum
D = zeros(x1,y1);
D1 = zeros(x1,y1);
for i =1:x1
    for j =1:y1
        value = 0;
        k1 = 1;
        for k =1:25
            if M(i,j,k) > value
                value = M(i,j,k);
                k1 = k;
            end
        end
        D(i,j) = k1;
    end
end
figure,imshow(D,[]);

% Recover an all-focus image of the scene
A = zeros(x1,y1,3);
for i = 1:x1
    for j = 1:y1
     A(i,j,:) = II(i,j,:,D(i,j));   
    end
end
figure,imshow(A/255.0);
