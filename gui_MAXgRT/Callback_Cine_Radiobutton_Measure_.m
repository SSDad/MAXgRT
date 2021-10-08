function Callback_Cine_Radiobutton_Measure_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
TagNo = 1;
if strcmp(src.Tag, 'Wave')
        hRB = data.cine.Panel.Measure.Comp.Radiobutton.Measure(1);
        if hRB.Value
            if isfield(data.cine, 'Measure')
                if ishandle(data.cine.Measure.hFig)
                    data.cine.Measure.hFig.Visible = 'on';
                    data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'on';
                    data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'on';

                    data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'on';
                else
                    data.cine.Measure.hFig.Visible = 'off';
                end
            else
                createFig_Cine_Measure(TagNo);
                data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'on';
            end
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkPatch.Visible = 'on';
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkPatch.Visible = 'on';

            data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'on';
%             data.Panel.Measure.Comp.Text.NoP.Visible = 'on';
            data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'on';
        else
            data.cine.Measure.hFig.Visible = 'off';
            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'off';
            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'off';

            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'off';
            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'off';
            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'off';
            data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value = 0;
            data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'off';

            data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'off';

            data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'off';
%             data.Panel.Measure.Comp.Text.NoP.Visible = 'off';
            
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkPatch.Visible = 'off';
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkPatch.Visible = 'off';
            
        end
end

if strcmp(src.Tag, 'Distance')
        hRB = data.cine.Panel.Measure.Comp.Radiobutton.Measure(2);
        if hRB.Value
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'on';
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'on';
            
            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'on';
            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'on';
        else
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
            data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'off';

            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'off';
            data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'off';
        end
end
