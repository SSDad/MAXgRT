function CineMeasureWaveOff(data, TagNo)

data.cine.Measure(TagNo).hFig.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'off';

data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'off';
data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value = 0;
data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'off';

data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'off';
data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'off';

data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkPatch.Visible = 'off';
data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkPatch.Visible = 'off';
