
%-----------------------------------------------------------------------
% Loading data
[x, y, data_size] = load_train_data();

%------------------------------------------------------------------------
% Creation of NN

net = network;

% inputs are blocks(parts) of images
net.numInputs = 1;

% each block represents image window of size 43*45
% inputs size is the number of blocks
net.inputs{1}.size = data_size;

% there is one hidden layer and one output layer for each output
net.numLayers = 2;

% on hidden layer there are 50 neurons
net.layers{1}.size = 50;
net.layers{1}.transferFcn = 'logsig';
net.layers{1}.initFcn = 'initnw';

% output layers
for lay = 2:2
    net.layers{lay}.size = data_size;
    net.layers{lay}.transferFcn = 'purelin';
    net.layers{lay}.initFcn = 'initnw';
end;

% bias is on each layer
net.biasConnect = ones(2, 1);

% input is connected only to first layer
net.inputConnect(1,1) = 1;

% first layer is connected to all output layers
net.layerConnect(2,1) = 1;

% output layers are connected with output
net.outputConnect(2) = 1;

% training parameters
net.initFcn = 'initlay';
net.performFcn = 'mse';
net.trainFcn = 'trainrp';

%-------------------------------------------------------------------------
% Training

net = init(net);
net = train(net,x,y);



