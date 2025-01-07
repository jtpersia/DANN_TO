function finalOut = FullFunction(X)

% This function is used independently of optimization, meant to
% provide the combined DANN result out of all outputs at the same
% time. The input is a vector of hinge dimensions, and the output
% is all of the stress results using the DANN surrogate model.

% -------------- Variable Key ---------------
% Directional load outputs)
% A = Axial | N = Normal | P = Pitch
% R = Right side of beam | L = Left side of beam
% 
% von Mises stress outputs)
% First letters (S/R/N/M):
% S = Standard Loading | RN = Reverse Normal
% RM = Reverse Normal | RNM = Reverse both
% Second letters (A/B/C)1: Peak stress location A/B/C

% applies to both Directional/von Mises)
% IW1 = Input weight matrix
% LW_ = Hidden Layer weight matrix number: _ = (layer no.)
% b_ = bias vector number: _ = (layer no. + 1)

load('ARstructIW.mat') % this is same for all inputs

load('ALIW1.txt')
load('ALLW1.txt')
load('ALLW2.txt')
load('ALLW3.txt')
load('ALb1.txt')
load('ALb2.txt')
load('ALb3.txt')
load('ALb4.txt')
load('ALstructOW.mat')
load('ALnorm.txt')

load('ARIW1.txt')
load('ARLW1.txt')
load('ARLW2.txt')
load('ARb1.txt')
load('ARb2.txt')
load('ARb3.txt')
load('ARstructOW.mat')
load('ARnorm.txt')

load('NLIW1.txt')
load('NLLW1.txt')
load('NLLW2.txt')
load('NLb1.txt')
load('NLb2.txt')
load('NLb3.txt')
load('NLstructOW.mat')
load('NLnorm.txt')

load('NRIW1.txt')
load('NRLW1.txt')
load('NRLW2.txt')
load('NRb1.txt')
load('NRb2.txt')
load('NRb3.txt')
load('NRstructOW.mat')
load('NRnorm.txt')

load('PLIW1.txt')
load('PLLW1.txt')
load('PLLW2.txt')
load('PLb1.txt')
load('PLb2.txt')
load('PLb3.txt')
load('PLstructOW.mat')
load('PLnorm.txt')

load('PRIW1.txt')
load('PRLW1.txt')
load('PRLW2.txt')
load('PRb1.txt')
load('PRb2.txt')
load('PRb3.txt')
load('PRstructOW.mat')
load('PRnorm.txt')

load('SA1IW1.txt')
load('SA1LW1.txt')
load('SA1LW2.txt')
load('SA1LW3.txt')
load('SA1LW4.txt')
load('SA1LW5.txt')
load('SA1LW6.txt')
load('SA1LW7.txt')
load('SA1LW8.txt')
load('SA1LW9.txt')
load('SA1LW10.txt')
load('SA1b1.txt')
load('SA1b2.txt')
load('SA1b3.txt')
load('SA1b4.txt')
load('SA1b5.txt')
load('SA1b6.txt')
load('SA1b7.txt')
load('SA1b8.txt')
load('SA1b9.txt')
load('SA1b10.txt')
load('SA1b11.txt')
load('SA1structOW.mat')
load('SA1norm.txt')

load('SB1IW1.txt')
load('SB1LW1.txt')
load('SB1LW2.txt')
load('SB1b1.txt')
load('SB1b2.txt')
load('SB1b3.txt')
load('SB1structOW.mat')
load('SB1norm.txt')

load('SC1IW1.txt')
load('SC1LW1.txt')
load('SC1LW2.txt')
load('SC1LW3.txt')
load('SC1LW4.txt')
load('SC1LW5.txt')
load('SC1LW6.txt')
load('SC1b1.txt')
load('SC1b2.txt')
load('SC1b3.txt')
load('SC1b4.txt')
load('SC1b5.txt')
load('SC1b6.txt')
load('SC1b7.txt')
load('SC1structOW.mat')
load('SC1norm.txt')

