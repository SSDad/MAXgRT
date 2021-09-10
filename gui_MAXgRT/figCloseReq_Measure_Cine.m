function figCloseReq_Measure_Cine(src, evnt)

global hFig
% hFig = ancestor(src, 'Figure');
data = guidata(hFig);

data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(1).Value = 0;
data.Measure_Cine.hFig.Visible = 'off';

TagNo = 1;
data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'off';

