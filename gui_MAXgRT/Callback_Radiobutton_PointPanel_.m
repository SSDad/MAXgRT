function Callback_Radiobutton_PointPanel_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

if strcmp(src.Tag, 'Dome')
    hRB = data.Panel.Point.Comp.Radiobutton.Tumor;
else
    hRB = data.Panel.Point.Comp.Radiobutton.Dome;
end

if src.Value
    hRB.Value = 0;
else
    hRB.Value = 1;
end