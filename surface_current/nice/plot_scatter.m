clearvars


observed_velocity1 = [8.1	11.67142857	10.61666667	9.916666667	12.41428571	19.38571429
                       23.2,	33.7,	38.81428571,	36.21428571,	28.38571429,	23.52857143,
                       23.74285714,	16.32857143,	14.7,	19.04285714,	16.85714286,	22.25714286];
calculated_velocity1 = [13.208922	9.497057	15.25822	10.288294	9.2971811	10.178657
                       12.335970	15.585253	11.756020	20.270302	12.428949	14.85545170,
                       13.769360	8.2924585	6.1064577	7.8312917	8.7145500	8.9868648];

observed_velocity2 = [59.06666667,	55.86666667,	35.36666667,	40.13333333,	62.76666667,	54.03333333,
                       41.3,	35.6,	29.83333333,	27.66666667,	33.23333333,	28.26666667,
                       13.26666667	19.06666667	17.86666667	13.63333333	20.6	28.53333333];

calculated_velocity2 = [33.660065	39.108009	35.025589	40.070942	28.136221	40.636765,
                        22.723385	7.8202724	11.516070	21.668564	23.913403	11.193502,
                       17.767529	15.658792	26.057848	19.613649	16.228748	22.487789];

%%

% plot 유속 산점도


figure;

scatter(observed_velocity1, calculated_velocity1, 'r'); 

hold on; 

scatter(observed_velocity2, calculated_velocity2, 'b'); % 

x_values = 0:500;
plot(x_values, x_values, 'k');

err1 = plot(x_values+13, x_values, 'k');
err1.Color = [0 0 0 0.2];


err2 = plot(x_values-13, x_values, 'k');
err2.Color = [0 0 0 0.2];


p1 = polyfit(observed_velocity1, calculated_velocity1, 1);  % 선형 회귀
f1 = polyval(p1, x_values);  % 추세선 계산
plot1 = plot(x_values, f1, 'r', 'LineWidth', 0.1);  % 추세선 플롯
plot1.Color = [1 0 0 0.4];


p2 = polyfit(observed_velocity2, calculated_velocity2, 1);  % 선형 회귀
f2 = polyval(p2, x_values);  % 추세선 계산
plot2 = plot(x_values, f2, 'b', 'LineWidth', 0.1);  % 추세선 플롯
plot2.Color = [0 0 1 0.4];

xlim([0 60]);
ylim([0 60]);

xlabel('Observed Velocity(cm/sec)');
ylabel('Calculated Velocity(cm/sec)');

legend('상왕등도', '울릉도','Location','Best');

grid on;

%%

observed_velocity1 = [8.1	11.67142857	10.61666667	9.916666667	12.41428571	19.38571429
                       23.2,	33.7,	38.81428571,	36.21428571,	28.38571429,	23.52857143,
                       23.74285714,	16.32857143,	14.7,	19.04285714,	16.85714286,	22.25714286];
calculated_velocity1 = [13.208922	9.497057	15.25822	10.288294	9.2971811	10.178657
                       12.335970	15.585253	11.756020	20.270302	12.428949	0.85545170,
                       13.769360	8.2924585	6.1064577	7.8312917	8.7145500	8.9868648];

observed_velocity2 = [59.06666667,	55.86666667,	35.36666667,	40.13333333,	62.76666667,	54.03333333,
                       41.3,	35.6,	29.83333333,	27.66666667,	33.23333333,	28.26666667,
                       13.26666667	19.06666667	17.86666667	13.63333333	20.6	28.53333333];

calculated_velocity2 = [33.660065	39.108009	35.025589	40.070942	28.136221	40.636765,
                        22.723385	7.8202724	11.516070	21.668564	23.913403	11.193502,
                       17.767529	15.658792	26.057848	19.613649	16.228748	22.487789];


%%
% 상왕등도 유속 상관계수

corr = [];
length = size(observed_velocity1);

for i = 1:length(1)
   ob = observed_velocity1(i,:);
   cal = calculated_velocity1(i,:);
   corr_result = corrcoef(ob, cal);
   corr(i) = corr_result(2,1);
end

corr
corr_average = mean(abs(corr))

%%
% 울릉도 유속 상관계수

