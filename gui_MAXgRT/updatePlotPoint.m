function updatePlotPoint

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

%% clear plot
hPlotObj = data2.Panel.View.Comp.hPlotObj;

hPlotObj.PlotPointTC.All.XData = [];
hPlotObj.PlotPointTC.All.YData = [];

hPlotObj.PlotPointTC1.All.XData = [];
hPlotObj.PlotPointTC1.All.YData = [];
% hPlotObj.PlotPointTC1.Current = line(hA1, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 24, 'Color', 'r', 'LineStyle', 'none');

% points on diaphragm
hPlotObj.PlotPoint.All.XData = [];
hPlotObj.PlotPoint.All.YData = [];
hPlotObj.PlotPoint.Current.XData = [];
hPlotObj.PlotPoint.Current.YData = [];

hPlotObj.PlotPoint1.All.XData = [];
hPlotObj.PlotPoint1.All.YData = [];
% hPlotObj.PlotPoint1.Current = line(hA1, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 24, 'Color', 'r', 'LineStyle', 'none');                            

%%
% x
if data2.Panel.Button1.Comp.Radiobutton.xd.Value
    Point = data.Point;
    xi = Point.Data.xi;
    yi = Point.Data.yi;
    ixm = Point.Data.ixm;
    NP = Point.Data.NP;
    iSlice = Point.Data.iSlice;

    xx = (1:size(yi, 1))';
    yy = mean(yi(:, ixm-NP:ixm+NP), 2);

    hPlotObj = data2.Panel.View.Comp.hPlotObj;

    xd = data.Point.Data.xi(data.Point.Data.ixm);
    xxd = repmat(xd, length(xx), 1);
    for n =1:length(yy)
        if isnan(yy(n))
            xxd(n) = nan;
        end
    end
    hPlotObj.PlotPoint1.All.XData = xx;
    hPlotObj.PlotPoint1.All.YData = xxd;
end


if data2.Panel.Button1.Comp.Radiobutton.yt.Value
    cent = data.Tumor.cent;
    data2.Panel.View.Comp.hPlotObj.PlotPointTC.All.XData = 1:length(cent.y);
    data2.Panel.View.Comp.hPlotObj.PlotPointTC.All.YData = cent.y;
end

if data2.Panel.Button1.Comp.Radiobutton.xt.Value
    cent = data.Tumor.cent;
    data2.Panel.View.Comp.hPlotObj.PlotPointTC1.All.XData = 1:length(cent.x);
    data2.Panel.View.Comp.hPlotObj.PlotPointTC1.All.YData = cent.x;
end
% data2.Panel.Button1.Comp.Radiobutton.xd.Value = 1;
% data2.Panel.Button1.Comp.Radiobutton.yd.Value = 1;
if data2.Panel.Button1.Comp.Radiobutton.yd.Value
    Point = data.Point;
    xi = Point.Data.xi;
    yi = Point.Data.yi;
    ixm = Point.Data.ixm;
    NP = Point.Data.NP;
    iSlice = Point.Data.iSlice;

    xx = (1:size(yi, 1))';
    yy = mean(yi(:, ixm-NP:ixm+NP), 2);

    hPlotObj = data2.Panel.View.Comp.hPlotObj;

    % y
    hPlotObj.PlotPoint.All.XData = xx;
    hPlotObj.PlotPoint.All.YData = yy;
    hPlotObj.PlotPoint.Current.XData =xx(iSlice);
    hPlotObj.PlotPoint.Current.YData = yy(iSlice);

    x0 = 0;
    y0 = min(yy);
    w = length(xx);
    h = range(yy);
    hPlotObj.Rect.Position = [x0 y0 w, h];

    y1 = max(yy);
    n0 = 0;
    n1 = 0;

    updatePlotPointRectText(hPlotObj.Text, y0, y1, w, n0, n1)

    data.Point.Data.xx = xx;
    data.Point.Data.yy = yy;
    guidata(hFig, data)
    
%     if ~data.ActiveAxis.MovePoints
%         axes(data2.Panel.View.Comp.hAxis.PlotPoint)
%     end
end


% % [x1 y1
% %  x2 y2]
% Lim(1,1) = 1;
% Lim(2,1) = size(allP,1);
% Lim(1,2) = min(allP(:, 2));
% Lim(2,2) = max(allP(:, 2));
% 
% posUL = Lim;
% posUL(1, 2) = posUL(2, 2);
% posLL = Lim;
% posLL(2, 2) = posLL(1, 2);
% 
%     hPlotObj.UL.Position = posUL;
%     hPlotObj.LL.Position = posLL;

% line position text
%     hPlotObj.Text.UL.Position(1) = length(xx)+3;
%     hPlotObj.Text.UL.Position(2) = posUL(2,2);
%     hPlotObj.Text.UL.String = num2str(posUL(2,2), '%4.1f');
%     
%     hPlotObj.Text.LL.Position(1) = length(xx)+3;
%     hPlotObj.Text.LL.Position(2) = posLL(2,2);
%     hPlotObj.Text.LL.String = num2str(posLL(2,2), '%4.1f');
%     
%     hPlotObj.Text.Gap.Position(1) = length(xx)+3;
%     hPlotObj.Text.Gap.Position(2) = (posUL(2,2)+posLL(2,2))/2;
%     hPlotObj.Text.Gap.String = num2str(posUL(2,2)-posLL(2,2), '%4.1f');

% data_main.LinePos.y1 = Lim(1, 2);
% data_main.LinePos.y2 = Lim(2, 2);
% 
% data_main.LinePos.x = posLL(:, 1);
