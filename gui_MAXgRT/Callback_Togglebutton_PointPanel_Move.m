function Callback_Togglebutton_PointPanel_Move(src, evnt)

global hFig
% hFig = ancestor(src, 'Figure');
data = guidata(hFig);
str = src.String;
if strcmp(str, 'Move Points')
    
    axes(data.Panel.View.Comp.hAxis.Image)
    data.ActiveAxis.MovePoints = 1;
    
    set(hFig, 'keypressfcn', @fh_kpfcn);

    src.String = 'Done';
    src.ForegroundColor = 'r';
    src.BackgroundColor = [1 1 1]*0.25;

else
    set(hFig, 'keypressfcn', []);
    src.String = 'Move Points';
    src.ForegroundColor = 'c';
    src.BackgroundColor = [1 1 1]*0.25;

    data.ActiveAxis.MovePoints = 0;
end
guidata(hFig, data);

% data = guidata(hFig);
% 
% iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
% 
% x0 = data.Image.x0;
% y0 = data.Image.y0;
% dx = data.Image.dx;
% dy = data.Image.dy;
% 
% if strcmp(str, 'reDraw')
%     src.String = 'Done';
%     src.ForegroundColor = 'r';
%     src.BackgroundColor = [1 1 1]*0.25;
%     
%     C = data.Snake.Snakes{iSlice};
%     % convert to xy
%     C(:, 1) = (C(:, 1)-1)*dx+x0;
%     C(:, 2) = (C(:, 2)-1)*dy+y0;
%     
%     nWP = size(C, 1);
%     WP = false(nWP, 1);
%     WP(round(linspace(1, nWP-nWP/14, 14))) = true;
%     
%     reContL = drawfreehand(data.Panel.View.Comp.hAxis.Image,...
%         'Position', C, 'Closed', 0);%, 'Waypoints', WP);
% 
%     data.Panel.View.Comp.hPlotObj.Snake.YData = [];
%     data.Panel.View.Comp.hPlotObj.Snake.XData = [];
% 
%     % disable buttons
%     data.Panel.Snake.Comp.Pushbutton.LoadSnake.Enable = 'off';
%     data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'off';
%     data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'off';
%     data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'off';
% 
% else
%     src.String = 'reDraw';
%     src.ForegroundColor = 'c';
%     src.BackgroundColor = [1 1 1]*0.25;
% 
%     data.Snake.Snakes{iSlice} = [];
%     C = reContL.Position;
%     % convert to ij
%     C(:, 1) = (C(:, 1)-x0)/dx+1;
%     C(:, 2) = (C(:, 2)-y0)/dy+1;
%     C(:, 1) = sgolayfilt(C(:, 1), 3, 75);
%  
%     data.Snake.Snakes{iSlice} = C;
%     % show
%     data.Panel.View.Comp.hPlotObj.Snake.YData = (C(:, 2)-1)*dy+y0;
%     data.Panel.View.Comp.hPlotObj.Snake.XData = (C(:, 1)-1)*dx+x0;
%     
%     reContL.Visible = 'off';
%     
%     % enable buttons
%     data.Panel.Snake.Comp.Pushbutton.LoadSnake.Enable = 'on';
%     data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'on';
%     data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'on';
% 
%     guidata(hFig, data)
% end
% 
