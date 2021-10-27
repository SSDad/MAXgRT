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
            for iT = 1:2
                data.cine.Measure(TagNo).hPlotObj.TumorRect(iT).Visible = 'on';
            end
        end
    else    % TumorOL off
        data.cine.hPlotObj(TagNo).TumorOLView.Visible = 'off';
        for iT = 1:2
            data.cine.Measure(TagNo).hPlotObj.TumorRect(iT).Visible = 'off';
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
