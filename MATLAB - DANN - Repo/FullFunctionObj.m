function finalOut = FullFunctionObj(X)

% use global variables

% First letters (S/R/N/M):
% S = Standard Loading | RN = Reverse Normal
% RM = Reverse Normal | RNM = Reverse both
% Second letters (A/B/C)1: Peak stress location A/B/C
% IW1 = Input weight matrix
% LW_ = Hidden Layer weight matrix number: _ = (layer no.)
% b_ = bias vector number: _ = (layer no. + 1)

global ARs1; % used across all inputs: normalization of thicknesses

global SA1IW1; global SA1b1; global SA1LW1; global SA1b2;
global SA1LW2; global SA1b3; global SA1LW3; global SA1b4;
global SA1b5; global SA1LW4; global SA1b6; global SA1LW5;
global SA1b7; global SA1b8; global SA1LW6; global SA1b9;
global SA1LW7; global SA1b10; global SA1b11; global SA1LW8;
global SA1LW9;global SA1LW10; global SA1s2; global SA1norm;

global SB1IW1; global SB1b1; global SB1LW1; global SB1b2;
global SB1LW2; global SB1b3; global SB1s2; global SB1norm;

global SC1IW1; global SC1b1; global SC1LW1; global SC1b2;
global SC1LW2; global SC1b3; global SC1LW3; global SC1b4;
global SC1LW4; global SC1b5; global SC1LW5; global SC1b6;
global SC1LW6; global SC1b7; global SC1s2; global SC1norm;

global RNA1IW1; global RNA1b1; global RNA1LW1; global RNA1b2;
global RNA1LW2; global RNA1b3; global RNA1LW3; global RNA1b4;
global RNA1s2; global RNA1norm;

global RNB1IW1; global RNB1b1; global RNB1LW1; global RNB1b2;
global RNB1LW2; global RNB1b3; global RNB1LW3; global RNB1b4;
global RNB1s2; global RNB1norm;

global RNC1IW1; global RNC1LW1; global RNC1b1; global RNC1b2;
global RNC1LW2; global RNC1b3; global RNC1LW3; global RNC1b4;
global RNC1LW4; global RNC1b5; global RNC1LW5; global RNC1b6;
global RNC1LW6; global RNC1b7; global RNC1s2; global RNC1norm;

global RMA1IW1; global RMA1b1; global RMA1LW1; global RMA1b2;
global RMA1LW2; global RMA1b3; global RMA1LW3; global RMA1b4;
global RMA1LW4; global RMA1b5; global RMA1LW5; global RMA1b6;
global RMA1LW6; global RMA1b7; global RMA1LW7; global RMA1b8;
global RMA1LW8; global RMA1b9; global RMA1s2; global RMA1norm;

global RMB1IW1; global RMB1b1; global RMB1LW1; global RMB1b2;
global RMB1LW2; global RMB1b3; global RMB1s2; global RMB1norm;

global RMC1IW1; global RMC1b1; global RMC1LW1; global RMC1b2;
global RMC1LW2; global RMC1b3; global RMC1LW3; global RMC1b4;
global RMC1LW4; global RMC1b5; global RMC1LW5; global RMC1b6;
global RMC1LW6; global RMC1b7; global RMC1LW7; global RMC1b8;
global RMC1LW8; global RMC1b9; global RMC1s2; global RMC1norm;

global RNMA1IW1; global RNMA1b1; global RNMA1LW1; global RNMA1b2;
global RNMA1LW2; global RNMA1b3; global RNMA1LW3; global RNMA1b4;
global RNMA1LW4; global RNMA1b5; global RNMA1LW5; global RNMA1b6;
global RNMA1LW6; global RNMA1b7; global RNMA1s2; global RNMA1norm;

global RNMB1IW1; global RNMB1b1; global RNMB1LW1; global RNMB1b2;
global RNMB1LW2; global RNMB1b3; global RNMB1LW3; global RNMB1b4;
global RNMB1LW4; global RNMB1b5; global RNMB1s2; global RNMB1norm;

global RNMC1IW1; global RNMC1b1; global RNMC1LW1; global RNMC1b2;
global RNMC1LW2; global RNMC1b3; global RNMC1LW3; global RNMC1b4;
global RNMC1LW4; global RNMC1b5; global RNMC1LW5; global RNMC1b6;
global RNMC1LW6; global RNMC1b7; global RNMC1s2; global RNMC1norm;

