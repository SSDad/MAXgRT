function updatePlotPointRectText(hText, y0, y1, w, n0, n1)

g1 = 3;
g2 = 12;

hPlotObj.Text = hText;
hPlotObj.Text.UL.Position(1) = w+g1;
hPlotObj.Text.UL.Position(2) = y1;
hPlotObj.Text.UL.String = num2str(y1, '%4.1f');

hPlotObj.Text.LL.Position(1) = w+g1;
hPlotObj.Text.LL.Position(2) = y0;
hPlotObj.Text.LL.String = num2str(y0, '%4.1f');

hPlotObj.Text.Gap.Position(1) = w+g1;
hPlotObj.Text.Gap.Position(2) = (y0+y1)/2;
hPlotObj.Text.Gap.String = num2str(y1-y0, '%4.1f');

% number of points
hPlotObj.Text.UP.Position(1) = w+g2;
hPlotObj.Text.UP.Position(2) = y1;
hPlotObj.Text.UP.String = num2str(n1, '%4d');

hPlotObj.Text.LP.Position(1) = w+g2;
hPlotObj.Text.LP.Position(2) = y0;
hPlotObj.Text.LP.String = num2str(n0, '%4d');

hPlotObj.Text.MP.Position(1) = w+g2;
hPlotObj.Text.MP.Position(2) = (y0+y1)/2;
hPlotObj.Text.MP.String = num2str(w-n0-n1, '%4d');