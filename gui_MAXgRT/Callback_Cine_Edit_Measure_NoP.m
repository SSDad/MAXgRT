 function Callback_Cine_Edit_Measure_NoP(src, evnt)

global hFig 
data = guidata(hFig);

%% update Patch
TagNo = data.cine.ActiveTagNo;
nA = str2double(src.String);

% Ab
hP = data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.AbMarkPatch;
y4 = hP.YData;
yL = data.cine.data(TagNo).dy*nA;
yp = (y4(2)+y4(3))/2;
y4 = [yp-yL yp-yL yp+yL yp+yL];
hP.YData = y4;

updateAbMarkWave_Cine(yp, data.cine.data(TagNo).Ab.Snakes);

% Snake
hP = data.cine.Panel.View.subPanel(1).ssPanel(3).Comp.hPlotObj.MarkLines.SnakeMarkPatch;
xL = data.cine.data(TagNo).dx*nA;
x4 = hP.XData;
xp = (x4(2)+x4(3))/2;
x4 = [xp-xL xp-xL xp+xL xp+xL];
hP.XData = x4;

updateSnakeMarkWave_Cine(xp, data.cine.data(TagNo).Snake.Snakes);