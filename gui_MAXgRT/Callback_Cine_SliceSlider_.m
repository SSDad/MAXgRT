 function Callback_Cine_SliceSlider_(src, evnt)

global hFig % hFig2 
global contrastRectLim_Cine

data = guidata(hFig);

% startSlice = str2double(data.Panel.Snake.Comp.Edit.StartSlice.String);
% endSlice = str2double(data.Panel.Snake.Comp.Edit.EndSlice.String);

TagNo = str2num(src.Tag);
iSlice = round(get(src, 'Value'));
data.cine.data(TagNo).iSlice = iSlice;

data.cine.Panel.View.subPanel(TagNo).ssPanel(4).Comp.hText.nImages.String...
            = [num2str(data.cine.data(TagNo).iSlice), ' / ', num2str(data.cine.data(TagNo).nSlice)];

if TagNo ==3
    I1 = data.cine.data(3).v(:, :, iSlice);
    I2 = data.cine.data(4).v(:, :, iSlice);
    I1 =  flipud(I1);
    I2 =  flipud(I2);
    data.cine.hPlotObj(3).Image.CData =I1;
    data.cine.hPlotObj(4).Image.CData = I2;

    I = [I1 I2];
else
    I = data.cine.data(TagNo).v(:, :, iSlice);
    I = flipud(I);
    data.cine.hPlotObj(TagNo).Image.CData = I;
end
axis(data.cine.hAxis(TagNo), 'xy')

    %% contrast limit
    maxI = max(I(:));
    minI = min(I(:));
    wI = maxI-minI;
    cL1 = minI+wI*contrastRectLim_Cine(TagNo, 1);
    cL2 = minI+wI*contrastRectLim_Cine(TagNo, 2);
    I(I<cL1) = cL1;
    I(I>cL2) = cL2;

    %% hist
    yc = histcounts(I, max(I(:))+1);
    yc = log10(yc);
    yc = yc/max(yc);
    xc = 1:length(yc);
    xc = xc/max(xc);
    set(data.cine.Panel.View.subPanel(TagNo).ssPanel(2).Comp.hPlotObj.Hist, 'XData', xc, 'YData', yc);

%     % xy info
%     x0 = data.cine.data(TagNo).x0;
%     y0 = data.cine.data(TagNo).y0;
%     dx = data.cine.data(TagNo).dx;
%     dy = data.cine.data(TagNo).dy;
% 
    %% contours
    if data.cine.data(TagNo).bContourLoaded
        bDist = data.cine.Panel.Measure.Comp.Radiobutton.Measure(2).Value;
        if TagNo < 3
            hPlotObj = data.cine.hPlotObj(TagNo);
            cineData = data.cine.data(TagNo);
            bShow = [1 1 1];
            if TagNo == 2
                bShow = [1 1 0];
            end
            showAllContours(hPlotObj, cineData, iSlice, bShow);
            showTumorCenter(hPlotObj, cineData, iSlice);
            
            % tumor margin
            if data.cine.Panel.Measure.Comp.Radiobutton.Measure(3).Value
                showTumorMargin(hPlotObj, cineData, iSlice);
            end
            
            % distance
            if TagNo == 1
                updateAbTumorLine(hPlotObj, cineData, iSlice, bDist)
            end
            updateSnakeTumorLine(hPlotObj, cineData, iSlice, bDist)
        else
            for iV = 3:4
                hPlotObj = data.cine.hPlotObj(iV);
                cineData = data.cine.data(iV);
                bShow = [1 1 1];
                if iV == 4
                    bShow = [1 1 0];
                end
                showAllContours(hPlotObj, cineData, iSlice, bShow)
                showTumorCenter(hPlotObj, cineData, iSlice)
                % distance
                if iV == 3
                    updateAbTumorLine(hPlotObj, cineData, iSlice, bDist)
                end
                updateSnakeTumorLine(hPlotObj, cineData, iSlice, bDist)

                % tumor margin
%                 if data.cine.Panel.Measure.Comp.Togglebutton.TumorMargin.Value
                if data.cine.Panel.Measure.Comp.Radiobutton.Measure(3).Value
                    showTumorMargin(hPlotObj, cineData, iSlice);
                end

            end
        end
    end
    
%% slice line on wave
if data.cine.Panel.Measure.Comp.Radiobutton.Measure(1).Value
    if TagNo ==3
        data.cine.Measure(TagNo).hPlotObj.TumorSliceLine.Position(1, 1) = iSlice;
        data.cine.Measure(TagNo).hPlotObj.TumorSliceLine.Position(2, 1) = iSlice;
        data.cine.Measure(TagNo+1).hPlotObj.TumorSliceLine.Position(1, 1) = iSlice;
        data.cine.Measure(TagNo+1).hPlotObj.TumorSliceLine.Position(2, 1) = iSlice;

        hA = data.cine.Measure(TagNo).hAxis.DA(1);
        data.cine.Measure(TagNo).hPlotObj.DASliceLine.Position = [iSlice hA.YLim(1); iSlice hA.YLim(2)];

        hA = data.cine.Measure(TagNo+1).hAxis.DA(1);
        data.cine.Measure(TagNo+1).hPlotObj.DASliceLine.Position = [iSlice hA.YLim(1); iSlice hA.YLim(2)];
    else
        data.cine.Measure(TagNo).hPlotObj.TumorSliceLine.Position(1, 1) = iSlice;
        data.cine.Measure(TagNo).hPlotObj.TumorSliceLine.Position(2, 1) = iSlice;
        
        hA = data.cine.Measure(TagNo).hAxis.DA(1);
        data.cine.Measure(TagNo).hPlotObj.DASliceLine.Position = [iSlice hA.YLim(1); iSlice hA.YLim(2)];
    end
end
    
guidata(hFig, data)