%clc; clear; close all;

Tbl = readtable("sample_mass_history.csv");

figure()
plot(Tbl,"time_s_","sampleMass_g_","Marker","o","MarkerSize",4)
title("Numerical Sample Mass")
ylabel("Mass [g]")
xlabel("Time [s]")
fontsize(12,"points")