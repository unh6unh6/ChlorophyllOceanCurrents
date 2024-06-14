clc;

for day = 11:11
    minX = 1520;
    maxX = 1820;
    minY = 1198;
    maxY = 1498;

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
            clim([0, 3]); 
            shading flat;
            axis off; 
            set(gca, 'Position', [0 0 1 1]); % Remove margins
            
            % Set figure size explicitly for square shape
            fig.Units = 'pixels';
            fig.Position(3) = 500; % Set width
            fig.Position(4) = 500; % Set height

            filename = sprintf('23-10-%d_blank_image', day);
            save_path = './상왕등도_data_fullscreen/';
            if ~exist(save_path, 'dir')
                mkdir(save_path);
            end
            exportgraphics(fig, [save_path, filename, '.jpg'], 'Resolution', 300);
            close(fig);
        end

        chl_image = chl_image(minX:maxX, minY:maxY);

        if time == 12
            temp = chl_image;
        end

        mean_val = mean(chl_image(:), 'omitnan');
        min_val = min(chl_image(:));
        max_val = max(chl_image(:));

        % plot Chl image %
        fprintf('    plot Chl image ... \n\n');
        fig = figure('Visible', 'off');
        pcolor(chl_image); 
        clim([0.0, 4]); 
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
        clim([0.0, 4]); 
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

        save_path = './상왕등도_data_fullscreen/';
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
