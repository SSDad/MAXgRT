function Callback_Cine_Radiobutton_TumorCheckBox_(src, evnt)

global hFig
data = guidata(hFig);

TagNo = str2num(src.Tag(1));
n = str2num(src.Tag(2));

if src.Value
    data.cine.Measure(TagNo).hPlotObj.Tumor(n).Visible = 'on';
    data.cine.Measure(TagNo).hPlotObj.TumorRect(n).Visible = 'on';
    data.cine.Measure(TagNo).hAxis.Tumor(n).Visible = 'on';
    axis(data.cine.Measure(TagNo).hAxis.Tumor(n));
else
    data.cine.Measure(TagNo).hPlotObj.Tumor(n).Visible = 'off';
    data.cine.Measure(TagNo).hPlotObj.TumorRect(n).Visible = 'off';
    data.cine.Measure(TagNo).hAxis.Tumor(n).Visible = 'off';
end