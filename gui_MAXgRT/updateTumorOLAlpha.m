function updateTumorOLAlpha(TagNo)

global hFig
data = guidata(hFig);
iV = TagNo;

% iV = str2num(src.Tag(end-1));  % index View
% iHV = str2num(src.Tag(end)); % index Horizontal/Vertical

ovA = data.cine.data(iV).Tumor.OL;
ovSum = data.cine.data(iV).Tumor.OLSum;
% cent = data.cine.data(iV).Tumor.Cent;
% 
% y0 = src.Position(2);
% y1 = y0+src.Position(4);
% 
% yy = cent(:, iHV);
% ind = yy >= y0 & yy <= y1;

% overlay view
ov = sum(ovA, 3);
h = data.cine.hPlotObj(iV).TumorOLView;
h.CData(:, :, 1) = ov;
h.AlphaData = ov./max(ovSum(:));

data.cine.data(iV).Tumor.ovAlpha =  h.AlphaData;
guidata(hFig, data);

% tumor margin
% if data.cine.Panel.Measure.Comp.Togglebutton.TumorMargin.Value
if  data.cine.Panel.Measure.Comp.Radiobutton.Measure(3).Value    
    hPlotObj = data.cine.hPlotObj(iV);
    cineData = data.cine.data(iV);
%     ovAlpha = cineData.Tumor.ovAlpha;
    iSlice = data.cine.data(min(iV, 3)).iSlice;

    showTumorMargin(hPlotObj, cineData, iSlice);
end
