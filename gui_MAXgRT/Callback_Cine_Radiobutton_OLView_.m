function Callback_Cine_Radiobutton_OLView_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

if strcmp(src.Tag, 'Tumor')
    hRB = data.cine.Panel.OLView.Comp.Radiobutton.OLView(1);
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
            h = data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView;
            if isfield(data.cine.data(n).Tumor, 'OL')
                h.CData(:, :, 1) = data.cine.data(n).Tumor.OL;
                h.AlphaData = rescale(data.cine.data(n).Tumor.OL);
                h.Visible = 'on';
            end
        end
    else
        % TumorOL off
        for n = 1:1
            data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.TumorOLView.Visible = 'off';
        end
    end
elseif strcmp(src.Tag, 'Diaphragm')
    hRB = data.cine.Panel.OLView.Comp.Radiobutton.OLView(2);
    if hRB.Value
        n = 1;
%         data.Panel.View_Cine.subPanel(n).ssPanel(3).Comp.hPlotObj.hgSnake.Visible = 'on';
        data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView.Visible = 'on';
    else
        n = 1;
        data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.DiaphragmOLView.Visible = 'off';
    end
elseif strcmp(src.Tag, 'Ab')
    hRB = data.cine.Panel.OLView.Comp.Radiobutton.OLView(3);
    if hRB.Value
        n = 1;
        data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView.Visible = 'on';
    else
        n = 1;
        data.cine.Panel.View.subPanel(n).ssPanel(3).Comp.hPlotObj.AbOLView.Visible = 'off';
    end
end

