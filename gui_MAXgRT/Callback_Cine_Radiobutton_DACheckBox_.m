function Callback_Cine_Radiobutton_DACheckBox_(src, evnt)

global hFig
data = guidata(hFig);

TagNo = str2num(src.Tag(1));
n = str2num(src.Tag(2));

if n~=3
    hg = data.cine.Measure(TagNo).hPlotObj.DADot(n);
    if src.Value
        data.cine.Measure(TagNo).hPlotObj.DA(n).Visible = 'on';
        hg.Visible = 'on';  % dots on
    else
        data.cine.Measure(TagNo).hPlotObj.DA(n).Visible = 'off';
        hg.Visible = 'off';        % dots off
    end
else
    if ~src.Value
        data.cine.Measure(TagNo).hAxis.DA(2).YDir = 'normal';
    else
        data.cine.Measure(TagNo).hAxis.DA(2).YDir = 'reverse';
    end
end