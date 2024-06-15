clc;

for day = 11:11
    minX = 2361;
    maxX = 2660;
    minY = 381;
    maxY = 680;

    save_path = './sample_300x300_fullscreen/';
    for time = 9:15

        fprintf('start  23.10.%d / %d:15 ... \n\n', day, time);

        fprintf('    build matrix ... \n\n');
        filename = sprintf('C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrents/23.10.%d/%d15.nc', day, time);
        chl_image = ncread(filename, '/geophysical_data/Chl');
        chl_image = rot90(chl_image);

        if time == 12 % save blank image
            chl_blank_image = chl_image;
            chl_blank_image(minX:maxX, minY:maxY) = 0;
            fig = figure('Visible', 'off');
            pcolor(chl_blank_image); 
            clim([0, 2.5]); 
            shading flat;
            axis off; 
            set(gca, 'Position', [0 0 1 1]); % Remove margins
            
            % Set figure size explicitly for square shape
            fig.Units = 'pixels';
            fig.Position(3) = 500; % Set width
            fig.Position(4) = 500; % Set height

            filename = sprintf('23-10-%d_blank_image', day);
            if ~exist(save_path, 'dir')
                mkdir(save_path);
            end
            exportgraphics(fig, [save_path, filename, '.jpg'], 'Resolution', 300);
            close(fig);


         
        end

        chl_image = chl_image(minX:maxX, minY:maxY);

        if time == 12
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
            xlim([0.0 3.0]);
            ylim([0 6000]);
            
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
        clim([0, 3.1]); 
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
        clim([0, 3.1]); 
        shading flat;
        axis off;
        set(gca, 'Position', [0 0 1 1]); % Remove margins
        
        % Set figure size explicitly for square shape
        fig2.Units = 'pixels';
        fig2.Position(3) = 500; % Set width
        fig2.Position(4) = 500; % Set height

        % 이미지 파일 저장 %
        fprintf('    save image in local ... \n\n');
        filename = sprintf('23-10-%d_%d15', day, time);

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
