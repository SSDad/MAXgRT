function figCloseReq_Cine_Measure(src, evnt)

global hFig
% hFig = ancestor(src, 'Figure');
data = guidata(hFig);
Tag = data.cine.ActiveTagNo;

data.cine.Panel.Measure.Comp.Radiobutton.Measure(1).Value = 0;
data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'off';

if Tag < 3
    LV = Tag;
else
    LV = [3 4];
end

for TagNo = LV
    data.cine.Measure(TagNo).hFig.Visible = 'off';
    data.cine.hPlotObj(TagNo).MarkLines.SnakeMarkLine.Visible = 'off';
    data.cine.hPlotObj(TagNo).MarkLines.AbMarkLine.Visible = 'off';

    % mark patch off
    data.cine.hPlotObj(TagNo).MarkLines.AbMarkPatch.Visible = 'off';
    data.cine.hPlotObj(TagNo).MarkLines.SnakeMarkPatch.Visible = 'off';
end

% Distance off
data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'off';

data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'off';
data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value = 0;
data.cine.hPlotObj(TagNo).MarkLines.AbTumorLine.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.AbTumorText.Visible = 'off';

data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorLine.Visible = 'off';
data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorText.Visible = 'off';