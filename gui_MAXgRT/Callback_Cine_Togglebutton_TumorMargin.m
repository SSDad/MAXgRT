function Callback_Cine_Togglebutton_TumorMargin(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;

if TagNo == 3
    nV = [3 4];
else
    nV = TagNo;
end

iSlice = data.cine.data(TagNo).iSlice;

for iV = nV

    hPlotObj = data.cine.hPlotObj(iV);
    cineData = data.cine.data(iV);
    ovAlpha = cineData.Tumor.ovAlpha;

    if src.Value
        src.String = 'Tumor Margin off';
        src.ForegroundColor =  'r';
        showTumorMargin(hPlotObj, cineData, iSlice);
    else
        src.String = 'Tumor Margin on';
        src.ForegroundColor =  'g';
        hPlotObj.TumorOLView.AlphaData = ovAlpha;
    end

end