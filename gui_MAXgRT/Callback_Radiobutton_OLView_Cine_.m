function Callback_Radiobutton_OLView_Cine_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

if strcmp(src.Tag, 'Tumor')
    hRB = data.Panel.OLView_Cine.Comp.Radiobutton.OLView_Cine(1);
    if hRB.Value
%         if ~data.bCineTumorOLDone
%             % Calculate TumorOL
%             CineTumorOL = fun_getCineTumorOL(data.cine);
%             for n = 1:length(CineTumorOL)
%                 data.cine(n).TumorOL = CineTumorOL{n};
%             end
%             data.bCineTumorOLDone = 1;
%             guidata(hFig, data);
%         end
        % TumorOL on
        for n = 1:1
            h = data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView;
            if isfield(data.cine(n).Tumor, 'OL')
                h.CData(:, :, 1) = data.cine(n).Tumor.OL;
                h.AlphaData = rescale(data.cine(n).Tumor.OL);
                h.Visible = 'on';
            end
        end
    else
        % TumorOL off
        for n = 1:1
            data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView.Visible = 'off';
        end
    end
elseif strcmp(src.Tag, 'Diaphragm')
    hRB = data.Panel.OLView_Cine.Comp.Radiobutton.OLView_Cine(2);
    if hRB.Value
        n = 1;
%         data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgSnake.Visible = 'on';
        data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView.Visible = 'on';
    else
        n = 1;
        data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView.Visible = 'off';
    end
elseif strcmp(src.Tag, 'Ab')
    hRB = data.Panel.OLView_Cine.Comp.Radiobutton.OLView_Cine(3);
    if hRB.Value
        n = 1;
        data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView.Visible = 'on';
    else
        n = 1;
        data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView.Visible = 'off';
    end
end

% if src.Value
%     hRB.Value = 0;
% else
%     hRB.Value = 1;
% end

% if data.Panel.Selection.Comp.Radiobutton.Diaphragm.Value
%     data.Panel.Body.hPanel.Visible = 'off';
%     data.Panel.Snake.hPanel.Visible = 'on';
%     data.Panel.Point.hPanel.Visible = 'on';
% 
%     data.Panel.View.Comp.hPlotObj.AbRect.Visible = 'off';
%     data.Panel.View.Comp.hPlotObj.AbRectCLine.Visible = 'off';
% 
% %     data.Panel.View.Comp.hPlotObj.AbRect.Visible = 'off';
% %     data.Panel.View.Comp.hPlotObj.AbRectCLine.Visible = 'off';
% else
%     data.Panel.Snake.hPanel.Visible = 'off';
%     data.Panel.Point.hPanel.Visible = 'off';
%     data.Panel.Body.hPanel.Visible = 'on';
%     
% %     data.Panel.View.Comp.hPlotObj.AbRect.Visible = 'on';
% %     data.Panel.View.Comp.hPlotObj.AbRectCLine.Visible = 'on';
% end    
% 
%     
%     % check previously saved contours
% %     [~, fn1, ~] = fileparts(matFile);
% %     ffn_snakes = fullfile(dataPath, [fn1, '_Snake.mat']);
% %     data.FileInfo.ffn_AbsContour = ffn_Abs;
% 
% %  ViewRay/Cine
% if strcmp(data.bMode, 'V')
%     if exist(data.FileInfo.ffn_AbsContour, 'file')
%         data.Panel.Body.Comp.Pushbutton.LoadContour.Enable = 'on';
%     end
% else
%     data.Panel.Point.hPanel.Visible = 'off';
%     
% end

