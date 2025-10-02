ard = serialport('COM4',9600);

p1 = animatedline("Color","r");
p2 = animatedline("Color","b");

dataVector = [1,100];

j = 1;
hold on
legend
grid on
while true
    for i = 1:100
        lcData = str2double(readline(ard));
        dataVector(i) = lcData;
    end

    addpoints(p1,j,mean(dataVector))
    addpoints(p2,j,mean(lowpass(dataVector,340,860)))
    drawnow
    if j > 20
        xlim([j-20 j])
    end
    j = j + 1;
end
