function initTumorProfile(src, evnt)

global hFig hFig2

data = guidata(hFig);
data2 = guidata(hFig2);

hAxis = data2.Panel.Tumor.Comp.hAxis;                         
axis(hAxis.Tumor, 'tight', 'equal')

nSlices = data.Image.nSlices;
cent = data.Tumor.cent;
snakeCont = data.Tumor.snakeCont;
snakeContXY = data.Tumor.snakeContXY;
snakeContLimM = data.Tumor.snakeContLimM;
snakeContLimN = data.Tumor.snakeContLimN;

refCont = data.Tumor.refCont;
refContXY = data.Tumor.refContXY;

%% tumor center points
data2.Panel.View.Comp.hPlotObj.PlotPointTC.All.XData = 1:nSlices;
data2.Panel.View.Comp.hPlotObj.PlotPointTC.All.YData = cent.y;

data2.Panel.View.Comp.hPlotObj.PlotPointTC1.All.XData = 1:nSlices;
data2.Panel.View.Comp.hPlotObj.PlotPointTC1.All.YData = cent.x;

linkaxes([data2.Panel.View.Comp.hAxis.PlotPoint data2.Panel.View.Comp.hAxis.PlotPoint1], 'x');
data2.Panel.Button1.Comp.Radiobutton.xt.Value = 1;
data2.Panel.Button1.Comp.Radiobutton.yt.Value = 1;

%% tumor mask
    x0 = data.Image.x0;
    y0 = data.Image.y0;
    dx = data.Image.dx;
    dy = data.Image.dy;
    
    M = diff(snakeContLimM)+1;
    N = diff(snakeContLimN)+1;
    
    xmin = (snakeContLimN(1)-1)*dx - x0;
    ymin = (snakeContLimM(1)-1)*dy - y0;
    xmax = (snakeContLimN(2)-1)*dx - x0;
    ymax = (snakeContLimM(2)-1)*dy - y0;
    xWL(1) = xmin-dx/2;
    xWL(2) = xWL(1)+dx*N;
    yWL(1) = ymin-dy/2;
    yWL(2) = yWL(1)+dy*M;
    RA = imref2d([M N], xWL, yWL);
%     data.Image.RA = RA;


[tumorMask] = getTumorMask(snakeCont, snakeContLimM, snakeContLimN);
bwSum = sum(tumorMask, 3);
data2.Panel.Tumor.Comp.hPlotObj.Tumor.bwSum = imshow(bwSum, RA, 'parent',  hAxis.Tumor);
if any(bwSum(:))
      hAxis.Tumor.CLim = [min(bwSum(:)) max(bwSum(:))];
end

%% tumor contours
data2.Panel.Tumor.Comp.hPlotObj.Tumor.hgContour = hggroup(hAxis.Tumor);
hPlotObj = data2.Panel.Tumor.Comp.hPlotObj;
for iSlice = 1:nSlices
    hPlotObj.Tumor.Contour(iSlice) = line(hPlotObj.Tumor.hgContour, ...
        'XData',  [], 'YData',  [],  'Color', 'g', 'LineStyle', '-', 'LineWidth', 1);
    if ~isempty(snakeContXY{iSlice})
        set(hPlotObj.Tumor.Contour(iSlice), 'XData', snakeContXY{iSlice}(:, 1),  'YData', snakeContXY{iSlice}(:, 2));
    end
end
hPlotObj.Tumor.RefContour = line(hAxis.Tumor, 'XData', refContXY(:, 1), 'YData', refContXY(:, 2),...
    'Color', 'r', 'LineStyle', '-', 'LineWidth', 1);

%% profile line
xmin = min(xmin, min(refContXY(:,1)));
ymin = min(ymin, min(refContXY(:,2)));
xmax = max(xmax, max(refContXY(:,1)));
ymax = max(ymax, max(refContXY(:,2)));

xyrange = [xmin xmax ymin ymax];
data.Tumor.xyrangeCC = xyrange;

