function Callback_AbRectCLine(src, evnt)

global hFig

data = guidata(hFig);
hRect = data.Panel.View.Comp.hPlotObj.AbRect;

prevPos = evnt.PreviousPosition;
currentPos = evnt.CurrentPosition;
yShift = currentPos(1, 2) - prevPos(1, 2);

hRect.Position(2) = hRect.Position(2)+yShift;
% pos = src.Position;
% x1 = pos(1);
% x2 = x1+pos(3);
% y1 = pos(2)+pos(4)/2;
% y2 = y1;
% hRect.Position = [x1 y1 x2 y2];