
function projection_cb(vol, D, phi_deg, theta_deg, psi_deg, n_fig)
% projection_cb: Cone-beam projection of a volume

% Return the size of the volume
  [N_x, N_y, N_z] = size(vol);
  
% Initial point of the volume  
  v0_tilde = [0 0 0 1]';             
  
% Size of the voxel  
  dx = 1; dy = 1; dz = 1;
  
% Detector-specifications
  NDH = N_y;
  ND  = 2*NDH + 1; 
 
% Initialize the detector array
  proj = zeros(ND, ND);

% Projection-matrix
  P_tilde = P_gen_v5(NDH,N_y,D,phi_deg,theta_deg,psi_deg);
  
% Initial point
  p0_tilde = P_tilde*v0_tilde;
  
% First three columns of P_tilde
% Pre-multiply the columns of P_tilde
  p1 = P_tilde(:,1)*dx;
  p2 = P_tilde(:,2)*dy;
  p3 = P_tilde(:,3)*dz;
  
  v1 = p0_tilde;
  
  for i = 1:N_x
      v1 = v1 + p1;
      v2 = v1;
      
      for j = 1:N_y
          v2 = v2 + p2;
          v3 = v2;
          
          for k = 1:N_z
              v3 = v3 + p3;
              u = v3(1)/v3(3); 
              v = v3(2)/v3(3);
              
              ii = floor(u);
              jj = floor(v);
              
              if ( (ii > 0 && ii < ND) && (jj > 0 && jj < ND) )
                  
                  du = 1; dv = 1;
                  t = (u - ii)/du;
                  s = (v - jj)/dv;
              
                  w1 = (1 - t)*(1 - s);    
                  w2 = t*(1 - s);          
                  w3 = t*s;                
                  w4 = (1 - t)*s;          
                    
                  vox_val = vol(i,j,k);    
                  
                  proj(ii,jj)     =  proj(ii,jj)     +  w1*vox_val;
                  proj(ii+1,jj)   =  proj(ii+1,jj)   +  w2*vox_val;
                  proj(ii+1,jj+1) =  proj(ii+1,jj+1) +  w3*vox_val;
                  proj(ii,jj+1)   =  proj(ii,jj+1)   +  w4*vox_val;
                  
              end;
          end;
      end;
  end;
  figure(n_fig);
  imagesc(proj); colormap(gray); axis square;


