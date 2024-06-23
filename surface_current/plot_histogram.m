clc;

minX = 1520;
maxX = 1820;
minY = 1198;
maxY = 1498;
    
save_path = 'C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrent/surface_current/분포 히스토그램';
     
filename1 = 'C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrents/23.10.11_slot7/1215.nc';
filename2 = 'C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrents/24.5.13_slot7/1215.nc';
filename3 = 'C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrents/24.5.14_slot7/1215.nc';

chl_histogram1 = ncread(filename1, '/geophysical_data/Chl');
chl_histogram2 = ncread(filename2, '/geophysical_data/Chl');
chl_histogram3 = ncread(filename3, '/geophysical_data/Chl');

chl_histogram1 = rot90(chl_histogram1);
chl_histogram2 = rot90(chl_histogram2);
chl_histogram3 = rot90(chl_histogram3);


chl_histogram1 = chl_histogram1(minX:maxX, minY:maxY);
chl_histogram2 = chl_histogram2(minX:maxX, minY:maxY);
chl_histogram3 = chl_histogram3(minX:maxX, minY:maxY);


chl_histogram1 = chl_histogram1(:);
chl_histogram2 = chl_histogram2(:);
chl_histogram3 = chl_histogram3(:);


chl_histogram = cat(1,chl_histogram1,chl_histogram2,chl_histogram3);


chl_histogram = chl_histogram(:);
                
% 히스토그램 그리기
figure;
histogram(chl_histogram);
                
% 막대 색상을 연한 회색으로 변경 (옵션)
h = findobj(gca,'Type','histogram');
h.FaceColor = [0.8 0.8 0.8]; % RGB 값으로 연한 회색 설정
% 그래프 제목과 축 레이블 추가
xlabel('Chlorophyll-a (mg/m^3)');
ylabel('Frequency');
                
% x축과 y축 범위 지정 (옵션)
xlim([0.0 6.0]);
%ylim([0 6000]);
                
% 데이터 개수 구하기
num_elements = numel(chl_histogram);
                
% 분포 요소 개수를 나타내는 범례 추가
legend(['sample size: ' num2str(num_elements)]);
xticks([0.0:0.5:6.0]); 


