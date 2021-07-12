function updateTumorPoint

global hFig hFig2

data = guidata(hFig);
data2 = guidata(hFig2);

ixm = data.Point.Data.ixm;
xi = data.Point.Data.xi;
yi = data.Point.Data.yi;
NP = data.Point.Data.NP;

yy = mean(yi(:, ixm-NP:ixm+NP), 2);
% 
% indSS = data.Tumor.indSS;

hAxis = data2.Panel.Tumor.Comp.hAxis.Tumor;
hPlotObj = data2.Panel.Tumor.Comp.hPlotObj;

% for n = 1:data.Image.nImages
%     hPlotObj.Tumor.Points(n).XData = [];
%     hPlotObj.Tumor.Points(n).YData = [];
% end

% for n = 1:length(indSS)
%     hPlotObj.Tumor.Points(n).XData = xi(ixm);
%     hPlotObj.Tumor.Points(n).YData = yy(indSS(n));
% end
for n = 1:data.Image.nSlices
    hPlotObj.Tumor.Points(n).XData = xi(ixm);
    hPlotObj.Tumor.Points(n).YData = yy(n);
end