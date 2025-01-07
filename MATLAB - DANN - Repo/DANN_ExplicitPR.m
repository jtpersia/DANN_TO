clear
clc

T = readtable("dataset.xlsx", "Sheet", "Dataset Complete");
X = [T.L1 T.T1 T.T2 T.L3 T.T3 T.T4 T.L5 T.T5];

archLayer = 2;
archNeuron = 14;
archHL = 'tansig';
archOL = 'purelin';
output = T.PR;

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

PRs2 = net.outputs{(archLayer+1)}.processSettings{1};

% save('PRstructOW.mat', 'PRs2')

IW = net.IW{1};
LW = net.LW{2, 1};
LW2 = net.LW{3, 2};

b = net.b;
b1 = b{1};
b2 = b{2};
b3 = b{3};

save('PRstructOW.mat', 'PRs2')

save('PRIW1.txt','IW','-ascii')
save('PRLW1.txt','LW','-ascii')
save('PRLW2.txt','LW2','-ascii')

save('PRb1.txt','b1','-ascii')
save('PRb2.txt','b2','-ascii')
save('PRb3.txt','b3','-ascii')

save('PRnorm.txt', 'normFactor','-ascii')
% 
% Xtest = [2.847 1.593 1.224 0.604 1.072 1.390 2.165 0.413]';
% modelTest = net(Xtest)/normFactor; % neural net output value
% disp('Neural net output')
% disp(modelTest)

% RSM --------------------------------------------------------------------
for i=1:8
%     Xn(:,i) = round((X(:,i) -mean(X(:,i))) /(max(X(:,i))-mean(X(:,i))), 4); 
    Xn(:,i) = X(:,i); %<-- no normalization
end

%normalize PR
PRn = Y; 

x1 = Xn(:,1);
x2 = Xn(:,2);
x3 = Xn(:,3);
x4 = Xn(:,4);
x5 = Xn(:,5);
x6 = Xn(:,6);
x7 = Xn(:,7);
x8 = Xn(:,8);

% Second order polynomial RSM model:
% b(0) + b(1)*x(1) + ... b(8)*x(8) + ...
% b(1-1)*x(1)*x(1) + ... + b(8-8)*x(8)*x(8) + ...
% b(1-2)*x(1)*x(2) + ... + b(7-8)*x(7)*x(8)

A=[ones(size(x1)),x1,x2,x3,x4,x5,x6,x7,x8, ...
    x1.*x1,x2.*x2,x3.*x3,x4.*x4,x5.*x5,x6.*x6,x7.*x7,x8.*x8,...
    x1.*x2,x1.*x3,x1.*x4,x1.*x5,x1.*x6,x1.*x7,x1.*x8, ...
    x2.*x3,x2.*x4,x2.*x5,x2.*x6,x2.*x7,x2.*x8, ...
    x3.*x4,x3.*x5,x3.*x6,x3.*x7,x3.*x8, ...
    x4.*x5,x4.*x6,x4.*x7,x4.*x8, ...
    x5.*x6,x5.*x7,x5.*x8, ...
    x6.*x7,x6.*x8, ...
    x7.*x8];


Coeff=inv(A'*A)*A'*PRn; 

%sum of the squares
SS = (A*Coeff-PRn)'*(A*Coeff-PRn);
% Compare RSM with DANN
perf = sse(net,t,y);

fprintf('SSE) DANN: %6.4f, RSM: %6.4f \n', perf, SS)