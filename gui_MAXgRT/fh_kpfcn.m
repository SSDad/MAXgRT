function [] = fh_kpfcn(H, E)          

data = guidata(H);

ixm = data.Point.Data.ixm;
xi = data.Point.Data.xi;
yi = data.Point.Data.yi;
NP = data.Point.Data.NP;

switch E.Key
    case 'rightarrow'
        ixm = ixm+1;
    case 'leftarrow'
        ixm = ixm-1;
    otherwise  
end

data.Point.Data.ixm = ixm;

% on image
iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
hPlotObj = data.Panel.View.Comp.hPlotObj;
hPlotObj.Point.XData = xi(ixm);
hPlotObj.Point.YData = yi(iSlice, ixm);

hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);

data.Point.Data.iSlice = iSlice;
guidata(H, data);

% point
updatePlotPoint;

if data.Tumor.InitDone
    updateTumorPoint;
end
% yy = mean(yi(:, ixm-NP:ixm+NP), 2);
% hPlotObj.PlotPoint.All.YData = yy;
% hPlotObj.PlotPoint.Current.XData = iSlice;
% hPlotObj.PlotPoint.Current.YData = yy(iSlice);
% 
% xx = (1:data.nImages)';
% data.Point.AllPoint = [xx yy];
% 
% % 2 line update
% y1 = min(yy);
% y2 = max(yy);
% hPlotObj.UL.Position = [1 y2; data.nImages y2];
% hPlotObj.LL.Position = [1 y1; data.nImages y1];
% data.LinePos.y1 = y1;
% data.LinePos.y2 = y2;
% 
%     hPlotObj.PlotPoint.Text.UL.Position(2) = y2;
%     hPlotObj.PlotPoint.Text.UL.String =num2str(y2, '%4.1f');
%     hPlotObj.PlotPoint.Text.LL.Position(2) = y1;
%     hPlotObj.PlotPoint.Text.LL.String =num2str(y1, '%4.1f');
%     hPlotObj.PlotPoint.Text.Gap.Position(2) = (y2+y1)/2;
%     hPlotObj.PlotPoint.Text.Gap.String =num2str(y2-y1, '%4.1f');
%     
%     % tumor line
%     hPlotObj.tumorUL.YData = [y2 y2];
%     hPlotObj.tumorLL.YData = [y1 y1];
%     
%     strTP = num2str(length(yy));
%     hPlotObj.Tumor.Text.UL.Position(2) = y2;
%     hPlotObj.Tumor.Text.UL.String =['0 / ', strTP];
%     hPlotObj.Tumor.Text.LL.Position(2) = y1;
%     hPlotObj.Tumor.Text.LL.String = ['0 / ', strTP];
%     hPlotObj.Tumor.Text.Gap.Position(2) = (y2+y1)/2;
%     hPlotObj.Tumor.Text.Gap.String = [strTP, ' / ', strTP];
% 
% % update tumor points
% data.hPlotObj = hPlotObj;
% updateTumorPoints(data)
% 

