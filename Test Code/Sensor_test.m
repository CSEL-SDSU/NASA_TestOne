s = serialport("COM5",19200);
configureTerminator(s,"CR");

while true
    writeline(s,"#MRAW ");
    readline(s)
    pause(1);
end
