function showAllContours(hPlotObj, cineData, iSlice, bShow)

% Tumor
if bShow(1)
    if iSlice > length(cineData.Tumor.Snakes)
        S = [];
    else
        S = cineData.Tumor;
    end
    showContour(iSlice, S, hPlotObj.Tumor)
end

% Snake
if bShow(2)
    if iSlice > length(cineData.Snake.Snakes)
        S = [];
    else
        S = cineData.Snake;
    end
    showContour(iSlice, S, hPlotObj.Snake)
end

% Ab
if bShow(3)
    if iSlice > length(cineData.Ab.Snakes)
        S = [];
    else
        S = cineData.Ab;
    end
    showContour(iSlice, S, hPlotObj.Ab)
end

end
 
 function showContour(iSlice, S, hPlotObj)
 
 if isempty(S)
     set(hPlotObj, 'XData', [], 'YData', []);
 else
    C = S.Snakes{iSlice};
    if isempty(C)
        set(hPlotObj, 'XData', [], 'YData', []);
    else
        set(hPlotObj, 'XData', C(:, 1), 'YData', C(:, 2));
%         CLR = sscanf(S.CLR, '%2x%2x%2x', [1 3])/255;
        junk = [S.CLR(1) S.CLR(4:9)];
        CLR = validatecolor(junk);
        set(hPlotObj, 'Color',  CLR);
    end
 end
 end