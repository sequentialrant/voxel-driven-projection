
function disp_vol_slices(vol,n_fig)

 disp('Display of slices through the volume')
 [N_x N_y N_z] = size(vol); 
 
  for k = 1:N_z;k 
      vol_slice = vol(:,:,k);
      figure(n_fig); imagesc(vol_slice); impixelinfo; 
      colormap(gray); axis square; 
      pause; 
  end;



