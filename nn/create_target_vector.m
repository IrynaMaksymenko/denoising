% function converts target image (cleared) into result vector
function [target_vector, columns] = create_target_vector(directoy_name, img_name) 

% read image
imdata = imread(sprintf('%s/%s', directoy_name, img_name));
[rows, columns] = size(imdata);

% each element of vector is a pixel itself
target_vector = double(reshape(imdata', [1, rows*columns]));
end