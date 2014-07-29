function [] = make_stims(file)

    function [] = make_stim(img1,img2,color)
        
        if nargin < 3
            color = 'black';
        end
        
        im1 = imread(['../images/' img1 '.jpg']);
        im2 = imread(['../images/' img2 '.jpg']);
        
        if strcmp(color,'white')
            imboth = uint8(365*ones(1200,1920,3));
            dir = '../image_pairs_white/';
        else
            imboth = uint8(zeros(1200,1920,3));
            dir = '../image_pairs/';
        end
            
        imboth(361:840,1:640,:) = im1;
        imboth(361:840,1281:end,:) = im2;
        
        imwrite(imboth,[dir img1 '_' img2 '.jpg'],'jpg');
    end

    if nargin < 1
        file = 'stimulus_pairs.csv';
    end
    
    stims = readtable(file);
    stims
    
    for row = 1:height(stims)
        make_stim(stims{row,1}{:},stims{row,2}{:},'black');
        make_stim(stims{row,2}{:},stims{row,1}{:},'black');
        
        make_stim(stims{row,1}{:},stims{row,2}{:},'white');
        make_stim(stims{row,2}{:},stims{row,1}{:},'white');
    end

end