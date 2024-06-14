% 
%  유속 그래프
%

% 주어진 데이터
observed_velocity = [8.1, 11.67142857, 10.61666667, 9.916666667, 12.41428571, 19.38571429];
calculated_velocity = [13.208922, 9.497057, 15.25822, 10.288294, 9.2971811, 10.178657];
time = {'9:15-10:15', '10:15-11:15', '11:15-12:15', '12:15-13:15', '13:15-14:15', '14:15-15:15'};

time_cell = cellstr(time);

% 셀형 배열을 categorical 형식으로 변환
time_categorical = categorical(time_cell, time, 'Ordinal', true);

% 그래프 그리기
figure;
hold on;
plot(time_categorical, observed_velocity, '-s', 'DisplayName', '관측 유속 (cm/sec))');
plot(time_categorical, calculated_velocity, '-o', 'DisplayName', '산출 유속 (cm/sec)');


% 0.2 지점과 55.9 지점에 점 추가
plot(time_categorical(1), 0.2, 'r*', 'DisplayName', '당일 최저 유속 (0.2 cm/sec)');
plot(time_categorical(1), 55.9, 'g*', 'DisplayName', '당일 최대 유속 (55.9 cm/sec)');

hold off;

% 그래프 속성 설정
xlabel('Time');
ylabel('Velocity (cm/sec)');
legend('Location', 'best');
title('관측 유속과 산출 유속의 편차');

grid on;

% y축 범위 설정
ylim([0.2, 55.9]);

% y축의 스케일을 소수점 1자리로 설정
ytickformat('%.1f');

%% 

% 유향 벡터

observed_angles = [118, 73.71428571, 44.83333333, 285.1666667, 309.4285714, 282.5714286];
calculated_angles = [88.505623, 34.135136, 74.694809, 311.93002, 9.050549, 297.92905];

for i = 1:length(observed_angles)
    % 각도를 라디안으로 변환
    observed_angle_rad = deg2rad(observed_angles(i));
    calculated_angle_rad = deg2rad(calculated_angles(i));
    
    % 단위 벡터 계산
    observed_x = cos(observed_angle_rad);
    observed_y = sin(observed_angle_rad);
    calculated_x = cos(calculated_angle_rad);
    calculated_y = sin(calculated_angle_rad);

    % 새로운 figure 생성
    figure;
    
    % 벡터 그리기
    hold on;
    quiver(0, 0, observed_x, observed_y, 'b', 'LineWidth', 2, 'DisplayName', '관측 유향');
    quiver(0, 0, calculated_x, calculated_y, 'r', 'LineWidth', 2, 'DisplayName', '산출 유향');
    hold off;
    
    % 축과 격자 제거
    axis off;
    
    % figure 제목 추가
    title(sprintf('Pair %d', i));
end
%% 

% 유향 편차 그래프

% 주어진 데이터
observed_angles = [118, 73.71428571, 44.83333333, 285.1666667, 309.4285714, 282.5714286];
calculated_angles = [88.505623, 34.135136, 74.694809, 311.93002, 9.050549, 297.92905];

% 편차 계산
deviations = zeros(size(observed_angles));
for i = 1:length(observed_angles)
    diff = observed_angles(i) - calculated_angles(i);
    if diff > 180
        diff = 360 - diff;
    elseif diff < -180
        diff = 360 + diff;
    end
    deviations(i) = abs(diff);
end

% 그래프 그리기
figure;
bar(deviations, 0.5); % 편차를 막대 그래프로 표시
xlabel('Time');
ylabel('편차 (degree)');
title('관측 유향과 산출 유향의 편차');

% y축 상한 및 하한 설정
ylim([0 180]); % y축 범위 설정 (상한 180, 하한 0)
yticks(0:30:180);

% 각도 쌍 번호 표시
xticks(1:length(deviations));
xticklabels(time_categorical);

% 그리드 표시
grid on;


% 편차 값 표시
for i = 1:length(deviations)
    text(i, deviations(i) + 5, num2str(round(deviations(i), 2)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
        'Color', 'blue', 'FontWeight', 'bold');
end






