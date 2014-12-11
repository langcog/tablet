function [data,dropped] = nan_out_missing(data)

MINIMUM = .5;

missing = nansum(~isnan(data),2) < (size(data,2)*MINIMUM);
missing = repmat(missing,[1 size(data,2) 1]);

size(missing);

dropped = squeeze(nansum(missing,2) > 0);

data(missing) = NaN;

end