clc;


for day = 11:11

    minX = 1391;
    maxX = 1690;
    minY = 891;
    maxY = 1190;

    for time = 9:16

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
          saveas(fig, ['./sample_300x300_2/', filename ,'.jpg']);
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


      % 이미지 파일 저장 %
      fprintf('    save image in local ... \n\n')
      filename = sprintf('23-10-%d_%d15', day, time);
      saveas(fig, ['./sample_300x300_2/', filename ,'.jpg']);


      fprintf('end  23.10.%d / %d:15 ... \n',day, time)
      disp('-------------------------------------------------')

    end

end