marg = 0.1;
xL = xmax-xmin;
yL = ymax-ymin;
yM = (ymin+ymax)/2;
pos = [xmin-xL*marg  yM
          xmax+xL*marg yM];
      
hPlotObj.Tumor.ProfileLine = images.roi.Line(hAxis.Tumor, 'Color', 'c', 'Position', pos , 'Tag', 'PL');
addlistener(hPlotObj.Tumor.ProfileLine, 'MovingROI', @Callback_Line_Profile);

%% axis limits
hAxis.Tumor.XLim = [xmin-xL*marg*2 xmax+xL*marg*2];
hAxis.Tumor.YLim = [ymin-yL*marg*2 ymax+yL*marg*2];

%% save data
data2.Panel.Tumor.Comp.hPlotObj = hPlotObj;
guidata(hFig2, data2);
guidata(hFig, data);

%% profile measurement
updateTumorProfile;
% 
% % points
% if data.Point.InitDone
%     xi = data.Point.Data.xi;
%     ixm = data.Point.Data.ixm;
%     yy = data.Point.Data.yy;
% %     for n = 1:size(yi,1)
% %         yy = yi(n,:);
% %         junk = ~isnan(yy);
% %         xmin = min(xi(find(junk, 1, 'first')), xmin);
% %         xmax = max(xi(find(junk, 1, 'last')), xmax);
% %     end
%     junk = min(yy);   ymin = min(junk, ymin);
%     junk = max(yy);    ymax = max(junk, ymax);
%     xmin = min(xmin, xi(ixm));
%     xmax = max(xmax, xi(ixm));
%     
%     hPlotObj.Tumor.hgPoints = hggroup(hAxis.Tumor);
%     for n = 1:data.Image.nImages
%         hPlotObj.Tumor.Points(n) = line(hPlotObj.Tumor.hgPoints, 'XData', [], 'YData', [],...
%             'Marker', '.',  'MarkerSize', 12, 'Color', 'c', 'LineStyle', 'none');
%     end
%     
%     data2.Panel.Tumor.Comp.hPlotObj = hPlotObj;
%     guidata(hFig2, data2);
%     updateTumorPoint;
% end
% 
% dx = xmax-xmin;
% dy = ymax-ymin;
% mg = 0.2;
% xmin = xmin-dx*mg;
% xmax = xmax+dx*mg;
% ymin = ymin-dy*mg;
% ymax = ymax+dy*mg;
% 
% hAxis.Tumor.XLim = [xmin xmax];
% hAxis.Tumor.YLim = [ymin ymax];
% 
% data.Tumor.xmin = xmin;
% data.Tumor.xmax = xmax;
% data.Tumor.ymin = ymin;
% data.Tumor.ymax = ymax;
% data.Tumor.InitDone = true;
% 
% data.Panel.Point.Comp.Pushbutton.PointPlot.Enable = 'on';
% 
% guidata(hFig, data);
% 
% % for n = 1:data_main.nImages
% %     if ~isempty(CC_GC{n})
% %         hPlotObj.Tumor.GatedContour(n).XData = CC_GC{n}(:, 2);
% %         hPlotObj.Tumor.GatedContour(n).YData = CC_GC{n}(:, 1);
% %     end
% %     if ~isempty(CC_TC{n})
% %         hPlotObj.Tumor.TrackContour(n).XData = CC_TC{n}(:, 2);
% %         hPlotObj.Tumor.TrackContour(n).YData = CC_TC{n}(:, 1);
% %     end
% % end
% 
data2.Panel.Button.Comp.Radiobutton.bwSum.Value = 1;
data2.Panel.Button.Comp.Radiobutton.Contour.Value = 1;
data2.Panel.Button.Comp.Radiobutton.hProfile.Value = 1;
data2.Panel.Button.Comp.Radiobutton.vProfile.Value = 0;
 
% data2.Panel.Tumor.Comp.hPlotObj = hPlotObj;
% guidata(hFig2, data2);
% 
% %hFig2.Visible = 'on';