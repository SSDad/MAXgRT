function fun_readCineDicom(dcmPath, matPath) 

dcmC = dicomCollection(dcmPath);

for idx = 1:size(dcmC,1)
    dicomFileName = dcmC.Filenames{idx};
%     if length(dicomFileName) > 1
%         matFileName = fileparts(dicomFileName(1));
%         matFileName = split(matFileName,filesep);
%         matFileName = replace(strtrim(matFileName(end))," ","_");
%     else
%         [~,matFileName] = fileparts(dicomFileName);
%     end

    junk = dcmC.SeriesDescription{idx};
    bSag = contains(junk, 'sag', 'IgnoreCase',true);
    bCor = contains(junk, 'cor', 'IgnoreCase',true);
%     if bSag && bCor
%         strSC = 'sc';
%     elseif bSag && ~bCor
%         strSC = 'sag';
%     elseif ~bSag && bCor
%         strSC = 'cor';
%     end
%     
%     try
%         cineData = dicomreadVolume(dcmC, dcmC.Row{idx});
%     catch ME
%         nFile = length(dicomFileName);
%         if nFile > 1 % cine
%             junk = dcmC.SeriesDescription{idx};
%             bSag = contains(junk, 'sag', 'IgnoreCase',true);
%             bCor = contains(junk, 'cor', 'IgnoreCase',true);
            
            [cineData] = fun_dicomreadCine(bSag, bCor, dicomFileName);

%         else % single dicom
%             cineData = dicomread(dicomFileName);
%         end
%     end    
% For complete volumes returned in a 4-D array, write the data and the absolute file name to a MAT file.

    matFileName = fullfile(matPath, [cineData.sc, '.mat']);
    save(matFileName,'cineData');
% End the loop over the studies in the collection.

end