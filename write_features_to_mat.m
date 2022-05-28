clc
clear all
close all
tic

subjects = dir('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S*');
emotions = dir('C:\Program Files\MATLAB\R2017a\bin\major_project\S');
myname = cell(40 , 1 );

for i = 3 : 42
    myname(i , 1) = {emotions(i , 1).name};
end
output = cell(40, 1);
index = 1;

%------------Subjects---------------
for i = 1 : 32
    for j = 1 : 40 %----emotions-------
        hoc_fv = dir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\feature', subjects(i, 1).name, myname{j+2, 1}, 'nzc-*'));
        cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\feature\', subjects(i, 1).name, myname{j+2, 1}));

        for k = 1 : 40 %-------channels-------
            data = dlmread(hoc_fv(k, 1).name);
            feature_set{index, 1} = data;
            output{j, index} = 1;
            index = index + 1;
        end 
    end
end.

output = ~cellfun(@isempty,output);
input = cell2mat(feature_set)';
cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment'));
save feature_set;

toc