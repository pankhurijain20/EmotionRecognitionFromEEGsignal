clc
clear all
close all
tic
emotions = dir('C:\Program Files\MATLAB\R2017a\bin\major_project\S');
myname = cell(40 , 1 );

for i = 3 : 42
    myname(i , 1) = {emotions(i , 1).name};
end
toc
cd('C:\Program Files\MATLAB\R2017a\bin\major_project\variables and files');
save myname
tic
files = dir('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\DEAP_data_set\*.mat');
cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\DEAP_data_set');


for i = 1 : 32
    data1(i, 1) = load(files(i , 1).name);
end

tic
for l = 1 : 32              % Subject
    
    st = num2str(l);
    name = strcat('S' , '(' , st , ')');
    for k = 1 : 40                      % Video/ Trials
        str_trial = myname{k+2};      %To convert cell array to string
        mkdir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process' , name, 'data' , str_trial));
        cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process' , name, 'data' , str_trial));
        for i = 1 : 40                  % Channels
            for j = 1 : 8064            % Signal
                var(i , j) = data1(l , 1).data(k , i , j );
            end
            if i <= 9
                str_data = strcat('channel','-','0',num2str(i));
                dlmwrite(str_data , var( i , :));
            else
                str_data = strcat('channel','-',num2str(i));
                dlmwrite(str_data , var( i , :));
            end
        end
    end
end

toc
%--------------------------------------------------------------
