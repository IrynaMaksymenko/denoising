function [x, y, block_size] = load_train_data()
train_images_directory = 'D:\Ira\ML Project\denoising\data\train_258';
train_cleaned_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_258';

input_images = dir(sprintf('%s/*.png', train_images_directory));
image_count = length(input_images(not([input_images.isdir])));
rows = 258;
columns = 540;

block_s1 = 43;
block_s2 = 45;
block_size = block_s1*block_s2;

blocks_in_one_image = (rows/block_s1)*(columns/block_s2);

data_size = blocks_in_one_image * image_count;

x = zeros(block_size, data_size);
y = zeros(block_size, data_size);

image_index = 0;
for img = input_images'
    
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
        
    % split image into blocks
    blocks = reshape(imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    [~, s2, ~, s4] = size(blocks);
    
    index = image_index*blocks_in_one_image+1;
    for row = 1 : s2
        for column = 1 : s4            
            block = blocks(:, row, :, column);

            feature_vector = create_feature_vector(block);
            x(:, index) = feature_vector;
            index = index + 1;
        end;
    end;
    

    target_imdata = double(imread(sprintf('%s/%s', train_cleaned_images_directory, img.name)));
    
    target_blocks = reshape(target_imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    
    index = image_index*blocks_in_one_image+1;
    for row = 1 : s2
        for column = 1 : s4            
            target_block = target_blocks(:, row, :, column);
            
            target_vector = create_target_vector(target_block);
            y(:, index) = target_vector;
            index = index + 1;
        end;
    end;
    
    image_index = image_index + 1;
end
end