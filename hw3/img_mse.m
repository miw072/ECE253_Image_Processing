function [ mse ] = img_mse( img1, img2 )
    mse = (sum(sum((double (img1) - double (img2)).^2)))/numel(img1) ;
end

