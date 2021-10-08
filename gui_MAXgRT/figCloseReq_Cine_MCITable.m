function figCloseReq_MCITable_Cine(src, evnt)

global hFig
% hFig = ancestor(src, 'Figure');
data = guidata(hFig);

data.Panel.MCI_Cine.Comp.Radiobutton.MCI_Cine(1).Value = 0;
data.MCI_Cine.hFig.Visible = 'off';

% TagNo = 1;
% data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'off';
% data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'off';
% 
% % Distance off
% data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(2).Enable = 'off';
% data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(2).Value = 0;
% data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
% data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'off';
% 
% data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'off';
% data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'off';

