function     updateAbTumorLine(hPlotObj, cineData, iSlice)

TC =  cineData.Tumor.Cent;  % Tumor Center

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
        hPlotObj.MarkLines.AbTumorLine.Position = junk;
        hPlotObj.MarkLines.AbTumorLine.Visible = 'on';
    end
else
        hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
end