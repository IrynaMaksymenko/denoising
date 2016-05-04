% test trained NN called 'net'

test_images_directory = 'D:\Ira\ML Project\denoising\data\train_tiny';
target_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_tiny';
results_directory = 'D:\Ira\ML Project\denoising\data\predicted_small';

input_images = dir(sprintf('%s/*.png', test_images_directory));
image_count = length(input_images(not([input_images.isdir])));
rows = 258;
columns = 540;

blocks_in_one_image = (rows/block_s1)*(columns/block_s2);
data_size = blocks_in_one_image * image_count;

for img = input_images'
    % read image
    imdata = double(imread(sprintf('%s/%s', test_images_directory, img.name)));
    [rows, columns] = size(imdata);
    
    % split image into blocks
    blocks = reshape(imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    [s1, s2, s3, s4] = size(blocks);
    
    for row = 1 : s2
        for column = 1 : s4            
            block = blocks(:, row, :, column);

            feature_vector = create_feature_vector(block);            
            predicted = sim(net, feature_vector);
            
            blocks(:, row, :, column) = reshape(predicted, block_s1, block_s2); 
        end;
    end;
    
    img_matrix = uint8(round(reshape(blocks, rows, columns)));
    expected = imread(sprintf('%s/%s', target_images_directory, img.name));
    mseError = mse(expected - img_matrix)

    % write result
    imwrite(img_matrix, sprintf('%s/%s', results_directory, img.name));    
    
end


