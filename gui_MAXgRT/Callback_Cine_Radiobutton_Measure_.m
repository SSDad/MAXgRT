function Callback_Cine_Radiobutton_Measure_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;
if strcmp(src.Tag, 'Wave')
        hRB = data.cine.Panel.Measure.Comp.Radiobutton.Measure(1);
        if hRB.Value
            data.cine.Measure(TagNo).hFig.Visible = 'on';
            data.cine.hPlotObj(TagNo).MarkLines.SnakeMarkLine.Visible = 'on';
            data.cine.hPlotObj(TagNo).MarkLines.AbMarkLine.Visible = 'on';

            data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'on';
            data.cine.hPlotObj(TagNo).MarkLines.AbMarkPatch.Visible = 'on';
            data.cine.hPlotObj(TagNo).MarkLines.SnakeMarkPatch.Visible = 'on';

            data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'on';
%             data.Panel.Measure.Comp.Text.NoP.Visible = 'on';
            data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'on';
        else
            CineMeasureWaveOff(data, TagNo)
        end
end

if strcmp(src.Tag, 'Distance')
        hRB = data.cine.Panel.Measure.Comp.Radiobutton.Measure(2);
        if hRB.Value
            data.cine.hPlotObj(TagNo).MarkLines.AbTumorLine.Visible = 'on';
            data.cine.hPlotObj(TagNo).MarkLines.AbTumorText.Visible = 'on';
            
            data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorLine.Visible = 'on';
            data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorText.Visible = 'on';
        else
            data.cine.hPlotObj(TagNo).MarkLines.AbTumorLine.Visible = 'off';
            data.cine.hPlotObj(TagNo).MarkLines.AbTumorText.Visible = 'off';

            data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorLine.Visible = 'off';
            data.cine.hPlotObj(TagNo).MarkLines.SnakeTumorText.Visible = 'off';
        end
end
