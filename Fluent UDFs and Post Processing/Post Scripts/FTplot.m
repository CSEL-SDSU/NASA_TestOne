%clc; clear; close all;

Tbl = readtable("Test2_manual.xlsx");
A = table2array(Tbl(:,2:end));
t = A(:,2);
t = t - t(1);
d = A(:,4);
d = d - d(1);

order=2;

figure(1)
hold on
plot(t,d,'o','DisplayName','Experimental Data','color','b')
legend('-DynamicLegend');
p=polyfit(t,d,order);
f = polyval(p,t);
eqn = poly_equation(flip(p));
plot(t,f,'-.','DisplayName',eqn,'color','b')
hold off

ylabel("y-coordinate [mm]")
xlabel("Flow Time [s]")
title("Vertical Flame Progression")
fontsize(12,"points")

SStot = sum((d-mean(d)).^2);
SSres = sum((d-f).^2);
Rsq = 1-SSres/SStot;
display(Rsq)

if order > 1
    eqn = convertStringsToChars(eqn);
    eqn(1:4) = [];
    seqn = str2sym(eqn);
    figure(2)
    hold on
    fplot(diff(seqn),'DisplayName','Experimental Data','color','b')
    legend('-DynamicLegend');
    xlim([t(1) t(end)])
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