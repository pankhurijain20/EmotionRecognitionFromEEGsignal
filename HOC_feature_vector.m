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
for i = 31 : 32
   for j = 1 : 40  % emotions
        mkdir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\feature', subjects(i, 1).name, myname{j+2, 1}));
        imf = dir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\IMF', subjects(i, 1).name, myname{j+2, 1}, 'imf-*'));
       for k = 1 : 40  % IMF
            cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\IMF', subjects(i, 1).name, myname{j+2, 1}));
            x = dlmread(imf(k, 1).name);
            D = zero_crossing(x);
            cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\feature', subjects(i, 1).name, myname{j+2, 1}));
            if k <= 9
                fea_data = strcat('nzc','-','0',num2str(k));
                dlmwrite(fea_data , D);
            else
                fea_data = strcat('nzc','-',num2str(k));
                dlmwrite(fea_data , D);
            end
           
       end
   end
end
toc

function D = zero_crossing(imf)
%------------------------HIGHER ORDER CROSSINGS------------------------
%----------------------------------------------------------------------
  N = length(imf);
  z = imf';
  for ord = 1 : 30
    d = 0;
    for t = ord : N
  %      Z = 0;
        if ord == 1
           Z{ord, t} = z(t);
        else
            Z{ord, t} = Z{ord-1, t} - Z{ord-1, t-1};
        end
     %   for j = 1 : ord
      %      Z = Z + ((factorial(ord-1) / (factorial(j-1) * factorial(ord-j)) ) * ((-1).^(j-1)) * z(t-j+1));
       % end
        if Z{ord, t} >= 0
            X(t) = 1;
        else
            X(t) = 0;
        end
    end

    for T = 2 : N
        d = d + (X(1,T) - X(1,(T-1)) ).^2 ;    
    end
    D(ord) = d;
  end

end


