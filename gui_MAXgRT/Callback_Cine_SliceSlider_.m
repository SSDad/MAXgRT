 function Callback_Cine_SliceSlider_(src, evnt)

global hFig % hFig2 
global contrastRectLim_Cine

data = guidata(hFig);

% startSlice = str2double(data.Panel.Snake.Comp.Edit.StartSlice.String);
% endSlice = str2double(data.Panel.Snake.Comp.Edit.EndSlice.String);

TagNo = str2num(src.Tag);
iSlice = round(get(src, 'Value'));
data.cine.data(TagNo).iSlice = iSlice;
I = data.cine.data(TagNo).v(:, :, iSlice);

data.cine.Panel.View.subPanel(TagNo).ssPanel(4).Comp.hText.nImages.String...
        = [num2str(data.cine.data(TagNo).iSlice), ' / ', num2str(data.cine.data(TagNo).nSlice)];

%% contrast limit
maxI = max(I(:));
minI = min(I(:));
wI = maxI-minI;
cL1 = minI+wI*contrastRectLim_Cine(TagNo, 1);
cL2 = minI+wI*contrastRectLim_Cine(TagNo, 2);
I(I<cL1) = cL1;
I(I>cL2) = cL2;

data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Image.CData = I;

%% hist
yc = histcounts(I, max(I(:))+1);
yc = log10(yc);
yc = yc/max(yc);
xc = 1:length(yc);
xc = xc/max(xc);
% data.Panel.ContrastBar.Comp.Panel.Constrast.hPlotObj.Hist.XData = xc;
% data.Panel.ContrastBar.Comp.Panel.Constrast.hPlotObj.Hist.YData = yc;
     data.Cine.Panel.View.subPanel(TagNo).ssPanel(2).Comp.hPlotObj.Hist.XData = xc;
     data.Cine.Panel.View.subPanel(TagNo).ssPanel(2).Comp.hPlotObj.Hist.YData = yc;

% xy info
x0 = data.cine.data(TagNo).x0;
y0 = data.cine.data(TagNo).y0;
dx = data.cine.data(TagNo).dx;
dy = data.cine.data(TagNo).dy;

%% contours
if data.cine.data(TagNo).bContourLoaded
    hPlotObj = data.cine.Panel.View.subPanel(TagNo).ssPanel(3).Comp.hPlotObj; %data.Panel.View.Comp.hPlotObj;

    cineData = data.cine.data(TagNo);
    bShow = [1 1 1];
    if TagNo == 2
        bShow = [1 1 0];
    end
    showAllContours(hPlotObj, cineData, iSlice, bShow)
    showTumorCenter(hPlotObj, cineData, iSlice)
    
    bDist = data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value;
    if TagNo == 1
        updateAbTumorLine(hPlotObj, cineData, iSlice, bDist)
    end
    updateSnakeTumorLine(hPlotObj, cineData, iSlice, bDist)
end

