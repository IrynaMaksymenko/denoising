function [x, y, length] = load_train_data()
train_images_directory = 'D:\Ira\ML Project\denoising\data\train_tiny';
train_cleaned_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_tiny';

input_images = dir(sprintf('%s/*.png', train_images_directory));
%s = length(input_images(not([input_images.isdir])));
block_s1 = 43;
block_s2 = 45;
x = cell(72, 1);
y = cell(72, 1);
for img = input_images'
    
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
    [rows, columns] = size(imdata);
    
    % split image into blocks
    blocks = reshape(imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    [~, s2, ~, s4] = size(blocks);
    
    index = 1;
    for row = 1 : s2
        for column = 1 : s4            
            block = blocks(:, row, :, column);

            feature_vector = create_feature_vector(block);
            x{index, 1} = feature_vector;
            index = index + 1;
        end;
    end;
    

    target_imdata = double(imread(sprintf('%s/%s', train_cleaned_images_directory, img.name)));
    target_blocks = reshape(target_imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    
    index = 1;
    for row = 1 : s2
        for column = 1 : s4            
            target_block = target_blocks(:, row, :, column);
            
            target_vector = create_target_vector(target_block);
            y{index, 1} = target_vector;
            index = index + 1;
        end;
    end;
    
    length = rows/block_s1 * columns/block_s2;

end
end