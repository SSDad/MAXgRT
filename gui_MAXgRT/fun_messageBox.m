function fun_messageBox(msg)

scrSize = get(0,'ScreenSize');
fontSize = 14;
nLine = length(msg);

for n = 1:nLine
    nC(n) = length(msg{n});
end

mbW = max(nC)*fontSize*0.6;
mbH = fontSize*(nLine+4);

mbx0 = (scrSize(3)-mbW)/2/2;
mby0 = (scrSize(4)-mbH)/2;

hMB = msgbox('');
hMB.Position = [mbx0 mby0 mbW mbH];
% w = pos(3);
% h = pos(4);
% hMB.Position = [pos(1)-w*2.5 pos(2)-h/2 w*6 h*2];
hT = findall(hMB, 'Type', 'Text');
hT.String = msg;
hT.FontSize = fontSize;

hPB = findall(hMB, 'Style', 'pushbutton');
fs = 16;
hPB.FontSize = fs;
w = fs*5;
h = fs*1.5;
hPB.Position = [(mbW-w)/2 2 w h];
% hPB.Visible = 'off';

