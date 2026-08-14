%Tracks minimum verical point of the flame based on a set tolerance
%If a flame is being supplied with enough fuel the tolerance should be around 1
%Effect of lower tolerance should be negligable however
clc; clear; close all;

timeTotal = 5;
timeStep = 0.01;
saveInterval = 0.5;
tol = 1e-7;

totalTs = timeTotal/timeStep;
TsInterval = saveInterval/timeStep;

flamePos = zeros(1,totalTs/TsInterval);
z=1;
for i = TsInterval:TsInterval:totalTs
    %Load data
    grid_file = "data_ts"+string(i)+".cgns";

    grid = load_cgns(grid_file);

    grid = [round(grid(:,1:end-1), 15) grid(:,end)];

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

    krr = -162.*griddata(grid.CoordinateY_Cell_Center,grid.CoordinateX_Cell_Center,data.Net_Reaction_Rate_of_c6h10o5,Rq,Xq);
    ind = min(find(krr(:,11)>tol,1)); %or max(krr)
    flamePos(z) = Xq(ind,1)*1000;
    z = z+1;
end

order = 2;
t = saveInterval:saveInterval:timeTotal;
plot(t,flamePos,'o')
hold on
p=polyfit(t,flamePos,order);
f = polyval(p,t);
eqn = poly_equation(flip(p));
plot(t,f,'-.','color','r')

legend('Flame Position',eqn)
ylabel("Distance From Inlet [mm]")
xlabel("Flow Time [s]")
title("Vertical Flame Progression")
fontsize(12,"points")

if order > 1
    eqn = convertStringsToChars(eqn);
    eqn(1:4) = [];
    seqn = str2sym(eqn);
    figure()
    fplot(diff(seqn))
    xlim([0 timeTotal])
    ylabel("Velocity [mm/s]")
    xlabel("Flow Time [s]")
    title("Vertical Flame Velocity")
    fontsize(12,"points")
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
