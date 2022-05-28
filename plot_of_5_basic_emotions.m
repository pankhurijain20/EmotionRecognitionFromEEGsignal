clc
clear all
close all
tic
cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S(1)\data\B - Joy');
eeg = dlmread("channel-01");
subplot(5, 1, 1);
plot(eeg()), title("Joy");
cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S(1)\data\PP - Shock');
eeg = dlmread("channel-01");
subplot(5, 1, 2);
plot(eeg()), title("Shock");
cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S(1)\data\LL - Sad');
eeg = dlmread("channel-01");
subplot(5, 1, 3);
plot(eeg()), title("Sad");
cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S(1)\data\H - Lovely');
eeg = dlmread("channel-01");
subplot(5, 1, 4);
plot(eeg()), title("Lovely");
cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S(1)\data\Q - Hate');
eeg = dlmread("channel-01");
subplot(5, 1, 5);
plot(eeg()), title("Hate");
toc