function output_img = ipc( noisy )
mask = [ 1 8 64; 2 16 128; 4 32 256];
im_tmp = filter2(mask,noisy);
tmp = (im_tmp ~= 16);
output_img = noisy .* tmp;
tmp = (im_tmp == 495);
output_img = output_img + tmp;
end

