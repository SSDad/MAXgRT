function Callback_Radiobutton_Measure_Cine_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
TagNo = 1;
if strcmp(src.Tag, 'Wave')
        hRB = data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(1);
        if hRB.Value
            if isfield(data, 'hFig_Measure_Cine')
                if ishandle(data.hFig_Measure_Cine)
                    data.Measure_Cine.hFig.Visible = 'on';
                    data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'on';
                    data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'on';
                else
                    data.Measure_Cine.hFig.Visible = 'off';
                end
            else
                createFig_Measure_Cine(TagNo);
            end
        else
            data.Measure_Cine.hFig.Visible = 'off';
            data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'off';
            data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'off';
        end
end
