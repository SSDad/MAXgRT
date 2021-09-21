function Callback_Cine_SnakeMarkLine(src, evnt)

global SnakeMarkLinePos
yp = SnakeMarkLinePos(1:2, 2);

pos = src.Position;
xp = pos(1);
S = src.UserData;

updateSnakeMarkWave_Cine(xp, S);

src.Position(1:2, 2) = yp;