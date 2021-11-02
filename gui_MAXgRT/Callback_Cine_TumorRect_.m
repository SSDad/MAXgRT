function Callback_Cine_TumorRect_(src, evnt)

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

% wave
if iV == 2 | iV == 4
    if iHV == 1
        hg = data.cine.Measure(iV).hPlotObj.DADot(iHV);
        for id = 1:length(yy)
            hg.Children(id).MarkerFaceColor = [0 0 0];
        end
        junk = find(ind);
        for id = 1:length(junk)
            hg.Children(junk(id)).MarkerFaceColor = 'r';
        end
    end
else
        hg = data.cine.Measure(iV).hPlotObj.DADot(iHV);
        for id = 1:length(yy)
            hg.Children(id).MarkerFaceColor = [0 0 0];
        end
        junk = find(ind);
        for id = 1:length(junk)
            hg.Children(junk(id)).MarkerFaceColor = 'r';
        end
    end
end