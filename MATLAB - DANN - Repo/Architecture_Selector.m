clear
clc

% This code is used to determine network parameters for a specified output
% variable (von Mises/Directional load stress)

% output variable is defined as follows:
% Directional load outputs)
% A = Axial | N = Normal | P = Pitch
% R = Right side of beam | L = Left side of beam
% 
% von Mises stress outputs)
% First letters (S/R/N/M):
% S = Standard Loading | RN = Reverse Normal
% RM = Reverse Normal | RNM = Reverse both
% (A/B/C)1: Peak stress location A/B/C

T = readtable("dataset.xlsx", "Sheet", "Dataset Complete");
X = [T.L1 T.T1 T.T2 T.L3 T.T3 T.T4 T.L5 T.T5];
output = T.RNMVMA1;
Y = output;

Y = normalize(Y, "zscore");
Rvalues = [];
row = 1;

% this code uses a case-by-case evaluation of all possible networks within
% a specified range of layer/neuron count, saving the best R value and its
% corresponding architecture
for m = 1:3
    if m == 1 % m is input layer transfer function
        hfun = 'logsig';
    elseif m == 2
        hfun = 'tansig';
    else
        hfun = 'purelin';
    end
    for n = 1:3 % n is hidden layer transfer function
        if n == 1
            efun = 'logsig';
        elseif n == 2
            efun = 'tansig';
        else
            efun = 'purelin';
        end
        for j = 2:1:10 % j is number of layers, from 2-10
            for k = 5:1:25 % k is number of neurons, from 5-25
                structure = zeros(1,j)+k;
                % ---------- neural net architecture ------------ %
                net = feedforwardnet(structure, 'trainlm');
                for i = 1:length(structure)
                    net.layers{i}.transferFcn = hfun; % purelin, tansig, or logsig
                end
                net.layers{(length(structure)+1)}.transferFcn = efun;
                % train/test/validation different datapoints each run unless RNG disabled
                rng("default") % For reproducibility of the partition
                net.divideParam.trainRatio = 0.8;
                net.divideParam.valRatio = 0.1;
                net.divideParam.testRatio = 0.1;
                % ------------- end, start training --------------%
                % this prevents network window from showing to increase computational speed
                net.trainParam.showWindow = 0;
                [net, tr, y, e] = train(net, X', Y');
                % ---------------- end training ------------------%
                t = Y'; CorrC = corrcoef(y, t);
                R = CorrC(2, 1);
                Rvalues(row) = R;
                Indexj(row) = j;
                Indexk(row) = k;
                Indexm(row) = m;
                Indexn(row) = n;
                row = row + 1;
            end
        end
    end
end
disp('SVMA1')
[max, index] = max(Rvalues);
disp(max)
disp(Indexj(index))
disp(Indexk(index))
disp(Indexm(index))
disp(Indexn(index))