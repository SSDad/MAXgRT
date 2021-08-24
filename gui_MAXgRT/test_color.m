clearvars

CLR{1} = '#FFFF0000';
CLR{2} = '#FFA52A2A';
CLR{3} = '#FF00FFFF';

x = linspace(0, pi, 100);

for n = 1:length(CLR)
    c = validatecolor(CLR{n}(1:7));
    line(x, sin(n*x), 'Color', c');
end

set(gca, 'Color', 'k')