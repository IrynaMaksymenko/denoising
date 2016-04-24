train_images_directory = 'data/train_tiny';
result_images_directory = 'data/predicted_small';

input_images = dir(sprintf('%s/*.png', train_images_directory));
for img = input_images'
    imdata = double(imread(sprintf('%s/%s', train_images_directory, img.name)));
    [rows, columns] = size(imdata);

    % split image into blocks of 3x3
    
    block_size = 6;
    
    blocks = reshape(imdata, [block_size, rows/block_size, block_size, columns/block_size]);
    [s1, s2, s3, s4] = size(blocks);
    data_count = s2*s4;
    
    % collect features
    
    X = zeros(data_count, 7);
    index = 1;
    for row = 1 : s2
        for column = 1 : s4
                block = blocks(:, row, :, column);
                vec = reshape(block, [1, block_size*block_size]);
                %X(index, 1:9) = vec;
                X(index, 1) = min(vec);
                X(index, 2) = max(vec);
                X(index, 3) = range(vec);
                X(index, 4) = var(vec);
                X(index, 5) = std(vec);
                X(index, 6) = mode(vec);
                X(index, 7) = mean(vec);
                index = index + 1;
        end
    end
    
    % apply clustering
    
    [idx, C] = kmeans(X, 10);   
    means = C(:, 7);
    [max_mean, background] = max(means);
    [sorted_means, sorted_clusters] = sort(means);
    
    index = 1;
    for row = 1 : s2
        for column = 1 : s4
         
                block = blocks(:, row, :, column);
                cluster = idx(index);
                cluster_mean = means(cluster); 
                block_mean = mean(reshape(block, [1, block_size*block_size]));

                for i = 1 : block_size
                    for j = 1 : block_size
                        bright = block(i, j);
                        if (cluster == background)
                            % increase brightness
%                             coeff = 1;
%                             if (bright > cluster_mean)
%                                 coeff = 1.2;
%                             else
%                                 coeff = 2;
%                             end;
                            blocks(i, row, j, column) = 255; %bright*coeff;
                            %background_detected(row, column) = 1;
                        else 
                            if (bright - cluster_mean > 0)
                                % increase brightness
                                blocks(i, row, j, column) = bright*1.2;
                            else
%                                 if (bright - block_mean < -3)
%                                     % reduce brightness
%                                     blocks(i, row, j, column) = bright*0.7;
%                                 else 
%                                     % keep same value
%                                 end;
                            end;
                        end;
                    end;
                end;

    %             for i = 1 : 3
    %                 for j = 1 : 3
    %                     blocks(i, row, j, column) = cluster_mean;
    %                 end;
    %             end;

                index = index + 1;

        end
    end
    
    img_matrix = uint8(round(reshape(blocks, rows, columns)));
    %imshow(img_matrix);
    
%    img_matrix = uint8(round(vec2mat(result, columns)));
    imwrite(img_matrix, sprintf('%s/%s', result_images_directory, img.name));
end
