function final_image = lloyds_quan( partition, codebook, ori_image )
    [row, ~] = size(ori_image);
    final_image = ori_image;
    for i  = 1: row
        [~, quants] = quantiz(ori_image(i, :), partition, codebook);
        final_image(i, :) = quants;  
    end  
end

