s = serialport("COM5",19200);
configureTerminator(s,"CR");
t = 0;
while (t==0)
    writeline(s,"#MRAW ");
    readline(s)
    pause(1);
end