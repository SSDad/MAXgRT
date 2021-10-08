function figCloseReq_Cine_Measure(src, evnt)

global hFig
% hFig = ancestor(src, 'Figure');
data = guidata(hFig);

data.cine.Panel.Measure.Comp.Radiobutton.Measure(1).Value = 0;
data.cine.Measure.hFig.Visible = 'off';

TagNo = 1;
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'off';

% mark patch off
data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkPatch.Visible = 'off';
data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkPatch.Visible = 'off';

data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'off';

% Distance off
data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'off';

data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'off';
data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value = 0;
data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'off';

data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'off';