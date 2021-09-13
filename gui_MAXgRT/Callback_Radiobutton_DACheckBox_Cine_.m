function Callback_Radiobutton_DACheckBox_Cine_(src, evnt)

global hFig
data = guidata(hFig);

if strcmp(src.Tag, 'Diaphragm')
    n = 1;
else
    n = 2;
end

if src.Value
    data.Measure_Cine.hPlotObj.DA(n).Visible = 'on';
else
    data.Measure_Cine.hPlotObj.DA(n).Visible = 'off';
end