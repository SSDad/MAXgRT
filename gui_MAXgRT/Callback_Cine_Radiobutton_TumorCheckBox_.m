function Callback_Cine_Radiobutton_TumorCheckBox_(src, evnt)

global hFig
data = guidata(hFig);

TagNo = str2num(src.Tag(1));
n = str2num(src.Tag(2));

if src.Value
    data.cine.Measure(TagNo).hPlotObj.Tumor(n).Visible = 'on';
    data.cine.Measure(TagNo).hAxis.Tumor(n).Visible = 'on';
    
    if data.cine.Measure(TagNo).TumorCheckBox(1).Value && data.cine.Measure(TagNo).TumorCheckBox(2).Value
        data.cine.Measure(TagNo).hPlotObj.TumorRect(1).Visible = 'off';
        data.cine.Measure(TagNo).hPlotObj.TumorRect(2).Visible = 'off';
    elseif (n==1 &&  ~data.cine.Measure(TagNo).TumorCheckBox(2).Value) |...
            (n==2 &&  ~data.cine.Measure(TagNo).TumorCheckBox(1).Value)
        if data.cine.Panel.OLView.Comp.Radiobutton.OLView(1).Value
            data.cine.Measure(TagNo).hPlotObj.TumorRect(n).Visible = 'on';
            updateTumorOLandDADot( data.cine.Measure(TagNo).hPlotObj.TumorRect(n));
        end
    end
    axis(data.cine.Measure(TagNo).hAxis.Tumor(n));
else
    data.cine.Measure(TagNo).hPlotObj.Tumor(n).Visible = 'off';
    data.cine.Measure(TagNo).hAxis.Tumor(n).Visible = 'off';
    data.cine.Measure(TagNo).hPlotObj.TumorRect(n).Visible = 'off';

    if data.cine.Panel.OLView.Comp.Radiobutton.OLView(1).Value
        iR = [];
        if n == 1 &&  data.cine.Measure(TagNo).TumorCheckBox(2).Value
            iR = 2;
        elseif n == 2 &&  data.cine.Measure(TagNo).TumorCheckBox(1).Value
            iR = 1;
        end
        if ~isempty(iR)
            data.cine.Measure(TagNo).hPlotObj.TumorRect(iR).Visible = 'on';
            updateTumorOLandDADot(data.cine.Measure(TagNo).hPlotObj.TumorRect(iR));
        end
    end    
end

% all dots off
if data.cine.Measure(TagNo).TumorCheckBox(1).Value == data.cine.Measure(TagNo).TumorCheckBox(2).Value
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
end
