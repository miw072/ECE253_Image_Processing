function img = equalization( filename )
    img=imread(filename);
    imgR=img(:,:,1);
    imgG=img(:,:,2);
    imgB=img(:,:,3);
    subplot(131);imhist(imgR);
    title('Hist of original R');
    subplot(132);imhist(imgG);
    title('Hist of original G');    
    subplot(133);imhist(imgB);
    title('Hist of original B');    
    hnewR=histeq(imgR);
    figure;
    subplot(131);imhist(hnewR);
    title('Hist of equalization R');
    hnewG=histeq(imgG);
    subplot(132);imhist(hnewG);
    title('Hist of equalization G');
    hnewB=histeq(imgB);
    subplot(133);imhist(hnewB);
    title('Hist of equalization B');
    figure;
    enhanced_img=cat(3,hnewR,hnewG,hnewB);
    imshow(enhanced_img);
    title('enhanced image')
end

