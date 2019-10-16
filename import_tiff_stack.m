function vol = import_tiff_stack(fname)
%import_tiff_stack: procedure to import a multi-page TIFF file 

info = imfinfo(fname);
num_images = numel(info);

for k = 1:num_images
    vol(:,:,k) = imread(fname, k, 'Info', info);
end