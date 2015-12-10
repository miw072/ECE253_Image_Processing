%% p1
clear;clc;
% car = imread('D:\ucsd\ece253\hw5\car.png');
% [H,W]=size(car);  
% 
% % smoothing
% gaussian_kernel = 1/159 * [2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2];
% car_after_smoothing = conv2(double(car), gaussian_kernel, 'same');
% 
% % Finding Gradients
% filterx = [-1 0 1; -2 0 2; -1 0 1];
% filtery = [-1 -2 -1; 0 0 0; 1 2 1];
% Ix= conv2(car_after_smoothing,filterx,'same');
% Iy= conv2(car_after_smoothing,filtery,'same');
% G=sqrt(Ix.*Ix+Iy.*Iy);
% figure;
% imshow(G, [])
% title('The original gradient magnitude image');
% 
% % NMS
% tang = zeros(H, W);
% car_after_NMS = G;
% 
% for i = 1:H
%     for j = 1:W
%         if (Ix(i, j) == 0) 
%             tang(i, j) = 5;
%         else
%             tang(i, j) = Iy(i, j)/Ix(i, j);
%         end
%     end
% end
% 
% 
% for i = 2:H-1
%     for j = 2:W-1
%         if (-0.4142<tang(i ,j) && tang(i, j)<=0.4142)
%             if(G(i,j)<G(i,j+1) || G(i,j)<G(i,j-1))
%                 car_after_NMS(i, j) = 0;
%             end
%         end
%         if (0.4142<tang(i ,j) && tang(i, j)<=2.4142)
%             if(G(i,j)<G(i-1,j+1) || G(i,j)<G(i+1,j-1))
%                 car_after_NMS(i, j) = 0;
%             end
%         end
%         if (abs(tang(i ,j))>2.4142)
%             if(G(i,j)<G(i-1,j) || G(i,j)<G(i+1,j))
%                 car_after_NMS(i, j) = 0;
%             end
%         end
%         if (-2.4142<tang(i, j) && tang(i, j)<=-0.4142)
%             if(G(i,j)<G(i-1,j-1) || G(i,j)<G(i+1,j+1))
%                 car_after_NMS(i, j) = 0;
%             end
%         end
%     end
% end
% 
% figure;
% imshow(car_after_NMS, [])
% title('The image after NMS');
% 
% threshold = 180;
% car_after_threshold=max(car_after_NMS, threshold.*ones(size(car_after_NMS)));
% 
% figure;
% imshow(car_after_threshold, [])
% title('The image after threshold');

%% p2
% test_image = zeros(11, 11);
% test_image(1,1) = 1;
% test_image(1,11) = 1;
% test_image(11,1) = 1;
% test_image(11,11) = 1;
% test_image(6,6) = 1;
% 
% ori = imread('D:\ucsd\ece253\hw5\lane.png');
% lane = rgb2gray(imread('D:\ucsd\ece253\hw5\lane.png'));
% E = double(edge(lane, 'sobel'));
% 
% figure;
% imshow(ori);
% 
% img = E;
% [w, h] = size(img);
% rhoLimit = norm([w, h]);
% rho = (-rhoLimit:1:rhoLimit); 
% theta = (0:2*pi/360:pi);
% 
% thetasize = numel(theta);
% HT = zeros(numel(rho),thetasize);
% 
% [x,y] = find(img);
% numEdgePixels = numel(x);
% accumulator = zeros(numEdgePixels,thetasize);
% 
% cosine = (0:w-1)'*cos(theta);
% sine = (0:h-1)'*sin(theta); 
%  
% accumulator((1:numEdgePixels),:) = cosine(x,:) + sine(y,:);
% for i = (1:thetasize)
%      HT(:,i) = hist(accumulator(:,i),rho);
% end
% 
% threshold = 0.82*max(HT(:));
% img_after_threshold = HT > threshold;
% 
% [rho_line, theta_line] = find(img_after_threshold);
% [rows, cols] = size(img);
% 
% figure;
% imshow(img);
% figure;
% imshow(HT);colorbar;axis on;xlabel('theta');ylabel('rho');
% 
% figure;
% imshow(ori);
% hold on
% for i = 1:size(theta_line,1)
%     th = theta(theta_line(i));
%     rh = rho(rho_line(i));
%     m = -(cos(th)/sin(th));
%     b = rh/sin(th);
%     x = 1:cols;
%     plot(m*x+b, x,'linewidth',2);
%     hold on;
% end

%% p3
coins = imread('D:\ucsd\ece253\hw5\coins.png');
wheels = imread('D:\ucsd\ece253\hw5\wheels.png');
img = wheels;
filterx = [-1 0 1; -2 0 2; -1 0 1];
filtery = [-1 -2 -1; 0 0 0; 1 2 1];
Ix= conv2(img,filterx,'same');
Iy= conv2(img,filtery,'same');
g=sqrt(Ix.*Ix+Iy.*Iy);
% figure;imshow(g, []);title('The original gradient magnitude image');

gmax = max(g(:)); 
edgeThresh = graythresh(g/gmax); 
edgeThresh = gmax * edgeThresh; 
e = g > edgeThresh; % edge image
% figure;imshow(e, []);title('The edge image');
[rows, cols] = find(e);

for R = 10:20
    cht = zeros(size(img));
    for i = 1:size(rows, 1)
        r = rows(i);
        c = cols(i);
        xc = ceil(c - Ix(r, c)*R/g(r, c)); 
        yc = ceil(r - Iy(r, c)*R/g(r, c));
        if xc <= 0 || yc <= 0 || xc > size(img, 1) || yc > size(img, 2)
            continue
        end
        cht(xc, yc) = cht(xc, yc) + 1;
    end
    
    threshold = 0.5*max(cht(:));
    img_after_threshold = cht > threshold;
    
    [x_result, y_result] = find(img_after_threshold);  
    figure;imshow(img); hold on; plot(x_result, y_result,'rx','linewidth',2); hold off;
end

