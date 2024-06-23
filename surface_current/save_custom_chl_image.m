clc;
set_year = 24;
set_month = 5;
set_day = 14;
set_slot = 7;

for day = set_day:set_day
    minX = 1520;
    maxX = 1820;
    minY = 1198;
    maxY = 1498;

    save_path = './분포 히스토그램/';
    for time = 12:12

        fprintf('start  23.10.%d / %d:15 ... \n\n', day, time);

        fprintf('    build matrix ... \n\n');
        filename = sprintf('C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrents/%d.%d.%d_slot%d/%d15.nc',set_year,set_month, day,  set_slot, time);
        chl_image = ncread(filename, '/geophysical_data/Chl');
        chl_image = rot90(chl_image);

        if time == 20 % save blank image
            chl_blank_image = chl_image;
            chl_blank_image(minX:maxX, minY) = 0;
            chl_blank_image(minX, minY:maxY) = 0;
            chl_blank_image(maxX, minY:maxY) = 0;
            chl_blank_image(minX:maxX, maxY) = 0;


            fig = figure('Visible', 'off');
            pcolor(chl_blank_image); 
            clim([0, 1.3]); 
            shading flat;
            axis off; 
            set(gca, 'Position', [0 0 1 1]); % Remove margins
            
            % Set figure size explicitly for square shape
            fig.Units = 'pixels';
            fig.Position(3) = 500; % Set width
            fig.Position(4) = 500; % Set height

            filename = sprintf('%d-%d-%d_blank_image',set_year, set_month, day);
            if ~exist(save_path, 'dir')
                mkdir(save_path);
            end
            exportgraphics(fig, [save_path, filename, '.jpg'], 'Resolution', 300);
            close(fig);


         
        end

        chl_image = chl_image(minX:maxX, minY:maxY);

        if 1
            temp = chl_image;
            chl_histogram = chl_image(:);
            
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
            xlim([0.0 8.0]);
            %ylim([0 6000]);
            
            % 데이터 개수 구하기
            num_elements = numel(chl_histogram);
            
            % 분포 요소 개수를 나타내는 범례 추가
            %legend(['분포 요소 개수: ' num2str(num_elements)]);

            histogram_file = append(save_path, 'histogram.jpg');
            saveas(gcf, histogram_file);
        end

        mean_val = mean(chl_image(:), 'omitnan');
        min_val = min(chl_image(:));
        max_val = max(chl_image(:));

        % plot Chl image %
        fprintf('    plot Chl image ... \n\n');
        fig = figure('Visible', 'off');
        pcolor(chl_image); 
        clim([0, 1]); 
        shading flat;
        axis off;
        set(gca, 'Position', [0 0 1 1]); % Remove margins
        
        % Set figure size explicitly for square shape
        fig.Units = 'pixels';
        fig.Position(3) = 500; % Set width
        fig.Position(4) = 500; % Set height

        % plot interpolated Chl image
        fprintf('    plot interp image ... \n\n');
        interp_image = inpaint_nans(chl_image, 2);
        fig2 = figure('Visible', 'off');
        pcolor(interp_image); 
        clim([0, 1]); 
        shading flat;
        axis off;
        %colorbar;
        set(gca, 'Position', [0 0 1 1]); % Remove margins
        
        % Set figure size explicitly for square shape
        fig2.Units = 'pixels';
        fig2.Position(3) = 500; % Set width
        fig2.Position(4) = 500; % Set height

        % 이미지 파일 저장 %
        fprintf('    save image in local ... \n\n');
        filename = sprintf('%d-%d-%d_%d15', set_year, set_month, day, time);

        if ~exist(save_path, 'dir')
            mkdir(save_path);
        end
        exportgraphics(fig, [save_path, filename, '.jpg'], 'Resolution', 300);

        save_path_interp = append(save_path, 'interp/');
        if ~exist(save_path_interp, 'dir')
            mkdir(save_path_interp);
        end
        exportgraphics(fig2, [save_path_interp, filename, '.jpg'], 'Resolution', 300);

        close(fig);
        close(fig2);

        fprintf('end  23.10.%d / %d:15 ... \n', day, time);
        disp('-------------------------------------------------');

    end
end
