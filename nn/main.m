
[x, y] = load_train_data();

% net = network;
% net.numInputs = 1;
% net.numLayers = 2;
% 
% % hidden layer of size 10 and sigmoid activation function
% net.layers{1}.size = 10;
% net.layers{1}.transferFcn = 'logsig';
% net.layers{1}.initFcn = 'initnw';
% 
% % output layer of size 1 and sigmoid activation function
% net.layers{2}.size = 1;
% net.layers{2}.transferFcn = 'logsig';
% net.layers{2}.initFcn = 'initnw';
% 
% net.biasConnect = [1; 1];
% net.inputConnect = [1; 0];
% net.layerConnect = [0 0; 1 0];
% net.outputConnect = [0 1];
% 
% net.initFcn = 'initlay';
% net.performFcn = 'mse';
% net.trainFcn = 'trainrp';
% view(net);
% 
% net = init(net);
% net = train(net,X,y);
% predicted = sim(net,X)

net = feedforwardnet(1, 'trainrp'); % Resilient Backpropagation
net1 = configure(net, x, y);

net2 = train(net1, x, y);
%predicted_train = net(x);
%error_train = perform(net, predicted_train, y);

[second, columns] = create_feature_vector('train_small', '2.png');
second_cleared = net2(second);
imwrite(create_image_matrix(second_cleared, columns), 'predicted_small/2.png');



