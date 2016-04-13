% function converts single image into vector of features
function [feature_vector, columns] = create_feature_vector(directoy_name, img_name)

% read image
imdata = imread(sprintf('%s/%s', directoy_name, img_name));
[rows, columns] = size(imdata);

feature_vector = zeros(1, rows*columns);
for row = 1 : rows
    for column = 1 : columns
        pixel = imdata(row, column);
        % each pixel is a feature
        % TODO: better feature selection (use sliding window etc)
        feature_vector((row-1)*columns + column) = pixel;  
    end
end

end
