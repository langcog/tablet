function [] = write_r_csv_tab_comp(data,info)

%write to csv
f = 'tab_comp_r.csv';

delete(f);

fid = fopen(f,'w');
fprintf(fid,'subj,age,gender,list.num,time.step,trial.type,trial.num,aoi\n');
fclose(fid);

for trialtype = 1:2
    
    switch(trialtype)
        case 1
            m = data.fam_aois;
        case 2
            m = data.new_aois;
    end


    %subj time.step trial.type trial.num aoi

    w_m = repmat((1:size(m,1))',[size(m,2)*size(m,3) 1]); %subj

    w_m(:,2) = repmat((info.ages)',[size(m,2)*size(m,3) 1]); %age
    
    w_m(:,3) = repmat((info.genders)',[size(m,2)*size(m,3) 1]); %gender
     
    w_m(:,4) = repmat((info.listnum)',[size(m,2)*size(m,3) 1]); %list.num
    
    
    %time.stamp
    w_m(:,5) = 0;
    for i = 1:size(m,2)*size(m,3)
        w_m(((size(m,1)*(i-1))+1):((size(m,1)*i)),5)=mod(i,size(m,2));
    end
    w_m(w_m(:,5)==0,4) = size(m,2);

    w_m(:,6) = trialtype; %trial.type

    %trial.num
    w_m(:,7) = 0;
    for i = 1:size(m,3)
        w_m(((size(m,1)*size(m,2)*(i-1))+1):((size(m,1)*size(m,2)*i)),7)...
            =i;
    end

    w_m(:,8) = reshape(m,[numel(m) 1]); %aoi
    
    dlmwrite(f, w_m, '-append', 'delimiter',',');
    
end
