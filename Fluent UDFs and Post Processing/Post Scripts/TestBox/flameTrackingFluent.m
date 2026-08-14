%Tracks minimum verical point of the flame based on a set tolerance
%If a flame is being supplied with enough fuel the tolerance should be around 1
%Effect of lower tolerance should be negligable however
%clc; clear; close all;

timeTotal = 8;
timeStep = 0.01;
saveInterval = 1;
tol = 1e-7; %Flame tolerance here
order = 2;

totalTs = timeTotal/timeStep;
TsInterval = saveInterval/timeStep;

flamePos = zeros(1,totalTs/TsInterval);
z=1;
for i = TsInterval:TsInterval:totalTs
    %Load data
    grid_file = "cellData_ts"+string(i)+".cgns";

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

    krr = -162.*griddata(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,grid.Net_Reaction_Rate_of_c6h10o5,Xq,Yq);
    ind = min(find(krr(:,end-1)>tol,1)); %or max(krr)
    flamePos(z) = Yq(ind,1)*1000;
     
    % krr = scatteredInterpolant(grid.CoordinateX_Cell_Center,grid.CoordinateY_Cell_Center,-162.*grid.Net_Reaction_Rate_of_c6h10o5);
    % krr.Method = 'natural';
    % ind = find(krr.Values>tol,1); 
    % flamePos(z) = min(krr.Points(ind,2))*1000;

    z = z+1;
end

flamePos = [0 flamePos];
t = 0:saveInterval:timeTotal;

figure(1)
hold on
plot(t,flamePos,'diamond','DisplayName','Numerical Data','color','r')
legend('-DynamicLegend');
p=polyfit(t,flamePos,order);
f = polyval(p,t);
eqn = poly_equation(flip(p));
plot(t,f,'-.','DisplayName',eqn,'color','r')
hold off

ylabel("y-coordinate [mm]")
xlabel("Flow Time [s]")
title("Vertical Flame Progression")
fontsize(12,"points")

SStot = sum((flamePos-mean(flamePos)).^2);
SSres = sum((flamePos-f).^2);
Rsq = 1-SSres/SStot;
display(Rsq)

if order > 1
    eqn = convertStringsToChars(eqn);
    eqn(1:4) = [];
    seqn = str2sym(eqn);
    var = symvar(seqn);
    figure(2)
    hold on
    h=fplot(piecewise(var<=timeTotal,diff(seqn)),'DisplayName','Numerical Data','color','r');
    legend('-DynamicLegend');
    xlim([0 timeTotal])
    ylabel("Velocity [mm/s]")
    xlabel("Flow Time [s]")
    title("Vertical Flame Velocity")
    fontsize(12,"points")
    hold off
    drawnow()
    h.NodeChildren(1).Visible = 'off';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function eqn = poly_equation(a_hat)
eqn = " y = "+a_hat(1);
for i = 2:(length(a_hat))
    if sign(a_hat(i))>0
        str = " + ";
    else
        str = " ";
    end
    if i == 2
        eqn = eqn+str+a_hat(i)+"*t";
    else
        eqn = eqn+str+a_hat(i)+"*t^"+(i-1)+" ";
    end
end
eqn = eqn+" ";
end
