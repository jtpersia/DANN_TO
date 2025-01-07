clear
clc

T = readtable("dataset.xlsx", "Sheet", "Dataset Complete");
X = [T.L1 T.T1 T.T2 T.L3 T.T3 T.T4 T.L5 T.T5];

archLayer = 2;
archNeuron = 9;
archHL = 'tansig';
archOL = 'tansig';
output = T.RMVMB1;

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

% ------------ save network coefficients here ------------- %
RMB1s2 = net.outputs{(archLayer+1)}.processSettings{1};

save('RMB1structOW.mat', 'RMB1s2')

IW = net.IW{1};
LW = net.LW{2, 1};
LW2 = net.LW{3, 2};

b = net.b;
b1 = b{1};
b2 = b{2};
b3 = b{3};

save('RMB1IW1.txt','IW','-ascii')
save('RMB1LW1.txt','LW','-ascii')
save('RMB1LW2.txt','LW2','-ascii')

save('RMB1b1.txt','b1','-ascii')
save('RMB1b2.txt','b2','-ascii')
save('RMB1b3.txt','b3','-ascii')

save('RMB1norm.txt', 'normFactor','-ascii')