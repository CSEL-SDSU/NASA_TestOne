clc; clear; close all;

%Load data
grid_file = "axiFixedGrid.cgns";
datafile = "axiSmolderingReactions.cgns";

grid = load_cgns(grid_file);
data = load_cgns(datafile);

grid = [round(grid(:,1:end-1), 15) grid(:,end)];
data = [round(data(:,1:end-1), 15) data(:,end)];

%Setup grid
x0 = min(grid.CoordinateX); 
x1 = max(grid.CoordinateX);

r0 = min(grid.CoordinateY);
r1 = max(grid.CoordinateY);

Nx = 1068; %
Nr = 127; %
dx = (x1 - x0)/(Nx-1);
dr = (r1 - r0)/(Nr-1);

xx = x0:dx:x1;
rr = r0:dr:r1;

[Rq,Xq] = meshgrid(rr,xx);

%Interpolate data from table to grid
RRC = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Net_Reaction_Rate_of_c6h10o5,Rq,Xq);
KRRC = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.("Kinetic_Rate_of_Reaction-1"),Rq,Xq);
KRRP = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.("Kinetic_Rate_of_Reaction-2"),Rq,Xq);

%Cutout sample
[~,fr] = find(Rq >= 0 & Rq <= 0.00979);
[fx,~] = find(Xq >= 0.134 & Xq <= 0.439);
RRC(unique(fx(:)).',unique(fr(:)).') = NaN;
KRRC(unique(fx(:)).',unique(fr(:)).') = NaN;
KRRP(unique(fx(:)).',unique(fr(:)).') = NaN;

%Fix dome interpolation
rd = 0.127;
tta = linspace(0,2*pi,100);
xc = 0.902 + rd.*cos(tta);
rc = rd.*sin(tta);

in = inpolygon(Rq,Xq,rc,xc);

for i=1:Nx
    for j=1:Nr
        if Rq(i,j) > 0.0127 && Xq(i,j) > 0.902 && in(i,j) == false
            RRC(i,j) = NaN;
            KRRC(i,j) = NaN;
            KRRP(i,j) = NaN;
        end
    end
end

%Equivalence Ratio math (use mass fractions)
% fs = 0.197;
% EQR = (fuel./(n2+o2))./fs;
% EQR(EQR>2.5) = NaN;
% levels =  [0.1 0.5 1 1.5 2];

%%%Setup and contour figure
f = figure();
ax = axes(f);
hold on

rectangle('Position',[0 0.134 0.00979 0.305])

[C,h] = contourf(ax,Rq,Xq,KRRC.*10^4,100,"LineColor",'none');
ylim([0.134 0.439])
xlim([0 0.03])
colormap("hot")
%colormap(flipud(hot))
%clabel(C,h,'manual')
pbaspect([1 8.41 1])
% set(gca,'TickDir','out');
%ylim([0.134 0.439])
%xlim([0 0.03])
% clim([0 2.5])

% hold on %To indicate sensor senor location
% scatter(0.12,0.085,10,"o","filled",'k')

cbar = colorbar(ax);
cbar.Label.String = "Reaction Rate *10^-^4 [kmol/(m^3 s)]";

ylabel("Distance from Inlet [m]")
xlabel("r-coordinate [m]")

title("Kinetic Rate of Combustion Reaction")
fontsize(12,"points")
