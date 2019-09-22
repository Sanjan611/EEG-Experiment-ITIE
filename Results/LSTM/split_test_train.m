load allData.mat;

PD = 0.70 ;  % percentage 80%

% Let P be your N-by-M input dataset
% Solution-2 (using basic MATLAB function)
N = size(X,1);

idx = randperm(N);

Xtrain = X(idx(1:round(N*PD)),:);
Xtest = X(idx(round(N*PD)+1:end),:);

Ytrain = Y(idx(1:round(N*PD)),:);
Ytest = Y(idx(round(N*PD)+1:end),:);

save('train_test_data', 'Xtrain', 'Xtest', 'Ytrain', 'Ytest');