% Network-bound input layer normalization
Xtestnorm = mapminmax('apply', X, ARs1); % same for all inputs
disp(Xtestnorm)
% --------- SA1 ---------%

ny1 = logsig(SA1IW1*Xtestnorm+SA1b1);
ny2 = logsig(SA1LW1*ny1+SA1b2);
ny3 = logsig(SA1LW2*ny2+SA1b3);
ny4 = logsig(SA1LW3*ny3+SA1b4);
ny5 = logsig(SA1LW4*ny4+SA1b5);
ny6 = logsig(SA1LW5*ny5+SA1b6);
ny7 = logsig(SA1LW6*ny6+SA1b7);
ny8 = logsig(SA1LW7*ny7+SA1b8);
ny9 = logsig(SA1LW8*ny8+SA1b9);
ny10 = logsig(SA1LW9*ny9+SA1b10);
y10 = tansig(SA1LW10*ny10+SA1b11);
y10 = mapminmax('reverse', y10, SA1s2); % reverse the output pre-processing
SA1out = y10*SA1norm(2)+SA1norm(1);

% --------- SB1 ---------%

ny1 = logsig(SB1IW1*Xtestnorm+SB1b1);
ny2 = logsig(SB1LW1*ny1+SB1b2);
y2 = tansig(SB1LW2*ny2+SB1b3);
y2 = mapminmax('reverse', y2, SB1s2); % reverse the output pre-processing
SB1out = y2*SB1norm(2)+SB1norm(1);

% --------- SC1 ---------%

ny1 = tansig(SC1IW1*Xtestnorm+SC1b1);
ny2 = tansig(SC1LW1*ny1+SC1b2);
ny3 = tansig(SC1LW2*ny2+SC1b3);
ny4 = tansig(SC1LW3*ny3+SC1b4);
ny5 = tansig(SC1LW4*ny4+SC1b5);
ny6 = tansig(SC1LW5*ny5+SC1b6);
y6 = purelin(SC1LW6*ny6+SC1b7);
y6 = mapminmax('reverse', y6, SC1s2); % reverse the output pre-processing
SC1out = y6*SC1norm(2)+SC1norm(1);

% --------- RNA1 ---------%

ny1 = tansig(RNA1IW1*Xtestnorm+RNA1b1);
ny2 = tansig(RNA1LW1*ny1+RNA1b2);
ny3 = tansig(RNA1LW2*ny2+RNA1b3);
y3 = tansig(RNA1LW3*ny3+RNA1b4);
y3 = mapminmax('reverse', y3, RNA1s2); % reverse the output pre-processing
RNA1out = y3*RNA1norm(2)+RNA1norm(1);

% --------- RNB1 ---------%

ny1 = logsig(RNB1IW1*Xtestnorm+RNB1b1);
ny2 = logsig(RNB1LW1*ny1+RNB1b2);
ny3 = logsig(RNB1LW2*ny2+RNB1b3);
y3 = purelin(RNB1LW3*ny3+RNB1b4);
y3 = mapminmax('reverse', y3, RNB1s2); % reverse the output pre-processing
RNB1out = y3*RNB1norm(2)+RNB1norm(1);

% --------- RNC1 ---------%

ny1 = logsig(RNC1IW1*Xtestnorm+RNC1b1);
ny2 = logsig(RNC1LW1*ny1+RNC1b2);
ny3 = logsig(RNC1LW2*ny2+RNC1b3);
ny4 = logsig(RNC1LW3*ny3+RNC1b4);
ny5 = logsig(RNC1LW4*ny4+RNC1b5);
ny6 = logsig(RNC1LW5*ny5+RNC1b6);
y6 = purelin(RNC1LW6*ny6+RNC1b7);
y6 = mapminmax('reverse', y6, RNC1s2); % reverse the output pre-processing
RNC1out = y6*RNC1norm(2)+RNC1norm(1);

% --------- RNMA1 ---------%

ny1 = logsig(RNMA1IW1*Xtestnorm+RNMA1b1);
ny2 = logsig(RNMA1LW1*ny1+RNMA1b2);


