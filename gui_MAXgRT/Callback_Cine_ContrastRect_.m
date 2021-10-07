function Callback_Cine_ContrastRect_(src, evnt)

global contrastRectLim_Cine

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

recPos = src.Position;
TagNo = str2num(src.Tag);
% iSlice = data.cine(TagNo).iSlice;

I = data.cine.data(TagNo).v(:, :, data.cine.data(TagNo).iSlice);

% % I = hPlotObj.snakeImage.CData;
% Images = data.Image.Images;
% % sV = data_main.sliderValue;
% sV = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
% % I = rot90(Images{sV}, 3);
% I = Images{sV};

contrastRectLim_Cine(TagNo, 1) = recPos(1);
contrastRectLim_Cine(TagNo, 2) = contrastRectLim_Cine(TagNo, 1)+recPos(3);
maxI = max(I(:));
minI = min(I(:));
wI = maxI-minI;

cL1 = minI+wI*contrastRectLim_Cine(TagNo, 1);
cL2 = minI+wI*contrastRectLim_Cine(TagNo, 2);

I(I<cL1) = cL1;
I(I>cL2) = cL2;
% data.Panel.View.Comp.hPlotObj.Image.CData = I;

data.Cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Image.CData = I;
