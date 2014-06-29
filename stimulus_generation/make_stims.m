function [] = make_stims(file)

    function [] = make_stim(img1,img2)
        
        imboth = uint8(zeros(1200,1920,3));
        
        im1 = imread(['../images/' img1 '.jpg']);
        im2 = imread(['../images/' img2 '.jpg']);

        imboth(361:840,1:640,:) = im1;
        imboth(361:840,1281:end,:) = im2;
        imwrite(imboth,['../image_pairs/' img1 '_' img2 '.jpg'],'jpg');
    end

    if nargin < 1
        file = 'stimulus_pairs.csv';
    end
    
    stims = readtable(file);
    
    for row = 1:height(stims)
        make_stim(stims{row,1}{:},stims{row,2}{:});
    end

end