clc
clear all
close all
tic

subjects = dir('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S*');
myname = {'F - Happy', 'P - Terrible', 'LL - Sad', 'H - Lovely', 'HH - Sentimental'};

output = cell(5, 1);
index = 1;

cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment');
data = load('minNumOfIMForder30.mat');
minIMF = data.minNumOfIMForder30;
%------------Subjects---------------
for i = 1 : 8
    for j = 1 : 5 %----emotions-------
        hoc_fv = dir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\modified feature with different emotion', subjects(i, 1).name, myname{j}, 'nzc-*'));
        cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\modified feature with different emotion', subjects(i, 1).name, myname{j}));

        for k = 1 : 32 %-------channels-------
            data = dlmread(hoc_fv(k, 1).name);
            feature_set_of_5_emotion_withDiffEmo_order_30_32_channels_8_subject{index, 1} = data(1 : minIMF*30);
            output{j, index} = 1;
            index = index + 1;
        end 
    end
end

output = ~cellfun(@isempty,output);
input = cell2mat(feature_set_of_5_emotion_withDiffEmo_order_30_32_channels_8_subject)';
cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment'));
save feature_set_of_5_emotion_withDiffEmo_order_30_32_channels_8_subject;

toc