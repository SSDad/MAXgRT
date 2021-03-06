 function Callback_Cine_Edit_Measure_NoP(src, evnt)

global hFig 
data = guidata(hFig);

%% update Patch
TagNo = data.cine.ActiveTagNo;
nA = str2double(src.String);

if TagNo < 3
    LV = TagNo;
else
    LV = [3 4];
end

for iV = LV
    % Ab
    if ismember(iV, [1 3])
        hP = data.cine.hPlotObj(iV).MarkLines.AbMarkPatch;
        y4 = hP.YData;
        yL = data.cine.data(iV).dy*nA;
        yp = (y4(2)+y4(3))/2;
        y4 = [yp-yL yp-yL yp+yL yp+yL];
        hP.YData = y4;

        updateAbMarkWave_Cine(iV, yp, data.cine.data(iV).Ab.Snakes);
    end
    % Snake
    hP = data.cine.hPlotObj(iV).MarkLines.SnakeMarkPatch;
    xL = data.cine.data(iV).dx*nA;
    x4 = hP.XData;
    xp = (x4(2)+x4(3))/2;
    x4 = [xp-xL xp-xL xp+xL xp+xL];
    hP.XData = x4;

    updateSnakeMarkWave_Cine(iV, xp, data.cine.data(iV).Snake.Snakes);

end