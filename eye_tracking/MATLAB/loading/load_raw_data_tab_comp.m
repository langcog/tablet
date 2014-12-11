function [times,raw_data,stim,info] = load_raw_data_tab_comp(file_path)

global PROCESSED_DATA_DIR;

files = dir([file_path '*.txt']);
files = {files.name};

vertcat(files);

n = length(files);

times = cell(n,1);
raw_data = cell(n,1);
stim = cell(n,1);
    
delim = '\t';
% loop over files and read each one in 
for i = 1:n
    disp(files{i})

    %[time lx ly rx ry stimulus]
    fid = fopen([file_path files{i}]);

    C = textscan(fid,'%f%*s%*d%f%f%f%f%s',...
        'delimiter',delim,'headerlines',36);

    fclose(fid);

    % arrange times, raw data, and stimulus info in cell arrays
    times{i} = round(((C{1} - C{1}(1)))/1000) + 1; % zero out times
    raw_data{i} = [round(mean([C{2} C{4}],2)) round(mean([C{3} C{5}],2))];
    stim{i} = C{6};
end

info.files = files;

save([PROCESSED_DATA_DIR 'loaded_raw_data_' date],'times','raw_data','stim','info');