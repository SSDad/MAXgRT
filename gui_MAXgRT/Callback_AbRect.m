function Callback_AbRect(src, evnt)

global hFig

data = guidata(hFig);
hCLine = data.Panel.View.Comp.hPlotObj.AbRectCLine;

pos = src.Position;
x1 = pos(1);
x2 = x1+pos(3);
y1 = pos(2)+pos(4)/2;
y2 = y1;
hCLine.Position = [x1 y1;x2 y2];