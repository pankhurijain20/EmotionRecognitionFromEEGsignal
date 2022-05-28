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

%-----------------Subjects------------
for i = 1 : 32
   for j = 1 : 40 % emotions
        mkdir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\IMF', subjects(i, 1).name, myname{j+2, 1}));
        channel = dir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process', subjects(i, 1).name, 'data', myname{j+2, 1}, 'channel-*'));
       for k = 1 : 40 % channels
            cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process', subjects(i, 1).name, 'data', myname{j+2, 1}));
            x = dlmread(channel(k, 1).name);
            imf = emd_calc(x);
            cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\IMF', subjects(i, 1).name, myname{j+2, 1}));
            if k <= 9
                fea_data = strcat('imf','-','0',num2str(k));
                dlmwrite(fea_data , imf);
            else
                fea_data = strcat('imf','-',num2str(k));
                dlmwrite(fea_data , imf);
            end
            
       end
   end
end
%emd_calc(x);
toc

function imf = emd_calc(x)
% Empiricial Mode Decomposition (Hilbert-Huang Transform)
% imf = emd(x)
% Func : findpeaks

  x = transpose(x(:));
  imf = [];
  while ~ismonotonic(x)
    x1 = x;
    sd = Inf;
    while (sd > 0.3) || ~isimf(x1)
      %if there is only maxima and one minima ie number of extrema is no more
      %than 2
      numofext = length(findpeaks(x1)) + length(findpeaks(-x1));
      if(numofext <= 2)
          break;
      end
      s1 = getspline(x1);
      s2 = -getspline(-x1);
      x2 = x1-(s1+s2)/2;
      %if upper and lower envelopes are same i.e mean is zero
      if (x1 == x2)
          break;
      end
      sd = sum((x1-x2).^2)/sum(x1.^2);
      x1 = x2;
    end
    
    %if there is only maxima and one minima ie number of extrema is no more
    %than 2
    numofext = length(findpeaks(x1)) + length(findpeaks(-x1));
    if(numofext <= 2)
        break;
    end
    imf{end+1} = x1;
    x = x-x1;
  end
  imf{end+1} = x;
end

% FUNCTIONS

function u = ismonotonic(x)

  u1 = length(findpeaks(x))*length(findpeaks(-x));
  if u1 > 0, u = 0;
  else,      u = 1; end
end

function u = isimf(x)

  N  = length(x);
  u1 = sum(x(1:N-1).*x(2:N) < 0);
  u2 = length(findpeaks(x))+length(findpeaks(-x));
  if abs(u1-u2) > 1, u = 0;
  else,              u = 1; end
end

function s = getspline(x)

  N = length(x);
  p = findpeaks(x);
  %make end points extremas
  p = [1 p N];
  s = spline([0 p N+1],[0 x(p) 0],1:N);
end

function n = findpeaks(x)
% Find peaks.
% n = findpeaks(x)

  n = find(diff(diff(x) > 0) < 0);
  u = find(x(n+1) > x(n));
  n(u) = n(u)+1;
end