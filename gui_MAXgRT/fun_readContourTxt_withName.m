function contData = fun_readContourTxt_withName(ffn)

fid = fopen(ffn);
n = 1;
tline = fgetl(fid);
tt{n} = tline;
m = 0;
while ischar(tline)
    tline = fgetl(fid);
    
    n = n+1;
%     tt{n} =convertCharsToStrings(tline);
    tt{n} =tline;

%     display(tline);
%     if contains(tline,'Image Id')
%         m = m + 1;
%         ind_img(m) = n;
%     end
    
end
fclose(fid);

k = strfind(tt{1}, '=');
contData.ratio = eval(tt{1}(k+2:k+8));

tt = tt(1:end-1);
ind_img = find(contains(tt, 'Image Id', 'IgnoreCase', true));%, 'IgnoreCase', true));

for n = 1:length(ind_img)-1
    m1 = ind_img(n)+1;
    m2 = ind_img(n+1)-1;
    if m2 > m1
        imgTxt = tt(m1:m2);
        contData.data(n).cont = fun_readImgContour(imgTxt);
    end
end
% last slice
nLine = length(tt);
if nLine >  ind_img(end)
    imgTxt = tt(ind_img(end)+1:nLine);
    contData.data(n+1).cont = fun_readImgContour(imgTxt);
end    

end

function cont =  fun_readImgContour(imgTxt)
    ind = find(contains(imgTxt, 'Color = ', 'IgnoreCase', true));%, 'IgnoreCase', true));
    for n = 1:length(ind)
        idx = strfind(imgTxt{ind(n)}, '#');
        cont(n).CLR = imgTxt{ind(n)}(idx:idx+8);
        
        junk = imgTxt{ind(n)+1}(3:end-2);
        junk1 = strrep(junk, ',', ' ');
        junk2 = str2num(junk1);
        cont(n).pt = (reshape(junk2, 2, []))';
        
    end
end