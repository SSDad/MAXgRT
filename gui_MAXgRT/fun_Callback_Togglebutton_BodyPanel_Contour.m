function fun_Callback_Togglebutton_BodyPanel_Contour(src, evnt)

global AbBoundLim
global stopBodySlither 

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

if strcmp(src.String, 'Delineate')
    src.String = 'Stop';
    src.ForegroundColor = 'r';

x0 = data.Image.x0;
y0 = data.Image.y0;
dx = data.Image.dx;
dy = data.Image.dy;

II = data.Image.Images;

nSlices = data.Image.nSlices;
hBody = data.Panel.View.Comp.hPlotObj.Body;
hAb = data.Panel.View.Comp.hPlotObj.Ab;
hSnake = data.Panel.View.Comp.hPlotObj.Snake;

mBound = round((AbBoundLim-y0)/dy);

data.Body.Contours = cell(nSlices, 1);
data.Body.AbsContours = cell(nSlices, 1);

for iSlice = 1:nSlices
    
    if stopBodySlither
        break;
    end
    
    bC = []; % body Contour
    abC2 = []; % abdomen Contour
    J = II{iSlice};
    if data.Tumor.indC(iSlice) > 1 % gating or tracking contour on image
        
        [abC2] = fun_findAb(J, mBound);
        
%         BW = im2bw(J, 0.05);
%         BW = imfill(BW, 8, 'holes');
% %         BW21 = bwareaopen(BW2, round(data.Image.mImgSize*data.Image.nImgSize/10));
% %         BW3 = bwconvhull(BW21);
%         bd = bwboundaries(BW);
% 
%         idx = 1;
%         if length(bd) > 1
%             for n = 1:length(bd)
%                 nP(n) = size(bd{n}, 1);
%             end
%             [~, idx] = max(nP);
%         end
%         bC = bd{idx}; %Boundary Contour
%         
%         % smooth
%         % sC(:, 1) = sgolayfilt(sC(:, 1), 3, 75);
%         bC(:, 2) = sgolayfilt(bC(:, 2), 3, 75);
        
%         data.Body.Contours{iSlice} = bC; % 1 - row, 2 - column
        
        % ab
%         % lower than left end of diaphram and on left of diaphram
        sC = data.Snake.Snakes{iSlice}; % diaphragm Contour, 1 - column, 2 - row
%        [n1, idx] = min(sC(:, 1));
%         m1 = sC(idx, 2);
%         m2 = size(J, 1);
   
%         ind1 = bC(:, 1) > mBound(1) & bC(:, 1) < mBound(2);
%         abC1 = bC(ind1, :);
%         
%         n1 = mean(abC1(:, 2));
%         ind2 =  abC1(:, 2) < n1;
%         abC2 = abC1(ind2, :);
%         
%         [~, idx] = min(abC2(:, 1));
%         abC2 = circshift(abC2, -idx, 1);
%         
%         [~, idx] = min(abC2(:,1));
%         if idx > 5
%             abC2 = flip(abC2);
%         end
%         abC2(:, 2) = sgolayfilt(abC2(:, 2), 3, 75);
        data.Body.AbsContours{iSlice} = abC2; % 1 - row, 2 - column

    end
    
    % update slice iamge
%     data.Panel.View.Comp.hPlotObj.Image.CData = rot90(data.Image.Images{iSlice}, 3);
    data.Panel.View.Comp.hPlotObj.Image.CData = J;
    if isempty(abC2)
        hBody.YData = [];
        hBody.XData = [];
        hAb.YData = [];
        hAb.XData = [];
        hSnake.YData = [];
        hSnake.XData = [];
    else
%        hBody.YData = (bC(:, 1)-1)*dy+y0;
%        hBody.XData = (bC(:, 2)-1)*dx+x0;
        hAb.YData = (abC2(:, 1)-1)*dy+y0;
        hAb.XData = (abC2(:, 2)-1)*dx+x0;
        if ~isempty(sC)
            hSnake.YData = (sC(:, 2)-1)*dy+y0;
            hSnake.XData = (sC(:, 1)-1)*dx+x0;
        end
    end
    data.Panel.SliceSlider.Comp.hSlider.Slice.Value = iSlice;
    data.Panel.SliceSlider.Comp.hText.nImages.String = [num2str(iSlice), ' / ', num2str(nSlices)];
    
    %tumor center
    data.Panel.View.Comp.hPlotObj.TumorCent.XData = data.Tumor.cent.x(iSlice);
    data.Panel.View.Comp.hPlotObj.TumorCent.YData = data.Tumor.cent.y(iSlice);

    
    if data.Point.InitDone
        % points on contour
        xi = data.Point.Data.xi;
        yi = data.Point.Data.yi;
        ixm = data.Point.Data.ixm;
        NP = data.Point.Data.NP;

        hPlotObj = data.Panel.View.Comp.hPlotObj;
        hPlotObj.Point.XData = xi(ixm);
        hPlotObj.Point.YData = yi(iSlice, ixm);
        hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
        hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
        hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
        hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);

        % point of current slice on points plot
        data2.Panel.View.Comp.hPlotObj.PlotPoint.Current.XData = iSlice;
        data2.Panel.View.Comp.hPlotObj.PlotPoint.Current.YData = mean(yi(iSlice, ixm-NP:ixm+NP));
    end

    drawnow;
    
%     pause(0.1);
end

    if stopBodySlither
       
%         hPlotObj.Snake.XData = [];
%         hPlotObj.Snake.YData = [];
        
    else
        data.Body.ContourDone = 1;
        data.Panel.Body.Comp.Pushbutton.SaveContour.Enable = 'on';
    end

    src.String = 'Delineate';
    src.ForegroundColor = 'c';
    stopBodySlither = false;
    src.Value = 0;
else
    stopBodySlither = true;
end

guidata(hFig, data)
