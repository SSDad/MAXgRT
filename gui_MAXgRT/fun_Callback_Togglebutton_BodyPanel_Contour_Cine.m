function fun_Callback_Togglebutton_BodyPanel_Contour_Cine(src, evnt)

global AbBoundLim_Cine
global stopBodySlither 

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

if strcmp(src.String, 'Delineate')
    src.String = 'Stop';
    src.ForegroundColor = 'r';

    TagNo = data.CineActiveTagNo;
    
    x0 = data.cine(TagNo).x0;
    y0 = data.cine(TagNo).y0;
    dx = data.cine(TagNo).dx;
    dy = data.cine(TagNo).dy;

% II = data.Image.Images;

nSlices = data.cine(TagNo).nSlice;
hBody = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Body;
hAb = data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Ab;
% hSnake = data.Panel.View.Comp.hPlotObj.Snake;

mBound = round((AbBoundLim_Cine{TagNo}-y0)/dy);

data.cine(TagNo).Body.Contours = cell(nSlices, 1);
data.cine(TagNo).Body.AbsContours = cell(nSlices, 1);

for iSlice = 1:nSlices
    
    if stopBodySlither
        break;
    end
    
    bC = []; % body Contour
    abC2 = []; % abdomen Contour
    J = data.cine(TagNo).v(:,:,iSlice);
%     if data.Tumor.indC(iSlice) > 1 % gating or tracking contour on image
        
        [abC2] = fun_findAb_Cine(J, mBound, TagNo);
        
%         sC = data.Snake.Snakes{iSlice}; % diaphragm Contour, 1 - column, 2 - row
        data.cine(TagNo).Body.AbsContours{iSlice} = abC2; % 1 - row, 2 - column

%     end
    
    % update slice iamge
   data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.Image.CData = J;
    if isempty(abC2)
        hBody.YData = [];
        hBody.XData = [];
        hAb.YData = [];
        hAb.XData = [];
%         hSnake.YData = [];
%         hSnake.XData = [];
    else
%        hBody.YData = (bC(:, 1)-1)*dy+y0;
%        hBody.XData = (bC(:, 2)-1)*dx+x0;
        hAb.YData = (abC2(:, 1)-1)*dy+y0;
        hAb.XData = (abC2(:, 2)-1)*dx+x0;
%         if ~isempty(sC)
%             hSnake.YData = (sC(:, 2)-1)*dy+y0;
%             hSnake.XData = (sC(:, 1)-1)*dx+x0;
%         end
    end
    data.Panel.View_Cine.subPanel(TagNo).ssPanel(4).Comp.hSlider.Slice.Value = iSlice;
    data.Panel.View_Cine.subPanel(TagNo).ssPanel(4).Comp.hText.nImages.String...
        = [num2str(iSlice), ' / ', num2str(data.cine(TagNo).nSlice)];
    
%     %tumor center
%     data.Panel.View.Comp.hPlotObj.TumorCent.XData = data.Tumor.cent.x(iSlice);
%     data.Panel.View.Comp.hPlotObj.TumorCent.YData = data.Tumor.cent.y(iSlice);

    
%     if data.Point.InitDone
%         % points on contour
%         xi = data.Point.Data.xi;
%         yi = data.Point.Data.yi;
%         ixm = data.Point.Data.ixm;
%         NP = data.Point.Data.NP;
% 
%         hPlotObj = data.Panel.View.Comp.hPlotObj;
%         hPlotObj.Point.XData = xi(ixm);
%         hPlotObj.Point.YData = yi(iSlice, ixm);
%         hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
%         hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
%         hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
%         hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);
% 
%         % point of current slice on points plot
%         data2.Panel.View.Comp.hPlotObj.PlotPoint.Current.XData = iSlice;
%         data2.Panel.View.Comp.hPlotObj.PlotPoint.Current.YData = mean(yi(iSlice, ixm-NP:ixm+NP));
%     end

    drawnow;
    
%     pause(0.1);
end

    if stopBodySlither
       
%         hPlotObj.Snake.XData = [];
%         hPlotObj.Snake.YData = [];
        
%     else
%         data.Body.ContourDone = 1;
%         data.Panel.Body.Comp.Pushbutton.SaveContour.Enable = 'on';
    end

    stopBodySlither = false;
else
    stopBodySlither = true;
end

    src.String = 'Delineate';
    src.ForegroundColor = 'c';
    src.Value = 0;

guidata(hFig, data)
