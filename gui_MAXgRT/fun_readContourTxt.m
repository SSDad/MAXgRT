function contData = fun_readContourTxt(ffn)

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
ratio = eval(tt{1}(k+2:k+8));

tt = tt(1:end-1);
ind_img = find(contains(tt, 'Image Id', 'IgnoreCase', true));%, 'IgnoreCase', true));