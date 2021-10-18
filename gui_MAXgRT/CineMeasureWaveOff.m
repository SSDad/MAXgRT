function CineMeasureWaveOff(data, TagNo)

data.cine.Measure(TagNo).hFig.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.SnakeMarkLine.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.AbMarkLine.Visible = 'off';

data.cine.hPlotObj(TagNo).MarkLines.AbTumorLine.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.AbTumorText.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorLine.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorText.Visible = 'off';
data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value = 0;
data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'off';

data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'off';
data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'off';

data.cine.hPlotObj(TagNo).MarkLines.AbMarkPatch.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.SnakeMarkPatch.Visible = 'off';
