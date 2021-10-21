function Callback_Cine_Pushbutton_Measure_SavePDF(src, evnt)

addpath(fullfile(pwd, 'inputdlg'));

global hFig
data = guidata(hFig);
TagNo = data.cine.ActiveTagNo;

FigName{1} = 'Sagittal';
FigName{2} = 'Coronal';
FigName{3} = 'SagSC';

datafd = data.cine.fd_Cine;
MRN = data.cine.data(1).dcmInfo.PatientID;

%% save data
% prompt = {'\fontsize{16} Enter suffix:'};
prompt = {'Enter suffix:'};
dlgtitle = 'Analysis Suffix';
dims = [1 50];
definput = {''};
opts.Interpreter = 'tex';
suffix = fun_inputdlg(prompt, dlgtitle, dims, definput, opts);

if ~isempty(suffix)
    ffn{1} = fullfile(datafd, [MRN, '_Image_', FigName{TagNo}, '_', suffix{1}, '.pdf']);
    ffn{2} = fullfile(datafd, [MRN, '_Wave_', FigName{TagNo}, '_', suffix{1}, '.pdf']);

    hF(1) = hFig;
    hF(2) = data.cine.Measure(TagNo).hFig;
    
    for m = 1:2
        set(hF(m), 'Units', 'Inches');
        pos = get(hF(m), 'Position');
        set(hF(m), 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)])
        print(hF(m), ffn{m}, '-dpdf', '-r0')
        set(hF(m), 'Units', 'normalized');
    end
    msg{1} = '     Image and Wave have been saved in PDF...';
    msg{2} = ' ';
    msgColor = 'g';
    [hMB_saveData] = fun_messageBox2('Save PDF', msg, msgColor);
end

