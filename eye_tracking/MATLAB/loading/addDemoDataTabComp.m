function info = addDemoDataTabComp(info)
global DEMO_FILE;

%% add demographic data to the mix

fid = fopen(DEMO_FILE);
%[sub_id age age_group gender hisp ethnicity english numlang parented premie list]
C = textscan(fid,'%s %f %n %n %n %n %n %n %n %n %n', ...
    'delimiter', '\t', 'headerlines', 1);
fclose(fid);

%% matching with ages

subids = C{1};
ages = C{2};
genders = C{4};
englishes = C{7};
premies = C{end-1};
listnum = C{end};
check = zeros(size(subids));


for i = 1:length(info.files)

    
    info.files{i};
    this_sub = find(~cellfun(@isempty,...
        (cellfun(@(x) strfind(info.files{i},x),subids,...
        'UniformOutput',false))));
    
    subid = subids(this_sub);
    info.subid{i} = subid{1};

    if isempty(this_sub)
        fprintf('%s, NO DEMOGRAPHIC\n',subid)
        info.ages(i) = NaN;
    elseif length(this_sub) > 1
        fprintf('%s, MULTIPLE MATCHES\n',subid)
    else
        info.ages(i) = ages(this_sub);
        info.genders(i) = genders(this_sub);
        info.englishes(i) = englishes(this_sub);
        info.premies(i) = premies(this_sub);
        info.listnum(i) = listnum(i);
        check(this_sub) = 1;
    end
end

%% output the ones where we found no match

for i = 1:length(check)
  if ~check(i)
    fprintf('%s, NO ET DATA\n',subids{i})
  end
end

end