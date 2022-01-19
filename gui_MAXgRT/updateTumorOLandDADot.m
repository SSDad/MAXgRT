function updateTumorOLandDADot(src)

global hFig
data = guidata(hFig);

iV = str2num(src.Tag(end-1));  % index View
iHV = str2num(src.Tag(end)); % index Horizontal/Vertical

ovA = data.cine.data(iV).Tumor.OL;
ovSum = data.cine.data(iV).Tumor.OLSum;
cent = data.cine.data(iV).Tumor.Cent;

y0 = src.Position(2);
y1 = y0+src.Position(4);

yy = cent(:, iHV);
ind = yy >= y0 & yy <= y1;

% overlay view
ov = sum(ovA(:, :, ind), 3);
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


% wave
if iV == 1 | iV == 3
    nDA = [1 2];
else
   nDA = 1;
end

for iDA = nDA
    hg = data.cine.Measure(iV).hPlotObj.DADot(iDA);
    for id = 1:length(yy)
        hg.Children(id).MarkerFaceColor = [0 0 0];
    end
    junk = find(ind);
    for id = 1:length(junk)
        hg.Children(junk(id)).MarkerFaceColor = 'r';
    end
end
