function Callback_Radiobutton_ButtonPanel_Contour(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hAxis = data.Panel.Tumor.Comp.hAxis.Tumor;
hPlotObj = data.Panel.Tumor.Comp.hPlotObj;

if data.Panel.Button.Comp.Radiobutton.Contour.Value
%     updateTumorOverlay(data_main);
    hPlotObj.Tumor.hgContour.Visible = 'on';
%     hPlotObj.Tumor.hgGatedContour.Visible = 'on';
else
    hPlotObj.Tumor.hgContour.Visible = 'off';
%     hPlotObj.Tumor.hgGatedContour.Visible = 'off';
end