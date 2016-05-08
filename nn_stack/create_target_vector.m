% function converts target image (cleared) into result vector
function [target_vector, columns] = create_target_vector(imdata) 
[rows, columns] = size(imdata);

% each element of vector is a pixel itself
%target_vector = double(reshape(imdata', [rows*columns, 1]));
target_vector = imdata(:);
end