data_path = './울릉도_data_24.5.13_fullscreen/interp/result_data.mat';
result_data = load(data_path);
result = [];

% 원래의 x, y 범위
x_range = [2185, 2585];
y_range = [300, 700];

% 목표 좌표
target_x = 2425;
target_y = 657;

% 매트릭스의 크기 확인을 위해 첫 번째 시간 스텝의 u_matrix를 사용
u_matrix_sample = result_data.u_original{1, 1};
v_matrix_sample = result_data.v_original{1, 1};

% 목표 좌표를 u_matrix, v_matrix의 인덱스로 변환
x_index = round((target_x - x_range(1)) / (x_range(2) - x_range(1)) * (size(u_matrix_sample, 2) - 1)) + 1;
y_index = round((target_y - y_range(1)) / (y_range(2) - y_range(1)) * (size(u_matrix_sample, 1) - 1)) + 1;

for time = 10:15
    u_matrix = result_data.u_original{time-9, 1};
    v_matrix = result_data.v_original{time-9, 1};

    u_matrix = inpaint_nans(u_matrix);
    v_matrix = inpaint_nans(v_matrix);
    
    % 변환된 인덱스를 사용하여 u, v 값 설정
    u = u_matrix(y_index, x_index);
    v = v_matrix(y_index, x_index);

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

result_table = array2table(result, 'VariableNames', {'9~10','10~11','11~12','12~13','13~14','14~15'});
