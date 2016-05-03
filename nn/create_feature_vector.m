% function converts single image into vector of features
function [feature_vector, columns] = create_feature_vector(imdata)
    [rows, columns] = size(imdata);
   
    % collect features for each pixel
   
    feature_vector = zeros(rows*columns, 1);
    index = 1;
    for r = 1 : rows
        for c = 1 : columns
            pixel = imdata(r, c);
            %neighbours = get_neighbours(imdata, r, c);
            %vec = [pixel, neighbours];
            feature_vector(index, 1) = pixel;
            %feature_vector(index, 3) = range(vec);
            %feature_vector(index, 4) = var(vec);
            %feature_vector(index, 5) = std(vec);
            %feature_vector(index, 6) = mode(vec);
            %feature_vector(index, 7) = mean(vec);
            index = index + 1;
        end
    end

end
