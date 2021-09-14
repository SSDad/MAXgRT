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
h.SnakeMarkLine = images.roi.Line(hA, 'Position',[x1 y1; x2 y2], 'Color', 'g', 'LineWidth', 1,...
    'UserData', cineData.Snake.Snakes, 'Tag', 'SnakeMarkLine', 'InteractionsAllowed', 'translate', 'Visible', 'off');
addlistener(h.SnakeMarkLine, 'MovingROI', @Callback_Cine_SnakeMarkLine);


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

x1 = xc - xr;
x2 = xc + xr;
y1 = yc;
y2 = yc;
h.AbMarkLine = images.roi.Line(hA, 'Position',[x1 y1; x2 y2], 'Color', 'c', 'LineWidth', 1,...
   'UserData', cineData.Ab.Snakes, 'Tag', 'AbMarkLine', 'InteractionsAllowed', 'translate', 'Visible', 'off');
addlistener(h.AbMarkLine, 'MovingROI', @Callback_Cine_AbMarkLine);

h.AbTumorLine = images.roi.Line(hA, 'Position',[0 0; 0 0], 'Color', 'y', 'LineWidth', 1,...
   'UserData', cineData.Ab.Snakes,  'Label', 'AbTumor', 'Tag', 'AbTumorLine', 'InteractionsAllowed', 'none', 'Visible', 'off');
% addlistener(h.TumorLine, 'MovingROI', @Callback_Cine_AbMarkLine);