function Callback_Cine_AbMarkLine(src, evnt)

global hFig
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;

global AbMarkLinePos
xp = AbMarkLinePos(1:2, 1);

pos = src.Position;
yp = pos(1, 2);
S = src.UserData;

updateAbMarkWave_Cine(TagNo, yp, S);

src.Position(1:2, 1) = xp;

% updateAbMarkPatch
nA = str2double(data.cine.Panel.Measure.Comp.Edit.NoP.String);
hP = data.cine.hPlotObj(TagNo).MarkLines.AbMarkPatch;
yL = data.cine.data(TagNo).dy*nA;
y4 = [yp-yL yp-yL yp+yL yp+yL];
hP.YData = y4;