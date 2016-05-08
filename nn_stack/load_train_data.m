% this script fills input data matrix 'x', target data matrix 'y',
% defines input_size and output_size
train_images_directory = 'D:\Ira\ML Project\denoising\data\train_small';
train_cleaned_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_small';

input_images = dir(sprintf('%s/*.png', train_images_directory));

%image_count = length(input_images(not([input_images.isdir])));

window_size = [3 3];

x = [];
y = [];

% iterate ovet target images to fill x and y
target_images = dir(sprintf('%s/*.png', train_cleaned_images_directory));

for img = input_images'
    
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
    target_imdata = double(imread(sprintf('%s/%s', train_cleaned_images_directory, img.name)));
    [rows, columns] = size(imdata);
   
    x = [x, im2col(imdata, window_size, 'sliding')];
    y = [y, im2col(target_imdata, window_size, 'sliding')];
        
end

input_size = 9; 
output_size = 9; 
dataset_size = size(x, 2);
