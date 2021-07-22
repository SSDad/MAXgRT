function Callback_Togglebutton_BodyPanel_Boundary(src, evnt)

global hFig
% global AbBoundLim 

data = guidata(hFig);

if strcmp(data.bMode, 'V')
    fun_Callback_Togglebutton_BodyPanel_Boundary(src, evnt);
elseif strcmp(data.bMode, 'C')
    fun_Callback_Togglebutton_BodyPanel_Boundary_Cine(src, evnt)
end
% 
% hRect = data.Panel.View.Comp.hPlotObj.AbRect;
% hRectCLine = data.Panel.View.Comp.hPlotObj.AbRectCLine;
% 
% str = src.String;
% 
% if strcmp(str, 'Boundary Lines')
%     src.String = 'Done';
%     src.ForegroundColor = 'r';
%     hRect.Color = 'Green';
%     hRect.Visible = 'on';
%     hRect.InteractionsAllowed = 'all';
%     hRectCLine.Visible = 'on';
%     hRectCLine.InteractionsAllowed = 'all';
%     data.Panel.Body.Comp.Pushbutton.Contour.Enable = 'off';
% %     src.BackgroundColor = [1 1 1]*0.25;
% else
%     src.String = 'Boundary Lines';
%     src.ForegroundColor = 'g';
%     hRect.Color = 'Red';
%     hRect.InteractionsAllowed = 'none';
%     hRectCLine.InteractionsAllowed = 'none';
%     data.Panel.Body.Comp.Pushbutton.Contour.Enable = 'on';
% 
%     AbBoundLim = [hRect.Position(2) hRect.Position(2)+hRect.Position(4)];
% end