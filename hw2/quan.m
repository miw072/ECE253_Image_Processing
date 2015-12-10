function  final_image = quan(ori_image, s)
    ori_image = double(ori_image);
    [row, col] = size(ori_image);
    final_image = ori_image;
    level = 2^s;
    step = 256/level;
    period = zeros(level, 2);
    key = zeros(level, 1);
    for i = 1:level
        period(i, 1) = (i-1)*step;
        period(i, 2) = (i-1)*step+step-1;
        key(i) = floor(period(i, 1) + (period(i, 2)-period(i ,1))/2);
    end
    
    for i = 1:row
        for j = 1:col
            target_period = floor(ori_image(i, j)/step)+1;
            final_image(i, j) = key(target_period);
        end
    end
    
    final_image = uint8(final_image);
    
end

