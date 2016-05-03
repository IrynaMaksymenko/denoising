% test trained NN called 'net'

test_images_directory = 'D:\Ira\ML Project\denoising\data\train_tiny';
results_directory = 'D:\Ira\ML Project\denoising\data\predicted_small';

input_images = dir(sprintf('%s/*.png', test_images_directory));

block_s1 = 43;
block_s2 = 45;

for img = input_images'
    x = cell(72, 1);
    
    % read image
    imdata = double(imread(sprintf('%s/%s', test_images_directory, img.name)));
    [rows, columns] = size(imdata);
    
    % split image into blocks
    blocks = reshape(imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    [s1, s2, s3, s4] = size(blocks);
    
    index = 1;
    for row = 1 : s2
        for column = 1 : s4            
            block = blocks(:, row, :, column);

            feature_vector = create_feature_vector(block);
            x{index, 1} = feature_vector;
            index = index + 1;
        end;
    end;
  
    % use net to predict 
    predicted = sim(net, x);

    % convert net output back to image
    parts = reshape(predicted, [s2, s4]);
    for row = 1 : s2
        for column = 1 : s4
            parts{row, column} = reshape(cell2mat(parts(row, column)), [s1, s3]);
        end;
    end;
    blocks = cell2mat(parts);

    img_matrix = uint8(round(reshape(blocks, rows, columns)));

    % write result
    imwrite(img_matrix, sprintf('%s/%s', results_directory, img.name));
end


