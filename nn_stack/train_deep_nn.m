% Creation of NN

net = network;

% inputs are blocks(parts) of images
net.numInputs = 1;
net.inputs{1}.size = input_size;

% normalize inputs
net.inputs{1}.processFcns = {'mapminmax'};

% there is one hidden layer and one output layer for each output
net.numLayers = 6;

% on hidden layer there are 10 neurons
net.layers{1}.size = ae1.layers{1}.size;
net.layers{2}.size = ae2.layers{1}.size;
net.layers{3}.size = ae3.layers{1}.size;
net.layers{4}.size = ae3.layers{2}.size;
net.layers{5}.size = ae2.layers{2}.size;

net.layers{1}.transferFcn = ae1.layers{1}.transferFcn;
net.layers{2}.transferFcn = ae2.layers{1}.transferFcn;
net.layers{3}.transferFcn = ae3.layers{1}.transferFcn;
net.layers{4}.transferFcn = ae3.layers{2}.transferFcn;
net.layers{5}.transferFcn = ae2.layers{2}.transferFcn;

% net.layers{1}.initFcn = 'initnw';
% net.layers{2}.initFcn = 'initnw';
% net.layers{3}.initFcn = 'initnw';
% net.layers{4}.initFcn = 'initnw';
% net.layers{5}.initFcn = 'initnw';
% net.layers{6}.initFcn = 'initnw';

% output layers
net.layers{6}.size = output_size;
net.layers{6}.transferFcn = 'purelin';

% bias is on each layer
net.biasConnect = ones(6, 1);

% input is connected only to first layer
net.inputConnect(1,1) = 1;
net.layerConnect(2,1) = 1;
net.layerConnect(3,2) = 1;
net.layerConnect(4,3) = 1;
net.layerConnect(5,4) = 1;
net.layerConnect(6,5) = 1;


% output layers are connected with output
net.outputConnect(6) = 1;

% normalize outputs
net.outputs{1}.processFcns = {'mapminmax'};

% training parameters
net.initFcn = 'initlay';
%net.performParam.regularization = 0.1;
net.performFcn = 'mse';
net.trainFcn = 'traingdx';
net.trainParam.lr = 0.3;
net.trainParam.goal = 0.01;
net.trainParam.epochs = 1000;

net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
 'plotregression'};

net.inputs{1}.size = input_size;

%-------------------------------------------------------------------------
% Training

%net = init(net);

% init weiht and biases with trained ones
net.iw{1,1} = ae1.iw{1,1};
 net.lw{2,1} = ae2.iw{1,1};
 net.lw{3,2} = ae3.iw{1,1};
 net.lw{4,3} = ae3.lw{2,1};
 net.lw{5,4} = ae2.lw{2,1};
 net.lw{6,5} = ae1.lw{2,1};
 net.b{1} = ae1.b{1,1};
 net.b{2} = ae2.b{1,1};
 net.b{3} = ae3.b{1,1};
 net.b{4} = ae3.b{2,1};
net.b{5} = ae2.b{2,1};
 net.b{6} = ae1.b{2,1};
% 
net = train(net, x, y);

