function updateTumorProfile
global hFig hFig2

data = guidata(hFig);
data2 = guidata(hFig2);

% hAxis = data_main.hAxis;
% hPL = hPlotObj.Profile.PL;

bwSum = data2.Panel.Tumor.Comp.hPlotObj.Tumor.bwSum.CData;

bwSumA = zeros(data.Image.mImgSize, data.Image.nImgSize);
bwSumA(data.Tumor.snakeContLimM(1):data.Tumor.snakeContLimM(2), ...
    data.Tumor.snakeContLimN(1):data.Tumor.snakeContLimN(2)) = bwSum;

pos = data2.Panel.Tumor.Comp.hPlotObj.Tumor.ProfileLine.Position; 

xL = data.Image.RA.XWorldLimits;
yL = data.Image.RA.YWorldLimits;
[xProf, yProf, prof] = improfile(xL, yL, bwSumA, pos(:, 1), pos(:, 2));

rr = ((xProf-xProf(1)).^2+(yProf-yProf(1)).^2).^0.5;

data.MeasureData.Profile.LinePosition = [xProf(1) yProf(1)
                                                        xProf(end) yProf(end)];
data.MeasureData.Profile.XData = rr;
data.MeasureData.Profile.YData = prof;

% line
hPlotObj = data2.Panel.Profile.Comp.hPlotObj;
hPlotObj.Profile.Profile.XData = rr;
hPlotObj.Profile.Profile.YData = prof;

% patches
maxV = max(prof);

xL2 = find(prof == maxV, 1, 'first');
if prof(1) == 0
    xL1 = find(prof(1:xL2) == 0, 1, 'last');
else
    xL1 = 1;
end
hPlotObj.Profile.Patch1.XData = [rr(xL1) rr(xL2) rr(xL2) rr(xL1)];
hPlotObj.Profile.Patch1.YData = [0 0 maxV maxV];
hPlotObj.Profile.Text1.Position = [rr(xL1)+2*data.Image.dx maxV 0];
hPlotObj.Profile.Text1.String = num2str(rr(xL2)-rr(xL1), '%4.1f');
data.MeasureData.Profile.Up(1) = rr(xL2)-rr(xL1);

xR1 = find(prof == maxV, 1, 'last');
if prof(end) == 0
    junk = find(prof(xR1:end) == 0, 1, 'first');
    xR2 = junk+xR1-1;
else
    xR2 = length(prof);
end

hPlotObj.Profile.Patch2.XData = [rr(xR1) rr(xR2) rr(xR2) rr(xR1)];
hPlotObj.Profile.Patch2.YData = [0 0 maxV maxV];
hPlotObj.Profile.Text2.Position = [rr(xR2)-4*data.Image.dx maxV 0];
hPlotObj.Profile.Text2.String = num2str(rr(xR2)-rr(xR1), '%4.1f');
data.MeasureData.Profile.Down(1) = rr(xR2)-rr(xR1);


% ref contour
% RC = data.Tumor.RC_TC{1};
RC = data.Tumor.refContXY;

[xi, yi] = polyxpoly(pos(:, 1), pos(:, 2), RC(:, 1), RC(:, 2));

xr = ((xi-xProf(1)).^2+(yi-yProf(1)).^2).^0.5;
xr = sort(xr);

if length(xr) == 2
    hPlotObj.Profile.RefLeft.XData = [xr(1) xr(1)];
    hPlotObj.Profile.RefLeft.YData = [0 maxV];

    hPlotObj.Profile.RefRight.XData = [xr(2) xr(2)];
    hPlotObj.Profile.RefRight.YData = [0 maxV];

    hPlotObj.Profile.RefTextLeft1.Position = [rr(xL1) maxV/2 0];
    hPlotObj.Profile.RefTextLeft1.String = num2str(abs(xr(1)-rr(xL1)), '%4.1f');
    data.MeasureData.Profile.Up(2) = xr(1)-rr(xL1);
    hPlotObj.Profile.RefTextLeft1.HorizontalAlignment = 'right';

    hPlotObj.Profile.RefTextLeft2.Position = [rr(xL2) maxV/2 0];
    hPlotObj.Profile.RefTextLeft2.String = num2str(abs(xr(1)-rr(xL2)), '%4.1f');
    data.MeasureData.Profile.Up(3) = xr(1)-rr(xL2);
    hPlotObj.Profile.RefTextLeft2.HorizontalAlignment = 'left';

    hPlotObj.Profile.RefTextRight1.Position = [rr(xR1) maxV/2 0];
    hPlotObj.Profile.RefTextRight1.String = num2str(abs(xr(2)-rr(xR1)), '%4.1f');
    data.MeasureData.Profile.Down(2) = xr(2)-rr(xR1);
    hPlotObj.Profile.RefTextRight1.HorizontalAlignment = 'right';
    hPlotObj.Profile.RefTextRight2.Position = [rr(xR2) maxV/2 0];
    hPlotObj.Profile.RefTextRight2.String = num2str(abs(xr(2)-rr(xR2)), '%4.1f');
    data.MeasureData.Profile.Down(3) = xr(2)-rr(xR2);
    hPlotObj.Profile.RefTextRight2.HorizontalAlignment = 'left';
end

guidata(hFig, data)
