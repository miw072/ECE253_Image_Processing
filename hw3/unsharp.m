function im_out = unsharp( im_in, maskA, weight )
[a,b] = size(maskA);
maskB = zeros( size(maskA) );
maskB(ceil(a/2), ceil(b/2)) = 1;
maskC = maskB - maskA;
maskD = maskB + weight * maskC;
im_out = conv2(double(im_in), double(maskD), 'same');
% figure;
% subplot(121);
% imshow(uint8(conv2(im_in, maskA, 'same')));
% subplot(122);
% imshow(conv2(im_in, maskC, 'same'));
end

