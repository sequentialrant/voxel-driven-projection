
function vol_th = pre_threshold( volume,th )

[N_x N_y N_z] = size(volume);

vol_th = zeros(N_x,N_y,N_z);

for i = 1:N_x;
    for j = 1:N_y;
        for k = 1:N_z;
            if (volume(i,j,k) >= th), 
                vol_th(i,j,k) = volume(i,j,k);
            end;
        end;
    end;
   
end;


