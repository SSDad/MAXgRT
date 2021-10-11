function Callback_Cine_Pushbutton_ZoomButton_(src, evnt)

global bZoomSelect

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

TagNo = str2num(src.Tag);
hPanel = data.cine.Panel.View.subPanel(TagNo).hPanel;
if hPanel.Position(4) < 1
    for n = 1:3
        data.cine.Panel.View.subPanel(n).hPanel.Visible = 'off';
    end
    hPanel.Position = [0 0 1 1];
    hPanel.Visible = 'on';

%     % Snake panel on
%     data.Panel.Selection.hPanel.Visible = 'on';

%     if strcmp(bZoomSelect, 'B')
%         data.Panel.Selection.Comp.Radiobutton.Diaphragm.Value = 0;
%         data.Panel.Selection.Comp.Radiobutton.Body.Value = 1;
% 
%         data.Panel.Body.hPanel.Visible = 'on';
%         data.Panel.Snake.hPanel.Visible = 'off';
%     else
%         data.Panel.Selection.Comp.Radiobutton.Diaphragm.Value = 1;
%         data.Panel.Selection.Comp.Radiobutton.Body.Value = 0;
%         data.Panel.Body.hPanel.Visible = 'off';
%         data.Panel.Snake.hPanel.Visible = 'on';
%     end
    
    data.cine.ActiveTagNo = TagNo;
    
    if data.cine.data(TagNo).bContourLoaded
        data.cine.Panel.OLView.hPanel.Visible = 'on';
        data.cine.Panel.OLView.Comp.Radiobutton.OLView(3).Visible = 'on';
        if TagNo == 2
            data.cine.Panel.OLView.Comp.Radiobutton.OLView(3).Visible = 'off';
        end
        
        data.cine.Panel.Measure.hPanel.Visible = 'on';
    end
%     data.Panel.Snake.Comp.Edit.StartSlice.String = '1';
%     data.Panel.Snake.Comp.Edit.EndSlice.String = num2str(data.cine.data(TagNo).nSlice);
   
else
    x = [0 0.5 0];
    y = [0.5 0.5 0];
    w = [.5 .5 1];
    h = .5;
    for n = 1:3
        data.cine.Panel.View.subPanel(n).hPanel.Position = [x(n) y(n) w(n) h];
        data.cine.Panel.View.subPanel(n).hPanel.Visible = 'on';
    end
    
    % panel off
%     data.Panel.Selection.hPanel.Visible = 'off';
%     data.Panel.Snake.hPanel.Visible = 'off';
%     data.Panel.Body.hPanel.Visible = 'off';
    
    % OL off
    for m = 1:3
        data.cine.Panel.OLView.Comp.Radiobutton.OLView(m).Value = 0;
    end
    data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.TumorOLView.Visible = 'off';
    data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.DiaphragmOLView.Visible = 'off';
    if TagNo == 1
        data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.DiaphragmOLView.Visible = 'off';
    end
    
    %  Measure off
    data.cine.Panel.Measure.Comp.Radiobutton.Measure(1).Value = 0;
    CineMeasureWaveOff(data, TagNo)


    data.cine.Panel.OLView.hPanel.Visible = 'off';
    data.cine.Panel.Measure.hPanel.Visible = 'off';

    data.cine.ActiveTagNo = 0;
end

%% all off
% data.Panel.Selection.hPanel.Visible = 'off';
% data.Panel.Body.hPanel.Visible = 'off';
% data.Panel.Snake.hPanel.Visible = 'off';

guidata(hFig, data);