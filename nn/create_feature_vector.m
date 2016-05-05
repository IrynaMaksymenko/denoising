% function converts single image into vector of features
function feature_vector = create_feature_vector(imdata, r, c)
    % collect features for each pixel
   
    feature_vector = zeros(6, 1);
    
    % first, put pixels itself as features
    pixel = imdata(r, c);
    feature_vector(1) = pixel;

    % add other festures   
    vec = get_neighbours(imdata, r, c);
    feature_vector(2) = range(vec);
    feature_vector(3) = var(vec);
    feature_vector(4) = std(vec);
    feature_vector(5) = mode(vec);
    feature_vector(6) = mean(vec);
end
