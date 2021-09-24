function figCloseReq(src, callbackdata)     % Close all figures
% global hFig hFig2

delete(findall(groot))

% if ishandle(hFig2)
%     delete(hFig2)
% end
% 
% data = guidata(hFig);
% if isfield(data, 'Measure_Cine')
%     if ishandle(data.Measure_Cine.hFig)
%         delete(data.Measure_Cine.hFig)
%     end
% end
% delete(src)


%    selection = questdlg('Close This Figure?',...
%       'Close Request Function',...
%       'Yes','No','Yes'); 
%    switch selection 
%       case 'Yes'
%          delete(gcf)
%       case 'No'
%       return 
%    end
% end