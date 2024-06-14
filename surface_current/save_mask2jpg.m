% Load the MAT file
data = load('./상왕등도_data_fullscreen/interp/mask.mat');

% Extract the variable (assuming it is named 'maskiererx')
mask = data.maskiererx{1};

% Plot the mask
figure;
imshow(mask, []);
axis off;

% Save the mask as a JPG file
saveas(gcf, 'path_to_save/mask.jpg');
