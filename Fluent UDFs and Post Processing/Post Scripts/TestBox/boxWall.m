%Plots mass flux and face mass of a selected timestep
%Run reactionBoxPost first to get cell centroid (Yq)
%Comment out the figures you dont want to display/record
%clc; clear; close all;

A = reorderFaces(readtable("face_flux_history.csv"));

B = reorderFaces(readtable("face_mass_history.csv"));

animate = 1; %Turns animated lines on and off
record = 0; %Turns recording on and off
videoName = 'fixedRun.mp4';

maxtime = 10;
idx = 1; %Timestep number (0 is ts#1)

h = 523000; %heat constant

if record == 1
    v = VideoWriter(videoName, 'MPEG-4');
    v.FrameRate = 30; % Set frames per second
    open(v);
end

figure()
ylim([0 305])
title("Pyrolysis Mass Flux")
ylabel("Distance from Inlet [mm]")
xlabel("Mass Flux [kg/(m^2 s)]")
fontsize(12,"points")
if animate == 1
    gr = animatedline;
    for j = 1:maxtime*100
        if j>1
            clearpoints(gr)
        end
        title("Mass Flux at t="+j/100+"s")
        addpoints(gr,A(j,:),Yq(:,1)*1000);
        drawnow
    end
else
    plot(A(idx,:),Yq(:,1)*1000)
    ylim([0 305])
    title("Pyrolysis Mass Flux")
    ylabel("Distance from Inlet [mm]")
    xlabel("Mass Flux [kg/(m^2 s)]")
    fontsize(12,"points")
end


figure()
plot(A(idx,:)*h,Yq(1:end,1)*1000)
ylim([0 305])
title("Sample Heat Flux")
ylabel("Distance from Inlet [mm]")
xlabel("Heat Flux [W/m^2]")
fontsize(12,"points")

f = figure();
ylim([0 305])
title("Face Mass at t=0.00s")
ylabel("Distance from Inlet [mm]")
xlabel("Mass [mg]")
fontsize(12,"points")
if animate == 1
    gr = animatedline;
    for j = 1:maxtime*100
        if j>1
            clearpoints(gr)
        end
        title("Face Mass at t="+j/100+"s")
        addpoints(gr,B(j,:),Yq(:,1)*1000);
        drawnow
        if record == 1
            writeVideo(v, getframe(f));
        end
    end
else
    plot(B(idx,:),Yq(:,1)*1000)
    ylim([0 305])
    title("Face Mass")
    ylabel("Distance from Inlet [mm]")
    xlabel("Mass [mg]")
    fontsize(12,"points")
end

if record == 1
    close(v);
end
