% wdmscratch
close all;
clearvars;
clc;

dfigppm = get(0,'DefaultFigurePaperPositionMode');
set(0,'DefaultFigurePaperPositionMode','Manual');
dfigpu = get(0,'DefaultFigurePaperUnits');
set(0,'DefaultFigurePaperUnits','Inches');
dfigpp = get(0,'DefaultFigurePaperPosition');
set(0,'DefaultFigurePaperPosition',[0 0 8 6]);
dlinems = get(0,'DefaultLineMarkerSize');
set(0,'DefaultLineMarkerSize',8);

PREFIXMOD = '0_';
FSZ = 16;
fSTATION = 1;   % 1.PHO445 2.ENGGRID 3.LAPTOP
% STATION
switch fSTATION
    case 1
        ctDirRes = 'C:\MyDocuments Local\LaTexProjects\2014 WDMOFDM\img\';
end

file = '9e_SNRvsLEDSD_4000K_Nsc64_FILTFWHM60';

fname = [ctDirRes file];
fnameSave = [ctDirRes PREFIXMOD file];

uiopen([fname '.fig'],1);
fig = gcf;
ax = gca;
set(get(ax,'xlabel'),'fontsize', FSZ);
set(get(ax,'ylabel'),'fontsize', FSZ);
set(get(ax,'title'),'fontsize', FSZ);
set(ax,'fontsize',FSZ);
set(legend,'fontsize',12,'Location','NorthEast');
strT = sprintf('');
title(gca,strT);


saveas(fig,[fnameSave '.fig'],'fig');
saveas(fig,[fnameSave '.png'],'png');
saveas(fig,[fnameSave '.eps'],'epsc');
