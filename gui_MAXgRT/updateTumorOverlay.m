function updateTumorOverlay

global hFig hFig2 indSS
data = guidata(hFig);
data2 = guidata(hFig2);


% hAxis = data2.Panel.Tumor.Comp.hAxis.Tumor;
hPlotObj = data2.Panel.Tumor.Comp.hPlotObj;

mask_GC = data.Tumor.mask_GC;
mask_TC = data.Tumor.mask_TC;

bwSum = sum(mask_GC(:,:,indSS), 3)+sum(mask_TC(:,:,indSS), 3);
hPlotObj.Tumor.bwSum.CData = bwSum;
% hAxis.Tumor.CLim = [min(bwSum(:)) max(bwSum(:))];

if any(bwSum(:))
      data2.Panel.Tumor.Comp.hAxis.Tumor.CLim = [min(bwSum(:)) max(bwSum(:))];
end
