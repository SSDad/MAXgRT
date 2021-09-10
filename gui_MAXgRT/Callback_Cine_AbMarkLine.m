function Callback_Cine_AbMarkLine(src, evnt)

pos = src.Position;
yp = pos(1, 2);
S = src.UserData;

updateAbMarkWave_Cine(yp, S);
