clc;

hour = 9;
min = 15;
imagename = sprintf('%d%d.png', hour, min);
I = imread(imagename);
imshow(I)

roi = drawrectangle('Color','r');
addlistener(roi,'MovingROI',@allevents);
addlistener(roi,'ROIMoved',@allevents);

while(true)
    prompt = input('select area [y] \n\n', "s");
    if strcmp(prompt,'y')
        break;
    end
end


mask = createMask(roi);
invert_mask = not(mask);

imwrite(invert_mask, "newMask.tif", "tif")



function allevents(src,evt)
    evname = evt.EventName;
    switch(evname)
        case{'MovingROI'}
            disp(['ROI moving previous position: ' mat2str(evt.PreviousPosition)]);
            disp(['ROI moving current position: ' mat2str(evt.CurrentPosition)]);
        case{'ROIMoved'}
            disp(['ROI moved previous position: ' mat2str(evt.PreviousPosition)]);
            disp(['ROI moved current position: ' mat2str(evt.CurrentPosition)]);
    end
end