load('RNA1IW1.txt')
load('RNA1LW1.txt')
load('RNA1LW2.txt')
load('RNA1LW3.txt')
load('RNA1b1.txt')
load('RNA1b2.txt')
load('RNA1b3.txt')
load('RNA1b4.txt')
load('RNA1structOW.mat')
load('RNA1norm.txt')

load('RNB1IW1.txt')
load('RNB1LW1.txt')
load('RNB1LW2.txt')
load('RNB1LW3.txt')
load('RNB1b1.txt')
load('RNB1b2.txt')
load('RNB1b3.txt')
load('RNB1b4.txt')
load('RNB1structOW.mat')
load('RNB1norm.txt')

load('RNC1IW1.txt')
load('RNC1LW1.txt')
load('RNC1LW2.txt')
load('RNC1LW3.txt')
load('RNC1LW4.txt')
load('RNC1LW5.txt')
load('RNC1LW6.txt')
load('RNC1b1.txt')
load('RNC1b2.txt')
load('RNC1b3.txt')
load('RNC1b4.txt')
load('RNC1b5.txt')
load('RNC1b6.txt')
load('RNC1b7.txt')
load('RNC1structOW.mat')
load('RNC1norm.txt')

load('RMA1IW1.txt')
load('RMA1LW1.txt')
load('RMA1LW2.txt')
load('RMA1LW3.txt')
load('RMA1LW4.txt')
load('RMA1LW5.txt')
load('RMA1LW6.txt')
load('RMA1LW7.txt')
load('RMA1LW8.txt')
load('RMA1b1.txt')
load('RMA1b2.txt')
load('RMA1b3.txt')
load('RMA1b4.txt')
load('RMA1b5.txt')
load('RMA1b6.txt')
load('RMA1b7.txt')
load('RMA1b8.txt')
load('RMA1b9.txt')
load('RMA1structOW.mat')
load('RMA1norm.txt')

load('RMB1IW1.txt')
load('RMB1LW1.txt')
load('RMB1LW2.txt')
load('RMB1b1.txt')
load('RMB1b2.txt')
load('RMB1b3.txt')
load('RMB1structOW.mat')
load('RMB1norm.txt')

load('RMC1IW1.txt')
load('RMC1LW1.txt')
load('RMC1LW2.txt')
load('RMC1LW3.txt')
load('RMC1LW4.txt')
load('RMC1LW5.txt')
load('RMC1LW6.txt')
load('RMC1LW7.txt')
load('RMC1LW8.txt')
load('RMC1b1.txt')
load('RMC1b2.txt')
load('RMC1b3.txt')
load('RMC1b4.txt')
load('RMC1b5.txt')
load('RMC1b6.txt')
load('RMC1b7.txt')
load('RMC1b8.txt')
load('RMC1b9.txt')
load('RMC1structOW.mat')
load('RMC1norm.txt')

load('RNMA1IW1.txt')
load('RNMA1LW1.txt')
load('RNMA1LW2.txt')
load('RNMA1LW3.txt')
load('RNMA1LW4.txt')
load('RNMA1LW5.txt')
load('RNMA1LW6.txt')
load('RNMA1b1.txt')
load('RNMA1b2.txt')
load('RNMA1b3.txt')
load('RNMA1b4.txt')
load('RNMA1b5.txt')
load('RNMA1b6.txt')
load('RNMA1b7.txt')
load('RNMA1structOW.mat')
load('RNMA1norm.txt')

load('RNMB1IW1.txt')
load('RNMB1LW1.txt')
load('RNMB1LW2.txt')
load('RNMB1LW3.txt')
load('RNMB1LW4.txt')
load('RNMB1b1.txt')
load('RNMB1b2.txt')
load('RNMB1b3.txt')
load('RNMB1b4.txt')
load('RNMB1b5.txt')
load('RNMB1structOW.mat')
load('RNMB1norm.txt')

