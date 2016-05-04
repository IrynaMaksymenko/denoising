% function converts single image into vector of features
function feature_vector = create_feature_vector(imdata, r, c)
    % collect features for each pixel
   
    feature_vector = zeros(6, 1);
    
    % first, put pixels itself as features
    index = 1;
            pixel = imdata(r, c);
            feature_vector(index) = pixel;
            index = index+1;
    % add other festures   
    vec = get_neighbours(imdata, r, c);
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
