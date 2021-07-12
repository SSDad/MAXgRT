function Callback_Pushbutton_ButtonPanel_vProfile(src, evnt)

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

xyrange = data.Tumor.xyrangeCC;
xmin = xyrange(1);
xmax = xyrange(2);
ymin = xyrange(3);
ymax = xyrange(4);

marg = 0.2;

if strcmp(src.Tag, 'hProfile')
    xL = xmax-xmin;
    yM = (ymin+ymax)/2;
    pos = [xmin-xL*marg  yM
           xmax+xL*marg yM];
else
    yL = ymax-ymin;
    xM = (xmin+xmax)/2;
    pos = [xM ymin-yL*marg
              xM ymax+yL*marg];
end

data2.Panel.Tumor.Comp.hPlotObj.Tumor.ProfileLine.Position = pos;

updateTumorProfile;