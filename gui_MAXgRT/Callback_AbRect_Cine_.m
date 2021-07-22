function Callback_AbRect_Cine_(src, evnt)

global hFig

data = guidata(hFig);
TagNo = data.CineActiveTagNo;

hCLine = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.AbRectCLine;

% data.Panel.View.Comp.hPlotObj.AbRectCLine;

pos = src.Position;
x1 = pos(1);
x2 = x1+pos(3);
y1 = pos(2)+pos(4)/2;
y2 = y1;
hCLine.Position = [x1 y1;x2 y2];