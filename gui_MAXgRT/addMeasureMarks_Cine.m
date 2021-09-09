function h = addMeasureMarks_Cine(hA, cineData)

%% snake
m = 0;
for n = 1:length(cineData.Snake.Snakes)
    S = cineData.Snake.Snakes{n};
    if ~isempty(S)
        m = m+1;
        xym(m, :) = mean(S);
        xyrange(m, :) = range(S);
    end
end

junk = mean(xym);
xc = junk(1);
yc = junk(2);

junk = max(xyrange);
xr = junk(1);
yr = junk(2);

x1 = xc;
x2 = xc;
y1 = yc - yr/2;
y2 = yc + yr/2;
h.SnakeMarkLine = images.roi.Line(hA, 'Position',[x1 y1; x2 y2], 'Color', 'c', 'LineWidth', 1,...
    'UserData', cineData.Snake, 'Tag', 'SnakeMarkLine', 'InteractionsAllowed', 'translate', 'Visible', 'on');
addlistener(h.SnakeMarkLine, 'MovingROI', @Callback_SnakeMarkLine_Cine);


%% Ab
m = 0;
for n = 1:length(cineData.Ab.Snakes)
    S = cineData.Ab.Snakes{n};
    if ~isempty(S)
        m = m+1;
        xym(m, :) = mean(S);
        xyrange(m, :) = range(S);
    end
end

junk = mean(xym);
xc = junk(1);
yc = junk(2);

junk = max(xyrange);
xr = junk(1);
yr = junk(2);

x1 = xc - xr/2;
x2 = xc + xr/2;
y1 = yc;
y2 = yc;
h.AbMarkLine = images.roi.Line(hA, 'Position',[x1 y1; x2 y2], 'Color', 'c',...
        'LineWidth', 1, 'Tag', 'AbMarkLine', 'InteractionsAllowed', 'translate', 'Visible', 'on');
%     addlistener(hPlotObj.AbRectCLine, 'MovingROI', @Callback_AbRectCLine);
