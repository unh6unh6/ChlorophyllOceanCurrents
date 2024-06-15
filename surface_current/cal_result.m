data_path = './상왕등도_data_fullscreen/test1/result_data.mat';
result_data = load(data_path);
result = [];

for time = 10:13
    u_matrix = result_data.u_original{time-9,1};
    v_matrix = result_data.v_original{time-9,1};
    
    [m, n] = size(u_matrix);
    
    if mod(m, 2) == 1
        center_index = (m + 1) / 2;
        u = u_matrix(center_index, center_index);
        v = v_matrix(center_index, center_index);
    else
        center_index = m / 2 : m / 2 + 1;
        u_component = u_matrix(center_index, center_index);
        v_component = v_matrix(center_index, center_index);
        u = mean(u_component(:));
        v = mean(v_component(:));
    end

    velocity = sqrt(u^2 + v^2);
    
    direction_rad = atan2(u, -v);
    direction_deg = rad2deg(direction_rad);
    
    if direction_deg < 0
        direction_deg = 360 + direction_deg;
    end
        
    if direction_deg >= 348.75 || direction_deg < 11.25
        direction_str = '북';
    elseif direction_deg >= 11.25 && direction_deg < 33.75
        direction_str = '북북동';
    elseif direction_deg >= 33.75 && direction_deg < 56.25
        direction_str = '북동';
    elseif direction_deg >= 56.25 && direction_deg < 78.75
        direction_str = '동북동';
    elseif direction_deg >= 78.75 && direction_deg < 101.25
        direction_str = '동';
    elseif direction_deg >= 101.25 && direction_deg < 123.75
        direction_str = '동남동';
    elseif direction_deg >= 123.75 && direction_deg < 146.25
        direction_str = '남동';
    elseif direction_deg >= 146.25 && direction_deg < 168.75
        direction_str = '남남동';
    elseif direction_deg >= 168.75 && direction_deg < 191.25
        direction_str = '남';
    elseif direction_deg >= 191.25 && direction_deg < 213.75
        direction_str = '남남서';
    elseif direction_deg >= 213.75 && direction_deg < 236.25
        direction_str = '남서';
    elseif direction_deg >= 236.25 && direction_deg < 258.75
        direction_str = '서남서';
    elseif direction_deg >= 258.75 && direction_deg < 281.25
        direction_str = '서';
    elseif direction_deg >= 281.25 && direction_deg < 303.75
        direction_str = '서북서';
    elseif direction_deg >= 303.75 && direction_deg < 326.25
        direction_str = '북서';
    elseif direction_deg >= 326.25 && direction_deg < 348.75
        direction_str = '북북서';
    end


    
    result{1, time-9} = u * 10^2;
    result{2, time-9} = v * 10^2;
    result{3, time-9} = velocity * 10^2;
    result{4, time-9} = direction_rad;
    result{5, time-9} = direction_deg;
    result{6, time-9} = direction_str;
end

result_table = array2table(result, 'VariableNames', {'9~10','10~11','11~12','12~13'});
