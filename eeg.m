clc,clear all,close all

tic
emotions = dir('C:\Program Files\MATLAB\R2014a\bin\thesis\phd\dataset\S');
E = cell(40 , 1 );

data_folder = fullfile('C:\Program Files\MATLAB\R2014a\bin\thesis\phd\dataset\data_preprocessed_matlab');
cd(data_folder);

for i = 3 : 42
    E{i - 2 , 1} = (emotions(i , 1).name);
end

%-------------------------------------------------------------------------

for l = 1 : 2                                    % Subject
    
    st = num2str(l);
    if l < 10
        name = strcat('S' , '0' , st, '.mat' );
    else
        name = strcat('S' , st, '.mat' );
    end
    cd(data_folder);
    data_str = load(name);
    cd('C:\Program Files\MATLAB\R2014a\bin\thesis\phd\dataset\S');
    
    %----------------------------------------------------------------------
    % Video/ Trials
    %----------------------------------------------------------------------
    
    for k = 1 : 40                               
        emotion{k, 1} = E(k , 1);
        
        for i = 1 : 32                            % Channels  
            em(k , i, :) = data_str.data(k, i , : );
        end
        cd('C:\Program Files\MATLAB');
        
    %----------------------------------------------------------------------
    %Power Spectral Density
    %----------------------------------------------------------------------
        Fs=134.4;           %sampling frequency
        Ts=1/Fs;            % sampling period
        %[N,nu]=size(x');    %obtain size of data
        t=(Ts:Ts:60);       %generates time vector
        
        for j=1:32
            x(j,:,:)=em(k,j,:);
            plot(t,x(j,:,:), 'b-');
            
        end    
             %[pxx, freq]=psd_spect(x);
             step=134;
             for n=1:32
                 [psd(:,n), f(:,n)]=pwelch(x(n,:,:),step,0,8192,134);
                 %plot(f,10*log10(psd));grid on;
             end   
    %----------------------------------------------------------------------
    %Spectrogram
    %----------------------------------------------------------------------
    
    end 
    a=em(5,:);
    %sub_emt(:,:,:,l)=em(:,:,:);
end
    

         
          

