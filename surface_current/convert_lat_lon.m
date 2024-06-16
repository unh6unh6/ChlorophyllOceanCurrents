
filename = 'C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrents/24.5.13_slot4/1015.nc';
latitude_values = ncread(filename, '/navigation_data/latitude');
longitude_values = ncread(filename, '/navigation_data/longitude');

latitude_values = rot90(latitude_values);
longitude_values = rot90(longitude_values);

% convert (x,y) -> (lat, long)
x = 2425;
y = 657;

latitude_value = latitude_values(x,y)
longitude_value = longitude_values(x,y)

% convert (lat, long) -> (x,y)
lat = 38.007222222222225;
long = 131.5525;


diff_lat = abs(latitude_values - lat);
diff_long = abs(longitude_values - long);
diff = diff_lat + diff_long;

[minValue, linearIndex] = min(diff(:));
[x_value, y_value] = ind2sub(size(latitude_values), linearIndex);

x_value
y_value

