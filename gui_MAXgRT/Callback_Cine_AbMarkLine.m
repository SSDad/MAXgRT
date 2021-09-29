function Callback_Cine_AbMarkLine(src, evnt)

global hFig

global AbMarkLinePos
xp = AbMarkLinePos(1:2, 1);

pos = src.Position;
yp = pos(1, 2);
S = src.UserData;

updateAbMarkWave_Cine(yp, S);

src.Position(1:2, 1) = xp;

% updateAbMarkPatch
data = guidata(hFig);
TagNo = data.CineActiveTagNo;

nA = str2double(data.Panel.Measure_Cine.Comp.Edit.NoP.String);
hP = data.Panel.View_Cine.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkPatch;
yL = data.cine(TagNo).dy*nA;
y4 = [yp-yL yp-yL yp+yL yp+yL];
hP.YData = y4;