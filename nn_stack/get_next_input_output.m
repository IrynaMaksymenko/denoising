function [x, y] = get_next_input_output(net, x_prev, y_prev)
wb = getwb(net);
[b,IW,LW] = separatewb(net,wb);
weights = IW{1};
bias = b{1};

x = logsig(weights*x_prev+repmat(bias, 1, size(x_prev, 2)));
y = logsig(weights*y_prev+repmat(bias, 1, size(y_prev, 2)));
end

