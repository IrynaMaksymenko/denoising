
%-----------------------------------------------------------------------
% Loading data
[x, y, length] = load_train_data();

%------------------------------------------------------------------------
% Creation of NN

net = network;

% inputs are blocks(parts) of images
net.numInputs = length;

% each block represents image window of size 43*45
for i = 1:length
    net.inputs{i}.size = 43*45;
end;

% there is one hidden layer and one output layer for each output
net.numLayers = length + 1;

% on hidden layer there are 50 neurons
net.layers{1}.size = 10;
net.layers{1}.transferFcn = 'logsig';
net.layers{1}.initFcn = 'initnw';

% output layers
for lay = 2:length+1
    net.layers{lay}.size = 43*45;
    net.layers{lay}.transferFcn = 'purelin';
    net.layers{lay}.initFcn = 'initnw';
end;

% bias is on each layer
net.biasConnect = ones(length+1, 1);

% input is connected only to first layer
for i = 1:length
    net.inputConnect(1,i) = 1;
end;

% first layer is connected to all output layers
for i = 2:length+1
    net.layerConnect(i,1) = 1;
end;

% output layers are connected with output
for i = 2:length+1
    net.outputConnect(i) = 1;
end;

% training parameters
net.initFcn = 'initlay';
net.performFcn = 'mse';
net.trainFcn = 'trainrp';

%-------------------------------------------------------------------------
% Training

net = init(net);
net = train(net,x,y);



