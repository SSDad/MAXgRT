function Callback_Pushbutton_SnakePanel_LoadSnake(src, evnt)

global hFig hFig2

% hFig = ancestor(src, 'Figure');
data = guidata(hFig);
data2 = guidata(hFig2);

ffn_snakes = data.FileInfo.ffn_snakes;

load(ffn_snakes);
data.Snake.Snakes = Snakes;
data.Snake.SlitherDone = true;

% show snake
x0 = data.Image.x0;
y0 = data.Image.y0;
dx = data.Image.dx;
dy = data.Image.dy;

iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
CB =   data.Snake.Snakes{iSlice};

if ~isempty(CB)
    hPlotObj = data.Panel.View.Comp.hPlotObj;
    hPlotObj.Snake.YData = (CB(:, 2)-1)*dy+y0;
    hPlotObj.Snake.XData = (CB(:, 1)-1)*dx+x0;
end

% data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'off';
data.Panel.Snake.Comp.Togglebutton.ReDraw.Enable = 'on';
data.Panel.Snake.Comp.Pushbutton.Delete.Enable = 'on';
data.Panel.Snake.Comp.Pushbutton.SaveSnake.Enable = 'on';

data.Panel.Point.Comp.Popup.Neighbour.Enable = 'on';
data.Panel.Point.Comp.Pushbutton.Init.Enable = 'on';

data.Panel.Point.Comp.Radiobutton.Tumor.Enable = 'on';
data.Panel.Point.Comp.Radiobutton.Dome.Enable = 'on';

guidata(hFig, data);

% point on snake
% dataPath = data.FileInfo.DataPath;
% matFile = data.FileInfo.MatFile;
% [~, fn1, ~] = fileparts(matFile);
% ffn_PointOnSnake = fullfile(dataPath, [fn1, '_Point.mat']);

pause(0.1);
ffn_PointOnSnake = data.FileInfo.ffn_PointOnSnake;
if exist(ffn_PointOnSnake, 'file')
    load(ffn_PointOnSnake);
    data.Point.Data = Point;
    data.Point.InitDone = true;
    
    % show on snake
    xi = data.Point.Data.xi;
    yi = data.Point.Data.yi;
    ixm = data.Point.Data.ixm;
    NP = data.Point.Data.NP;

    hPlotObj.Point.XData = xi(ixm);
    hPlotObj.Point.YData = yi(iSlice, ixm);
    hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
    hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
    hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
    hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);
    
    data.Panel.Point.Comp.Popup.Neighbour.Enable = 'off';
    data.Panel.Point.Comp.Pushbutton.Init.Enable = 'off';
    data.Panel.Point.Comp.Togglebutton.Move.Enable = 'on';
    data.Panel.Point.Comp.Pushbutton.PointPlot.Enable = 'on';
    
    data.Point.Data.iSlice = iSlice;
    guidata(hFig, data);    
    
    % point plot
    data2.Panel.Button1.Comp.Radiobutton.xd.Value = 1;
    data2.Panel.Button1.Comp.Radiobutton.yd.Value = 1;
    guidata(hFig2, data2);
    
    updatePlotPoint;
%     hFig2.Visible = 'on';

end

