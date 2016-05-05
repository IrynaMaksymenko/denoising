% this script fills input data matrix 'x', target data matrix 'y',
% defines input_size and output_size
%function [x, y, input_size, output_size] = load_train_data()
train_images_directory = 'D:\Ira\ML Project\denoising\data\train_258';
train_cleaned_images_directory = 'D:\Ira\ML Project\denoising\data\train_cleaned_258';

input_images = dir(sprintf('%s/*.png', train_images_directory));

image_count = length(input_images(not([input_images.isdir])));
imdata_vector = cell(image_count, 1);

% precalculate dataset size for speed up
samples_size = 0;
i = 1;
for img = input_images'
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
    [rows, columns] = size(imdata);
    samples_size = samples_size + rows*columns;
    imdata_vector{i} = imdata; 
    i = i + 1;
end

input_size = 6; 
output_size = 1; 

x = zeros(input_size, samples_size);
y = zeros(output_size, samples_size);

% iterate ovet target images to fill x and y
target_images = dir(sprintf('%s/*.png', train_cleaned_images_directory));

index = 1; % sample index
i = 1; % image index
for img = target_images'

    imdata = cell2mat(imdata_vector(i));
    target_imdata = double(imread(sprintf('%s/%s', train_cleaned_images_directory, img.name)));
    [rows, columns] = size(imdata);
   
    for row = 1 : rows
        for column = 1 : columns            
            features = create_feature_vector(imdata, row, column);
            x(:, index) = features;
            
            target_value = target_imdata(row, column);
            y(:, index) = target_value;
            
            index = index + 1;
        end;
    end;
    
    i = i + 1;
    
end
