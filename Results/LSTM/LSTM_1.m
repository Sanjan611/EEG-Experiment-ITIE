
%% 
close all;
clear;

%% SETUP
%run('getXYdata.m'); % Don't run this line! Or else it takes forever since
%it calculates the data once again
run('split_test_train.m');

% This script attempts to run LSTM algorithm for sequence classification
% based on the epochs got

load train_test_data.mat;

inputSize = 6;  % for the 6 channels
numHiddenUnits = 100;
numClasses = length(unique(Ytrain));     

%% THIS WILL BE RUN ONLY IF THERE ARE 2 CLASSES
% This block of code replicates the data containing label 5 in the training
% data if the number of classes is 2. This is to prevent overfitting to the
% other class label
if numClasses == 2
    for i=1:length(Ytrain)
        if Ytrain(i)==categorical(5)
            Ytrain(end+1) = categorical(5);
            Xtrain{end+1} = Xtrain{i};
        end
    end
end

%% DEFINE THE LAYERS AND THE TRAINING OPTIONS
layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    dropoutLayer(0.2)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    dropoutLayer(0.2)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 20;
miniBatchSize = 10;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','auto', ...
    'GradientThreshold',1, ...
    'InitialLearnRate', 0.01, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'ValidationData', {Xtest, Ytest}, ...
    'ValidationFrequency', 30, ...
    'Shuffle','once', ...
    'Verbose',0, ...
    'Plots','training-progress');

%% TRAIN THE DEEP NEURAL NETWORK
net = trainNetwork(Xtrain,Ytrain,layers,options);

%% GET THE FINAL ACCURACY AND THE CONFUSION MATRIX

Ypred = classify(net,Xtest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');

acc = sum(Ypred == Ytest)./numel(Ytest)

figure
plotconfusion(Ytest, Ypred)