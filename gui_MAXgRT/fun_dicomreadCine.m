function [data] = fun_dicomreadCine(bSag, bCor, dcmFileName)

nFile = length(dcmFileName);

if bSag && bCor % Sag+Cor
    sag = [];
    cor = [];
    acqt_sag = [];
    acqt_cor = [];
    hWB = waitbar(0);
    for n = 1:nFile
        di = dicominfo(dcmFileName(n));
        iop = di.ImageOrientationPatient;
        I = dicomread(dcmFileName(n));
        
        if iop == [0 1 0 0 0 -1]'  % sag
            sag =  cat(3, sag, I);
            acqt_sag = [acqt_sag; str2double(di.AcquisitionTime)];
            imp_sag = di.ImagePositionPatient;
            ps_sag =  di.PixelSpacing;
        elseif iop == [1 0 0 0 0 -1]'  % cor
            cor =  cat(3, cor, I);
            acqt_cor = [acqt_cor; str2double(di.AcquisitionTime)];
            imp_cor = di.ImagePositionPatient;
            ps_cor =  di.PixelSpacing;
        end
        
        waitbar(n/nFile, hWB, ['Processing ', num2str(n), '/', num2str(nFile)])
    end
    close(hWB);
    data.dcmInfo = di;

    [~, ind] = sort(acqt_sag);
    data.sag = sag(:,:,ind);

    [~, ind] = sort(acqt_cor);
    data.cor = cor(:,:,ind);
    
    data.sc = 'sc';
    data.imp_sag = imp_sag;
    data.imp_cor = imp_cor;
    data.ps_sag = ps_sag;
    data.ps_cor = ps_cor;
    
elseif (bSag && ~bCor) |  (~bSag && bCor) % Sag or cor
    v = [];
    acqt = [];
    hWB = waitbar(0);
    ipp = [];
    for n = 1:nFile
        I = dicomread(dcmFileName(n));
        v = cat(3, v, I);
        di = dicominfo(dcmFileName(n));
        ipp = [ipp di.ImagePositionPatient];
        acqt = [acqt; str2double(di.AcquisitionTime)];
        waitbar(n/nFile, hWB, ['Processing ', num2str(n), '/', num2str(nFile)])
    end
    close(hWB);
    data.dcmInfo = di;

    [~, ind] = sort(acqt);
    data.v = v(:,:,ind);
    
    data.sc = 'sag';
    if bCor
        data.sc = 'cor';
    end
    
    data.IMP = di.ImagePositionPatient;
    data.PS = di.PixelSpacing;
    
end
