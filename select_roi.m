function vol_roi = select_roi(vol)

[N_x N_y N_z] = size(vol);

[x, y, crop_slice, rect] = imcrop(vol(:, :, 1));

l = length(vol(N_x, N_y, :));

for k = 1:l
    crop_vol(:,:,k) = imcrop(vol(:, :, k), rect);
end;

vol_roi = crop_vol;
