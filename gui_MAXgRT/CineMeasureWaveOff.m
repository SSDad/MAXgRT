function CineMeasureWaveOff(data, TagNo)

data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value = 0;
data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'off';
data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'off';
data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'off';

if TagNo < 3
    LV = TagNo;
else
    LV = [3 4];
end

for iV = LV
    data.cine.Measure(iV).hFig.Visible = 'off';
    data.cine.hPlotObj(iV).MarkLines.SnakeMarkLine.Visible = 'off';
    data.cine.hPlotObj(iV).MarkLines.SnakeTumorLine.Visible = 'off';
    data.cine.hPlotObj(iV).MarkLines.SnakeTumorText.Visible = 'off';
    data.cine.hPlotObj(iV).MarkLines.SnakeMarkPatch.Visible = 'off';
end

if  ismember(TagNo, [1 3])
    data.cine.hPlotObj(TagNo).MarkLines.AbMarkLine.Visible = 'off';
    data.cine.hPlotObj(TagNo).MarkLines.AbTumorLine.Visible = 'off';
    data.cine.hPlotObj(TagNo).MarkLines.AbTumorText.Visible = 'off';
    data.cine.hPlotObj(TagNo).MarkLines.AbMarkPatch.Visible = 'off';
end