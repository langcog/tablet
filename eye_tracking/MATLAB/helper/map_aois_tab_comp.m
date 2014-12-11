function aois = map_aois_tab_comp(gaze_pts,aois)

    global SMOOTH_PARAM;

    function inaoi = in_aoi(aoi,x,y)
        
        %1 if in this aoi
        inaoi = x >= min(aoi(:,1)-SMOOTH_PARAM,aoi(:,2)+SMOOTH_PARAM) & ...
           x <= max(aoi(:,1)-SMOOTH_PARAM,aoi(:,2)+SMOOTH_PARAM) ...
           & y >= min(aoi(:,3)-SMOOTH_PARAM,aoi(:,4)+SMOOTH_PARAM) ...
           & y <= max(aoi(:,3)-SMOOTH_PARAM,aoi(:,4)+SMOOTH_PARAM);
    end

    function aoinum = which_aoi(pts,aois)
        
        %try all aois
        inaois = arrayfun(@(x) double(in_aoi(aois{x},pts(:,1),pts(:,2))),...
            1:size(aois,2),'UniformOutput',false);
        
        %find which fired
        inaois = [horzcat(inaois{:}) (~isnan(pts(:,1)) & ~isnan(pts(:,2)))...
            ones(size(inaois{1}))];
        [~,aoinum] = max(inaois,[],2);
        aoinum(aoinum > (size(aois,3)+1)) = NaN;    
    end


    function subj_aois = map_train_helper(subj_gaze_pts,aois)
        subj_aois = cellfun(@(x) which_aoi(x,aois), subj_gaze_pts,...
            'UniformOutput',false);
    end


    %reshape data to be cell array
    gaze_pts = cellfun(@squeeze,squeeze(num2cell(gaze_pts,[2 3])),...
        'UniformOutput',false);
    gaze_pts = arrayfun(@(idx) gaze_pts(idx,:), 1:size(gaze_pts,1), ...
        'UniformOutput', false);
    
    %run the aoi checker
    aois = arrayfun(@(x) map_train_helper(gaze_pts{x},aois), ...
        1:length(gaze_pts), 'UniformOutput', false);

    %convert back to matrix representation
    num_times = size(aois{1}{1},1);
    num_subjs = size(aois,2);
    num_trials = size(aois{1},2);
    aois = cell2mat(vertcat(aois{:}));
    aois = reshape(aois,num_times,num_subjs,num_trials);
    aois = permute(aois,[2 1 3]);
   

end