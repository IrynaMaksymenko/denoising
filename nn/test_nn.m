% test trained NN called 'net'

test_images_directory = 'D:\Ira\ML Project\denoising\data\train_tiny';
target_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_tiny';
results_directory = 'D:\Ira\ML Project\denoising\data\predicted_small';

input_images = dir(sprintf('%s/*.png', test_images_directory));
image_count = length(input_images(not([input_images.isdir])));
rows = 258;
columns = 540;

blocks_in_one_image = (rows)*(columns);
data_size = blocks_in_one_image * image_count;

for img = input_images'
    % read image
    imdata = double(imread(sprintf('%s/%s', test_images_directory, img.name)));
    [rows, columns] = size(imdata);
    img_matrix = zeros(rows, columns);
       
    for row = 1 : rows
        for column = 1 : columns            
            %block = blocks(:, row, :, column);

            feature_vector = create_feature_vector(imdata, row, column);            
            predicted = sim(net, feature_vector);
            
            img_matrix(row, column) = predicted; 
        end;
    end;
    
    img_matrix = uint8(round(img_matrix));
    expected = imread(sprintf('%s/%s', target_images_directory, img.name));
    mseError = mse(expected - img_matrix)

    % write result
    imwrite(img_matrix, sprintf('%s/%s', results_directory, img.name));    
    
end


