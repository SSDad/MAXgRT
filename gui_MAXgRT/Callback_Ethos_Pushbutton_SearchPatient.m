function Callback_Ethos_Pushbutton_SearchPatient(src, evnt)

global hFig

data = guidata(hFig);
fd_Ethos = data.Ethos.fd_Ethos;

dname = uigetdir(fd_Ethos);
if dname ~= 0
    [~, MRN] = fileparts(dname);
    fd = fullfile(fd_Ethos, MRN);
    
    ffn_sim = fullfile(fd, 'SimData.mat');
    if exist(ffn_sim, 'file')
        load(ffn_sim);
        for iS = 1:3
            for iR = 1:6
                for iC = 1:3
                    val = SimuData{iS}(iR, iC);
                    if ~isnan(val)
                        data.Ethos.Panel.Table.Comp.SimTable(iS).hEdit(iR, iC).String = num2str(val);
                    end
                end
            end
        end
        
        data.Ethos.Panel.PtInfo.Comp.Edit.MRN.String = MRN;
        
    end
    
    guidata(hFig, data);
end