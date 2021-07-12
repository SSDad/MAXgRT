function Callback_Pushbutton_PointPanel_MeasurementPlot(src, evnt)

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

if ~data.ActiveAxis.MovePoints
    axes(data2.Panel.View.Comp.hAxis.PlotPoint)
end

hFig2.Visible = 'on';