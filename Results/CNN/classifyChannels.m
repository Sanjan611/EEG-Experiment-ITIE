clear;
close all;

current = pwd();

cd('SpectrogramImages/');
%filenames = dir('*_4.jpg');
filenames = dir('*.jpg');

class_labels = cell(length(filenames),1);
all_labels = {'3', '4', '5'};

images = cell(length(filenames),1);
cd(current);
%%


for i=1:length(filenames)
   
    %images{i} = [images; convertCharsToStrings(filenames(i).name)];
    images{i} = filenames(i).name;
    filename = images{i};
    class_labels{i,1} = filename(18);
    
    % The below code is for 2 class classification
    if(class_labels{i,1}=='3' || class_labels{i,1}=='4')
        class_labels{i,1}='1';
    end
    
end

%imds = imageDatastore('SpectrogramImages/');

cd('SpectrogramImages/');
imds = imageDatastore(images);
cd(current);
% If 2 class ->
all_labels = {'1','5'};

imds.Labels = categorical(class_labels,all_labels);



%% Create a training and testing set

percentTrain = 0.7;
[imdsTrain,imdsValidation] = splitEachLabel(imds,percentTrain,'randomize');
%[Xtrain, Ytrain, Xtest, Ytest] = split_test_train(imds, class_labels, 0.7);
save('train_test_data_1', 'imdsTrain', 'imdsValidation');