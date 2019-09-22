% This script aims to get the data from the .set files and store it as X
% and Y (sequence and classification)

current = pwd();

eeglab; 

filepaths = ["C:\Users\Admin\Documents\MATLAB\EEG\Experiment\Results\Pre-processing\6_ICArun_someRejected\Around_3", ...
    "C:\Users\Admin\Documents\MATLAB\EEG\Experiment\Results\Pre-processing\6_ICArun_someRejected\Around_4", ...
    "C:\Users\Admin\Documents\MATLAB\EEG\Experiment\Results\Pre-processing\6_ICArun_someRejected\Around_5"];
class_label = [3 4 5];


X = {};
Y = [];

for i=1:length(filepaths)
    filename = [];
    filepath = convertStringsToChars(filepaths(i));
    cd(filepath);
    filenames = dir('*.set');
    
    for j=1:length(filenames)
        filename = filenames(j).name;
        [EEG] = pop_loadset(filename, filepath);
        for m=1:EEG.trials
            X{end+1} = EEG.data(:, :, m);
            Y(end+1) = class_label(i);
        end
        
    end
end

X = X';
Y = Y';

% This code block is for creating 2 labels rather than 3, one of the labels
% being 'item found', and the other 'item not found'
for i=1:length(Y)
    if Y(i)==3 || Y(i)==4
        Y(i)=1;
    end
end


Y = categorical(Y);

cd(current);

save('allData','X', 'Y');