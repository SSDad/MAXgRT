function Callback_Radiobutton_SelectionPanel_(src, evnt)

global bZoomSelect

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

if strcmp(src.Tag, 'Body')
    hRB = data.Panel.Selection.Comp.Radiobutton.Diaphragm;
    bZoomSelect = 'B';
else
    hRB = data.Panel.Selection.Comp.Radiobutton.Body;
    bZoomSelect = 'D';
end

if src.Value
    hRB.Value = 0;
else
    hRB.Value = 1;
end

if data.Panel.Selection.Comp.Radiobutton.Diaphragm.Value
    data.Panel.Body.hPanel.Visible = 'off';
    data.Panel.Snake.hPanel.Visible = 'on';
    data.Panel.Point.hPanel.Visible = 'on';

    data.Panel.View.Comp.hPlotObj.AbRect.Visible = 'off';
    data.Panel.View.Comp.hPlotObj.AbRectCLine.Visible = 'off';

%     data.Panel.View.Comp.hPlotObj.AbRect.Visible = 'off';
%     data.Panel.View.Comp.hPlotObj.AbRectCLine.Visible = 'off';
else
    data.Panel.Snake.hPanel.Visible = 'off';
    data.Panel.Point.hPanel.Visible = 'off';
    data.Panel.Body.hPanel.Visible = 'on';
    
%     data.Panel.View.Comp.hPlotObj.AbRect.Visible = 'on';
%     data.Panel.View.Comp.hPlotObj.AbRectCLine.Visible = 'on';
end    

    
    % check previously saved contours
%     [~, fn1, ~] = fileparts(matFile);
%     ffn_snakes = fullfile(dataPath, [fn1, '_Snake.mat']);
%     data.FileInfo.ffn_AbsContour = ffn_Abs;

%  ViewRay/Cine
if strcmp(data.bMode, 'V')
    if exist(data.FileInfo.ffn_AbsContour, 'file')
        data.Panel.Body.Comp.Pushbutton.LoadContour.Enable = 'on';
    end
else
    data.Panel.Point.hPanel.Visible = 'off';
    
end

