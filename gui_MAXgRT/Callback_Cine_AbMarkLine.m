function Callback_Cine_AbMarkLine(src, evnt)

global AbMarkLinePos
xp = AbMarkLinePos(1:2, 1);

pos = src.Position;
yp = pos(1, 2);
S = src.UserData;

updateAbMarkWave_Cine(yp, S);

src.Position(1:2, 1) = xp;
