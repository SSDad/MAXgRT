function Callback_Cine_SnakeMarkLine(src, evnt)

global hFig
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;

global SnakeMarkLinePos
yp = SnakeMarkLinePos(1:2, 2, TagNo);

pos = src.Position;
xp = pos(1);
% S = src.UserData;
S = data.cine.data(TagNo).Snake.Snakes;

updateSnakeMarkWave_Cine(TagNo, xp, S);

src.Position(1:2, 2) = yp;

% updateMarkPatch
nA = str2double(data.cine.Panel.Measure.Comp.Edit.NoP.String);
hP = data.cine.hPlotObj(TagNo).MarkLines.SnakeMarkPatch;
xL = data.cine.data(TagNo).dx*nA;
x4 = [xp-xL xp-xL xp+xL xp+xL];
hP.XData = x4;