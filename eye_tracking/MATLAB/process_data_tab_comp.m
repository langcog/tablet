%% data processing script for TAB_COMP
% dy 11/14

clear all
CONSTANTS_TAB_COMP;
addpath('export_fig/');
addpath('helper/');
addpath('loading/');

%% read in data
[data, info] = readDataTabComp(RAW_DATA_DIR);

data.new_data = trim_data_tab_comp(data.new_data);
data.fam_data = trim_data_tab_comp(data.fam_data);

[data.fam_aois,dropped_fam] = nan_out_missing(map_aois_tab_comp(data.fam_data,TEST_AOIS));
[data.new_aois,dropped_new] = nan_out_missing(map_aois_tab_comp(data.new_data,TEST_AOIS));

save([PROCESSED_DATA_DIR 'processed_data_' date],'data','info');

DROP_KIDS = isnan(info.ages);
sum(DROP_KIDS)
DROPKIDS(isnan(info.genders)) = 1;
sum(DROP_KIDS)
DROP_KIDS(info.premies == 1) = 1;
sum(DROP_KIDS)
DROP_KIDS(info.englishes < 4) = 1;
sum(DROP_KIDS)
DROP_KIDS(isnan(info.listnum)) = 1;
sum(DROP_KIDS)

DROP_KIDS = logical(DROP_KIDS);

data.new_data(DROP_KIDS,:,:,:) = [];
data.new_aois(DROP_KIDS,:,:) = [];
data.fam_data(DROP_KIDS,:,:,:) = [];
data.fam_aois(DROP_KIDS,:,:) = [];

info.ages(DROP_KIDS) = [];
info.premies(DROP_KIDS) = [];
info.englishes(DROP_KIDS) = [];
info.genders(DROP_KIDS) = [];
info.files(DROP_KIDS) = [];
info.subid(DROP_KIDS) = [];
info.listnum(DROP_KIDS) = [];

dropped_fam(DROP_KIDS,:) = 0;
dropped_new(DROP_KIDS,:) = 0;

save([PROCESSED_DATA_DIR 'processed_data_dropped_' date],'data',...
    'info');

%graph ages
hist(info.ages,1.25:.5:4.75)
title('Histogram of Participant Ages','fontsize',28);
xlim([.5 5.5]);
set(gca,'xtick',1:.5:5);
xlabel('Age','fontsize',24);
ylabel('Number of Participants','fontsize',24);
set(gca,'fontsize',18);
set(gcf,'color','white');
