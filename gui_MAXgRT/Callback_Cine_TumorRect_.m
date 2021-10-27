function Callback_Cine_TumorRect_(src, evnt)

global hFig
data = guidata(hFig);
iV = str2num(src.Tag(end-1));
iHV = str2num(src.Tag(end));

ovA = data.cine.data(iV).Tumor.OL;
cent = data.cine.data(iV).Tumor.Cent;
% , data.cine.data(TagNo).Tumor.Lim]

y0 = src.Position(2);
y1 = y0+src.Position(4);

yy = cent(:, iHV);
ind = yy >= y0 & yy <= y1;

ov = sum(ovA(:, :, ind), 3);
h = data.cine.hPlotObj(iV).TumorOLView;
h.CData(:, :, 1) = ov;
h.AlphaData = rescale(ov);
