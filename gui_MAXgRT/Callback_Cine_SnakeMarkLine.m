function Callback_Cine_SnakeMarkLine(src, evnt)

pos = src.Position;
xp = pos(1);
S = src.UserData;

updateSnakeMarkWave_Cine(xp, S);
