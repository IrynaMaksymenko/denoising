function img_matrix = create_image_matrix(pixel_vector, columns) 
% function converts vector of pixels into image matrix
img_matrix = vec2mat(pixel_vector, columns);
% % % img_matrix = zeros(rows, columns);
% % % for pixel_index = 1 : size(pixel_vector)
% % %     pixel = pixel_vector(pixel_index);
% % %     if (rem(pixel_index,columns) == 0)
% % %         row = pixel_index/columns;
% % %     else 
% % %         row = fix(pixel_index/columns) + 1;
% % %     end
% % %     column = pixel_index - (row - 1) * columns;
% % %     img_matrix(row, column) = pixel;
% % % end
end