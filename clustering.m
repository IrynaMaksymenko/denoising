train_images_directory = 'train_tiny';
result_images_directory = 'predicted_small';

input_images = dir(sprintf('%s/*.png', train_images_directory));
for img = input_images'
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
    [rows, columns] = size(imdata);
    feature_count = 1;
    data_count = rows*columns;
    X = zeros(data_count, feature_count);
    for row = 1 : rows
        for column = 1 : columns
            pixel = imdata(row, column);
            % each pixel is a feature
            % TODO: better feature selection (use sliding window etc)
            row_index = (row-1)*columns + column;
            X(row_index, 1) = pixel;
            feature_index = 2;
            for i = row-1:row+1
                for j = column-1:column+1
                    if (i > 0 && j > 0 && i <= rows && j <= columns && (i ~= row || j ~= column))
                        X(row_index, feature_index) = imdata(i, j);
                    end;
                    if (i ~= row || j ~= column)
                        feature_index = feature_index+1;
                    end;
                end;
            end;
            X(row_index, feature_index) = max(X(row_index, :));
        end
    end
    [idx, C] = kmeans(X, 3);
    means = C(:, 1);
    [max_mean, text] = max(means);
    [min_mean, background] = min(means);
   
    % find lowest value of background
    min_background_color = 100000000;
    for i = 1 : data_count
        cluster = idx(i);
        features = X(i, :);
        pixel = features(1);
        if (cluster ~= text) 
            if (pixel < min_background_color)
                min_background_color = pixel;
            end;
        end;
    end;

    result = [];
    for i = 1 : data_count
        cluster = idx(i);
%         if (cluster ~= text) 
%             % set to lowest value
%             pixel = min_background_color;
%         else
%             pixel = X(i, 1);
%         end
        pixel = means(cluster);
        result = [result, pixel];
    end
    img_matrix = uint8(round(vec2mat(result, columns)));
    imwrite(img_matrix, sprintf('%s/%s', result_images_directory, img.name));
end
