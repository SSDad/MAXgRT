function Callback_Ethos_Tx_MenuItem_New_(src, evnt)

hFig = ancestor(src, 'Figure');
aObj = findobj(hFig);
for n = 1:length(aObj)
    tagFC = aObj(n).Tag;
    if strcmp(tagFC, 'FirstColumn_Panel')
        break
    end
end

nT = length(aObj(n).Children) - 1;

pos = hFig.Position;
dh = pos(4)/(1/2+nT);
hFig.Position(2) = pos(2) - dh;
hFig.Position(4) = pos(4) + dh;

% data = guidata(hFig);
% 
% iFig = str2double(src.Tag);
% data.Ethos.TxTable(iFig).hFig.Visible = 'on';


% bSimData = 0;
% if strcmp(src.Tag, 'Save Data')
%     for iS = 1:3
%         SimuData{iS} = nan(6,3);
%         for iR = 1:6
%             for iC = 1:3
%                 str = data.Ethos.Panel.Table.Comp.SimTable(iS).hEdit(iR, iC).String;
%                 if ~isempty(str)
%                     SimuData{iS}(iR, iC) = str2double(str);
%                 end
%             end
%         end
%         if ~all(isnan(SimuData{iS}(:)))
%             bSimData = 1;
%         end
%     end
%     
%     % save sim data
%     if bSimData
%         MRN = data.Ethos.Panel.PtInfo.Comp.Edit.MRN.String;
%         Fx = data.Ethos.Panel.PtInfo.Comp.Edit.Fraction.String;
%         fd = fullfile(data.Ethos.fd_Ethos, MRN);
%         if ~exist(fd, 'dir')
%             mkdir(fd);
%         end
%         ffn = fullfile(fd, 'SimData');
%         save(ffn, 'SimuData');
% 
%         msg = {'Sim data have been saved in:'; ffn};
%         fun_messageBox(msg);
% 
%     end
% elseif strcmp(src.Tag, 'New CBCT_Tx')
%     createFig_Ethos_Tx;
%     
% end