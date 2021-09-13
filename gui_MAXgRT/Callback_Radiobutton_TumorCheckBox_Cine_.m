function Callback_Radiobutton_TumorCheckBox_Cine_(src, evnt)

global hFig
data = guidata(hFig);

if strcmp(src.Tag, 'Horizontal')
    n = 1;
else
    n = 2;
end

if src.Value
    data.Measure_Cine.hPlotObj.Tumor(n).Visible = 'on';
else
    data.Measure_Cine.hPlotObj.Tumor(n).Visible = 'off';
end