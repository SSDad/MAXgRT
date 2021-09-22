function     updateSnakeTumorLine(hPlotObj, cineData, iSlice, bDist)

TC =  cineData.Tumor.Cent;  % Tumor Center
hL = hPlotObj.MarkLines.SnakeTumorLine;
hT = hPlotObj.MarkLines.SnakeTumorText;

if iSlice <= size(TC, 1) && ~isnan(TC(iSlice, 1))

    pos = hPlotObj.MarkLines.SnakeMarkLine.Position;
    xq = pos(1,1);
    S = cineData.Snake.Snakes{iSlice};
    if ~isempty(S)
        xx = S(:, 1);
        yy = S(:, 2);
        [xu, ia, ~] = unique(xx);
        yu = yy(ia);
        yq = interp1(xu, yu, xq);
        
        junk = [TC(iSlice, 1) TC(iSlice, 2)
                    xq yq];
        hL.Position = junk;
        if bDist
            hL.Visible = 'on';
            hT.Visible = 'on';
        end
        
        dx = abs(diff(hL.Position(:, 1)));
        dy = abs(diff(hL.Position(:, 2)));
%         hL.Label = ['X = ', num2str(dx, '%.1f'), ',  dY = ', num2str(dy, '%.1f')];
        
        hT.Position = [xq+10 yq-20];
        hT.String = {['\DeltaX = ', num2str(dx, '%.1f')],...
                            ['\DeltaY = ', num2str(dy, '%.1f')], ...
                            ['D = ', num2str(sqrt(dx^2+dy^2), '%.1f')]};
        
    end
else
        hL.Visible = 'off';
        hT.Visible = 'off';
end