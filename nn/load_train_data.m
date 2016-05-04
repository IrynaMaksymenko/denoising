%function [x, y, input_size, output_size] = load_train_data()
train_images_directory = 'D:\Ira\ML Project\denoising\data\train_258';
train_cleaned_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_258';

input_images = dir(sprintf('%s/*.png', train_images_directory));
image_count = length(input_images(not([input_images.isdir])));
rows = 258;
columns = 540;

additional_fetures = 5;
input_size = 1 + additional_fetures; 
output_size = 1; 

blocks_in_one_image = (rows)*(columns);

dataset_size = blocks_in_one_image * image_count;

x = zeros(input_size, dataset_size);
y = zeros(output_size, dataset_size);

image_index = 0;
for img = input_images'
    
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
        
    % split image into blocks
    %blocks = reshape(imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    %[~, s2, ~, s4] = size(blocks);
    
    index = image_index*blocks_in_one_image+1;
    for row = 1 : rows
        for column = 1 : columns            
            %block = blocks(:, row, :, column);

            feature_vector = create_feature_vector(imdata, row, column);
            x(:, index) = feature_vector;
            index = index + 1;
        end;
    end;
    

    target_imdata = double(imread(sprintf('%s/%s', train_cleaned_images_directory, img.name)));
    
    %target_blocks = reshape(target_imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    
    index = image_index*blocks_in_one_image+1;
    for row = 1 : rows
        for column = 1 : columns            
            %target_block = target_blocks(:, row, :, column);
            
            target_vector = target_imdata(row, column);
            y(:, index) = target_vector;
            index = index + 1;
        end;
    end;
    
    image_index = image_index + 1;
end
%end