%% Cut the regions
[nozzel_upper_row, nozzel_upper_column] = nozzle_diameter();
%% Cut for bw2
[BW2] = cut_upper_nozzle(nozzel_upper_row,nozzel_upper_column,BW2);
upper_region = 65;   %define the upper region freshold is 65
[BW2] = cut_upper_region(upper_region,BW2);
%% Cut for bw1
% cut the nozzel
[BW1]=cut_upper_nozzle(nozzel_upper_row,nozzel_upper_column,BW1);
% cut the upper water level region
[BW1]=cut_upper_region(upper_region,BW1);