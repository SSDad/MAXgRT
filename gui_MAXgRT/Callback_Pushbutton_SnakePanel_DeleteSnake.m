function Callback_Pushbutton_SnakePanel_DeleteSnake(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hPlotObj = data.Panel.View.Comp.hPlotObj;

iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
data.Snake.Snakes{iSlice} = [];
hPlotObj.Snake.YData = [];
hPlotObj.Snake.XData = [];

% points
if data.Point.InitDone
    data.Point.Data.yi(iSlice, :) = NaN;
    
    hPlotObj.Point.XData = [];
    hPlotObj.Point.YData = [];
    hPlotObj.LeftPoints.XData = [];
    hPlotObj.LeftPoints.YData = [];
    hPlotObj.RightPoints.XData = [];
    hPlotObj.RightPoints.YData = [];

    guidata(hFig, data)
    updatePlotPoint
end

guidata(hFig, data)