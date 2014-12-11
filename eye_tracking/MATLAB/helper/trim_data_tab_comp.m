function fix_data = trim_data_tab_comp(data)

global PRE_POD_TIME;
global TRIAL_LEN;
global SAMP_FREQ;
global WORD_ONSET;

end_time = TRIAL_LEN/1000*SAMP_FREQ;
onset = ceil(WORD_ONSET)-PRE_POD_TIME; %pre_pod_time

len = end_time - onset;

fix_data = nan(size(data,1),len+1, ...
    size(data,3), size(data,4));

for i = 1:size(data,4)
    fix_data(:,1:(len+1),:,i) = ...
        data(:,onset:end_time,:,i);
end


end