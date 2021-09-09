function figCloseReq_Measure_Cine(src, evnt)

global hFig
% hFig = ancestor(src, 'Figure');
data = guidata(hFig);

data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(1).Value = 0;
data.hFig_Measure_Cine.Visible = 'off';

