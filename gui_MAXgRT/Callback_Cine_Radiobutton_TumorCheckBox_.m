function Callback_Cine_Radiobutton_TumorCheckBox_(src, evnt)

global hFig
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;

if strcmp(src.Tag, 'Horizontal')
    n = 1;
else
    n = 2;
end

if src.Value
    data.cine.Measure(TagNo).hPlotObj.Tumor(n).Visible = 'on';
else
    data.cine.Measure(TagNo).hPlotObj.Tumor(n).Visible = 'off';
end