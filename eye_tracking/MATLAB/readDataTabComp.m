% main data reading function for reflook4 

function [data, info] = ...
    readDataTabComp(file_path)
    
    %disp('Loading Raw Gaze Data...');
    %[times,raw_data,stim,info] = load_raw_data_tab_comp(file_path);

    load('processed_data/tab_comp/loaded_raw_data_10-Dec-2014.mat',...
          'times','raw_data','stim','info');
 
    %grab demographics
    fprintf('\n')
    disp('Loading Demographic Data...');
    info = addDemoDataTabComp(info);
    
    %extract data
    fprintf('\n');
    disp('Extracting Data...');
    data = extract_data_tab_comp(times,stim,raw_data);
    
    load('processed_data/tab_comp/extracted_data_10-Dec-2014.mat', ...
        'data');
  
end