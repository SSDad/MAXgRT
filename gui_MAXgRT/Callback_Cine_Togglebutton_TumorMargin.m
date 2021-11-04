function Callback_Cine_Togglebutton_TumorMargin_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;

hPlotObj = data.cine.hPlotObj(TagNo);
cineData = data.cine.data(TagNo);
ovAlpha = cineData.Tumor.ovAlpha;
iSlice = data.cine.data(TagNo).iSlice;

if src.Value
    src.String = 'Tumor Margin off';
    src.ForegroundColor =  'r';
    showTumorMargin(hPlotObj, cineData, iSlice);
else
    src.String = 'Tumor Margin on';
    src.ForegroundColor =  'g';
    hPlotObj.TumorOLView.AlphaData = ovAlpha;
end

% if strcmp(src.Tag, 'Wave')
%         hRB = data.cine.Panel.Measure.Comp.Radiobutton.Measure(1);
%         if hRB.Value
%             data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Enable = 'on';
%             data.cine.Panel.Measure.Comp.Edit.NoP.Enable = 'on';
%             data.cine.Panel.Measure.Comp.Pushbutton.SavePDF.Enable = 'on';
% 
%             if TagNo < 3
%                 LV = TagNo;
%             else
%                 LV = [3 4];
%             end
%             for iV = LV
%                 data.cine.Measure(iV).hFig.Visible = 'on';
%                 data.cine.hPlotObj(iV).MarkLines.SnakeMarkLine.Visible = 'on';
%                 data.cine.hPlotObj(iV).MarkLines.SnakeMarkPatch.Visible = 'on';
%             end
% 
%             if  ismember(TagNo, [1 3]) 
%                 data.cine.hPlotObj(TagNo).MarkLines.AbMarkPatch.Visible = 'on';
%                 data.cine.hPlotObj(TagNo).MarkLines.AbMarkLine.Visible = 'on';
%             end
% 
%         else
%             CineMeasureWaveOff(data, TagNo)
%         end
% end
% 
% if strcmp(src.Tag, 'Distance')
%         hRB = data.cine.Panel.Measure.Comp.Radiobutton.Measure(2);
% 
%         if TagNo < 3
%             LV = TagNo;
%         else
%             LV = [3 4];
%         end
%         
%         for iV = LV
%             if hRB.Value
%                 data.cine.hPlotObj(iV).MarkLines.AbTumorLine.Visible = 'on';
%                 data.cine.hPlotObj(iV).MarkLines.AbTumorText.Visible = 'on';
% 
%                 data.cine.hPlotObj(iV).MarkLines.SnakeTumorLine.Visible = 'on';
%                 data.cine.hPlotObj(iV).MarkLines.SnakeTumorText.Visible = 'on';
%             else
%                 data.cine.hPlotObj(iV).MarkLines.AbTumorLine.Visible = 'off';
%                 data.cine.hPlotObj(iV).MarkLines.AbTumorText.Visible = 'off';
% 
%                 data.cine.hPlotObj(iV).MarkLines.SnakeTumorLine.Visible = 'off';
%                 data.cine.hPlotObj(iV).MarkLines.SnakeTumorText.Visible = 'off';
%             end
%         end
% end
