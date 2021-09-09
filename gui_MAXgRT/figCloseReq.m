function figCloseReq(src, callbackdata)     % Close all figures

global hFig hFig2
if ishandle(hFig2)
    delete(hFig2)
end

data = guidata(hFig);
if ishandle(data.hFig_Measure_Cine)
    delete(data.hFig_Measure_Cine)
end

delete(src)


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