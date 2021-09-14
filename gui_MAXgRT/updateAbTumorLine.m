function     updateAbTumorLine(hPlotObj, cineData, iSlice)

TC =  cineData.Tumor.Cent;  % Tumor Center
hL = hPlotObj.MarkLines.AbTumorLine;

if iSlice <= size(TC, 1)

    pos = hPlotObj.MarkLines.AbMarkLine.Position;
    yq = pos(1,2);
    S = cineData.Ab.Snakes{iSlice};
    if ~isempty(S)
        xx = S(:, 1);
        yy = S(:, 2);
        [yu, ia, ~] = unique(yy);
        xu = xx(ia);
        xq = interp1(yu, xu, yq);
        
        junk = [TC(iSlice, 1) TC(iSlice, 2)
                    xq yq];
        
        hL.Position = junk;
        hL.Visible = 'on';
        
        dx = abs(diff(hL.Position(:, 1)));
        dy = abs(diff(hL.Position(:, 2)));
        hL.Label = ['dX = ', num2str(dx, '%.1f'), ',  dY = ', num2str(dy, '%.1f')];
        
    end
else
        hL.Visible = 'off';
end