corr = [];
for i = 1:length(1);
   ob = observed_velocity2(i,:);
   cal = calculated_velocity2(i,:);
   corr_result = corrcoef(ob, cal);
   corr(i) = corr_result(2,1);
end
corr
corr_average = mean(abs(corr))


%%


observed_direction1 = [118	73.71428571	44.83333333	285.1666667	309.4285714	282.5714286
                       246.7142857	229.8333333	223.2857143	201.5714286	169	253.4285714
                       316.2857143	272.2857143	234.4285714	204	168.4285714	131.2857143];
calculated_direction1 = [88.505623	34.135136	74.694809	311.93002	369.050549	297.92905
                        269.93729	294.67090	237.66823	259.94446	132.75618	310.66327
                        269.62482	223.98148	240.29657	176.97166	226.61885	155.46161];

observed_direction2 = [168	173	156.3333333	136.6666667	173.6666667	175
                        239.6666667	235	233	211.3333333	198.6666667	217
                        217.6666667	187	187.3333333	160.3333333	178	195];
calculated_direction2 = [181.05421	180.80862	187.27702	184.47845	187.56621	18.25209
                        245.80946	260.25531	391.642710	176.84045	239.93243	130.81198
                        197.91049	178.04893	78.405670	216.41882	267.81784	243.38809];

%%
% plot 유향 산점도

figure;

scatter(observed_direction1, calculated_direction1, 'r');
hold on;

scatter(observed_direction2, calculated_direction2, 'b');

x_values = 0:500;
plot(x_values, x_values, 'k');

err1 = plot(x_values+64, x_values, 'k');
err1.Color = [0 0 0 0.2];


err2 = plot(x_values-64, x_values, 'k');
err2.Color = [0 0 0 0.2];


p1 = polyfit(observed_direction1, calculated_direction1, 1);  % 선형 회귀
f1 = polyval(p1, x_values);  % 추세선 계산
plot1 = plot(x_values, f1, 'r', 'LineWidth', 0.1);  % 추세선 플롯
plot1.Color = [1 0 0 0.4];

p2 = polyfit(observed_direction2, calculated_direction2, 1);  % 선형 회귀
f2 = polyval(p2, x_values);  % 추세선 계산
plot2 = plot(x_values, f2, 'b', 'LineWidth', 0.1);  % 추세선 플롯
plot2.Color = [0 0 1 0.4];


xlim([30 390]);
ylim([30 390]);

xlabel('Observed Direction(°)');
ylabel('Calculated Direction(°)');

legend('상왕등도', '울릉도','Location','Best');

% 그리드 추가
grid on;

%%

observed_direction1 = [118	73.71428571	44.83333333	285.1666667	309.4285714	282.5714286
                       246.7142857	227.8333333	223.2857143	201.5714286	169	253.4285714
                       316.2857143	272.2857143	234.4285714	204	168.4285714	131.2857143];
calculated_direction1 = [88.505623	34.135136	74.694809	311.93002	369.050549	297.92905
                        269.93729	294.67090	237.66823	259.94446	132.75618	310.66327
                        269.62482	223.98148	240.29657	176.97166	226.61885	155.46161];

observed_direction2 = [168	173	156.3333333	156.6666667	173.6666667	175
                        239.6666667	241	233	211.3333333	198.6666667	217
                        217.6666667	187	187.3333333	160.3333333	178	195];
calculated_direction2 = [181.05421	180.80862	187.27702	184.47845	187.56621	180.25209
                        245.80946	260.25531	391.642710	176.84045	239.93243	130.81198
                        197.91049	178.04893	78.405670	216.41882	267.81784	243.38809];

%%
% 상왕등도 유향 상관계수
corr = [];
length = size(observed_direction1);

for i = 1:length(1)
   ob = observed_direction1(i,:);
   cal = calculated_direction1(i,:);
   corr_result = corrcoef(ob, cal);
   corr(i) = corr_result(2,1);
end

corr
corr_average = mean(abs(corr))
%%
% 울릉도 유향 상관계수

corr = [];
for i = 1:length(1);
   ob = observed_direction2(i,:);
   cal = calculated_direction2(i,:);
   corr_result = corrcoef(ob, cal);
   corr(i) = corr_result(2,1);
end
corr
corr_average = mean(abs(corr))