load('RNMC1IW1.txt')
load('RNMC1LW1.txt')
load('RNMC1LW2.txt')
load('RNMC1LW3.txt')
load('RNMC1LW4.txt')
load('RNMC1LW5.txt')
load('RNMC1LW6.txt')
load('RNMC1b1.txt')
load('RNMC1b2.txt')
load('RNMC1b3.txt')
load('RNMC1b4.txt')
load('RNMC1b5.txt')
load('RNMC1b6.txt')
load('RNMC1b7.txt')
load('RNMC1structOW.mat')
load('RNMC1norm.txt')

% Directional Stresses

% --------- Axial Right ---------%

Xtestnorm = mapminmax('apply', X, ARs1);

y1 = ARIW1*Xtestnorm+ARb1; % normalize input first
y1 = logsig(y1); % apply hidden layer transfer functions
y2 = ARLW1*y1+ARb2; % calculate next layer using weight/bias from network
y2 = logsig(y2);
y2 = purelin(ARLW2*y2+ARb3); % apply output layer network function
y2 = mapminmax('reverse', y2, ARs2); % reverse the output pre-processing
ARout = y2*ARnorm(2)+ARnorm(1);

% --------- Axial Left ---------%

y1 = ALIW1*Xtestnorm+ALb1;
y1 = logsig(y1);
y2 = ALLW1*y1+ALb2;
y2 = logsig(y2);
y3 = ALLW2*y2+ALb3;
y3 = logsig(y3);
y3 = purelin(ALLW3*y3+ALb4);
y3 = mapminmax('reverse', y3, ALs2); % reverse the output pre-processing

ALout = y3*ALnorm(2)+ALnorm(1);

% % --------- Normal Left ---------%

ny1 = logsig(NLIW1*Xtestnorm+NLb1); % more streamlined version of code
ny2 = logsig(NLLW1*ny1+NLb2);
y2 = purelin(NLLW2*ny2+NLb3);
y2 = mapminmax('reverse', y2, NLs2); % reverse the output pre-processing
NLout = y2*NLnorm(2)+NLnorm(1); % un-normalize z-score normalization

% % --------- Normal Right ---------%

ny1 = tansig(NRIW1*Xtestnorm+NRb1);
ny2 = tansig(NRLW1*ny1+NRb2);
y2 = purelin(NRLW2*ny2+NRb3);
y2 = mapminmax('reverse', y2, NRs2); % reverse the output pre-processing
NRout = y2*NRnorm(2)+NRnorm(1);

% % --------- Pitch Left ---------%

ny1 = logsig(PLIW1*Xtestnorm+PLb1);
ny2 = logsig(PLLW1*ny1+PLb2);
y2 = purelin(PLLW2*ny2+PLb3);
y2 = mapminmax('reverse', y2, PLs2); % reverse the output pre-processing
PLout = y2*PLnorm(2)+PLnorm(1);

% % --------- Pitch Right ---------%

ny1 = tansig(PRIW1*Xtestnorm+PRb1);
ny2 = tansig(PRLW1*ny1+PRb2);
y2 = purelin(PRLW2*ny2+PRb3);
y2 = mapminmax('reverse', y2, PRs2); % reverse the output pre-processing
PRout = y2*PRnorm(2)+PRnorm(1);

% von Mises Stresses ---------------------------------------------------

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

finalOut1 = [ALout ARout NLout NRout PLout PRout];
finalOut2 = [SA1out SB1out SC1out RNA1out RNB1out RNC1out ...
    RMA1out RMB1out RMC1out RNMA1out RNMB1out RNMC1out];
finalOut = ([finalOut1 finalOut2]'.*(10^-6)); % convert to MPa
% vonMises = max([SA1out SC1out RNA1out RNC1out RNMA1out RNMC1out RMA1out RMC1out]);
% finalOut = vonMises;
disp(ALout)
end