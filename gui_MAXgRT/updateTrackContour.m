function updateTrackContour

global hFig hFig2 indSS
data = guidata(hFig);
data2 = guidata(hFig2);

hPlotObj = data2.Panel.Tumor.Comp.hPlotObj;

for n = 1:data.Image.nSlices
    hPlotObj.Tumor.GatedContour(n).Visible = 'off';
    hPlotObj.Tumor.TrackContour(n).Visible = 'off';
end

CC_GC = data.Tumor.CC_GC;
CC_TC = data.Tumor.CC_TC;
for iSS = 1:length(indSS)
    n = indSS(iSS);
    if ~isempty(CC_GC{n})
        hPlotObj.Tumor.GatedContour(n).Visible = 'on';
    end
    if ~isempty(CC_TC{n})
        hPlotObj.Tumor.TrackContour(n).Visible = 'on';
    end
end
