clc;


for day = 11:11
    minX = 1520;
    maxX = 1820;
    minY = 1198;
    maxY = 1498;


    for time = 10:15

      fprintf('start  23.10.%d / %d:15 ... \n\n',day, time)



      fprintf('    build matrix ... \n\n')
      filename = sprintf('C:/Users/민경윤/Desktop/논문/ChlorophyllOceanCurrents/23.10.%d/%d15.nc',day, time);
      chl_image = ncread(filename, '/geophysical_data/Chl');
      chl_image = rot90(chl_image);

      if time == 12 % save blanck image
          chl_blank_image = chl_image;
          chl_blank_image(minX:maxX, minY:maxY) = 0;
          hold on; 
          fig = figure('Visible','off');
          pcolor(chl_blank_image); 
          clim([0, 2.5]); 
          shading flat;
          axis off;
          filename = sprintf('23-10-%d_blank_image', day);
          saveas(fig, [save_path, filename ,'.jpg']);
      end

      %chl_image = chl_image(2071:2570, 271:770);
      %chl_image(2071:2570, 271:770) = 0;
      chl_image = chl_image(minX:maxX, minY:maxY);

      if time == 12
          temp = chl_image;
      end

      mean_val = mean(chl_image(:), 'omitnan')
      min_val = min(chl_image(:))
      max_val = max(chl_image(:))



      % plot Chl image %
      fprintf('    plot Chl image ... \n\n')
      hold on; 
      fig = figure('Visible','off');
      pcolor(chl_image); 
      clim([0.0,2.5]); 
      shading flat;
      axis off;

      %plot interplated Chl image
      fprintf('    plot interp image ... \n\n')
      interp_image = inpaint_nans(chl_image,2);
      hold on; 
      fig2 = figure('Visible','off');
      pcolor(interp_image); 
      clim([0.0,2.5]); 
      shading flat;
      axis off;


      % 이미지 파일 저장 %
      fprintf('    save image in local ... \n\n')
      filename = sprintf('23-10-%d_%d15', day, time);


      save_path = './상왕등도_data/';
      if ~exist(save_path, 'dir')
          mkdir(save_path);
      end
      saveas(fig, [save_path, filename ,'.jpg']);



      save_path_interp = append(save_path,'interp/');
      if ~exist(save_path_interp, 'dir')
          mkdir(save_path_interp);
      end
      saveas(fig2, [save_path_interp, filename ,'.jpg']);
      


      fprintf('end  23.10.%d / %d:15 ... \n',day, time)
      disp('-------------------------------------------------')

    end

end