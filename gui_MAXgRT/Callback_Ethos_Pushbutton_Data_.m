function Callback_Ethos_Pushbutton_Data_(src, evnt)

hFig = ancestor(src, 'Figure');
data = guidata(hFig);

bSimData = 0;
if strcmp(src.Tag, 'Save Data')
    for iS = 1:3
        SimuData{iS} = nan(6,3);
        for iR = 1:6
            for iC = 1:3
                str = data.Ethos.Panel.Table.Comp.SimTable(iS).hEdit(iR, iC).String;
                if ~isempty(str)
                    SimuData{iS}(iR, iC) = str2double(str);
                end
            end
        end
        
        if ~all(isnan(SimuData{iS}(:)))
            bSimData = 1;
        end
        
    end
    
    if bSimData
        MRN = data.Ethos.Panel.PtInfo.Comp.Edit.MRN.String;
        Fx = data.Ethos.Panel.PtInfo.Comp.Edit.Fraction.String;
        fd = fullfile(data.Ethos.fd_Ethos, MRN);
        if ~exist(fd, 'dir')
            mkdir(fd);
        end
        ffn = fullfile(fd, 'SimData');
        save(ffn, 'SimuData');

        msg = {'Sim data have been saved in:'; ffn};
        fun_messageBox(msg);

    end
end