train_images_directory = 'data/train_tiny';
result_images_directory = 'data/predicted_small';

input_images = dir(sprintf('%s/*.png', train_images_directory));
for img = input_images'
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
    [rows, columns] = size(imdata);
   
    % collect features for each pixel
   
    X = zeros(rows*columns, 7);
    index = 1;
    for r = 1 : rows
        for c = 1 : columns
            pixel = imdata(r, c);
            neighbours = get_neighbours(imdata, r, c);
            vec = [pixel, neighbours];
            X(index, 1) = pixel;
            X(index, 3) = range(vec);
            X(index, 4) = var(vec);
            X(index, 5) = std(vec);
            X(index, 6) = mode(vec);
            X(index, 7) = mean(vec);
            index = index + 1;
        end
    end
    
    [idx, C] = kmeans(X, 8);
    means = C(:, 1);
    [max_mean, background] = max(means);
   
   
    index = 1;
    for row = 1 : rows
        for column = 1 : columns
            cluster = idx(index);
            cluster_mean = means(cluster); 
            bright = imdata(row, column);
            if (cluster == background)
                % increase brightness
%                             coeff = 1;
%                             if (bright > cluster_mean)
%                                 coeff = 1.2;
%                             else
%                                 coeff = 2;
%                             end;
                imdata(row, column) = 255; %bright*coeff;
            else 
                if (bright - cluster_mean > 0)
                    % increase brightness
                    imdata(row, column) = bright*1.2;
                else
%                                 if (bright - block_mean < -3)
%                                     % reduce brightness
%                                     imdata(row, column) = bright*0.7;
%                                 else 
%                                     % keep same value
%                                 end;
                end;
            end;



    % imdata(row, column) = cluster_mean;

            index = index + 1;
            
        end
    end
    
    img_matrix = uint8(round(imdata));
    %imshow(img_matrix);
    
%    img_matrix = uint8(round(vec2mat(result, columns)));
    imwrite(img_matrix, sprintf('%s/%s', result_images_directory, img.name));
end
