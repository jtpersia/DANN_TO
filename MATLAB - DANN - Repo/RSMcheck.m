clear
clc

T = readtable("dataset.xlsx", "Sheet", "Dataset Complete");
X = [T.L1 T.T1 T.T2 T.L3 T.T3 T.T4 T.L5 T.T5];
output = T.SVMA1;

Y = output;
Yavg = mean(Y);
Ystd = std(Y);

% Y = normalize(Y, "zscore"); % normalize by zscore
Y = (Y-Yavg)/Ystd; % normalize by zscore manually

% RSM --------------------------------------------------------------------
for i=1:8
%     Xn(:,i) = round((X(:,i) -mean(X(:,i))) /(max(X(:,i))-mean(X(:,i))), 4); 
    Xn(:,i) = X(:,i); %<-- no additional normalization
end

%normalize AL
ALn = Y; 

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


Coeff=inv(A'*A)*A'*ALn; 
disp(size(Coeff))


%sum of the squares
SS = (A*Coeff-ALn)'*(A*Coeff-ALn);
fprintf('SSE) RSM: %6.4f \n', SS)