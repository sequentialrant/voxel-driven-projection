function P_matrix = P_gen_v5( NDH,N_y,D,phi_deg,theta_deg,psi_deg )
% P_gen: function to generate P-matrix
    
  u0 = NDH; v0 = NDH;           % 2D translation  
  
  pi_n = pi/180; 
  theta =  theta_deg*pi_n;
  phi   =  phi_deg*pi_n;
  psi   =  psi_deg*pi_n;
 
   R_x = [ 1       0            0     ;
           0   cos(theta)   sin(theta);
           0  -sin(theta)   cos(theta);
         ];
     
   R_y = [ cos(phi)  0  sin(phi);
              0      1     0    ;
           sin(phi)  0  cos(phi);
         ];
     
   R_z = [ cos(psi)   sin(psi)   0;
          -sin(psi)   cos(psi)   0;
               0          0      1;
         ];
     
   R = R_x*R_y*R_z;
   
   du = 1; dv = 1;
   
   A = [ u0/D   du   0;
         v0/D   0   dv;
         1/D    0   0;
       ];
   
   tx = D; ty = -N_y/2; tz = -N_y/2;  % 3D translation
   t = [tx ty tz]';
   
   AR = A*R;
   At = A*t;
   
   P_matrix = [AR At];
   
end

