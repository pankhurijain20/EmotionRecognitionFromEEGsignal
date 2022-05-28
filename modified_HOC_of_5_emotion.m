clc
clear all
close all
tic
subjects = dir('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\process\S*');
myname = {'F - Happy', 'P - Terrible', 'LL - Sad', 'H - Lovely', 'HH - Sentimental'};

minNumOfIMForder30WithDifferentEmotion = 12;
%-----------------Subjects------------
for i = 17 : 32
   for j = 1 : 5  % emotions
       mkdir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\modified feature with different emotion', subjects(i, 1).name, myname{j}));
       imf = dir(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\IMF', subjects(i, 1).name, myname{j}, 'imf-*'));
       for k = 1 : 40  % IMF
            cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\IMF', subjects(i, 1).name, myname{j}));
            x = dlmread(imf(k, 1).name);
            D = hoc(x);
            cd(fullfile('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment\modified feature with different emotion', subjects(i, 1).name, myname{j}));
            if k <= 9
                fea_data = strcat('nzc','-','0',num2str(k));
                dlmwrite(fea_data , D);
            else
                fea_data = strcat('nzc','-',num2str(k));
                dlmwrite(fea_data , D);
            end
            numOfIMF = length(x)/8064;
            if minNumOfIMForder30WithDifferentEmotion > numOfIMF
                minNumOfIMForder30WithDifferentEmotion = numOfIMF;
            end
       end
   end
end
cd('E:\Data\Documents\MCA\Major projects\ANN emotion classification of deep data set\experiment');
save minNumOfIMForder30WithDifferentEmotion;
toc

function D = hoc(imf)
  numOfIMF = length(imf)/8064;
  D = [];
  for i = 1 : numOfIMF
      lower = (i-1)*8064 + 1;
      upper = lower+8064-1;
      fv = zero_crossing(imf(lower : upper));
      D = [D, fv];
  end
end

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