clc;


for day = 11:11
    for time = 8:14

      fprintf('start  23.10.%d / %d:15 ... \n\n',day, time)



      fprintf('    build matrix ... \n\n')
      filename = sprintf('C:/Users/민경윤/Documents/MATLAB/23.10.%d/%d15.nc',day, time);
      chl_image = ncread(filename, '/geophysical_data/Chl');
      chl_image = rot90(chl_image);

      % plot Chl image %
      fprintf('    plot Chl image ... \n\n')
      hold on; 
      fig = figure('Visible','off'); % 파일 저장을 위해 Visible off %
      pcolor(chl_image); 
      caxis([0 3]); 
      shading flat;
      axis off;


      % 이미지 파일 저장 %
      fprintf('    save image in local ... \n\n')
      saveas(fig, sprintf('%d15.png', time));


      fprintf('end  23.10.%d / %d:15 ... \n',day, time)
      disp('-------------------------------------------------')

    end
end