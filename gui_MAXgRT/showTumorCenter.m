function showTumorCenter(hPlotObj, cineData, iSlice)

TC =  cineData.Tumor.Cent;
if iSlice <= size(TC, 1)
     set(hPlotObj.TumorCenter, 'XData', TC(iSlice, 1), 'YData', TC(iSlice, 2));
else
     set(hPlotObj.TumorCenter, 'XData', [], 'YData', []);
end