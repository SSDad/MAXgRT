function Callback_Pushbutton_SnakePanel_FreeHand(src, evnt)

global hFig hFig2 contrastRectLim

data = guidata(hFig);

%% slice No.
startSlice = str2double(data.Panel.Snake.Comp.Edit.StartSlice.String);
endSlice = str2double(data.Panel.Snake.Comp.Edit.EndSlice.String);


%% Mode
if strcmp(data.bMode, 'V') % ViewRay
% if strcmp(data.hMenuItem.Cine.Checked, 'off')  % ViewRay
    hSlider = data.Panel.SliceSlider.Comp.hSlider.Slice;
    iSlice = round(hSlider.Value);
else % Cine
    TagNo = data.CineActiveTagNo;
end

if strcmp(data.bMode, 'V') % ViewRay
    if iSlice < startSlice || iSlice > endSlice
        iSlice = startSlice;
        hSlider.Value = iSlice;
        data.Panel.SliceSlider.Comp.hText.nImages.String = [num2str(iSlice), ' / ', num2str(data.Image.nImages)];

        % image
        I = rot90(data.Image.Images{iSlice}, 3);

        % contrast limit
        maxI = max(I(:));
        minI = min(I(:));
        wI = maxI-minI;
        cL1 = minI+wI*contrastRectLim(1);
        cL2 = minI+wI*contrastRectLim(2);
        I(I<cL1) = cL1;
        I(I>cL2) = cL2;

        hPlotObj = data.Panel.View.Comp.hPlotObj;
        hPlotObj.Image.CData = I;
    end

    % remove snake
    hPlotObj = data.Panel.View.Comp.hPlotObj;
    hPlotObj.Snake.YData = [];
    hPlotObj.Snake.XData = [];

    %%%%%%%%%%%%%%%%%
    if data.Point.InitDone
        data.Point.Data.yi(iSlice, :) = NaN;

        hPlotObj.Point.XData = [];
        hPlotObj.Point.YData = [];
        hPlotObj.LeftPoints.XData = [];
        hPlotObj.LeftPoints.YData = [];
        hPlotObj.RightPoints.XData = [];
        hPlotObj.RightPoints.YData = [];

        guidata(hFig, data)
        updatePlotPoint
    end
    %%%%%%%%%%%%%%%%%

    hA = data.Panel.View.Comp.hAxis.Image;
    % uistack(hA, 'top');

    axis(hA);
    L = images.roi.AssistedFreehand(hA,...
        'Image', data.Panel.View.Comp.hPlotObj.Image, ...
        'Closed', 0);
    % L = images.roi.AssistedFreehand('Image', data.Panel.View.Comp.hPlotObj.Image, ...
    %     'Closed', 0);
    draw(L);

elseif strcmp(data.bMode, 'C') % Cine
    hA = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hAxis.Image;
    % uistack(hA, 'top');

    axis(hA);
    L = images.roi.AssistedFreehand(hA,...
        'Image', data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Image, ...
        'Closed', 0);
    % L = images.roi.AssistedFreehand('Image', data.Panel.View.Comp.hPlotObj.Image, ...
    %     'Closed', 0);
    draw(L);
end    
    
data.Snake.FreeHand.L = L;
data.Snake.FreeHand.Done = true;

data.Panel.Snake.Comp.Togglebutton.Slither.Enable = 'on';
data.Panel.Snake.Comp.Togglebutton.Slither.ForegroundColor = 'g';

%% save
guidata(hFig, data);                