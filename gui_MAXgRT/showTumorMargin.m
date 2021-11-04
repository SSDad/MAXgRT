function showTumorMargin(hPlotObj, cineData, iSlice)

% Tumor
ovAlpha = cineData.Tumor.ovAlpha;
ov = cineData.Tumor.OL;

if iSlice <= size(ov, 3)
    bw = ov(:,:,iSlice);
    ovAlpha(bw) = 0;
    hPlotObj.TumorOLView.AlphaData = ovAlpha;
end