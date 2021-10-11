function h = addMeasureMarks_Cine(hA, cineData, TagNo)

global SnakeMarkLinePos AbMarkLinePos

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
SnakeMarkLinePos(:, :, TagNo) = [x1 y1; x2 y2];
h.SnakeMarkLine = images.roi.Line(hA, 'Position', SnakeMarkLinePos(:, :, TagNo), 'Color', 'g', 'LineWidth', 1,...
    'UserData', cineData.Snake.Snakes, 'Tag', 'SnakeMarkLine', 'InteractionsAllowed', 'translate', 'Visible', 'off');
addlistener(h.SnakeMarkLine, 'MovingROI', @Callback_Cine_SnakeMarkLine);

h.SnakeTumorLine = images.roi.Line(hA, 'Position',[0 0; 0 0], 'Color', 'y', 'LineWidth', 1,...
   'UserData', cineData.Snake.Snakes,  'Label', '', 'Tag', 'SnakeTumorLine', 'InteractionsAllowed', 'none', 'Visible', 'off');

h.SnakeTumorText = text(hA, 'Position', [inf inf], 'String', ' ',...
    'Color', [1 1 1]*0.01, 'FontSize', 12, 'BackgroundColor', 'y', 'Visible', 'off');

y4 = [y1 y2 y2 y1];
xL = cineData.dx*10;
x4 = [xc-xL xc-xL xc+xL xc+xL];
h.SnakeMarkPatch = patch(hA, 'XData', x4, 'YData', y4,'FaceColor', 'red', 'FaceAlpha', 0.25, 'Visible', 'off');

%% Ab
if TagNo == 1
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
    AbMarkLinePos = [x1 y1; x2 y2];
    h.AbMarkLine = images.roi.Line(hA, 'Position', AbMarkLinePos, 'Color', 'c', 'LineWidth', 1,...
       'UserData', cineData.Ab.Snakes, 'Tag', 'AbMarkLine', 'InteractionsAllowed', 'translate', 'Visible', 'off');
    addlistener(h.AbMarkLine, 'MovingROI', @Callback_Cine_AbMarkLine);

    h.AbTumorLine = images.roi.Line(hA, 'Position',[0 0; 0 0], 'Color', 'y', 'LineWidth', 1,...
       'UserData', cineData.Ab.Snakes,  'Label', '', 'Tag', 'AbTumorLine', 'InteractionsAllowed', 'none', 'Visible', 'off');
    % addlistener(h.TumorLine, 'MovingROI', @Callback_Cine_AbMarkLine);

    h.AbTumorText = text(hA, 'Position', [inf inf], 'String', ' ',...
        'Color', [1 1 1]*0.01, 'FontSize', 12, 'BackgroundColor', 'y', 'Visible', 'off');

    x4 = [x1 x2 x2 x1];
    yL = cineData.dy*10;
    y4 = [yc-yL yc-yL yc+yL yc+yL];
    h.AbMarkPatch = patch(hA, 'XData', x4, 'YData', y4,'FaceColor', 'red', 'FaceAlpha', 0.25, 'Visible', 'off');
end
