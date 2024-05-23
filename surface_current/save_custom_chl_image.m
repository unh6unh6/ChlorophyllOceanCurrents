clc;


for day = 11:11
    for time = 11:11

      fprintf('start  23.10.%d / %d:15 ... \n\n',day, time)



      fprintf('    build matrix ... \n\n')
      filename = sprintf('C:/Users/민경윤/Documents/MATLAB/23.10.%d/%d15.nc',day, time);
      chl_image = ncread(filename, '/geophysical_data/Chl');
      chl_image = rot90(chl_image);

      chl_image = chl_image(2071:2570, 271:770);
      %chl_image(2071:2570, 271:770) = 0;


      mean_val = mean(chl_image(:), 'omitnan')
      min_val = min(chl_image(:))
      max_val = max(chl_image(:))

      % plot Chl image %
      fprintf('    plot Chl image ... \n\n')
      hold on; 
      fig = figure('Visible','on');
      pcolor(chl_image); 
      clim([0 3.5]); 
      shading flat;
      axis off;

  


      % 이미지 파일 저장 %
      fprintf('    save image in local ... \n\n')
      filename = sprintf('23-10-%d_%d15', day, time);
      %saveas(fig, ['./sample/', filename ,'.jpg']);


      fprintf('end  23.10.%d / %d:15 ... \n',day, time)
      disp('-------------------------------------------------')

    end

end