function Callback_Rect_PlotPoint(src, evnt)

global indSS
global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

src.Position(1) = evnt.PreviousPosition(1);
src.Position(3) = evnt.PreviousPosition(3);

y0 = src.Position(2);
y1 = y0+src.Position(4);

yy = data.Point.Data.yy;

n0 = sum(yy < y0);
n1 = sum(yy > y1);
w = length(yy);

data.MeasureData.PlotPoint.LineYPos = [y0 y1];
data.MeasureData.PlotPoint.NoPoints = [n0 n1 w-n0-n1];

updatePlotPointRectText(data2.Panel.View.Comp.hPlotObj.Text, y0, y1, w, n0, n1)

%
if data.Tumor.InitDone
    indSS = find(yy >= y0 & yy <= y1);
    updateTumorOverlay;
    updateTrackContour;
    updateTumorProfile;
end

guidata(hFig, data)

% 
% recPos = src.Position;
% % I = hPlotObj.snakeImage.CData;
% Images = data.Image.Images;
% % sV = data_main.sliderValue;
% sV = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
% I = rot90(Images{sV}, 3);
% 
% contrastRectLim(1) = recPos(1);
% contrastRectLim(2) = contrastRectLim(1)+recPos(3);
% maxI = max(I(:));
% minI = min(I(:));
% wI = maxI-minI;
% 
% cL1 = minI+wI*contrastRectLim(1);
% cL2 = minI+wI*contrastRectLim(2);
% 
% I(I<cL1) = cL1;
% I(I>cL2) = cL2;
% data.Panel.View.Comp.hPlotObj.Image.CData = I;