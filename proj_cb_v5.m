% Main Program 
  
  clear; clc;
  
% Source-detector Distnace 
  D = 1000000;     
  
% Orientation: Rotation-, and tilt-angle
  phi_deg = 60;
  theta_deg = 0; 
  psi_deg = 0; 
  
% Import multi-page TIFF file 
  vol = import_tiff_stack('_010.tif');
  
% Select ROI  
  vol_roi = select_roi(vol);
  vol = vol_roi;
  
%   disp('Displaying the slices of the volume');
%   n_fig = 1;
%   disp_vol_slices(vol,n_fig);  
%   disp('Display of the slices Over, Eneter to continue'); pause;
  
%   maxx = max(max(max(double(vol))));
%   nbins = 1:maxx;
%   hist_vol = hist(double(vol(:)), nbins); 
%   n_fig = 2; 
%   figure(n_fig); plot(hist_vol);  grid;
%   
%   disp('Check Histogram, and Enter to continue'); pause; 
  
% Projection routine
  n_fig = 3;
  projection_cb(vol, D, phi_deg, theta_deg, psi_deg,n_fig);
  title('Projection of the ORIGINAL Volume');
  disp('Proj. of ORIGINAL Volume over - Enter to Continue');
  pause;
  
  disp('Interpolation in progress');
  vol_int = interp_along_slices(vol, 2);
  vol = vol_int;
%   n_fig = 4;
%   disp('Slices of Interpolated Volume - Enter to continue'); pause;
%   disp_vol_slices(vol,n_fig);  
  
%   maxx = max(max(max(double(vol))));
%   nbins = 1:maxx;
%   hist_vol = hist(double(vol(:)), nbins);  
%   n_fig = 5; figure(n_fig); plot(hist_vol);  grid;
%   disp('Histogram of Interpolated Volume - Enter to continue'); pause; 
 
% Projection routine
  n_fig = 6;
  projection_cb(vol, D, phi_deg, theta_deg, psi_deg,n_fig);
  title('Projection of the Interpolated Volume');
  disp('Proj. of INT-Volume - Enter to Continue'); pause;
  
% Pre-threshold  
  th_pre = 3400;
  vol_pre_th = pre_threshold(vol,th_pre);  

%   n_fig = 7;
%   disp('Display slices of Thresholded Volume');
%   disp_vol_slices(vol_pre_th,n_fig);
%   disp('Display of slices of Thresholded Volume over - Enter to continue'); pause;
   
% % Thresholding:
%   th_otsu_norm = graythresh(vol_pre_th);     % Find Threshold 
%   th_otsu = th_otsu_norm*max(max(max(vol_pre_th)));

%  th = th_pre; 
  th = th_otsu; 
  vol_th_bin = binary_vol_threshold(vol_pre_th, th);
  disp(['Otsu-thresholding Done: th_otsu = ',num2str(th)]);
  vol = vol_th_bin;
  
%   n_fig = 8;
%   disp('Display slices of the binary Volume');
%   disp_vol_slices(vol,n_fig);
%   disp('Display of slices of the binary Volume over - Enter to continue'); 
%   pause;
  
% Structuring element - sphere
  [x,y,z] = ndgrid(-1:1);
  se = strel(sqrt(x.^2 + y.^2 + z.^2) <=1);
    
% Perform morphological open
  vol_open = imopen(vol, se);
  vol = vol_open;
  
  n_fig = 9; 
  projection_cb(vol, D, phi_deg, theta_deg, psi_deg,n_fig);
  title('Projection of the Binary Volume - 45 deg');
  disp('Proj. of Binary Vol. - Enter to Continue'); pause;
  
% Counting the DNA double-strand breaks
  disp('Counting the blobs');
  [L, num_foci] = bwlabeln(vol);
  disp(['num_foci = ', num2str(num_foci)]);
  disp('Foci counting done - Enter to continue'); pause;

  n_fig = 100; 
  D = 1000000; 
  gap_disp = 0.00005; gap_ang = 1;
  disp_movie(vol, D, phi_deg, gap_ang,gap_disp,n_fig);
  
  
  
  