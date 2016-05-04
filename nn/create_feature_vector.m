% function converts single image into vector of features
function [feature_vector, columns] = create_feature_vector(imdata)
    [rows, columns] = size(imdata);
   
    % collect features for each pixel
   
    feature_vector = zeros(rows*columns + 5, 1);
    
    % first, put pixels itself as features
    index = 1;
    for r = 1 : rows
        for c = 1 : columns
            pixel = imdata(r, c);
            feature_vector(index) = pixel;
            index = index + 1;
        end
    end
    % add other festures   
    vec = reshape(imdata, rows*columns, 1);
    feature_vector(index) = range(vec);
    index = index + 1;
    feature_vector(index) = var(vec);
    index = index + 1;
    feature_vector(index) = std(vec);
    index = index + 1;
    feature_vector(index) = mode(vec);
    index = index + 1;
    feature_vector(index) = mean(vec);

end
