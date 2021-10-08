function Callback_Cine_Radiobutton_DACheckBox_(src, evnt)

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
        data.cine.Measure.hPlotObj.DA(n).Visible = 'on';
    else
        data.cine.Measure.hPlotObj.DA(n).Visible = 'off';
    end
else
    if ~src.Value
        data.cine.Measure.hAxis.DA(2).YDir = 'normal';
    else
        data.cine.Measure.hAxis.DA(2).YDir = 'reverse';
    end
end