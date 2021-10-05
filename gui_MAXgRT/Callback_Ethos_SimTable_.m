 function Callback_Ethos_SimTable_(src, evnt)

global hFig 

% data = guidata(hFig);
% 
% tagString = src.Tag;
% TagNo = str2num(tagString(5));
% MCI = tagString(6:7);
% row = str2num(tagString(8));
% col = str2num(tagString(9));
% 
% if strcmp(MCI, 'mr')
%     hT = data.MCI_Cine.Table.MRI;
% elseif strcmp(MCI, 'ct')
%     hT = data.MCI_Cine.Table.CBCT;
% end
% 
% xLim = data.cine(TagNo).RA.XWorldLimits;
% yLim = data.cine(TagNo).RA.YWorldLimits;
% 
% xp = nan;
% yp = nan;
% if col == 1
%     junk = str2double(src.String);
%     if junk > xLim(1) && junk<xLim(2)
%         xp = junk;
%         
%         junk2 = str2double(hT.hEdit(row, 2).String);
%         if ~isnan(junk2)
%             if junk2 > yLim(1) && junk<yLim(2)
%                 yp = junk2;
%             end
%         end
%     end
% end
% 
% data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MRICH(row).Visible = 'on';
% set(data.Panel.View_Cine.subPanel(TagNo).ssPanel(3).Comp.hPlotObj.MRICH(row), ...
%     'XData', xp, 'YData', yp);