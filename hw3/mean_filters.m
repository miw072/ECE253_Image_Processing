function [ x, y ] = mean_filters( original, noisy )
   x = [0 9 25 49];
   y = zeros(1, 4);
   y(1) = img_mse(original, noisy);
   
   kernel = 1/9*ones(3,3);
   im_1 = uint8(conv2(double(noisy), kernel, 'same'));
   y(2) = img_mse(original, im_1); 

   kernel = 1/25*ones(5,5);
   im_2 = uint8(conv2(double(noisy), kernel, 'same'));
   y(3) = img_mse(original, im_2);
   
   kernel = 1/49*ones(7,7);
   im_3 = uint8(conv2(double(noisy), kernel, 'same'));
   y(3) = img_mse(original, im_3);
   
   figure;
   subplot(311);
   imshow(im_1);
   title('image after 3*3 mean filter');
   subplot(312);
   imshow(im_2);
   title('image after 5*5 mean filter');
   subplot(313);
   imshow(im_3);
   title('image after 7*7 mean filter');
   
end

