function img_matrix = create_image_matrix(pixel_vector, columns) 
% function converts vector of pixels into image matrix
img_matrix =  uint8(round(vec2mat(pixel_vector, columns)));
end