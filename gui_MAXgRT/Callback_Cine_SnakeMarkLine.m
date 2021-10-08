function Callback_Cine_SnakeMarkLine(src, evnt)

global hFig
global SnakeMarkLinePos
yp = SnakeMarkLinePos(1:2, 2);

pos = src.Position;
xp = pos(1);
S = src.UserData;

updateSnakeMarkWave_Cine(xp, S);

src.Position(1:2, 2) = yp;

% updateAbMarkPatch
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;

nA = str2double(data.cine.Panel.Measure.Comp.Edit.NoP.String);
hP = data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkPatch;
xL = data.cine.data(TagNo).dx*nA;
x4 = [xp-xL xp-xL xp+xL xp+xL];
hP.XData = x4;