% test trained NN called 'net'

test_images_directory = 'D:\Ira\ML Project\denoising\data\train_tiny';
target_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_tiny';
results_directory = 'D:\Ira\ML Project\denoising\data\predicted_small';

input_images = dir(sprintf('%s/*.png', test_images_directory));
%image_count = length(input_images(not([input_images.isdir])));

for img = input_images'
    % read image
    imdata = double(imread(sprintf('%s/%s', test_images_directory, img.name)));
    [mm nn]=size(imdata);
    t = im2col(imdata, window_size, 'sliding');
    predicted = sim(net, t);
    img_matrix = col2im(sum(predicted),window_size,[mm nn],'sliding');

    img_matrix = uint8(round(img_matrix));
    
    expected = imread(sprintf('%s/%s', target_images_directory, img.name));
    %mseError = mse(expected - img_matrix);

    % write result
    imwrite(img_matrix, sprintf('%s/%s', results_directory, img.name));    
    
end


