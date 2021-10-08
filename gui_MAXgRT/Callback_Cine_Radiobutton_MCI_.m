function Callback_Radiobutton_MCI_Cine_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
TagNo = 1;
if strcmp(src.Tag, 'Table')
        hRB = data.Panel.MCI_Cine.Comp.Radiobutton.MCI_Cine(1);
        if hRB.Value
            if isfield(data, 'MCI_Cine')
                if ishandle(data.MCI_Cine.hFig)
                    data.MCI_Cine.hFig.Visible = 'on';
%                     data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'on';
%                     data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'on';
% 
%                     data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(2).Enable = 'on';
%                 else
%                     data.Measure_Cine.hFig.Visible = 'off';
                end
            else
                createFig_MCITable_Cine(TagNo);
%                 data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(2).Enable = 'on';
            end
        else
            data.MCI_Cine.hFig.Visible = 'off';
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkLine.Visible = 'off';
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkLine.Visible = 'off';
% 
%             data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
%             data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'off';
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'off';
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'off';
%             data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(2).Value = 0;
%             data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(2).Enable = 'off';
        end
end

% if strcmp(src.Tag, 'Distance')
%         hRB = data.Panel.Measure_Cine.Comp.Radiobutton.Measure_Cine(2);
%         if hRB.Value
%             data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'on';
%             data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'on';
%             
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'on';
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'on';
%         else
%             data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorLine.Visible = 'off';
%             data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbTumorText.Visible = 'off';
% 
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorLine.Visible = 'off';
%             data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeTumorText.Visible = 'off';
%         end
% end
