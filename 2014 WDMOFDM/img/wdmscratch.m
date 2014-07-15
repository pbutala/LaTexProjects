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
set(0,'DefaultLineMarkerSize',6);

CCTGOOD = 1; SPD = 2; FWHM = 3; CCTBAD = 8;
FLTT = 4; RESP = 5; CMF = 6; NSPD4 = 7;
%***************%
FIG = SPD;
%***************%
PREFIXMOD = '0_';
FSZ = 16;
FSZTB = 16;
MSZ = 8;
fSTATION = 1;   % 1.PHO445 2.ENGGRID 3.LAPTOP
% STATION
switch fSTATION
    case 1
        ctDirRes = 'C:\MyDocuments Local\LaTexProjects\2014 WDMOFDM\img\';
end

switch FIG
    case CCTGOOD
        file = '9e_SNRvsCCT_FILTFWHM40_LEDSD5';
    case CCTBAD
        file = '9e_SNRvsCCT_FILTFWHM250_LEDSD50';
    case SPD
        file = '9e_SNRvsLEDSD_6250K_Nsc64_FILTFWHM40';
    case FWHM
        file = '9e_SNRvsFLTWID_6250K_LEDSD5';
    case FLTT
        file = '9e_FiltTrans_FILTFWHM40';
    case RESP
        file = '9e_RecvResp';
    case CMF
        file = '9e_CIE Standard Observer 1978';
    case NSPD4
        file = '9e_SPDs_LEDSD5';
end

fname = [ctDirRes file];
fnameSave = [ctDirRes PREFIXMOD file];

uiopen([fname '.fig'],1);
fig = gcf;
ax = gca;
set(get(ax,'xlabel'),'fontsize', FSZ);
set(get(ax,'ylabel'),'fontsize', FSZ);
set(get(ax,'title'),'fontsize', FSZ);
set(ax,'fontsize',FSZ);

HLines = findall(gca,'type','line');
switch FIG
    case {CCTGOOD,CCTBAD,SPD,FWHM}
        set(HLines(1:3:4),'Marker','o');
        set(HLines(2:3:5),'Marker','*');
        set(HLines(3:3:6),'Marker','^');
        set(HLines,'MarkerSize',MSZ);
        set(HLines(1:3),'LineStyle','-');
        set(HLines(4:6),'LineStyle',':');
    case {FLTT,CMF}
        hold on;
        Xs = get(HLines(1),'XData');
        Ys = get(HLines(1),'YData');
        [Xp,Yp] = getCleanPoints(Xs,Ys*400,15);
        scatter(Xp,Yp/400,48,'bo','LineWidth',2);
        
        Xs = get(HLines(2),'XData');
        Ys = get(HLines(2),'YData');
        [Xp,Yp] = getCleanPoints(Xs,Ys*400,15);
        scatter(Xp,Yp/400,48,'g*','LineWidth',2);
        
        Xs = get(HLines(3),'XData');
        Ys = get(HLines(3),'YData');
        [Xp,Yp] = getCleanPoints(Xs,Ys*400,15);
        scatter(Xp,Yp/400,48,'r^','LineWidth',2);
        
        HLGD(1) = plot(nan,nan,'r-^','LineWidth',2,'MarkerSize',MSZ);
        HLGD(2) = plot(nan,nan,'g-*','LineWidth',2,'MarkerSize',MSZ);
        HLGD(3) = plot(nan,nan,'b-o','LineWidth',2,'MarkerSize',MSZ);
        
        set(HLines(1:3),'LineStyle','-');
    case RESP
        AX = get(gcf,'children');
        H1 = findall(AX(1),'type','line');
        set(H1,'LineStyle','-');
        set(AX(1),'YTickMode','Manual','YTick',[0:0.2:1]','YTickLabel',[0:0.2:1]');
        H2 = findall(AX(2),'type','line');
        set(H2,'LineStyle',':');
        set(AX(2),'YTickMode','Manual','YTick',[0:0.2:1]','YTickLabel',[0:0.2:1]');
        legend('Quantum Efficiency','Responsivity');
    case NSPD4
end

set(legend,'fontsize',12,'Location','NorthEast');

strT = sprintf('');
title(gca,strT);

switch FIG
    case CCTGOOD % SNR v CCT
        xlabel('Correlated color temperature (K)');
        annotation('ellipse','Position',[0.75 0.295 0.05 0.16],'LineWidth',2);
        annotation('textbox','String',sprintf('Power efficient\nCCT = 6250 K'),'FontSize',FSZTB,'Position',[0.675 0.4 0.35 0.16],'EdgeColor','none');
    case CCTBAD % SNR v CCT
        xlabel('Correlated color temperature (K)');
        annotation('ellipse','Position',[0.28 0.39 0.05 0.275],'LineWidth',2);
        annotation('textbox','String',sprintf('Power efficient\nCCT = 3500 K'),'FontSize',FSZTB,'Position',[0.305 0.375 0.35 0.4],'EdgeColor','none');
        set(legend,'fontsize',12,'Location','SouthEast');
    case SPD % SNR v SPD
        xlabel('Transmitting element SPD spread (nm)');
        annotation('ellipse','Position',[0.115 0.295 0.03 0.16],'LineWidth',2);
        annotation('textbox','String',sprintf('Power efficient\nSPD spread = 5 nm'),'FontSize',FSZTB,'Position',[0.135 0.13 0.4 0.16],'EdgeColor','none');
    case FWHM % SNR v FWHM
        xlabel('Filter FWHM (nm)');
        annotation('ellipse','Position',[0.236 0.295 0.03 0.16],'LineWidth',2);
        annotation('textbox','String',sprintf('Power efficient\nFWHM = 40 nm'),'FontSize',FSZTB,'Position',[0.15 0.39 0.35 0.16],'EdgeColor','none');
    case FLTT
        ylabel('Transmittance');
        legend(gca,HLGD,{'Red Filter','Green Filter','Blue Filter'});
        grid on;
    case RESP
        grid on;
    case CMF
        legend off;
        legend(gca,HLGD,{'x_c(\lambda)','y_c(\lambda)','z_c(\lambda)'});
        ylabel('Chromatic Response');
end

saveas(fig,[fnameSave '.fig'],'fig');
saveas(fig,[fnameSave '.png'],'png');
saveas(fig,[fnameSave '.eps'],'epsc');
