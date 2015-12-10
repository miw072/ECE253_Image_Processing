clear;clc;
car = imread('D:\ucsd\ece253\hw4\Car.tif');
dft_car = fftshift(fft2(car,512, 512));
figure;imagesc(-256:255,-256:255,log(abs(dft_car))); colorbar;
xlabel('u'); ylabel('v');
[u,v] = meshgrid(-256:255);
uk = [-90.0, -82.0, -90.0, -82.0 ];
vk = [-80.0, 85.0, -170.0, 175.0];

Hnr = ones(512, 512);
n = 4;
D0 = 25;
for i = 1:4
    Duv = sqrt((u - uk(i)).^2 + (v - vk(i)).^2);
    ButterworthHighPassPart1 = 1 ./ (1 + ((D0 ./ Duv).^(2*n)));
    
    DuvConj = sqrt((u + uk(i)).^2 + (v + vk(i)).^2);
    ButterworthHighPassPart2 = 1 ./ (1 + ((D0 ./ DuvConj).^(2*n)));
    Hnr = Hnr .* ButterworthHighPassPart1 .* ButterworthHighPassPart2;
end
figure
imshow(Hnr,[]);colorbar();

filtered = dft_car .* Hnr;
out = ifft2(ifftshift(filtered));
figure;subplot(121);imshow(car);colorbar;subplot(122);imshow(out(1:246, 1:168), [0, 255]);colorbar;

car = imread('D:\ucsd\ece253\hw4\Street.png');
dft_car = fftshift(fft2(car,512, 512));
figure;imagesc(-256:255,-256:255,log(abs(dft_car))); colorbar;
xlabel('u'); ylabel('v');
[u,v] = meshgrid(-256:255);
uk = [0,165];
vk = [170,0];

Hnr = ones(512, 512);
n = 4;
D0 = 25;
for i = 1:2
    Duv = sqrt((u - uk(i)).^2 + (v - vk(i)).^2);
    ButterworthHighPassPart1 = 1 ./ (1 + ((D0 ./ Duv).^(2*n)));
    
    DuvConj = sqrt((u + uk(i)).^2 + (v + vk(i)).^2);
    ButterworthHighPassPart2 = 1 ./ (1 + ((D0 ./ DuvConj).^(2*n)));
    Hnr = Hnr .* ButterworthHighPassPart1 .* ButterworthHighPassPart2;
end
figure
imshow(Hnr,[]);colorbar;

filtered = dft_car .* Hnr;
out = ifft2(ifftshift(filtered));
figure;subplot(121);imshow(car);colorbar;subplot(122);imshow(out(1:332, 1:359), [0, 255]);colorbar;


