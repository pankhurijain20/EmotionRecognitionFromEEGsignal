clc
clear all
close all
tic
plot_of_imf('B - Joy');
plot_of_imf('PP - Shock');
plot_of_imf('LL - Sad');
plot_of_imf('H - Lovely');
plot_of_imf('Q - Hate');
toc

function N = plot_of_imf(emotion)
    cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S(1)\data', emotion));
    eeg = dlmread("channel-01");
    figure();
    plot(eeg()), title(strcat(emotion, " EEG plot"));
    figure();
    cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\IMF\S(1)', emotion));
    imf = dlmread("imf-01");
    N = length(imf);
    numberOfIMF = N/8064; %each signal of length 8064
    for i = 1 : numberOfIMF
        if i <= 9
            name = strcat('imf','-','0',num2str(i));
        else
            name = strcat('imf','-',num2str(i));
        end 
        lower = (i-1)*8064 + 1;
        upper = lower+8064-1;
        subplot(numberOfIMF, 1, i);
        plot(imf(lower : upper));   
    end
end