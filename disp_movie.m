function disp_movie(vol, D, phi_deg, gap_ang,gap_disp,n_fig)

theta_deg = 0; psi_deg = 0; 

for k = 0:gap_ang:359; 
      phi_deg = k; 
      projection_cb(vol, D, phi_deg, theta_deg, psi_deg,n_fig);
     'Proj. of Binary Vol. - Enter to Continue'; 
     pause(gap_disp);
end;

