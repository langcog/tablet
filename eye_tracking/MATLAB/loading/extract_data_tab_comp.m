function data = extract_data_tab_comp(times,stim,raw_data)

global NEW_WORDS;
global TEST_ENDING;
global FAM_WORDS;

global TRIAL_LEN;

global SAMP_FREQ;

global PROCESSED_DATA_DIR;

NUM_FAM = 8;
NUM_NEW = 16;

n = length(times);

fam_data = NaN([n round(TRIAL_LEN/(1000/SAMP_FREQ)) 2 ...
        NUM_FAM]);
new_data = NaN([n round(TRIAL_LEN/(1000/SAMP_FREQ)) 2 ...
        NUM_NEW]);

fam_names = cell(n,1);
new_names = cell(n,1);
    
t_abs = round(1:1000/SAMP_FREQ:max(cellfun(@max,times)));    
    
for subj = 1:n
        
    fprintf('%d ',subj);
    if ~mod(subj,20), fprintf('\n'); end;

    comp = ~strcmp(['0';stim{subj}],[stim{subj}; '0']);
    ia = times{subj}(comp(1:(end-1)));
    ib = [ia(2:end)-round(1000/SAMP_FREQ);times{subj}(end)];

    stims = stim{subj}(comp(1:(end-1)));

    new_stims = cellfun(@(x) cellfun(@(y) ~isempty(y), ...
        strfind(stims,x)), NEW_WORDS, 'UniformOutput',false);
    new_stims = sum(horzcat(new_stims{:}),2) > 0;

    jpegs = cellfun(@(x) ~isempty(x),strfind(stims,TEST_ENDING));

    new_tests = new_stims & jpegs;

    fam_tests = cellfun(@(x) cellfun(@(y) ~isempty(y), ...
        strfind(lower(stims),x)), FAM_WORDS, 'UniformOutput',false);
    fam_tests = sum(horzcat(fam_tests{:}),2) > 0;

    ts = timeseries(raw_data{subj},times{subj});
    ts = setinterpmethod(ts,'zoh');   
    rts = resample(ts,t_abs);

    all_starts = ia(fam_tests);
    all_ends = ib(fam_tests);

    for trial = 1:sum(fam_tests)

        t_begin = all_starts(trial);
        t_end = all_ends(trial);

        this_trial = t_abs >= t_begin & t_abs <= t_end;

        fam_data(subj,1:sum(this_trial),:,trial) = ...
            rts.Data(this_trial,:);       
    end

    all_starts = ia(new_tests);
    all_ends = ib(new_tests);

    for trial = 1:sum(new_tests)


        t_begin = all_starts(trial);
        t_end = all_ends(trial);

        this_trial = t_abs >= t_begin & t_abs <= t_end;

        new_data(subj,1:sum(this_trial),:,trial) = ...
            rts.Data(this_trial,:);       
    end

    fam_names{subj} = stims(fam_tests);
    new_names{subj} = stims(new_tests);

end

fam_data(fam_data<=0) = NaN;
new_data(new_data<=0) = NaN;

data.fam_data = fam_data;
data.new_data = new_data;
data.fam_names = fam_names;
data.new_names = new_names;

fprintf('\n');

save([PROCESSED_DATA_DIR 'extracted_data_' date],...
    'data');

end