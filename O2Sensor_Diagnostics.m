%#ok<*NOPTS>
%#ok<*AGROW>
s = serialport("COM5",19200);
configureTerminator(s,"CR");
pressure = [];
O2Percent = [];
ambientLight = [];
time = [];
startTime = datetime('now')
i = 1;
while true
    writeline(s,"#MRAW ");
    r = readline(s) 
    splif = strsplit(r," ");

    time = [time seconds(datetime('now')-startTime)];

    press = str2double(splif(8))/68948; %add semicolon to hide, same units as GUI
    pressure = [pressure press];
    
    conc = str2double(splif(2))/(689.48 * press); %add semicolon to hide, same units as GUI
    O2Percent = [O2Percent conc]; %Saves concentration
    
    status = str2double(splif(4)); %Check sensor manual for error description
    
    light = str2double(splif(7))/1000; %Luminous intensity in units of mV 
    ambientLight = [ambientLight light];


    if (status ~= 0) %Ends program if status bit not normal, if stopped manually must also clear serialport object to run again
        clear s
        disp("Error bit:" + status)
        disp("Check sensor manual for description")
        break
    end
    pause(0.5);
end