ny3 = logsig(RNMA1LW2*ny2+RNMA1b3);
ny4 = logsig(RNMA1LW3*ny3+RNMA1b4);
ny5 = logsig(RNMA1LW4*ny4+RNMA1b5);
ny6 = logsig(RNMA1LW5*ny5+RNMA1b6);
y6 = purelin(RNMA1LW6*ny6+RNMA1b7);
y6 = mapminmax('reverse', y6, RNMA1s2); % reverse the output pre-processing
RNMA1out = y6*RNMA1norm(2)+RNMA1norm(1);

% --------- RNMB1 ---------%

ny1 = tansig(RNMB1IW1*Xtestnorm+RNMB1b1);
ny2 = tansig(RNMB1LW1*ny1+RNMB1b2);
ny3 = tansig(RNMB1LW2*ny2+RNMB1b3);
ny4 = tansig(RNMB1LW3*ny3+RNMB1b4);
y4 = tansig(RNMB1LW4*ny4+RNMB1b5);
y4 = mapminmax('reverse', y4, RNMB1s2); % reverse the output pre-processing
RNMB1out = y4*RNMB1norm(2)+RNMB1norm(1);

% --------- RNMC1 ---------%

ny1 = tansig(RNMC1IW1*Xtestnorm+RNMC1b1);
ny2 = tansig(RNMC1LW1*ny1+RNMC1b2);
ny3 = tansig(RNMC1LW2*ny2+RNMC1b3);
ny4 = tansig(RNMC1LW3*ny3+RNMC1b4);
ny5 = tansig(RNMC1LW4*ny4+RNMC1b5);
ny6 = tansig(RNMC1LW5*ny5+RNMC1b6);
y6 = purelin(RNMC1LW6*ny6+RNMC1b7);
y6 = mapminmax('reverse', y6, RNMC1s2); % reverse the output pre-processing
RNMC1out = y6*RNMC1norm(2)+RNMC1norm(1);

% --------- RMA1 ---------%

ny1 = tansig(RMA1IW1*Xtestnorm+RMA1b1);
ny2 = tansig(RMA1LW1*ny1+RMA1b2);
ny3 = tansig(RMA1LW2*ny2+RMA1b3);
ny4 = tansig(RMA1LW3*ny3+RMA1b4);
ny5 = tansig(RMA1LW4*ny4+RMA1b5);
ny6 = tansig(RMA1LW5*ny5+RMA1b6);
ny7 = tansig(RMA1LW6*ny6+RMA1b7);
ny8 = tansig(RMA1LW7*ny7+RMA1b8);
y8 = tansig(RMA1LW8*ny8+RMA1b9);
y8 = mapminmax('reverse', y8, RMA1s2); % reverse the output pre-processing
RMA1out = y8*RMA1norm(2)+RMA1norm(1);


% --------- RMB1 ---------%

ny1 = tansig(RMB1IW1*Xtestnorm+RMB1b1);
ny2 = tansig(RMB1LW1*ny1+RMB1b2);
y2 = tansig(RMB1LW2*ny2+RMB1b3);
y2 = mapminmax('reverse', y2, RMB1s2); % reverse the output pre-processing
RMB1out = y2*RMB1norm(2)+RMB1norm(1);

% --------- RMC1 ---------%

ny1 = tansig(RMC1IW1*Xtestnorm+RMC1b1);
ny2 = tansig(RMC1LW1*ny1+RMC1b2);
ny3 = tansig(RMC1LW2*ny2+RMC1b3);
ny4 = tansig(RMC1LW3*ny3+RMC1b4);
ny5 = tansig(RMC1LW4*ny4+RMC1b5);
ny6 = tansig(RMC1LW5*ny5+RMC1b6);
ny7 = tansig(RMC1LW6*ny6+RMC1b7);
ny8 = tansig(RMC1LW7*ny7+RMC1b8);
y8 = purelin(RMC1LW8*ny8+RMC1b9);
y8 = mapminmax('reverse', y8, RMC1s2); % reverse the output pre-processing
RMC1out = y8*RMC1norm(2)+RMC1norm(1);

% objective function: maximum of all stress outputs
output = [SA1out SB1out SC1out RNA1out RNB1out RNC1out ...
    RMA1out RMB1out RMC1out RNMA1out RNMB1out RNMC1out];
vonMises = max(output);
finalOut = vonMises;
end