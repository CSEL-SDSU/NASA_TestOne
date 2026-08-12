%clc; clear; close all;
%Run reactionBoxPost first to get cell centroid (Yq)

Tbl = readtable("face_flux_history.csv");
A = table2array(Tbl(:,2:end));

Tbl = readtable("face_mass_history.csv");
B = table2array(Tbl(2:end,2:end));

idx = 1; %Timestep number (0 is ts#1)

h = 523000; %heat constant

figure()
plot(A(idx,2:end),Yq*1000)
ylim([0 305])
title("Pyrolysis Mass Flux")
ylabel("Distance from Inlet [mm]")
xlabel("Mass Flux [kg/(m^2 s)]")
fontsize(12,"points")

figure()
plot(A(idx,2:end)*h,Yq*1000)
ylim([0 305])
title("Sample Heat Flux")
ylabel("Distance from Inlet [mm]")
xlabel("Heat Flux [W/m^2]")
fontsize(12,"points")

figure()
bar(B(idx,2:end)*h,Yq*1000)
ylim([0 305])
title("Face Mass")
ylabel("Distance from Inlet [mm]")
xlabel("Mass [mg]")
fontsize(12,"points")




