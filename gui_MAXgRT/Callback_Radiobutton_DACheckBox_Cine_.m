function Callback_Radiobutton_DACheckBox_Cine_(src, evnt)

global hFig
data = guidata(hFig);

if strcmp(src.Tag, 'Diaphragm')
    n = 1;
elseif strcmp(src.Tag, 'Abdomen')
    n = 2;
else
    n = 3;
end

if n~=3
    if src.Value
        data.Measure_Cine.hPlotObj.DA(n).Visible = 'on';
    else
        data.Measure_Cine.hPlotObj.DA(n).Visible = 'off';
    end
else
    if ~src.Value
        data.Measure_Cine.hAxis.DA(2).YDir = 'normal';
    else
        data.Measure_Cine.hAxis.DA(2).YDir = 'reverse';
    end
end