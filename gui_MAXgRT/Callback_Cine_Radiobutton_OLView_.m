function Callback_Cine_Radiobutton_OLView_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
Tag = data.cine.ActiveTagNo;

TagN = Tag;
if Tag ==3
    TagN = [3 4];
end

for TagNo = TagN
if strcmp(src.Tag, 'Tumor')
    hRB = data.cine.Panel.OLView.Comp.Radiobutton.OLView(1);
    if hRB.Value
        h = data.cine.hPlotObj(TagNo).TumorOLView;
        if isfield(data.cine.data(TagNo).Tumor, 'OL')
            ovSum = data.cine.data(TagNo).Tumor.OLSum;
            h.CData(:, :, 1) = ovSum;
            h.AlphaData = rescale(ovSum);
            h.Visible = 'on';
%             hTM = data.cine.Panel.Measure.Comp.Togglebutton.TumorMargin;
            hTM = data.cine.Panel.Measure.Comp.Radiobutton.Measure(3);
            hTM.Enable = 'on'; % tumor margin on
            
            hCB = data.cine.Measure(TagNo).TumorCheckBox;
            if hCB(1).Value ~= hCB(2).Value
                if hCB(1).Value
                    iR = 1;
                elseif hCB(2).Value
                    iR = 2;
                end
                data.cine.Measure(TagNo).hPlotObj.TumorRect(iR).Visible = 'on';
                updateTumorOLandDADot(data.cine.Measure(TagNo).hPlotObj.TumorRect(iR));
            else
                updateTumorOLAlpha(TagNo);
            end
        end
    else    % TumorOL off
        data.cine.hPlotObj(TagNo).TumorOLView.Visible = 'off';
        for iT = 1:2
            data.cine.Measure(TagNo).hPlotObj.TumorRect(iT).Visible = 'off';
        end
        % wave dot
        hg = data.cine.Measure(TagNo).hPlotObj.DADot(1);
        for id = 1:length(hg.Children)
            hg.Children(id).MarkerFaceColor = [0 0 0];
        end
        if TagNo == 1 | TagNo == 3
            hg = data.cine.Measure(TagNo).hPlotObj.DADot(2);
            for id = 1:length(hg.Children)
                hg.Children(id).MarkerFaceColor = [0 0 0];
            end
        end
        
        % tumor margin/dITV  off
        for ib = 3:4
            hTM = data.cine.Panel.Measure.Comp.Radiobutton.Measure(ib);
            hTM.Value = 0;
            hTM.Enable = 'off'; 
        end
      
    end
elseif strcmp(src.Tag, 'Diaphragm')
    hRB = data.cine.Panel.OLView.Comp.Radiobutton.OLView(2);
    if hRB.Value
        data.cine.hPlotObj(TagNo).DiaphragmOLView.Visible = 'on';
    else
        data.cine.hPlotObj(TagNo).DiaphragmOLView.Visible = 'off';
    end
elseif strcmp(src.Tag, 'Ab')
    hRB = data.cine.Panel.OLView.Comp.Radiobutton.OLView(3);
    if hRB.Value
        data.cine.hPlotObj(TagNo).AbOLView.Visible = 'on';
    else
        data.cine.hPlotObj(TagNo).AbOLView.Visible = 'off';
    end
end
end
