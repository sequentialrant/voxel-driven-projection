function vol_th = binary_vol_threshold( volume,th )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[x y z] = size(volume);

vol_th = zeros(x,y,z);

for i = 1:x
    for j = 1:y
        for k = 1:z
            if (volume(i,j,k) >= th)
                vol_th(i,j,k) = 1;
            else
                vol_th(i,j,k) = 0;
            end
        end
    end
    
%vol_th = uint8(vol_th);

end

