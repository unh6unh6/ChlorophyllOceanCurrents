% 
%  유속 그래프
%

% 주어진 데이터
observed_velocity = [23.2,	33.7,	38.81428571,	36.21428571,	28.38571429,	23.52857143];
calculated_velocity = [12.335970	15.585253	11.756020	20.270302	12.428949	0.85545170];


time = {'time1', 'time2', 'time3','time4', 'time5', 'time6'};

time_cell = cellstr(time);

% 셀형 배열을 categorical 형식으로 변환
time_categorical = categorical(time_cell, time, 'Ordinal', true);

% 그래프 그리기
figure;
hold on;
plot(time_categorical, observed_velocity, '-s', 'DisplayName', 'Observed');
plot(time_categorical, calculated_velocity, '-o', 'DisplayName', 'Calculated');


%plot(time_categorical(1), 0.2, 'r*', 'DisplayName', '당일 최저 유속 (0.2 cm/sec)');
%plot(time_categorical(1), 55.9, 'g*', 'DisplayName', '당일 최대 유속 (55.9 cm/sec)');

hold off;

% 그래프 속성 설정
ylabel('Velocity (cm/sec)');
legend('Location', 'best');

grid on;

% y축 범위 설정
ylim([0, 100]);

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

% 유속 편차 그래프

% 주어진 데이터
observed_velocity = [8.1, 11.67142857, 10.61666667, 9.916666667, 12.41428571, 19.38571429];
calculated_velocity = [13.208922, 9.497057, 15.25822, 10.288294, 9.2971811, 10.178657];

% 편차 계산
deviations = abs(observed_velocity - calculated_velocity);

% 그래프 그리기
figure;
bar(deviations, 0.5, 'FaceColor', [0.8 0.8 0.8]); % 연한 갈색으로 막대 그래프 표시

xlabel('Time');
ylabel('velocity deviation (cm/sec)');

% y축 상한 및 하한 설정
ylim([0.2 55.9]); % y축 범위 설정 
ytickformat('%.1f');

xticks(1:length(deviations));
xticklabels(time_categorical);

% 그리드 표시
grid on;

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
bar(deviations, 0.5, 'FaceColor', [0.8 0.8 0.8]); % 연한 갈색으로 막대 그래프 표시

ylabel('angular deviation (°)');

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
        'Color', 'black');
end

%% 
%유향 비교 그래프

% 주어진 데이터
observed_angles = [246.7142857,	227.8333333,	223.2857143,	201.5714286,	169,	253.4285714];
calculated_angles = [269.93729	294.67090	237.66823	259.94446	132.75618	310.66327];
time = {'time1', 'time2', 'time3','time4', 'time5', 'time6'};

time_cell = cellstr(time);

% 셀형 배열을 categorical 형식으로 변환
time_categorical = categorical(time_cell, time, 'Ordinal', true);


% 그래프 그리기
figure;
hold on;
plot(time_categorical, observed_angles, '-s', 'DisplayName', 'Observed');
plot(time_categorical, calculated_angles, '-o', 'DisplayName', 'Calculated');

hold off;

% 그래프 속성 설정
ylabel('Degree (°)');
legend('Location', 'best');



grid on;

% y축 범위 설정
ylim([0, 360]);

% y축 눈금 설정
yticks([0:30:360]); % 원하는 위치에 눈금 설정
yticklabels({'0', '30', '60', '90', '120', '150', '180', '210', '240', '270', '300', '330', '360'}); % 숫자를 표시할 위치에 맞게 설정


