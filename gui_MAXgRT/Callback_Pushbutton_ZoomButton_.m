function Callback_Pushbutton_ZoomButton_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

TagNo = str2num(src.Tag);
hPanel = data.Panel.View_Cine.subPanel(TagNo).hPanel;
if hPanel.Position(4) < 1
    for n = 1:3
        data.Panel.View_Cine.subPanel(n).hPanel.Visible = 'off';
    end
    hPanel.Position = [0 0 1 1];
    hPanel.Visible = 'on';

    % Snake panel on
    data.Panel.Selection.hPanel.Visible = 'on';
    data.Panel.Snake.hPanel.Visible = 'on';
    
    data.CineActiveTagNo = TagNo;

    % enable buttons
    data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'on';
% %     data.Panel.Snake.Comp.Pushbutton.StartSlice.Enable = 'on';
% %     data.Panel.Snake.Comp.Pushbutton.EndSlice.Enable = 'on';
%     data.Panel.Snake.Comp.Edit.StartSlice.String = '1';
%     data.Panel.Snake.Comp.Edit.EndSlice.String = num2str(data.cine(TagNo).nSlice);
%     data.Panel.Snake.Comp.Edit.StartSlice.ForegroundColor = 'r';
%     data.Panel.Snake.Comp.Edit.EndSlice.ForegroundColor = 'r';

%     data.Panel.Body.Comp.Pushbutton.Contour.Enable = 'on';
%     data.Panel.Body.Comp.Togglebutton.Boundary.Enable = 'on';

    
else
    x = [0 0.5 0];
    y = [0.5 0.5 0];
    w = [.5 .5 1];
    h = .5;
    for n = 1:3
        data.Panel.View_Cine.subPanel(n).hPanel.Position = [x(n) y(n) w(n) h];
        data.Panel.View_Cine.subPanel(n).hPanel.Visible = 'on';
    end
    
    % Snake panel off
    data.Panel.Selection.hPanel.Visible = 'off';
    data.Panel.Snake.hPanel.Visible = 'off';

    data.CineActiveTagNo = TagNo;

end

guidata(hFig, data);