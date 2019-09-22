% This script aims to generate spectrogram images for each epoch in the
% datasets

current = pwd();

eeglab; 

filepaths = ["C:\Users\Admin\Documents\MATLAB\EEG\Experiment\Results\Pre-processing\6_ICArun_someRejected\Around_3", ...
    "C:\Users\Admin\Documents\MATLAB\EEG\Experiment\Results\Pre-processing\6_ICArun_someRejected\Around_4", ...
    "C:\Users\Admin\Documents\MATLAB\EEG\Experiment\Results\Pre-processing\6_ICArun_someRejected\Around_5"];
class_label = [3 4 5];
WhereImages = 'C:\Users\Admin\Documents\MATLAB\EEG\Experiment\Results\CNN\SpectrogramImages';


X = {};
Y = [];
count = 0;

%%

for i=1:length(filepaths)
    filename = [];
    filepath = convertStringsToChars(filepaths(i));
    cd(filepath);
    filenames = dir('*.set');
    
    for j=1:length(filenames)
        filename = filenames(j).name;
        [EEG] = pop_loadset(filename, filepath);
        
        subject = filename(1:8);
        marker = class_label(i);
        
        % Now got the EEG data. So need to generate the spectrogram and
        % save it as an image file for CNN classification
        
        data = EEG.data;
        fs = EEG.srate;
        [numChan, numSamples, numEpochs] = size(EEG.data);
        
        for m=1:numEpochs
            for n=1:numChan
                % to start building the filename to save it as
                spectroName = "spectro_" + convertCharsToStrings(subject) + ...
                    "_" + convertCharsToStrings(int2str(marker)) + ...
                    "_" + convertCharsToStrings(int2str(m)) + ...
                    "_" + convertCharsToStrings(int2str(n)) + ...
                    ".jpg";  
                
                d = data(n,:,m);
                
                % Now to plot and store in the designated folder
                cd(WhereImages);
                figure;
                %spectrogram(d, [], [], [], fs, 'yaxis');
                pspectrum(d,fs,'spectrogram','FrequencyLimits',[0 45], 'MinThreshold', -30);
                colormap('jet');
                ylim([0 45]);
                colorbar('off');
                set(gca, 'Visible', 'off');
                saveas(gcf,convertStringsToChars(spectroName)); 
                close;
                
                count = count+1;
                disp(['SPECTROGRAM COUNT ' int2str(count)]);
            end
        end
        
    end
end

