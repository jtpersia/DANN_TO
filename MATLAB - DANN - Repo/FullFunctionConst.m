function [c, ceq] = FullFunctionConst(X)

% use global variables

% A = Axial | N = Normal | P = Pitch
% R = Right side of beam | L = Left side of beam
% IW1 = Input weight matrix
% LW_ = Hidden Layer weight matrix number: _ = (layer no.)
% b_ = bias vector number: _ = (layer no. + 1)

global ARs1; % used across all inputs: normalization of thicknesses

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

% --------- Axial Right ---------%

% Network-bound input layer normalization
Xtestnorm = mapminmax('apply', X, ARs1);

y1 = ARIW1*Xtestnorm+ARb1; % normalize input first
y1 = logsig(y1); % apply hidden layer transfer functions
y2 = ARLW1*y1+ARb2; % calculate next layer using weight/bias from network
y2 = logsig(y2);
y2 = purelin(ARLW2*y2+ARb3); % apply output layer network function
y2 = mapminmax('reverse', y2, ARs2); % reverse the output pre-processing

ARout = y2*ARnorm(2)+ARnorm(1); % un-normalize z-score normalization

% --------- Axial Left ---------%

y1 = ALIW1*Xtestnorm+ALb1;
y1 = logsig(y1);
y2 = ALLW1*y1+ALb2;
y2 = logsig(y2);
y3 = ALLW2*y2+ALb3;
y3 = logsig(y3);
y3 = purelin(ALLW3*y3+ALb4);
y3 = mapminmax('reverse', y3, ALs2); % reverse the output pre-processing

ALout = y3*ALnorm(2)+ALnorm(1); % un-normalize z-score normalization

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
NRout = y2*NRnorm(2)+NRnorm(1); % un-normalize z-score normalization

% % --------- Pitch Left ---------%

ny1 = logsig(PLIW1*Xtestnorm+PLb1);
ny2 = logsig(PLLW1*ny1+PLb2);
y2 = purelin(PLLW2*ny2+PLb3);
y2 = mapminmax('reverse', y2, PLs2); % reverse the output pre-processing
PLout = y2*PLnorm(2)+PLnorm(1); % un-normalize z-score normalization

% % --------- Pitch Right ---------%

ny1 = tansig(PRIW1*Xtestnorm+PRb1);
ny2 = tansig(PRLW1*ny1+PRb2);
y2 = purelin(PRLW2*ny2+PRb3);
y2 = mapminmax('reverse', y2, PRs2); % reverse the output pre-processing
PRout = y2*PRnorm(2)+PRnorm(1); % un-normalize z-score normalization

% constraints defined: c(1-2) normal and pitch response
% c(3-4) axial and pitch response; calculations originally in Pa

% evaluate sum of left/right sensors, make less than 15 MPa
% c(1) = (abs(NLout) - abs(NRout))*0.5 - 7.5*(10^6);
% c(2) = (abs(PLout) - abs(PRout))*0.5 - 7.5*(10^6);
c(1) = ((NLout) - (NRout))*0.5 - 7.5*(10^6);
c(2) = ((PLout) - (PRout))*0.5 - 7.5*(10^6);

% axial sensors > 75 MPa
c(3) = -ALout - 75*(10^6);
c(4) = 75*(10^6)-ARout;

c(5) = (NLout) + 7.5*(10^6);
c(6) = (NRout) - 7.5*(10^6);

% unused
ceq = [];
end