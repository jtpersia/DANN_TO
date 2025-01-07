clear
clc

% define global variables ------------------------

% ---------- directional values global -----------
% A = Axial | N = Normal | P = Pitch
% R = Right side of beam | L = Left side of beam
% IW1 = Input weight matrix
% LW_ = Hidden Layer weight matrix number: _ = (layer no.)
% b_ = bias vector number: _ = (layer no. + 1)

global ARs1; % used across all inputs: normalization of thicknesses

% all other global variable groups are unique to each output
global ARIW1; global ARb1; global ARLW1; global ARb2;
global ARLW2; global ARb3; global ARs2; global ARnorm;

global ALIW1; global ALb1; global ALLW1; global ALb2;
global ALLW2; global ALb3; global ALb4; global ALLW3;
global ALs2; global ALnorm;

global NLIW1; global NLb1; global NLLW1; global NLb2;
global NLLW2; global NLb3; global NLs2; global NLnorm;

global NRIW1; global NRb1; global NRLW1; global NRb2;
global NRLW2; global NRb3; global NRs2; global NRnorm;

global PLIW1; global PLb1; global PLLW1; global PLb2;
global PLLW2; global PLb3; global PLs2; global PLnorm;

global PRIW1; global PRb1; global PRLW1; global PRb2;
global PRLW2; global PRb3; global PRs2; global PRnorm;

% ---------- von Mises values global -----------
% First letters (S/R/N/M):
% S = Standard Loading | RN = Reverse Normal
% RM = Reverse Normal | RNM = Reverse both
% Second letters (A/B/C)1: Peak stress location A/B/C
% IW1 = Input weight matrix
% LW_ = Hidden Layer weight matrix number: _ = (layer no.)
% b_ = bias vector number: _ = (layer no. + 1)

global SA1IW1; global SA1b1; global SA1LW1; 
global SA1b2; global SA1LW2; global SA1b3; global SA1LW3;
global SA1b4; global SA1b5; global SA1LW4; global SA1b6;
global SA1LW5; global SA1b7; global SA1b8; global SA1LW6;
global SA1b9; global SA1LW7; global SA1b10; global SA1b11;
global SA1LW8; global SA1LW9;global SA1LW10; global SA1s2;
global SA1norm;

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

% ---------- Load text and mat files -------------------

% this section of the code takes the matrices and vectors found
% in the .txt and .mat files generated during network construction

% _structIW.mat files correspond to _s1 variables (network normalization)
% _structOW.mat files correspond to _s2 variables (network normalization)
% _norm.txt files contain z-score variables for reverse normalization

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

% --------------- begin optimization ----------------

% vector X contains hinge dimensions in (mm)
% order is as follows: L1	T1	T2	L3	T3	T4	L5	T5
% where L is hinge length and T is hinge thickness

X0 = [2.847 1.593 1.224 0.604 1.072 1.390 2.165 0.413]'; % starting point
% Xmax = [4.270 2.390 1.836 0.906 1.608 2.085 3.248 0.619]'; % upper bound
% Xmin = [1.423 0.797 0.612 0.302 0.536 0.695 1.083 0.206]'; % lower bound
Xmax = [4.6264 2.5886 1.9890 0.9815 1.7420 2.2588 3.5181 0.6711]'; % upper bound
Xmin = [1.0676 0.5974 0.4590 0.2265 0.4020 0.5213 0.8119 0.1549]'; % lower bound

% optimization using fmincon
% x is optimized inputs, fval is optimized outputs
options = optimoptions('fmincon','MaxFunctionEvaluations',3000);
tic
[x,fval,exitflag,fminconOutput] = fmincon(@(X) FullFunctionObj(X), X0,[],[],[],[],Xmin,Xmax,@(X) FullFunctionConst(X), options);
toc
fprintf('L1 %d\nT1 %d\nT2 %d\nL3 %d\nT3 %d\nT4 %d\nL5 %d\nT5 %d\n',...
    x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8))

Xout = [x(1) x(2) x(3) x(4) x(5) x(6) x(7) x(8)]';

output = FullFunction(X0); % display all outputs using standalone code
disp('Stresses in MPa')
fprintf('AxialL: %f \nAxialR: %f \n', output(1), output(2))
fprintf('NormalL: %f \nNormalR: %f \n', output(3), output(4))
fprintf('PitchL: %f \nPitchR: %f \n', output(5), output(6))

fprintf('SA1: %f \nSB1: %f \nSC1: %f \n', output(7), output(8), output(9))
fprintf('RNA1: %f \nRNB1: %f \nRNC1: %f \n', output(10), output(11), output(12))
fprintf('RMA1: %f \nRMB1: %f \nRMC1: %f \n', output(13), output(14), output(15))
fprintf('RNMA1: %f \nRNMB1: %f \nRNMC1: %f \n', output(16), output(17), output(18))