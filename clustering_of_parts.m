train_images_directory = 'data/train_tiny';
result_images_directory = 'data/predicted_small';

input_images = dir(sprintf('%s/*.png', train_images_directory));
for img = input_images'
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
    [rows, columns] = size(imdata);

    % split image into blocks of 43x45
    block_s1 = 43;
    block_s2 = 45;
    
    blocks = reshape(imdata, [block_s1, rows/block_s1, block_s2, columns/block_s2]);
    [s1, s2, s3, s4] = size(blocks);
    
    % for each block apply clustering
    
    for row = 1 : s2
        for column = 1 : s4
            
            block = blocks(:, row, :, column);
            %block_mean = mean(reshape(block, 1, 43*45));
            
            % collect features
            % TODO: extract into function to reuse in other clustering
            X = zeros(block_s1*block_s2, 7);
            index = 1;
            for r = 1 : block_s1
                for c = 1 : block_s2
                    pixel = block(r, c);
                    neighbours = get_neighbours(block, r, c);
                    vec = [pixel, neighbours];
                    X(index, 1) = pixel;
                    X(index, 3) = range(vec);
                    X(index, 4) = var(vec);
                    X(index, 5) = std(vec);
                    X(index, 6) = mode(vec);
                    X(index, 7) = mean(vec);
                    
                    %X(index, 6) = pixel - mode(vec);
                    %X(index, 7) = pixel - mean(vec);

                    index = index + 1;
                end
            end
            
            % apply clustering
            [idx, C] = kmeans(X, 3);
            
            means = C(:, 1);
            [max_mean, background] = max(means);
            
            index = 1;
            for r = 1 : block_s1
                for c = 1 : block_s2
                    
                    cluster = idx(index);
                    cluster_mean = means(cluster); 
                    bright = block(r, c);
                    
                    if (cluster == background)
                        % increase brightness
%                             coeff = 1;
%                             if (bright > cluster_mean)
%                                 coeff = 1.2;
%                             else
%                                 coeff = 2;
%                             end;
                        blocks(r, row, c, column) = 255; %bright*coeff;
                    else 
                        if (bright - cluster_mean > 0)
                            % increase brightness
                            blocks(r, row, c, column) = bright*1.1;
                        end;
                    end;
                    
                   % blocks(r, row, c, column) = cluster_mean;
                    
                    index = index + 1;
               end;
            end;

        end;
    end;

    img_matrix = uint8(round(reshape(blocks, rows, columns)));
    %imshow(img_matrix);
    
    imwrite(img_matrix, sprintf('%s/%s', result_images_directory, img.name));
end
