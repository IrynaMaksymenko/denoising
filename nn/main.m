
[x, y] = load_train_data();

%net = feedforwardnet([3], 'trainrp'); % Resilient Backpropagation
%net = configure(net, x, y);

%net = train(net, x, y);

autoenc1 = trainAutoencoder(x, 100)





[second, columns] = create_feature_vector('D:\Ira\ML Project\denoising\data\train_small', '2.png');
second_cleared = net(second);
%imwrite(create_image_matrix(second_cleared, columns), 'D:\Ira\ML Project\denoising\data\predicted_small/2.png');
imshow(create_image_matrix(second_cleared, columns));

%http://iopscience.iop.org/article/10.1088/1742-6596/536/1/012020/pdf
%https://papers.nips.cc/paper/4686-image-denoising-and-inpainting-with-deep-neural-networks.pdf
%http://www.mathworks.com/help/nnet/examples/training-a-deep-neural-network-for-digit-classification.html


