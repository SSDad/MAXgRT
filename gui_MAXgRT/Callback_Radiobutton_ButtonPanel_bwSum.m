function Callback_Radiobutton_ButtonPanel_bwSum(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);
hAxis = data.Panel.Tumor.Comp.hAxis.Tumor;
hPlotObj = data.Panel.Tumor.Comp.hPlotObj;

if data.Panel.Button.Comp.Radiobutton.bwSum.Value
%     updateTumorOverlay(data_main);
    hPlotObj.Tumor.bwSum.Visible = 'on';
else
    hPlotObj.Tumor.bwSum.Visible = 'off';
end