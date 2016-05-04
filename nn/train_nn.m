
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
% normalize inputs
net.inputs{1}.processFcns = {'mapminmax'};

% there is one hidden layer and one output layer for each output
net.numLayers = 2;

% on hidden layer there are 50 neurons
net.layers{1}.size = 100;
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

% normalize outputs
net.outputs{1}.processFcns = {'mapminmax'};

% training parameters
net.initFcn = 'initlay';
net.performParam.regularization = 0.1;
net.performFcn = 'mse';
net.trainFcn = 'traingdx';
net.trainParam.lr = 0.3;
net.trainParam.goal = 0.01;

net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
 'plotregression'};

%-------------------------------------------------------------------------
% Training

net = init(net);

net = train(net, xn, yn);



