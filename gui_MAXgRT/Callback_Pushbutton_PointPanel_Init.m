function Callback_Pushbutton_PointPanel_Init(src, evnt)

global hFig hFig2

data = guidata(hFig);
data2 = guidata(hFig2);

if ~data.Point.InitDone
    dataPath = data.FileInfo.DataPath;
    matFile = data.FileInfo.MatFile;

    [~, fn1, ~] = fileparts(matFile);
    ffn = fullfile(dataPath, [fn1, '_Point.mat']);

    if exist(ffn, 'file')

        hWB = waitbar(0, 'Loading points...');

        load(ffn)
        xi = Point.xi;
        yi = Point.yi;
        ixm = Point.ixm;
        pause(2);

    else
        x0 = data.Image.x0;
        y0 = data.Image.y0;
        dx = data.Image.dx;
        dy = data.Image.dy;
        mI = data.Image.mImgSize;
        nI = data.Image.nImgSize;
        nImages = data.Image.nSlices;

        xi = x0:dx:x0+dx*(nI-1);
        yi = nan(nImages, nI);
        xm = nan(nImages, 1);

        hWB = waitbar(0, 'Initializing points on Diaphragm...');

        for iSlice = 1:nImages
            C = data.Snake.Snakes{iSlice};
            if ~isempty(C)
                [xm(iSlice), yi(iSlice, :)] = fun_PointOnCurve2(C, dx, dy, x0, y0, xi, yi(iSlice, :));
                if data.Panel.Point.Comp.Radiobutton.Tumor.Value
                    xm(iSlice) = data.Tumor.cent.x(iSlice);
                end
            end
            waitbar(iSlice/nImages, hWB, 'Finding points on Diaphragm...');
        end

        [~, ixm] = min(abs(xi-nanmean(xm)));

    end
    waitbar(1, hWB, 'Bingo!');
    pause(2);
    close(hWB);

    data.Point.Data.xi = xi;
    data.Point.Data.yi = yi;
    data.Point.Data.ixm = ixm;

    data.Point.InitDone = true;

else
    xi = data.Point.Data.xi;
    yi = data.Point.Data.yi;
    ixm = data.Point.Data.ixm;

end

str = data.Panel.Point.Comp.Popup.Neighbour.String;
idx = data.Panel.Point.Comp.Popup.Neighbour.Value;
NP = str2num(str{idx});
data.Point.Data.NP = NP;

data.Panel.Point.Comp.Togglebutton.Move.Enable = 'on';
data.Panel.Point.Comp.Pushbutton.PointPlot.Enable = 'on';

%% show on snake gui
iSlice = round(data.Panel.SliceSlider.Comp.hSlider.Slice.Value);
if ~isempty(data.Snake.Snakes{iSlice})
    hPlotObj = data.Panel.View.Comp.hPlotObj;
    hPlotObj.Point.XData = xi(ixm);
    hPlotObj.Point.YData = yi(iSlice, ixm);
    hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
    hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
    hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
    hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);
end

data.Point.Data.iSlice = iSlice;

%% show on point plot
data2.Panel.Button1.Comp.Radiobutton.xd.Value = 1;
data2.Panel.Button1.Comp.Radiobutton.yd.Value = 1;

%% save
guidata(hFig, data);
guidata(hFig2, data2);

% point plot
updatePlotPoint;