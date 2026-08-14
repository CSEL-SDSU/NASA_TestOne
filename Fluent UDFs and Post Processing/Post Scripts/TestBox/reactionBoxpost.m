%Creates plots/ contours of saved solution variables
%clc; clear; close all;

%Load data
grid_file = "cellData_ts200.cgns";

grid = load_cgns(grid_file);

grid = [round(grid(:,1:end-1), 15) grid(:,end)];

%Setup grid
x0 = min(grid.CoordinateX); 
x1 = max(grid.CoordinateX);

y0 = min(grid.CoordinateY);
y1 = max(grid.CoordinateY);

Nx = 300;
Ny = 400;
dx = (x1 - x0)/(Nx-1);
dy = (y1 - y0)/(Ny-1);

xx = x0:dx:x1;
yy = y0:dy:y1;

[Xq,Yq] = meshgrid(xx,yy);

T = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Temperature,Xq,Yq);
 Vx = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.VelocityX,Xq,Yq);
% Vy = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.VelocityY,Xq,Yq);
% P = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Pressure,Xq,Yq);
 D = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Density,Xq,Yq);
% h2o = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Mole_fraction_of_h2o,Xq,Yq);
% co2 = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Mole_fraction_of_co2,Xq,Yq);
% o2 = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Mole_fraction_of_o2,Xq,Yq);
% %n2 = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Mole_fraction_of_n2,Xq,Yq);
% fuel = griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Mole_fraction_of_c6h10o5,Xq,Yq);
krr = -162.*griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Net_Reaction_Rate_of_c6h10o5,Xq,Yq);

%%%%%%%%%%%%
f = figure();
ax = axes(f);

[~,h] = contourf(ax,Xq*1000,Yq*1000,fliplr(T),100,"LineColor","none");
pbaspect([1 2.4 1])
set(gca,'TickDir','out');
cbar = colorbar(ax);
%colormap("hot")
%clim([0 190]);
%cbar.Label.String = "Kinetic Rate of Reaction [kmol/(m^3 s)]";
cbar.Label.String = "Temperature [K]";

ylabel("Distance from Inlet [mm]")
xlabel("x-coordinate [mm]")

title("Temperature Contour")
fontsize(12,"points")
% hold on
% %%%%%%%%%%%%
% % f = figure();
% % ax = axes(f);
% skipx = 10;
% skipy = 10;
% 
% Vx0 = Vx;
% Vy0 = Vy;
% Vx = NaN(size(Vx0));
% Vy = NaN(size(Vy0));
% Vx(1:skipx:end, 1:skipx:end)=Vx0(1:skipx:end, 1:skipx:end);
% Vy(1:skipy:end, 1:skipy:end)=Vy0(1:skipy:end, 1:skipy:end);
% 
% h2 = quiver(Xq,Yq,Vx,Vy,'k');
% set(h2,'AutoScale','on', 'AutoScaleFactor', 10)
% ylim([0 0.305])
% xlim([0 0.127])
% pbaspect([1 2.4 1])
% hold off
%%%%%%%%%%%%
% f = figure();
% ax = axes(f);
% 
% plot(yy,D(:,end-1))
% 
% %ylabel("Temperature [K]")
% xlabel("y-coordinate [m]")
% 
% %title("Wall Adjacent Temperature")
% fontsize(12,"points")
