clear
clc

archLayer = 3; % Start with Architecture_Selector and place inputs here
archNeuron = 12;
archHL = 'logsig'; % 1 = Logsig | 2 = Tansig | 3 = Purelin
archOL = 'purelin';

T = readtable("dataset.xlsx", "Sheet", "Dataset Complete");
X = [T.L1 T.T1 T.T2 T.L3 T.T3 T.T4 T.L5 T.T5];

output = T.AL;
Y = output;
normFactor = [mean(Y) std(Y)];
Y = normalize(Y, "zscore");

structure = ones(1,archLayer).*archNeuron;
net = feedforwardnet(structure, 'trainlm');

% ---------- neural net modifications ----------- %
% specify hidden layer transfer function
for i = 1:length(structure)
    net.layers{i}.transferFcn = archHL; % purelin, tansig, or logsig
    % tansig superior for directional stresses
end
net.layers{(length(structure)+1)}.transferFcn = archOL;
% train/test/validation different datapoints each run unless RNG disabled
rng("default") % For reproducibility of the partition
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.1;
net.divideParam.testRatio = 0.1;
% -------------------- end -----------------------%

[net, tr, y, e] = train(net, X', Y');
perf = perform(net, X, Y);
t = Y'; CorrC = corrcoef(y, t);
R = CorrC(2, 1);
disp(R)

% --------------- Explicit Network Scheme -------------------- %

% IW = net.IW; % Cell containing the Input Weights
% biases = net.b; % Cell containing the biases
% LW = net.LW; % Cell containing the layer weights



% ------------ save network coefficients here ------------- %
ALs1 = net.inputs{1}.processSettings{1};
ALs2 = net.outputs{4}.processSettings{1};

IW = net.IW{1};
LW = net.LW{2, 1};
LW2 = net.LW{3, 2};
LW3 = net.LW{4, 3};
b = net.b;
b1 = b{1};
b2 = b{2};
b3 = b{3};
b4 = b{4};

save('ALstructIW.mat', 'ALs1')
save('ALstructOW.mat', 'ALs2')
save('ALIW1.txt','IW','-ascii')
save('ALLW1.txt','LW','-ascii')
save('ALLW2.txt','LW2','-ascii')
save('ALLW3.txt','LW3','-ascii')
save('ALb1.txt','b1','-ascii')
save('ALb2.txt','b2','-ascii')
save('ALb3.txt','b3','-ascii')
save('ALb4.txt','b4','-ascii')
save('ALnorm.txt', 'normFactor','-ascii')