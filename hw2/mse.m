function [mse_uni, mse_lloyds] = mse( lena )
    mse_uni = zeros(1,7);
    mse_lloyds = zeros(1,7);
    for s = 1:7
        lena_uniquan = quan(lena, s);
        training_set = double(lena(:));
        [partition, codebook] = lloyds(training_set, 2^s);
        lena_lloyds = lloyds_quan(partition ,codebook, lena);
        D = imabsdiff(lena_uniquan,lena).^2;
        mse_uni(s) = sum(D(:))/numel(lena);
        D = imabsdiff(lena_lloyds,lena).^2;
        mse_lloyds(s) = sum(D(:))/numel(lena);
    end
end

