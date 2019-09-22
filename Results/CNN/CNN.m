clear;

load train_test_data_1.mat

inputSize = size(imread('SpectrogramImages\spectro_ITIE_001_3_1_1.jpg'));

numClasses = 2;

%% If number of classes is 2
%{
% This part is still under work! TODO for later maybe.
if numClasses == 2
    for i=1:length(imdsTrain.Labels)
        if imdsTrain.Labels(i)==categorical(5)
            
            imdsTrain.Files{end+1} = imdsTrain.Files{i};
            imdsTrain.Labels(end+1) = imdsTrain.Labels(i);
            
        end
    end
end
%}

%% LAYERS AND TRAINING OPTIONS

layers = [
    imageInputLayer(inputSize)
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'ExecutionEnvironment','auto', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',1, ...
    'MiniBatchSize',15, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

%%
net = trainNetwork(imdsTrain,layers,options);

%%
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation)