%Creates plots/ contours of saved solution variables
clc; clear; close all;

%Load data
grid_file = "axiFixedGrid.cgns";
datafile = "axiSmoldering.cgns";

grid = load_cgns(grid_file);
data = load_cgns(datafile);

grid = [round(grid(:,1:end-1), 15) grid(:,end)];
data = [round(data(:,1:end-1), 15) data(:,end)];

%Setup grid
x0 = min(grid.CoordinateX); 
x1 = max(grid.CoordinateX);

r0 = min(grid.CoordinateY);
r1 = max(grid.CoordinateY);

Nx = 1068; %1068  or 750 both
Nr = 127; %127
dx = (x1 - x0)/(Nx-1);
dr = (r1 - r0)/(Nr-1);

xx = x0:dx:x1;
rr = r0:dr:r1;

[Rq,Xq] = meshgrid(rr,xx);

%Interpolate data from table to grid
T = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Temperature,Rq,Xq);
V = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Axial_Velocity,Rq,Xq);
P = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Pressure,Rq,Xq);
D = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Density_All,Rq,Xq);
h2o = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Mass_fraction_of_h2o,Rq,Xq);
co2 = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Mass_fraction_of_co2,Rq,Xq);
o2 = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Mass_fraction_of_o2,Rq,Xq);
n2 = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Mass_fraction_of_n2,Rq,Xq);
fuel = griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Mass_fraction_of_c6h10o5,Rq,Xq);

%Cutout sample
[~,fr] = find(Rq >= 0 & Rq <= 0.010345);
[fx,~] = find(Xq >= 0.134 & Xq <= 0.439);
T(unique(fx(:)).',unique(fr(:)).') = NaN;
V(unique(fx(:)).',unique(fr(:)).') = NaN;
P(unique(fx(:)).',unique(fr(:)).') = NaN;
D(unique(fx(:)).',unique(fr(:)).') = NaN;
h2o(unique(fx(:)).',unique(fr(:)).') = NaN;
co2(unique(fx(:)).',unique(fr(:)).') = NaN;
o2(unique(fx(:)).',unique(fr(:)).') = NaN;
n2(unique(fx(:)).',unique(fr(:)).') = NaN;
fuel(unique(fx(:)).',unique(fr(:)).') = NaN;

%Fix dome interpolation
rd = 0.127;
tta = linspace(0,2*pi,100);
xc = 0.902 + rd.*cos(tta);
rc = rd.*sin(tta);

in = inpolygon(Rq,Xq,rc,xc);

for i=1:Nx
    for j=1:Nr
        if Rq(i,j) > 0.0127 && Xq(i,j) > 0.902 && in(i,j) == false
            T(i,j) = NaN;
            V(i,j) = NaN;
            P(i,j) = NaN;
            D(i,j) = NaN;
            h2o(i,j) = NaN;
            co2(i,j) = NaN;
            o2(i,j) = NaN;
            n2(i,j) = NaN;
            fuel(i,j) = NaN;
        end
    end
end

%Equivalence Ratio math (use mass fractions)
fs = 0.197;
EQR = (fuel./(n2+o2))./fs;
EQR(EQR>2.5) = NaN;
levels =  [0.1 0.5 1 1.5 2];

%%%Setup and contour figure
f = figure();
ax = axes(f);

[~,h] = contourf(ax,Rq,Xq,EQR,100,"LineColor","none");
pbaspect([1 8.41 1])
ylim([0.134 0.439])
xlim([0 0.03])

% hold on %To indicate sensor senor location
% scatter(0.12,0.085,10,"o","filled",'k')

hold on %To indicate sample position
rectangle('Position',[0 0.134 0.00979 0.305],"FaceColor",'none')

cbar = colorbar(ax);
cbar.Label.String = "Mass Fraction";

ylabel("Distance from Inlet [m]")
xlabel("r-coordinate [m]")

title("Cellulose Mass Fraction at Sample Surface")
fontsize(12,"points")

%%%Indexing and contour figure for velocity and temperature
% figure();
% hold on
% 
% idx1 = 95; %134.6mm %95 %144
% skip = 35; %50mm %35 %53
% 
% for i = 0:6 %0:6 for wall 7:10+ for plume
%     plot(Rq(idx1+skip*i,:),T(idx1+skip*i,:),"DisplayName",134+50*i + "mm")
% end
% 
% legend
% xlim([0.00979 0.05])
% 
% ylabel("Velocity [m/s]")
% xlabel("r-coordinate [m]")
% 
% title("Velocity")
% fontsize(12,"points")

%%%Centerline velocity and temperature
% f = figure();
% 
% plot(Xq(309:end-1,4),T(309:end-1,4))
% 
% %xlim([0.439 1.068])
% 
% ylabel("Velocity [m/s]")
% xlabel("Distance from Inlet [m]")
% 
% title("Centerline Axial Velocity")
% fontsize(12,"points")

%%%Mass flow rate calculations and plot
% f = figure();
% 
% mdot = zeros(1,441);
% Qplume = zeros(1,441);
% for i = 468:Nx-1 %idx from top sample to outlet
% 
%     ridx = 24; %0.03m is 24, 0.05m is 38
% 
%     rho = D(i,2:ridx); 
%     rho = rho(~isnan(rho)); %Omit NaN
% 
%     vx = V(i,2:ridx);
%     vx = vx(~isnan(vx)); %Omit NaN
% 
%     temp = T(i,2:ridx);
%     temp = temp(~isnan(temp)); %Omit NaN
% 
%     rspace = Rq(1,2:numel(rho)+1); %Spaceing changes as x increases
% 
%     mdot(i-467) = 2*pi*trapz(rspace,rho.*vx.*rspace);
% end
% 
% plot(Xq(468:end-1,1),mdot)
% 
% xlim([0.439 1.068])
% 
% ylabel("Mass Flow Rate [kg/s]")
% xlabel("Distance from Inlet [m]")
% 
% title("Plume Mass Flow")
% fontsize(12,"points")
