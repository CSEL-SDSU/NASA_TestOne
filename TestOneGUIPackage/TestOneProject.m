classdef TestOneProject < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        TestOneGUI                      matlab.ui.Figure
        O2SensorPanel                   matlab.ui.container.Panel
        LampO2                          matlab.ui.control.Lamp
        Label_4                         matlab.ui.control.Label
        ExportO2Button                  matlab.ui.control.Button
        RecordO2Button                  matlab.ui.control.Button
        LoadCellSettingsPanel           matlab.ui.container.Panel
        AmplifierGainSpinner            matlab.ui.control.Spinner
        AmplifierGainSpinnerLabel       matlab.ui.control.Label
        FullScaleOutputmVVSpinner       matlab.ui.control.Spinner
        FullScaleOutputmVVSpinnerLabel  matlab.ui.control.Label
        TareScaleButton                 matlab.ui.control.Button
        ExcitationVoltageVSpinner       matlab.ui.control.Spinner
        ExcitationVoltageVSpinnerLabel  matlab.ui.control.Label
        CapacitygSpinner                matlab.ui.control.Spinner
        LoadCellCapacitygLabel          matlab.ui.control.Label
        LoadCellPanel                   matlab.ui.container.Panel
        LampWeight                      matlab.ui.control.Lamp
        Label_3                         matlab.ui.control.Label
        ExportWeightButton              matlab.ui.control.Button
        RecordWeightButton              matlab.ui.control.Button
        PressurePanel                   matlab.ui.container.Panel
        RecordPressureButton            matlab.ui.control.Button
        LampPressure                    matlab.ui.control.Lamp
        Label_2                         matlab.ui.control.Label
        ExportPressureButton            matlab.ui.control.Button
        ControlsPanel                   matlab.ui.container.Panel
        ConnectO2SensorButton           matlab.ui.control.Button
        IgnitionTimesSpinner            matlab.ui.control.Spinner
        IgnitionTimesSpinnerLabel       matlab.ui.control.Label
        IgniteButton                    matlab.ui.control.Button
        ConnectArduinoButton            matlab.ui.control.Button
        ReadMFCsButton                  matlab.ui.control.Button
        CalculateButton                 matlab.ui.control.Button
        StopButton                      matlab.ui.control.Button
        StartButton                     matlab.ui.control.Button
        UnitPanel                       matlab.ui.container.Panel
        O2Label                         matlab.ui.control.Label
        B150Label                       matlab.ui.control.Label
        N2Label                         matlab.ui.control.Label
        A150Label                       matlab.ui.control.Label
        ActualsPanel                    matlab.ui.container.Panel
        ActualLPMEditField              matlab.ui.control.NumericEditField
        ActualLPMEditFieldLabel         matlab.ui.control.Label
        ActualSLPMEditField             matlab.ui.control.NumericEditField
        ActualSLPMEditFieldLabel        matlab.ui.control.Label
        EditField_14                    matlab.ui.control.NumericEditField
        EditField_13                    matlab.ui.control.NumericEditField
        EditField_12                    matlab.ui.control.NumericEditField
        EditField_11                    matlab.ui.control.NumericEditField
        LPMLabel                        matlab.ui.control.Label
        SLMLabel_2                      matlab.ui.control.Label
        SettingsPanel                   matlab.ui.container.Panel
        LPMSetpointEditField            matlab.ui.control.NumericEditField
        LPMSetpointEditFieldLabel       matlab.ui.control.Label
        SLPMSetpointEditField           matlab.ui.control.NumericEditField
        SLPMSetpointEditFieldLabel      matlab.ui.control.Label
        FullScaleLabel                  matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        EditField_5                     matlab.ui.control.NumericEditField
        EditField_3                     matlab.ui.control.NumericEditField
        EditField_2                     matlab.ui.control.NumericEditField
        EditField                       matlab.ui.control.NumericEditField
        SLMLabel                        matlab.ui.control.Label
        ReferencesPanel                 matlab.ui.container.Panel
        KEditField_2                    matlab.ui.control.NumericEditField
        KEditField_2Label               matlab.ui.control.Label
        PSIAEditField                   matlab.ui.control.NumericEditField
        PSIAEditFieldLabel              matlab.ui.control.Label
        FEditField_2                    matlab.ui.control.NumericEditField
        FEditField_2Label               matlab.ui.control.Label
        atmEditField_2                  matlab.ui.control.NumericEditField
        atmEditField_2Label             matlab.ui.control.Label
        DensityCorrectionFactorEditField  matlab.ui.control.NumericEditField
        DensityCorrectionFactorEditFieldLabel  matlab.ui.control.Label
        ReferenceTemperatureCSpinner    matlab.ui.control.Spinner
        ReferenceTemperatureCSpinnerLabel  matlab.ui.control.Label
        ReferencePressurekPaSpinner     matlab.ui.control.Spinner
        ReferencePressurekPaSpinnerLabel  matlab.ui.control.Label
        SetupPanel                      matlab.ui.container.Panel
        OxygenConcentrationEditField    matlab.ui.control.NumericEditField
        OxygenConcentrationLabel        matlab.ui.control.Label
        ScaleWeightgEditField           matlab.ui.control.NumericEditField
        ScaleWeightgEditFieldLabel      matlab.ui.control.Label
        KEditField                      matlab.ui.control.NumericEditField
        KEditFieldLabel                 matlab.ui.control.Label
        FEditField                      matlab.ui.control.NumericEditField
        FEditFieldLabel                 matlab.ui.control.Label
        ChamberTemperatureCSpinner      matlab.ui.control.Spinner
        ChamberTemperatureCSpinnerLabel  matlab.ui.control.Label
        SLMEditField_12                 matlab.ui.control.NumericEditField
        SLMEditField_12Label            matlab.ui.control.Label
        InitialVolumeFlowRateLPMEditField_2  matlab.ui.control.NumericEditField
        InitialVolumeFlowRateLPMEditField_2Label  matlab.ui.control.Label
        SourceBGasDropDown              matlab.ui.control.DropDown
        SourceBGasDropDownLabel         matlab.ui.control.Label
        InitialVolumeFlowRateTotalLPMSpinner  matlab.ui.control.Spinner
        InitialVolumeFlowRateTotalLPMLabel  matlab.ui.control.Label
        SLMEditField_8                  matlab.ui.control.NumericEditField
        SLMEditField_8Label             matlab.ui.control.Label
        TotalFlowSettingsLabel          matlab.ui.control.Label
        SLMEditField                    matlab.ui.control.NumericEditField
        SLMEditFieldLabel               matlab.ui.control.Label
        InitialVolumeFlowRateLPMEditField  matlab.ui.control.NumericEditField
        InitialVolumeFlowRateLPMEditFieldLabel  matlab.ui.control.Label
        SourceAGasDropDown              matlab.ui.control.DropDown
        SourceAGasDropDownLabel         matlab.ui.control.Label
        SensorPressurePSIAEditField     matlab.ui.control.NumericEditField
        SensorPressurePSIAEditFieldLabel  matlab.ui.control.Label
        PSIAtokPaConverterLabel         matlab.ui.control.Label
        kPaEditField                    matlab.ui.control.NumericEditField
        kPaEditFieldLabel               matlab.ui.control.Label
        PSIASpinner                     matlab.ui.control.Spinner
        PSIASpinnerLabel                matlab.ui.control.Label
        DesiredOxygenConcentrationOxygeninMixtureSpinner  matlab.ui.control.Spinner
        DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel  matlab.ui.control.Label
        PSIAEditField_2                 matlab.ui.control.NumericEditField
        PSIAEditField_2Label            matlab.ui.control.Label
        atmEditField                    matlab.ui.control.NumericEditField
        atmEditFieldLabel               matlab.ui.control.Label
        ChamberPressurekPaSpinner       matlab.ui.control.Spinner
        ChamberPressurekPaSpinnerLabel  matlab.ui.control.Label
    end


    properties (Access = private, SetObservable)

        % GUI variable initialization

        gChPress; gRefPress; ChTempK; gRefTemp; % chamber pressure in kPa, reference pressure in kPa, chamber temp. in Kelvin, reference temp. in celsius
        gOxyComp; gIVT; DC;                     % oxygen composition, initial volume flow total, density correction
        gChPressATM;                            % chamber pressure in ATM
        gChPressPSIA;                           % chamber pressure in PSIA
        gChTemp; ChTempF;                       % chamber temp. in celsius, chamber temp. in Fahrenheit
        gConverterPsia;                         % pressure conversion in PSIA
        gRefPressATM; gRefPressPSIA;            % reference pressure in ATM, reference pressure in PSIA
        RefTempF; RefTempK                      % reference temp. in Fahrenheit, reference temp. in Kelvin
        QT1; QB1; QA1;                          % total flow in SLM, gas B flow in SLM, gas A flow in SLM
        IVA; IVB;                               % gas A initial volume flow, gas B initial volume flow

        N2Unit; O2Unit;                         % N2 MFC letter assignment, O2 MFC letter assignment
        
        AFlowAct; BFlowAct;                     % gas A reported flow rate, gas B reported flow rate
        AFlow; BFlow;                           % gas A MFC full scale value, gas B MFC full scale value

        sampleSize; sampleRate;                 % # of samples to poll from MFC, rate of data collection, see pollMFC.m
        pollA; pollB;                           % read MFC A, read MFC B, see readMFC.m
        
        arduinoDevice;  O2Sensor;               % connected arduino & O2 Sensor through a serial port
        pressureVector; weightVector;           % collected pressure data, collected weight data
        togglePressure; toggleWeight;           % toggle to collect pressure data, toggle to collect weight data
        pressureOut; weightOut;                 % pressure output from sensor, weight output from arduino
        O2ConcentrationOut;                     % Same with O2 Concentration data
        toggleO2Concentration;
        O2ConcentrationVector;
        O2SensorError;
        arduinoDevice2;

        lcMax; lcInput; lcRatio;                % load cell max weight, load cell input voltage, load cell ratiometric factor
        zeroScale; lcGain;                      % tare scale value, op amp circuit gain

        ignitionTime;                           % set ignition time

        weightTime; pressTime; O2Time;          %Timestamp vectors for data 
        ignitionTimestamp;
        
        oneSecondTimer;
    
    end

    methods (Access = public)
        
        % Handles incoming data sent from the arduino through the serial
        % port. Reads a line from the serial port and outputs weight data. 
        % Called by the ConnectArduinoButtonPushed function.

        function handleArdIncoming(app, src, ~)
            max = 100;                                                      %Number of values to average, also affects data rate of mass measurements 
            lcDataVector = zeros(1,max);                                    % (higher number means slower, lower seems to be more accurate but increased chance of outliers)

            for i = 1:max
                ardOut = readline(src);
                if isempty(ardOut)
                    return
                end

                lcDataVector(i) = str2double(ardOut);
            end

            app.weightOut = (mean(lcDataVector)/16) - 1000;                 %Averaging and converting to mV scale, subtracting amplifier offset
        end

        % Handles incoming data sent from the O2 Sensor through the serial
        % port. Reads a line from the serial port and outputs O2 concentration and pressure data. 
        % Called by the ConnectO2SensorButtonPushed function.

        function handleO2SenseIncoming(app, src, ~)
            senseOut = readline(src);
            if isempty(senseOut)
                flush(src);
                writeline(src, "#MRAW ");
                return
            end
            splitOut = strsplit(senseOut, " ");                             %Splits incoming data string
            app.O2ConcentrationOut = str2double(splitOut(2));
            app.O2SensorError = str2double(splitOut(4));
            app.pressureOut = str2double(splitOut(8));

            if (app.O2SensorError ~= 0)                                    %Reads sensor status bit
                msgbox("Error detected! Please run sensor diagnostics!","Error","error");
                clear src;
            end

            flush(src);
            pause(0.1);
            writeline(src, "#MRAW ");

        end
        
        % Handles data output to the GUI in the appropriate display boxes.
        % Checks for changes in the pressure sensor and load cell data
        % variables, and updates the corresponding GUI boxes. Also handles
        % taring the sacle, and data collection if recording is enabled.
        % Called by the ConnectArduinoButtonPushed function.

        function lcChange(app, ~, ~)
            app.ScaleWeightgEditField.Value = ((app.weightOut-app.zeroScale)/app.lcGain)*app.lcMax/(app.lcInput*app.lcRatio);

            if app.toggleWeight == true
                app.weightVector = [app.weightVector app.ScaleWeightgEditField.Value];
                app.weightTime = [app.weightTime datetime('now')]; 
            end

        end

        % Handles data output to the GUI in the appropriate display boxes.
        % Checks for changes in the pressure sensor and load cell data
        % variables, and updates the corresponding GUI boxes. Also handles
        % taring the sacle, and data collection if recording is enabled.
        % Called by the ConnectArduinoButtonPushed function.
        % Pressure converted from microbar to PSIA and corrected to
        % atmospheric pressure.
        % O2 Concentration Converted from partial pressure in 10^3 hPa to
        % concentration.

        function O2SenseChange(app, ~, ~)
            if isempty(app.pressureOut) || isempty(app.O2ConcentrationOut)      %Prevents readings from freezing
                return
            end

            app.SensorPressurePSIAEditField.Value = (app.pressureOut/68948) + 0.2;
            app.OxygenConcentrationEditField.Value = app.O2ConcentrationOut/(689.48 * app.SensorPressurePSIAEditField.Value);

            if app.togglePressure == true
                app.pressureVector = [app.pressureVector app.SensorPressurePSIAEditField.Value];
                app.pressTime = [app.pressTime datetime('now')]; 
            end
            if app.toggleO2Concentration == true
                app.O2ConcentrationVector = [app.O2ConcentrationVector app.OxygenConcentrationEditField.Value];
                app.O2Time = [app.O2Time datetime('now')]; 
            end

        end

        function collectMFC(app, ~, ~)

            try
                flushAlicatBuffer;

                pollArrayA = readMFC('A');
                pollArrayB = readMFC('B');

                app.AFlowAct = pollArrayA.massFlow;
                app.EditField_11.Value = app.AFlowAct;
                app.EditField_12.Value = app.EditField_11.Value/(app.DC);

                app.BFlowAct = pollArrayB.massFlow;
                app.EditField_13.Value = app.BFlowAct;
                app.EditField_14.Value = app.EditField_13.Value/(app.DC);

                app.ActualSLPMEditField.Value = app.EditField_11.Value + app.EditField_13.Value;

                app.ActualLPMEditField.Value = app.ActualSLPMEditField.Value/(app.DC);

            catch ME
                uialert(app.TestOneGUI, ME.message, "Error", "Interpreter", "html");
            end
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            % Set initial variable values when the GUI opens

            app.LampPressure.Color = '#DA1884';
            app.LampWeight.Color = '#DA1884';
            app.LampO2.Color = '#DA1884';
            app.pressureVector = [];
            app.weightVector = [];
            app.O2ConcentrationVector = [];
            app.weightTime = [];
            app.pressTime = [];
            app.O2Time = [];
            app.ignitionTimestamp = datetime('now');
            app.togglePressure = false;
            app.toggleWeight = false;
            app.toggleO2Concentration = false;
            app.zeroScale = 0;
            app.gIVT = app.InitialVolumeFlowRateTotalLPMSpinner.Value;
            app.ignitionTime = app.IgnitionTimesSpinner.Value;
            app.lcInput = app.ExcitationVoltageVSpinner.Value;
            app.lcRatio = app.FullScaleOutputmVVSpinner.Value;
            app.lcMax = app.CapacitygSpinner.Value;
            app.lcGain = app.AmplifierGainSpinner.Value;
            app.oneSecondTimer = timer('TimerFcn', @(~, ~)collectMFC(app), 'Period', 1, 'ExecutionMode', 'fixedRate');

            %function ChamberPressurekPaSpinnerValueChanged(app, event)
            app.gChPress = app.ChamberPressurekPaSpinner.Value;
            app.gChPressATM = (app.gChPress)/101.32;
            app.atmEditField.Value = app.gChPressATM;
            
            %Pounds per square inch pressure
            app.gChPressPSIA = (app.gChPress)*14.696/101.32;
            app.PSIAEditField_2.Value = app.gChPressPSIA;
            
            %function ChamberTemperatureCSpinnerValueChanged(app, event)
            app.gChTemp = app.ChamberTemperatureCSpinner.Value;
            app.ChTempK = (app.gChTemp) + 273.15;
            app.KEditField.Value = app.ChTempK;
            app.ChTempF = ((app.ChTempK) - 273.15)*(9/5) + 32;
            app.FEditField.Value = app.ChTempF;

            %function PSIASpinnerValueChanged(app, event)
            app.gConverterPsia = app.PSIASpinner.Value;
            app.kPaEditField.Value = app.gConverterPsia*6.89476;
            
            %function DensityCorrectionFactorEditFieldValueChanged(app, event)
            app.DC = app.DensityCorrectionFactorEditField.Value;
            
            %function ReferencePressurekPaSpinnerValueChanged(app, event)
            app.gRefPress = app.ReferencePressurekPaSpinner.Value;
            app.gRefPressATM = (app.gRefPress)/101.32;
            app.atmEditField_2.Value = app.gRefPressATM;
            app.gRefPressPSIA = (app.gRefPress)*14.696/101.32;
            app.PSIAEditField.Value = app.gRefPressPSIA;
            
            %function ReferenceTemperatureCSpinnerValueChanged(app, event)
            app.gRefTemp = app.ReferenceTemperatureCSpinner.Value;
            app.RefTempK = (app.gRefTemp) + 273.15;
            app.KEditField_2.Value = app.RefTempK;
            app.RefTempF = ((app.RefTempK) - 273.15)*(9/5) + 32;
            app.FEditField_2.Value = app.RefTempF;
            
            %function DesiredOxygenConcentrationOxygeninMixtureSpinnerValueChanged(app, event)
            app.gOxyComp = app.DesiredOxygenConcentrationOxygeninMixtureSpinner.Value;

        end

        % Button pushed function: CalculateButton
        function CalculateButtonPushed(app, event)
            %Calculates Density Correction Factor
            app.DC = (app.gChPress/app.gRefPress)*(app.ChTempK/app.RefTempK);
            app.DensityCorrectionFactorEditField.Value = app.DC;
              
            %Total mass flow rate
            app.QT1 = app.gIVT*app.DC;
            app.SLMEditField_8.Value = app.QT1;
            
            %MFC B mass flow rate
            app.QB1 = (app.gOxyComp * app.QT1)/100;
            app.SLMEditField_12.Value = app.QB1;
            
            %MFC A mass flow rate
            app.QA1 = (app.QT1 - app.QB1);
            app.SLMEditField.Value = app.QA1;
            
            %Displays computed value of A
            app.IVA = app.QA1;
            app.InitialVolumeFlowRateLPMEditField.Value = app.IVA;
            
            %Displays computed value of B
            app.IVB = app.QB1;
            app.InitialVolumeFlowRateLPMEditField_2.Value = app.IVB;
                                               
        end

        % Value changed function: ChamberPressurekPaSpinner
        function ChamberPressurekPaSpinnerValueChanged(app, event)
            app.gChPress = app.ChamberPressurekPaSpinner.Value;
            
            %Atmospheric Pressure
            app.gChPressATM = (app.gChPress)/101.32;
            app.atmEditField.Value = app.gChPressATM;
            
            %Pounds per square inch pressure
            app.gChPressPSIA = (app.gChPress)*14.696/101.32;
            app.PSIAEditField_2.Value = app.gChPressPSIA;

        end

        % Value changed function: ChamberTemperatureCSpinner
        function ChamberTemperatureCSpinnerValueChanged(app, event)
            app.gChTemp = app.ChamberTemperatureCSpinner.Value;
            
            %Kelvin
            app.ChTempK = (app.gChTemp) + 273.15;
            app.KEditField.Value = app.ChTempK;
            
            %Fahrenheit
            app.ChTempF = ((app.ChTempK) - 273.15)*(9/5) + 32;
            app.FEditField.Value = app.ChTempF;

        end

        % Value changed function: 
        % DesiredOxygenConcentrationOxygeninMixtureSpinner
        function DesiredOxygenConcentrationOxygeninMixtureSpinnerValueChanged(app, event)
            app.gOxyComp = app.DesiredOxygenConcentrationOxygeninMixtureSpinner.Value;

        end

        % Value changed function: InitialVolumeFlowRateTotalLPMSpinner
        function InitialVolumeFlowRateTotalLPMSpinnerValueChanged(app, event)
            app.gIVT = app.InitialVolumeFlowRateTotalLPMSpinner.Value;
          
        end

        % Button pushed function: ReadMFCsButton
        function ReadMFCsButtonPushed(app, event)
 
            if strcmp(app.oneSecondTimer.Running, "off")
                app.oneSecondTimer.start;
                app.ReadMFCsButton.Enable = "off";
            end
            
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
     
            %Calculates Density Correction Factor
            app.DC = (app.gChPress/app.gRefPress)*(app.ChTempK/app.RefTempK);
            app.DensityCorrectionFactorEditField.Value = app.DC;
            
            %QT1
            app.QT1 = app.gIVT*app.DC;
            app.SLMEditField_8.Value = app.QT1;
            
            %QB1
            app.QB1 = (app.gOxyComp*app.QT1)/100;
            app.SLMEditField_12.Value = app.QB1;
            
            %QA1
            app.QA1 = (app.QT1 - app.QB1);
            app.SLMEditField.Value = app.QA1;
            
            %IVA
            app.IVA = app.QA1;
            app.InitialVolumeFlowRateLPMEditField.Value = app.IVA;
            
            %IVB
            app.IVB = app.QB1;
            app.InitialVolumeFlowRateLPMEditField_2.Value = app.IVB;
            

            %N2
            app.N2Unit = 'A';
               
            %Display for SLM Capacity
            app.AFlow = calcFlow(app.QA1, app.N2Unit); 
            app.EditField.Value = app.AFlow;
                
            %Display for MFC flow
            app.EditField_3.Value = app.QA1; %SLM
            setFlow(app.QA1, app.N2Unit);
            
            %O2   
            app.O2Unit = 'B';
                
            %Display for SLM Capacity
            app.BFlow = calcFlow(app.QB1, app.O2Unit);
            app.EditField_2.Value = app.BFlow;
                
            %Display for MFC flow
            app.EditField_5.Value = app.QB1; %SLM
            setFlow(app.QB1, app.O2Unit);
            
            %Display for Total Flow (Sum of the SLMs of MFCs A and B)
            app.SLPMSetpointEditField.Value = app.EditField_3.Value + app.EditField_5.Value;

            %Display for Total Volume (Sum of the cm/s of MFCs A and B)
            app.LPMSetpointEditField.Value = app.SLPMSetpointEditField.Value/(app.DC);
                
        end

        % Button pushed function: StopButton
        function StopButtonPushed(app, event)
            format shortG
            setFlow(0,'A');
            setFlow(0,'B');

            app.pollA = readMFC('A');
            app.pollB = readMFC('B');

            %Display for SLPM scale
            %MFC Unit A
            app.AFlow = 0;
            app.EditField.Value = 0; %Flow Unit
            app.EditField_3.Value = 0; %SLM
            app.AFlowAct = 0;
            app.EditField_11.Value = 0;
            app.EditField_12.Value = 0;

            %MFC Unit B
            app.BFlow = 0;
            app.EditField_2.Value = 0; %Flow Unit
            app.EditField_5.Value = 0; %SLM
            app.BFlowAct = 0;
            app.EditField_13.Value = 0;
            app.EditField_14.Value = 0;

            %TotalFlow
            app.SLPMSetpointEditField.Value = 0;

            %Display for Total Volume (Sum of the cm/s of MFCs A, B, C, D, and E)
            app.LPMSetpointEditField.Value = app.SLPMSetpointEditField.Value/(app.DC);

            %Actual Total Flow
            app.ActualSLPMEditField.Value = 0;

            %Actual Total Volume
            app.ActualLPMEditField.Value = app.ActualSLPMEditField.Value/(app.DC);

        end

        % Value changed function: PSIASpinner
        function PSIASpinnerValueChanged(app, event)
            app.gConverterPsia = app.PSIASpinner.Value;

            % mm to cm
            app.kPaEditField.Value = app.gConverterPsia*6.89476;
            
        end

        % Button pushed function: RecordPressureButton
        function RecordPressureButtonPushed(app, event)
            if app.togglePressure == false
                app.togglePressure = true;
                app.LampPressure.Color = '#00E600';
            else
                app.togglePressure = false;
                app.LampPressure.Color = '#DA1884';
            end

        end

        % Button pushed function: ExportPressureButton
        function ExportPressureButtonPushed(app, event)
            [fileNamePressure, fileLocPressure] = uiputfile('*.csv', 'Save Pressure Data');
            saveLocPressure = [fileLocPressure fileNamePressure];

            dPdt = diff(app.pressureVector)./seconds(diff(app.pressTime)); %Calculates time derivative of pressure
            dPdt = [dPdt 0];
            
            testInfo = string(zeros(size(app.pressTime)));                 %Includes Column of test data and sizes vector
            testInfo(1) = app.PSIAEditField_2.Value + "PSIA";
            testInfo(2) = app.InitialVolumeFlowRateTotalLPMSpinner.Value + "LPM";
            testInfo(3) = app.DesiredOxygenConcentrationOxygeninMixtureSpinner.Value + "%";
            testInfo(4) = app.ignitionTime + "s";
            testInfo(5:end) = ' ';

            tTime = seconds(app.pressTime-app.ignitionTimestamp);               %Counts time before and after ignition sequence start

            try
                writematrix([testInfo' tTime' app.pressureVector' dPdt'], saveLocPressure);
            catch ME
                uialert(app.TestOneGUI, ME.message, "Error", "Interpreter", "html");
                tempPress = app.pressureVector;
                save("pressureData.mat","tTime","tempPress","dPdt");
            end

            app.pressureVector = [];
            app.pressTime = [];

        end

        % Value changed function: ReferencePressurekPaSpinner
        function ReferencePressurekPaSpinnerValueChanged(app, event)
            app.gRefPress = app.ReferencePressurekPaSpinner.Value;
            
            %Atmospheric Pressure
            app.gRefPressATM = (app.gRefPress)/101.32;
            app.atmEditField_2.Value = app.gRefPressATM;
            
            %Pounds per square inch pressure
            app.gRefPressPSIA = (app.gRefPress)*14.696/101.32;
            app.PSIAEditField.Value = app.gRefPressPSIA;

        end

        % Value changed function: ReferenceTemperatureCSpinner
        function ReferenceTemperatureCSpinnerValueChanged(app, event)
            app.gRefTemp = app.ReferenceTemperatureCSpinner.Value;
            
            %Kelvin
            app.RefTempK = (app.gRefTemp) + 273.15;
            app.KEditField_2.Value = app.RefTempK;
            
            %Fahrenheit
            app.RefTempF = ((app.RefTempK)-273.15)*(9/5)+32;
            app.FEditField_2.Value = app.RefTempF;

        end

        % Button pushed function: ConnectArduinoButton
        function ConnectArduinoButtonPushed(app, event)
            dlgTitle = 'COM Port';
            dlgInput = {'COM3'};
            dlgFieldSize = [1 50];
            dlgPrompt = {'Enter the COM port of the Arduino (Ex. COM3)'};
            tempPort = inputdlg(dlgPrompt, dlgTitle, dlgFieldSize, dlgInput);
            comPort = char(tempPort);

            try
                app.arduinoDevice = serialport(comPort, 9600);
            catch ME
                uialert(app.TestOneGUI, ME.message, "Error", "Interpreter", "html");
                return
            end

            % configureCallback calls the function specified in the command when a terminator is available to be read from the serial port
            % addListener specifies a function to be called when a specific
            % value is changed

            configureTerminator(app.arduinoDevice, 'CR/LF');
            readline(app.arduinoDevice);
            configureCallback(app.arduinoDevice, "terminator", @app.handleArdIncoming);
            addlistener(app, 'weightOut', 'PostSet', @app.lcChange);

        end
        % Button pushed function: ConnectArduinoButton2
        function ConnectArduinoButtonPushed(app, event)
            dlgTitle = 'COM Port';
            dlgInput = {'COM6'};
            dlgFieldSize = [1 50];
            dlgPrompt = {'Enter the COM port of the Arduino (Ex. COM3)'};
            tempPort = inputdlg(dlgPrompt, dlgTitle, dlgFieldSize, dlgInput);
            comPort = char(tempPort);

            try
                app.arduinoDevice2 = serialport(comPort, 9600);
            catch ME
                uialert(app.TestOneGUI, ME.message, "Error", "Interpreter", "html");
                return
            end

            % configureCallback calls the function specified in the command when a terminator is available to be read from the serial port
            % addListener specifies a function to be called when a specific
            % value is changed

            %configureTerminator(app.arduinoDevice, 'CR/LF');
            %readline(app.arduinoDevice2);
            %configureCallback(app.arduinoDevice, "terminator", @app.handleArdIncoming);
            %addlistener(app, 'weightOut', 'PostSet', @app.lcChange);

        end

        % Button pushed function: RecordWeightButton
        function RecordWeightButtonPushed(app, event)
            if app.toggleWeight == false
                app.toggleWeight = true;
                app.LampWeight.Color = '#00E600';
            else
                app.toggleWeight = false;
                app.LampWeight.Color = '#DA1884';
            end

        end

        % Button pushed function: ExportWeightButton
        function ExportWeightButtonPushed(app, event)
            [fileNameWeight, fileLocWeight] = uiputfile('*.csv', 'Save Weight Data');
            saveLocWeight = [fileLocWeight fileNameWeight];

            dMdt = diff(app.weightVector)./seconds(diff(app.weightTime)); %See ExportPressure comments
            dMdt = [dMdt 0];

            testInfo = string(zeros(size(app.weightTime)));
            testInfo(1) = app.PSIAEditField_2.Value + "PSIA";
            testInfo(2) = app.InitialVolumeFlowRateTotalLPMSpinner.Value + "LPM";
            testInfo(3) = app.DesiredOxygenConcentrationOxygeninMixtureSpinner.Value + "%";
            testInfo(4) = app.ignitionTime + "s";
            testInfo(5:end) = ' ';

            tTime = seconds(app.weightTime-app.ignitionTimestamp);

            try
                writematrix([testInfo' tTime' app.weightVector' dMdt'], saveLocWeight);
            catch ME
                uialert(app.TestOneGUI, ME.message, "Error", "Interpreter", "html");
                tempWeight = app.weightVector;
                save("weightData.mat","tTime","tempWeight","dMdt");
            end

            app.weightVector = [];
            app.weightTime = [];

        end

        % Value changed function: FullScaleOutputmVVSpinner
        function FullScaleOutputmVVSpinnerValueChanged(app, event)
            app.lcRatio = app.FullScaleOutputmVVSpinner.Value;
            
        end

        % Value changed function: ExcitationVoltageVSpinner
        function ExcitationVoltageVSpinnerValueChanged(app, event)
            app.lcInput = app.ExcitationVoltageVSpinner.Value;
            
        end

        % Value changed function: CapacitygSpinner
        function CapacitygSpinnerValueChanged(app, event)
            app.lcMax = app.CapacitygSpinner.Value;
            
        end

        % Button pushed function: TareScaleButton
        function TareScaleButtonPushed(app, event)
            app.zeroScale = app.weightOut;

        end

        % Value changed function: IgnitionTimesSpinner
        function IgnitionTimesSpinnerValueChanged(app, event)
            app.ignitionTime = app.IgnitionTimesSpinner.Value;
            
        end

        % Button pushed function: IgniteButton
        function IgniteButtonPushed(app, event)
            ignTempValue = app.ignitionTime;
            ignNum = string(num2str(ignTempValue*1000));
            writeline(app.arduinoDevice2, ignNum);
            app.ignitionTimestamp = datetime('now');

            %Allows progress bar to operate properly without pausing app functions
            progressBar = uiprogressdlg(app.TestOneGUI, 'Title', 'Ignition in Progress', 'Cancelable', 'on');
            t = timer();
            t.Period = ignTempValue/100;
            t.TasksToExecute = 100;
            t.TimerFcn = @(src,~) updateBar(progressBar,src);
            t.StopFcn = @(src,~) deleteBar(progressBar,src);
            t.ExecutionMode = "fixedRate";
            t.start;

            %Timer functions
            function updateBar(bar,src)
                bar.Value = src.TasksExecuted/100;
                if bar.CancelRequested
                    writeline(app.arduinoDevice, "0");
                    src.stop;
                end
            end

            function deleteBar(bar,src)
                delete(bar)
                delete(src)
            end

        end

        % Button pushed function: ConnectO2SensorButton
        function ConnectO2SensorButtonPushed(app, event)
            dlgTitle = 'COM Port';
            dlgInput = {'COM5'};
            dlgFieldSize = [1 50];
            dlgPrompt = {'Enter the COM port of the O2 Sensor (Ex. COM3)'};
            tempPort = inputdlg(dlgPrompt, dlgTitle, dlgFieldSize, dlgInput);
            comPort = char(tempPort);

            try
                app.O2Sensor = serialport(comPort, 19200);
            catch ME
                uialert(app.TestOneGUI, ME.message, "Error", "Interpreter", "html");
                return
            end

            % configureCallback calls the function specified in the command when a terminator is available to be read from the serial port
            % addListener specifies a function to be called when a specific
            % value is changed

            configureTerminator(app.O2Sensor, "CR");
            writeline(app.O2Sensor, "#MRAW ")
            configureCallback(app.O2Sensor, "terminator", @app.handleO2SenseIncoming);
            addlistener(app, 'O2ConcentrationOut', 'PostSet', @app.O2SenseChange);
        end

        % Button pushed function: ExportO2Button
        function ExportO2ButtonPushed(app, event)
            [fileNameO2Concentration, fileLocO2Concentration] = uiputfile('*.csv', 'Save O2 Concentration Data');
            saveLocO2Concentration = [fileLocO2Concentration fileNameO2Concentration];
            
            dCdt = diff(app.O2ConcentrationVector)./seconds(diff(app.O2Time)); %See ExportPressure comments
            dCdt = [dCdt 0];

            testInfo = string(zeros(size(app.O2Time)));
            testInfo(1) = app.PSIAEditField_2.Value + "PSIA";
            testInfo(2) = app.InitialVolumeFlowRateTotalLPMSpinner.Value + "LPM";
            testInfo(3) = app.DesiredOxygenConcentrationOxygeninMixtureSpinner.Value + "%";
            testInfo(4) = app.ignitionTime + "s";
            testInfo(5:end) = ' ';

            tTime = seconds(app.O2Time-app.ignitionTimestamp);

            try
                writematrix([testInfo' tTime' app.O2ConcentrationVector' dCdt'], saveLocO2Concentration);
            catch ME
                uialert(app.TestOneGUI, ME.message, "Error", "Interpreter", "html");
                tempO2 = app.O2ConcentrationVector;
                save("pressureData.mat","tTime","tempO2","dCdt");
            end

            app.O2ConcentrationVector = [];
            app.O2Time = [];

        end

        % Button pushed function: RecordO2Button
        function RecordO2ButtonPushed(app, event)
            if app.toggleO2Concentration == false
                app.toggleO2Concentration = true;
                app.LampO2.Color = '#00E600';
            else
                app.toggleO2Concentration = false;
                app.LampO2.Color = '#DA1884';
            end
        end

        % Value changed function: AmplifierGainSpinner
        function AmplifierGainSpinnerValueChanged(app, event)
            app.lcGain = app.AmplifierGainSpinner.Value;

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create TestOneGUI and hide until all components are created
            app.TestOneGUI = uifigure('Visible', 'off');
            app.TestOneGUI.Color = [0.902 0.902 0.902];
            app.TestOneGUI.Position = [100 100 1106 725];
            app.TestOneGUI.Name = 'UI Figure';
            app.TestOneGUI.Icon = fullfile(pathToMLAPP, 'hd-nasa-logo-transparent-background-7017516947129576ypz4kes8x.png');

            % Create SetupPanel
            app.SetupPanel = uipanel(app.TestOneGUI);
            app.SetupPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SetupPanel.BorderWidth = 2;
            app.SetupPanel.TitlePosition = 'centertop';
            app.SetupPanel.Title = 'Setup';
            app.SetupPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.SetupPanel.FontWeight = 'bold';
            app.SetupPanel.FontSize = 14;
            app.SetupPanel.Position = [17 492 1071 216];

            % Create ChamberPressurekPaSpinnerLabel
            app.ChamberPressurekPaSpinnerLabel = uilabel(app.SetupPanel);
            app.ChamberPressurekPaSpinnerLabel.HorizontalAlignment = 'center';
            app.ChamberPressurekPaSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChamberPressurekPaSpinnerLabel.Position = [317 126 138 22];
            app.ChamberPressurekPaSpinnerLabel.Text = 'Chamber Pressure (kPa)';

            % Create ChamberPressurekPaSpinner
            app.ChamberPressurekPaSpinner = uispinner(app.SetupPanel);
            app.ChamberPressurekPaSpinner.ValueChangedFcn = createCallbackFcn(app, @ChamberPressurekPaSpinnerValueChanged, true);
            app.ChamberPressurekPaSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChamberPressurekPaSpinner.BackgroundColor = [0 1 1];
            app.ChamberPressurekPaSpinner.Position = [459 126 73 22];
            app.ChamberPressurekPaSpinner.Value = 101.32;

            % Create atmEditFieldLabel
            app.atmEditFieldLabel = uilabel(app.SetupPanel);
            app.atmEditFieldLabel.HorizontalAlignment = 'center';
            app.atmEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.atmEditFieldLabel.Position = [611 130 24 15];
            app.atmEditFieldLabel.Text = 'atm';

            % Create atmEditField
            app.atmEditField = uieditfield(app.SetupPanel, 'numeric');
            app.atmEditField.Editable = 'off';
            app.atmEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.atmEditField.Position = [543 126 64 22];
            app.atmEditField.Value = 1;

            % Create PSIAEditField_2Label
            app.PSIAEditField_2Label = uilabel(app.SetupPanel);
            app.PSIAEditField_2Label.HorizontalAlignment = 'center';
            app.PSIAEditField_2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PSIAEditField_2Label.Position = [711 127 29 19];
            app.PSIAEditField_2Label.Text = 'PSIA';

            % Create PSIAEditField_2
            app.PSIAEditField_2 = uieditfield(app.SetupPanel, 'numeric');
            app.PSIAEditField_2.Editable = 'off';
            app.PSIAEditField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PSIAEditField_2.Position = [641 126 64 22];
            app.PSIAEditField_2.Value = 14.7;

            % Create DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel
            app.DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel = uilabel(app.SetupPanel);
            app.DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel.HorizontalAlignment = 'center';
            app.DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel.FontWeight = 'bold';
            app.DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel.Position = [318 158 314 22];
            app.DesiredOxygenConcentrationOxygeninMixtureSpinnerLabel.Text = 'Desired Oxygen Concentration (% Oxygen in Mixture)';

            % Create DesiredOxygenConcentrationOxygeninMixtureSpinner
            app.DesiredOxygenConcentrationOxygeninMixtureSpinner = uispinner(app.SetupPanel);
            app.DesiredOxygenConcentrationOxygeninMixtureSpinner.Limits = [0 100];
            app.DesiredOxygenConcentrationOxygeninMixtureSpinner.ValueChangedFcn = createCallbackFcn(app, @DesiredOxygenConcentrationOxygeninMixtureSpinnerValueChanged, true);
            app.DesiredOxygenConcentrationOxygeninMixtureSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DesiredOxygenConcentrationOxygeninMixtureSpinner.BackgroundColor = [0 1 1];
            app.DesiredOxygenConcentrationOxygeninMixtureSpinner.Position = [642 157 100 22];

            % Create PSIASpinnerLabel
            app.PSIASpinnerLabel = uilabel(app.SetupPanel);
            app.PSIASpinnerLabel.HorizontalAlignment = 'center';
            app.PSIASpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PSIASpinnerLabel.Position = [90 132 32 22];
            app.PSIASpinnerLabel.Text = 'PSIA';

            % Create PSIASpinner
            app.PSIASpinner = uispinner(app.SetupPanel);
            app.PSIASpinner.ValueChangedFcn = createCallbackFcn(app, @PSIASpinnerValueChanged, true);
            app.PSIASpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PSIASpinner.BackgroundColor = [0.0588 1 1];
            app.PSIASpinner.Position = [11 135 77 22];
            app.PSIASpinner.Value = 14.696;

            % Create kPaEditFieldLabel
            app.kPaEditFieldLabel = uilabel(app.SetupPanel);
            app.kPaEditFieldLabel.HorizontalAlignment = 'center';
            app.kPaEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.kPaEditFieldLabel.Position = [90 104 26 22];
            app.kPaEditFieldLabel.Text = 'kPa';

            % Create kPaEditField
            app.kPaEditField = uieditfield(app.SetupPanel, 'numeric');
            app.kPaEditField.ValueDisplayFormat = '%.1f';
            app.kPaEditField.Editable = 'off';
            app.kPaEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.kPaEditField.Position = [11 104 77 22];
            app.kPaEditField.Value = 101.3;

            % Create PSIAtokPaConverterLabel
            app.PSIAtokPaConverterLabel = uilabel(app.SetupPanel);
            app.PSIAtokPaConverterLabel.HorizontalAlignment = 'center';
            app.PSIAtokPaConverterLabel.FontWeight = 'bold';
            app.PSIAtokPaConverterLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PSIAtokPaConverterLabel.Position = [11 161 130 22];
            app.PSIAtokPaConverterLabel.Text = 'PSIA to kPa Converter';

            % Create SensorPressurePSIAEditFieldLabel
            app.SensorPressurePSIAEditFieldLabel = uilabel(app.SetupPanel);
            app.SensorPressurePSIAEditFieldLabel.HorizontalAlignment = 'center';
            app.SensorPressurePSIAEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SensorPressurePSIAEditFieldLabel.Position = [841 161 133 22];
            app.SensorPressurePSIAEditFieldLabel.Text = 'Sensor Pressure (PSIA)';

            % Create SensorPressurePSIAEditField
            app.SensorPressurePSIAEditField = uieditfield(app.SetupPanel, 'numeric');
            app.SensorPressurePSIAEditField.ValueDisplayFormat = '%.2f';
            app.SensorPressurePSIAEditField.Editable = 'off';
            app.SensorPressurePSIAEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SensorPressurePSIAEditField.Position = [980 159 80 24];

            % Create SourceAGasDropDownLabel
            app.SourceAGasDropDownLabel = uilabel(app.SetupPanel);
            app.SourceAGasDropDownLabel.HorizontalAlignment = 'center';
            app.SourceAGasDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SourceAGasDropDownLabel.Position = [103 65 75 15];
            app.SourceAGasDropDownLabel.Text = 'Source A Gas';

            % Create SourceAGasDropDown
            app.SourceAGasDropDown = uidropdown(app.SetupPanel);
            app.SourceAGasDropDown.Items = {'O2', 'N2', 'Air', ''};
            app.SourceAGasDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SourceAGasDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.SourceAGasDropDown.Position = [188 62 61 22];
            app.SourceAGasDropDown.Value = 'N2';

            % Create InitialVolumeFlowRateLPMEditFieldLabel
            app.InitialVolumeFlowRateLPMEditFieldLabel = uilabel(app.SetupPanel);
            app.InitialVolumeFlowRateLPMEditFieldLabel.HorizontalAlignment = 'center';
            app.InitialVolumeFlowRateLPMEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InitialVolumeFlowRateLPMEditFieldLabel.Position = [11 36 170 17];
            app.InitialVolumeFlowRateLPMEditFieldLabel.Text = 'Initial Volume Flow Rate (LPM)';

            % Create InitialVolumeFlowRateLPMEditField
            app.InitialVolumeFlowRateLPMEditField = uieditfield(app.SetupPanel, 'numeric');
            app.InitialVolumeFlowRateLPMEditField.Editable = 'off';
            app.InitialVolumeFlowRateLPMEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InitialVolumeFlowRateLPMEditField.Position = [188 34 60 22];

            % Create SLMEditFieldLabel
            app.SLMEditFieldLabel = uilabel(app.SetupPanel);
            app.SLMEditFieldLabel.HorizontalAlignment = 'center';
            app.SLMEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMEditFieldLabel.Position = [151 10 30 15];
            app.SLMEditFieldLabel.Text = 'SLM';

            % Create SLMEditField
            app.SLMEditField = uieditfield(app.SetupPanel, 'numeric');
            app.SLMEditField.Editable = 'off';
            app.SLMEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMEditField.Position = [188 6 60 22];

            % Create TotalFlowSettingsLabel
            app.TotalFlowSettingsLabel = uilabel(app.SetupPanel);
            app.TotalFlowSettingsLabel.HorizontalAlignment = 'center';
            app.TotalFlowSettingsLabel.FontSize = 14;
            app.TotalFlowSettingsLabel.FontWeight = 'bold';
            app.TotalFlowSettingsLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.TotalFlowSettingsLabel.Position = [481 64 131 18];
            app.TotalFlowSettingsLabel.Text = 'Total Flow Settings';

            % Create SLMEditField_8Label
            app.SLMEditField_8Label = uilabel(app.SetupPanel);
            app.SLMEditField_8Label.HorizontalAlignment = 'right';
            app.SLMEditField_8Label.VerticalAlignment = 'top';
            app.SLMEditField_8Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMEditField_8Label.Position = [580 10 30 15];
            app.SLMEditField_8Label.Text = 'SLM';

            % Create SLMEditField_8
            app.SLMEditField_8 = uieditfield(app.SetupPanel, 'numeric');
            app.SLMEditField_8.Editable = 'off';
            app.SLMEditField_8.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMEditField_8.Position = [620 6 65 22];

            % Create InitialVolumeFlowRateTotalLPMLabel
            app.InitialVolumeFlowRateTotalLPMLabel = uilabel(app.SetupPanel);
            app.InitialVolumeFlowRateTotalLPMLabel.HorizontalAlignment = 'center';
            app.InitialVolumeFlowRateTotalLPMLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InitialVolumeFlowRateTotalLPMLabel.Position = [409 34 207 22];
            app.InitialVolumeFlowRateTotalLPMLabel.Text = 'Initial Volume Flow Rate - Total (LPM)';

            % Create InitialVolumeFlowRateTotalLPMSpinner
            app.InitialVolumeFlowRateTotalLPMSpinner = uispinner(app.SetupPanel);
            app.InitialVolumeFlowRateTotalLPMSpinner.Limits = [0 50];
            app.InitialVolumeFlowRateTotalLPMSpinner.ValueChangedFcn = createCallbackFcn(app, @InitialVolumeFlowRateTotalLPMSpinnerValueChanged, true);
            app.InitialVolumeFlowRateTotalLPMSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InitialVolumeFlowRateTotalLPMSpinner.BackgroundColor = [0 1 1];
            app.InitialVolumeFlowRateTotalLPMSpinner.Position = [620 34 66 22];

            % Create SourceBGasDropDownLabel
            app.SourceBGasDropDownLabel = uilabel(app.SetupPanel);
            app.SourceBGasDropDownLabel.HorizontalAlignment = 'center';
            app.SourceBGasDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SourceBGasDropDownLabel.Position = [920 66 77 15];
            app.SourceBGasDropDownLabel.Text = 'Source B Gas';

            % Create SourceBGasDropDown
            app.SourceBGasDropDown = uidropdown(app.SetupPanel);
            app.SourceBGasDropDown.Items = {'O2', 'N2', 'Air', ''};
            app.SourceBGasDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SourceBGasDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.SourceBGasDropDown.Position = [1006 62 54 22];
            app.SourceBGasDropDown.Value = 'O2';

            % Create InitialVolumeFlowRateLPMEditField_2Label
            app.InitialVolumeFlowRateLPMEditField_2Label = uilabel(app.SetupPanel);
            app.InitialVolumeFlowRateLPMEditField_2Label.HorizontalAlignment = 'center';
            app.InitialVolumeFlowRateLPMEditField_2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InitialVolumeFlowRateLPMEditField_2Label.Position = [831 34 170 22];
            app.InitialVolumeFlowRateLPMEditField_2Label.Text = 'Initial Volume Flow Rate (LPM)';

            % Create InitialVolumeFlowRateLPMEditField_2
            app.InitialVolumeFlowRateLPMEditField_2 = uieditfield(app.SetupPanel, 'numeric');
            app.InitialVolumeFlowRateLPMEditField_2.Editable = 'off';
            app.InitialVolumeFlowRateLPMEditField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InitialVolumeFlowRateLPMEditField_2.Position = [1006 34 54 22];

            % Create SLMEditField_12Label
            app.SLMEditField_12Label = uilabel(app.SetupPanel);
            app.SLMEditField_12Label.HorizontalAlignment = 'right';
            app.SLMEditField_12Label.VerticalAlignment = 'top';
            app.SLMEditField_12Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMEditField_12Label.Position = [971 10 26 15];
            app.SLMEditField_12Label.Text = 'SLM';

            % Create SLMEditField_12
            app.SLMEditField_12 = uieditfield(app.SetupPanel, 'numeric');
            app.SLMEditField_12.Editable = 'off';
            app.SLMEditField_12.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMEditField_12.Position = [1006 6 54 22];

            % Create ChamberTemperatureCSpinnerLabel
            app.ChamberTemperatureCSpinnerLabel = uilabel(app.SetupPanel);
            app.ChamberTemperatureCSpinnerLabel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ChamberTemperatureCSpinnerLabel.HorizontalAlignment = 'center';
            app.ChamberTemperatureCSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChamberTemperatureCSpinnerLabel.Position = [317 97 145 22];
            app.ChamberTemperatureCSpinnerLabel.Text = 'Chamber Temperature (C)';

            % Create ChamberTemperatureCSpinner
            app.ChamberTemperatureCSpinner = uispinner(app.SetupPanel);
            app.ChamberTemperatureCSpinner.ValueChangedFcn = createCallbackFcn(app, @ChamberTemperatureCSpinnerValueChanged, true);
            app.ChamberTemperatureCSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ChamberTemperatureCSpinner.BackgroundColor = [0 1 1];
            app.ChamberTemperatureCSpinner.Position = [467 97 65 22];
            app.ChamberTemperatureCSpinner.Value = 25;

            % Create FEditFieldLabel
            app.FEditFieldLabel = uilabel(app.SetupPanel);
            app.FEditFieldLabel.HorizontalAlignment = 'center';
            app.FEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FEditFieldLabel.Position = [612 101 11 15];
            app.FEditFieldLabel.Text = 'F';

            % Create FEditField
            app.FEditField = uieditfield(app.SetupPanel, 'numeric');
            app.FEditField.Editable = 'off';
            app.FEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FEditField.Position = [543 97 64 22];
            app.FEditField.Value = 77;

            % Create KEditFieldLabel
            app.KEditFieldLabel = uilabel(app.SetupPanel);
            app.KEditFieldLabel.HorizontalAlignment = 'center';
            app.KEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.KEditFieldLabel.Position = [711 101 11 15];
            app.KEditFieldLabel.Text = 'K';

            % Create KEditField
            app.KEditField = uieditfield(app.SetupPanel, 'numeric');
            app.KEditField.Editable = 'off';
            app.KEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.KEditField.Position = [641 97 64 22];
            app.KEditField.Value = 298.1;

            % Create ScaleWeightgEditFieldLabel
            app.ScaleWeightgEditFieldLabel = uilabel(app.SetupPanel);
            app.ScaleWeightgEditFieldLabel.HorizontalAlignment = 'center';
            app.ScaleWeightgEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ScaleWeightgEditFieldLabel.Position = [879 102 95 22];
            app.ScaleWeightgEditFieldLabel.Text = 'Scale Weight (g)';

            % Create ScaleWeightgEditField
            app.ScaleWeightgEditField = uieditfield(app.SetupPanel, 'numeric');
            app.ScaleWeightgEditField.ValueDisplayFormat = '%.2f';
            app.ScaleWeightgEditField.Editable = 'off';
            app.ScaleWeightgEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ScaleWeightgEditField.Position = [980 101 80 23];

            % Create OxygenConcentrationLabel
            app.OxygenConcentrationLabel = uilabel(app.SetupPanel);
            app.OxygenConcentrationLabel.HorizontalAlignment = 'center';
            app.OxygenConcentrationLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OxygenConcentrationLabel.Position = [830 130 146 22];
            app.OxygenConcentrationLabel.Text = 'Oxygen Concentration (%)';

            % Create OxygenConcentrationEditField
            app.OxygenConcentrationEditField = uieditfield(app.SetupPanel, 'numeric');
            app.OxygenConcentrationEditField.ValueDisplayFormat = '%.2f';
            app.OxygenConcentrationEditField.Editable = 'off';
            app.OxygenConcentrationEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OxygenConcentrationEditField.Position = [980 130 80 23];

            % Create ReferencesPanel
            app.ReferencesPanel = uipanel(app.TestOneGUI);
            app.ReferencesPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ReferencesPanel.BorderWidth = 2;
            app.ReferencesPanel.TitlePosition = 'centertop';
            app.ReferencesPanel.Title = 'References';
            app.ReferencesPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ReferencesPanel.FontWeight = 'bold';
            app.ReferencesPanel.FontSize = 14;
            app.ReferencesPanel.Position = [17 343 644 134];

            % Create ReferencePressurekPaSpinnerLabel
            app.ReferencePressurekPaSpinnerLabel = uilabel(app.ReferencesPanel);
            app.ReferencePressurekPaSpinnerLabel.HorizontalAlignment = 'center';
            app.ReferencePressurekPaSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ReferencePressurekPaSpinnerLabel.Position = [3 78 146 15];
            app.ReferencePressurekPaSpinnerLabel.Text = 'Reference Pressure (kPa)';

            % Create ReferencePressurekPaSpinner
            app.ReferencePressurekPaSpinner = uispinner(app.ReferencesPanel);
            app.ReferencePressurekPaSpinner.ValueChangedFcn = createCallbackFcn(app, @ReferencePressurekPaSpinnerValueChanged, true);
            app.ReferencePressurekPaSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ReferencePressurekPaSpinner.BackgroundColor = [0 1 1];
            app.ReferencePressurekPaSpinner.Position = [167 74 82 22];
            app.ReferencePressurekPaSpinner.Value = 101.32;

            % Create ReferenceTemperatureCSpinnerLabel
            app.ReferenceTemperatureCSpinnerLabel = uilabel(app.ReferencesPanel);
            app.ReferenceTemperatureCSpinnerLabel.HorizontalAlignment = 'center';
            app.ReferenceTemperatureCSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ReferenceTemperatureCSpinnerLabel.Position = [1 45 154 15];
            app.ReferenceTemperatureCSpinnerLabel.Text = 'Reference Temperature (C)';

            % Create ReferenceTemperatureCSpinner
            app.ReferenceTemperatureCSpinner = uispinner(app.ReferencesPanel);
            app.ReferenceTemperatureCSpinner.ValueChangedFcn = createCallbackFcn(app, @ReferenceTemperatureCSpinnerValueChanged, true);
            app.ReferenceTemperatureCSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ReferenceTemperatureCSpinner.BackgroundColor = [0 1 1];
            app.ReferenceTemperatureCSpinner.Position = [167 41 82 22];
            app.ReferenceTemperatureCSpinner.Value = 25;

            % Create DensityCorrectionFactorEditFieldLabel
            app.DensityCorrectionFactorEditFieldLabel = uilabel(app.ReferencesPanel);
            app.DensityCorrectionFactorEditFieldLabel.HorizontalAlignment = 'center';
            app.DensityCorrectionFactorEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DensityCorrectionFactorEditFieldLabel.Position = [3 14 143 15];
            app.DensityCorrectionFactorEditFieldLabel.Text = 'Density Correction Factor';

            % Create DensityCorrectionFactorEditField
            app.DensityCorrectionFactorEditField = uieditfield(app.ReferencesPanel, 'numeric');
            app.DensityCorrectionFactorEditField.Editable = 'off';
            app.DensityCorrectionFactorEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DensityCorrectionFactorEditField.Position = [167 10 81 22];
            app.DensityCorrectionFactorEditField.Value = 1;

            % Create atmEditField_2Label
            app.atmEditField_2Label = uilabel(app.ReferencesPanel);
            app.atmEditField_2Label.HorizontalAlignment = 'center';
            app.atmEditField_2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.atmEditField_2Label.Position = [421 78 20 15];
            app.atmEditField_2Label.Text = 'atm';

            % Create atmEditField_2
            app.atmEditField_2 = uieditfield(app.ReferencesPanel, 'numeric');
            app.atmEditField_2.Editable = 'off';
            app.atmEditField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.atmEditField_2.Position = [318 74 100 22];
            app.atmEditField_2.Value = 1;

            % Create FEditField_2Label
            app.FEditField_2Label = uilabel(app.ReferencesPanel);
            app.FEditField_2Label.HorizontalAlignment = 'center';
            app.FEditField_2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FEditField_2Label.Position = [420 47 10 15];
            app.FEditField_2Label.Text = 'F';

            % Create FEditField_2
            app.FEditField_2 = uieditfield(app.ReferencesPanel, 'numeric');
            app.FEditField_2.Editable = 'off';
            app.FEditField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FEditField_2.Position = [318 43 100 22];
            app.FEditField_2.Value = 77;

            % Create PSIAEditFieldLabel
            app.PSIAEditFieldLabel = uilabel(app.ReferencesPanel);
            app.PSIAEditFieldLabel.HorizontalAlignment = 'center';
            app.PSIAEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PSIAEditFieldLabel.Position = [604 77 28 16];
            app.PSIAEditFieldLabel.Text = 'PSIA';

            % Create PSIAEditField
            app.PSIAEditField = uieditfield(app.ReferencesPanel, 'numeric');
            app.PSIAEditField.Editable = 'off';
            app.PSIAEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PSIAEditField.Position = [501 74 100 22];
            app.PSIAEditField.Value = 14.7;

            % Create KEditField_2Label
            app.KEditField_2Label = uilabel(app.ReferencesPanel);
            app.KEditField_2Label.HorizontalAlignment = 'center';
            app.KEditField_2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.KEditField_2Label.Position = [604 47 10 15];
            app.KEditField_2Label.Text = 'K';

            % Create KEditField_2
            app.KEditField_2 = uieditfield(app.ReferencesPanel, 'numeric');
            app.KEditField_2.Editable = 'off';
            app.KEditField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.KEditField_2.Position = [501 43 100 22];
            app.KEditField_2.Value = 298.1;

            % Create SettingsPanel
            app.SettingsPanel = uipanel(app.TestOneGUI);
            app.SettingsPanel.ForegroundColor = [0.1294 0.1294 0.1294];
            app.SettingsPanel.BorderWidth = 2;
            app.SettingsPanel.TitlePosition = 'centertop';
            app.SettingsPanel.Title = 'Settings';
            app.SettingsPanel.FontWeight = 'bold';
            app.SettingsPanel.FontSize = 14;
            app.SettingsPanel.Position = [17 106 273 223];

            % Create SLMLabel
            app.SLMLabel = uilabel(app.SettingsPanel);
            app.SLMLabel.HorizontalAlignment = 'center';
            app.SLMLabel.FontWeight = 'bold';
            app.SLMLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMLabel.Position = [190 161 30 15];
            app.SLMLabel.Text = 'SLM';

            % Create EditField
            app.EditField = uieditfield(app.SettingsPanel, 'numeric');
            app.EditField.ValueDisplayFormat = '%.0f';
            app.EditField.Editable = 'off';
            app.EditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField.Position = [17 129 100 22];

            % Create EditField_2
            app.EditField_2 = uieditfield(app.SettingsPanel, 'numeric');
            app.EditField_2.ValueDisplayFormat = '%.0f';
            app.EditField_2.Editable = 'off';
            app.EditField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField_2.Position = [17 93 100 22];

            % Create EditField_3
            app.EditField_3 = uieditfield(app.SettingsPanel, 'numeric');
            app.EditField_3.Editable = 'off';
            app.EditField_3.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField_3.Position = [155 129 100 22];

            % Create EditField_5
            app.EditField_5 = uieditfield(app.SettingsPanel, 'numeric');
            app.EditField_5.Editable = 'off';
            app.EditField_5.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField_5.Position = [155 93 100 22];

            % Create Label
            app.Label = uilabel(app.SettingsPanel);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontWeight = 'bold';
            app.Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Label.Position = [25 154 83 22];
            app.Label.Text = '64000 = 100%';

            % Create FullScaleLabel
            app.FullScaleLabel = uilabel(app.SettingsPanel);
            app.FullScaleLabel.HorizontalAlignment = 'center';
            app.FullScaleLabel.FontWeight = 'bold';
            app.FullScaleLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FullScaleLabel.Position = [27 168 75 22];
            app.FullScaleLabel.Text = '% Full Scale';

            % Create SLPMSetpointEditFieldLabel
            app.SLPMSetpointEditFieldLabel = uilabel(app.SettingsPanel);
            app.SLPMSetpointEditFieldLabel.HorizontalAlignment = 'center';
            app.SLPMSetpointEditFieldLabel.FontWeight = 'bold';
            app.SLPMSetpointEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLPMSetpointEditFieldLabel.Position = [13 53 112 22];
            app.SLPMSetpointEditFieldLabel.Text = 'SLPM Setpoint';

            % Create SLPMSetpointEditField
            app.SLPMSetpointEditField = uieditfield(app.SettingsPanel, 'numeric');
            app.SLPMSetpointEditField.Editable = 'off';
            app.SLPMSetpointEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLPMSetpointEditField.Position = [155 53 100 22];

            % Create LPMSetpointEditFieldLabel
            app.LPMSetpointEditFieldLabel = uilabel(app.SettingsPanel);
            app.LPMSetpointEditFieldLabel.HorizontalAlignment = 'center';
            app.LPMSetpointEditFieldLabel.FontWeight = 'bold';
            app.LPMSetpointEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.LPMSetpointEditFieldLabel.Position = [27 22 81 22];
            app.LPMSetpointEditFieldLabel.Text = 'LPM Setpoint';

            % Create LPMSetpointEditField
            app.LPMSetpointEditField = uieditfield(app.SettingsPanel, 'numeric');
            app.LPMSetpointEditField.Editable = 'off';
            app.LPMSetpointEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.LPMSetpointEditField.Position = [155 22 100 22];

            % Create ActualsPanel
            app.ActualsPanel = uipanel(app.TestOneGUI);
            app.ActualsPanel.ForegroundColor = [0.1294 0.1294 0.1294];
            app.ActualsPanel.BorderWidth = 2;
            app.ActualsPanel.TitlePosition = 'centertop';
            app.ActualsPanel.Title = 'Actuals';
            app.ActualsPanel.FontWeight = 'bold';
            app.ActualsPanel.FontSize = 14;
            app.ActualsPanel.Position = [489 106 266 223];

            % Create SLMLabel_2
            app.SLMLabel_2 = uilabel(app.ActualsPanel);
            app.SLMLabel_2.HorizontalAlignment = 'center';
            app.SLMLabel_2.FontWeight = 'bold';
            app.SLMLabel_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SLMLabel_2.Position = [48 161 30 15];
            app.SLMLabel_2.Text = 'SLM';

            % Create LPMLabel
            app.LPMLabel = uilabel(app.ActualsPanel);
            app.LPMLabel.HorizontalAlignment = 'center';
            app.LPMLabel.FontWeight = 'bold';
            app.LPMLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.LPMLabel.Position = [175 158 51 22];
            app.LPMLabel.Text = 'LPM';

            % Create EditField_11
            app.EditField_11 = uieditfield(app.ActualsPanel, 'numeric');
            app.EditField_11.Editable = 'off';
            app.EditField_11.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField_11.Position = [13 129 100 22];

            % Create EditField_12
            app.EditField_12 = uieditfield(app.ActualsPanel, 'numeric');
            app.EditField_12.Editable = 'off';
            app.EditField_12.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField_12.Position = [150 129 100 22];

            % Create EditField_13
            app.EditField_13 = uieditfield(app.ActualsPanel, 'numeric');
            app.EditField_13.Editable = 'off';
            app.EditField_13.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField_13.Position = [13 93 100 22];

            % Create EditField_14
            app.EditField_14 = uieditfield(app.ActualsPanel, 'numeric');
            app.EditField_14.Editable = 'off';
            app.EditField_14.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditField_14.Position = [150 93 100 22];

            % Create ActualSLPMEditFieldLabel
            app.ActualSLPMEditFieldLabel = uilabel(app.ActualsPanel);
            app.ActualSLPMEditFieldLabel.HorizontalAlignment = 'center';
            app.ActualSLPMEditFieldLabel.FontWeight = 'bold';
            app.ActualSLPMEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActualSLPMEditFieldLabel.Position = [18 53 95 22];
            app.ActualSLPMEditFieldLabel.Text = 'Actual SLPM';

            % Create ActualSLPMEditField
            app.ActualSLPMEditField = uieditfield(app.ActualsPanel, 'numeric');
            app.ActualSLPMEditField.Editable = 'off';
            app.ActualSLPMEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActualSLPMEditField.Position = [150 53 100 22];

            % Create ActualLPMEditFieldLabel
            app.ActualLPMEditFieldLabel = uilabel(app.ActualsPanel);
            app.ActualLPMEditFieldLabel.HorizontalAlignment = 'center';
            app.ActualLPMEditFieldLabel.FontWeight = 'bold';
            app.ActualLPMEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActualLPMEditFieldLabel.Position = [25 22 80 22];
            app.ActualLPMEditFieldLabel.Text = 'Actual LPM';

            % Create ActualLPMEditField
            app.ActualLPMEditField = uieditfield(app.ActualsPanel, 'numeric');
            app.ActualLPMEditField.Editable = 'off';
            app.ActualLPMEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ActualLPMEditField.Position = [150 22 100 22];

            % Create UnitPanel
            app.UnitPanel = uipanel(app.TestOneGUI);
            app.UnitPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.UnitPanel.BorderWidth = 2;
            app.UnitPanel.TitlePosition = 'centertop';
            app.UnitPanel.Title = 'Unit';
            app.UnitPanel.FontWeight = 'bold';
            app.UnitPanel.FontSize = 14;
            app.UnitPanel.Position = [289 106 201 223];

            % Create A150Label
            app.A150Label = uilabel(app.UnitPanel);
            app.A150Label.HorizontalAlignment = 'center';
            app.A150Label.FontWeight = 'bold';
            app.A150Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.A150Label.Position = [40 129 53 22];
            app.A150Label.Text = 'A: (1-50)';

            % Create N2Label
            app.N2Label = uilabel(app.UnitPanel);
            app.N2Label.HorizontalAlignment = 'center';
            app.N2Label.FontWeight = 'bold';
            app.N2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.N2Label.Position = [134 132 25 15];
            app.N2Label.Text = 'N2';

            % Create B150Label
            app.B150Label = uilabel(app.UnitPanel);
            app.B150Label.HorizontalAlignment = 'center';
            app.B150Label.FontWeight = 'bold';
            app.B150Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.B150Label.Position = [40 93 53 22];
            app.B150Label.Text = 'B: (1-50)';

            % Create O2Label
            app.O2Label = uilabel(app.UnitPanel);
            app.O2Label.HorizontalAlignment = 'center';
            app.O2Label.FontWeight = 'bold';
            app.O2Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.O2Label.Position = [134 96 25 15];
            app.O2Label.Text = 'O2';

            % Create ControlsPanel
            app.ControlsPanel = uipanel(app.TestOneGUI);
            app.ControlsPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ControlsPanel.BorderWidth = 2;
            app.ControlsPanel.TitlePosition = 'centertop';
            app.ControlsPanel.Title = 'Controls';
            app.ControlsPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ControlsPanel.FontWeight = 'bold';
            app.ControlsPanel.FontSize = 14;
            app.ControlsPanel.Position = [682 343 406 134];

            % Create StartButton
            app.StartButton = uibutton(app.ControlsPanel, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.BackgroundColor = [0.5725 0.8 0.2706];
            app.StartButton.FontWeight = 'bold';
            app.StartButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.StartButton.Position = [19 71 120 22];
            app.StartButton.Text = 'Start';

            % Create StopButton
            app.StopButton = uibutton(app.ControlsPanel, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @StopButtonPushed, true);
            app.StopButton.BackgroundColor = [1 0.3882 0.502];
            app.StopButton.FontWeight = 'bold';
            app.StopButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.StopButton.Position = [144 71 120 22];
            app.StopButton.Text = 'Stop';

            % Create CalculateButton
            app.CalculateButton = uibutton(app.ControlsPanel, 'push');
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateButtonPushed, true);
            app.CalculateButton.BackgroundColor = [0.8 0.8 0.8];
            app.CalculateButton.FontWeight = 'bold';
            app.CalculateButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CalculateButton.Position = [269 71 120 22];
            app.CalculateButton.Text = 'Calculate';

            % Create ReadMFCsButton
            app.ReadMFCsButton = uibutton(app.ControlsPanel, 'push');
            app.ReadMFCsButton.ButtonPushedFcn = createCallbackFcn(app, @ReadMFCsButtonPushed, true);
            app.ReadMFCsButton.BackgroundColor = [0.8 0.8 0.8];
            app.ReadMFCsButton.FontWeight = 'bold';
            app.ReadMFCsButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ReadMFCsButton.Position = [269 44 120 22];
            app.ReadMFCsButton.Text = 'Read MFCs';

            % Create ConnectArduinoButton
            app.ConnectArduinoButton = uibutton(app.ControlsPanel, 'push');
            app.ConnectArduinoButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectArduinoButtonPushed, true);
            app.ConnectArduinoButton.BackgroundColor = [0.8 0.8 0.8];
            app.ConnectArduinoButton.FontWeight = 'bold';
            app.ConnectArduinoButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ConnectArduinoButton.Position = [19 44 120 22];
            app.ConnectArduinoButton.Text = 'Connect Arduino';

            % Create IgniteButton
            app.IgniteButton = uibutton(app.ControlsPanel, 'push');
            app.IgniteButton.ButtonPushedFcn = createCallbackFcn(app, @IgniteButtonPushed, true);
            app.IgniteButton.BackgroundColor = [0.8 0.8 0.8];
            app.IgniteButton.FontWeight = 'bold';
            app.IgniteButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.IgniteButton.Position = [19 10 184 23];
            app.IgniteButton.Text = 'Ignite';

            % Create IgnitionTimesSpinnerLabel
            app.IgnitionTimesSpinnerLabel = uilabel(app.ControlsPanel);
            app.IgnitionTimesSpinnerLabel.HorizontalAlignment = 'center';
            app.IgnitionTimesSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.IgnitionTimesSpinnerLabel.Position = [221 10 94 22];
            app.IgnitionTimesSpinnerLabel.Text = 'Ignition Time (s)';

            % Create IgnitionTimesSpinner
            app.IgnitionTimesSpinner = uispinner(app.ControlsPanel);
            app.IgnitionTimesSpinner.ValueChangedFcn = createCallbackFcn(app, @IgnitionTimesSpinnerValueChanged, true);
            app.IgnitionTimesSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.IgnitionTimesSpinner.BackgroundColor = [0 1 1];
            app.IgnitionTimesSpinner.Position = [316 10 68 22];
            app.IgnitionTimesSpinner.Value = 10;

            % Create ConnectO2SensorButton
            app.ConnectO2SensorButton = uibutton(app.ControlsPanel, 'push');
            app.ConnectO2SensorButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectO2SensorButtonPushed, true);
            app.ConnectO2SensorButton.BackgroundColor = [0.8 0.8 0.8];
            app.ConnectO2SensorButton.FontWeight = 'bold';
            app.ConnectO2SensorButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ConnectO2SensorButton.Position = [144 44 120 22];
            app.ConnectO2SensorButton.Text = 'Connect O2 Sensor';

            % Create PressurePanel
            app.PressurePanel = uipanel(app.TestOneGUI);
            app.PressurePanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PressurePanel.BorderWidth = 2;
            app.PressurePanel.TitlePosition = 'centertop';
            app.PressurePanel.Title = 'Pressure';
            app.PressurePanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.PressurePanel.FontWeight = 'bold';
            app.PressurePanel.FontSize = 14;
            app.PressurePanel.Position = [780 258 307 71];

            % Create ExportPressureButton
            app.ExportPressureButton = uibutton(app.PressurePanel, 'push');
            app.ExportPressureButton.ButtonPushedFcn = createCallbackFcn(app, @ExportPressureButtonPushed, true);
            app.ExportPressureButton.BackgroundColor = [0.8 0.8 0.8];
            app.ExportPressureButton.FontWeight = 'bold';
            app.ExportPressureButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportPressureButton.Position = [186 13 108 23];
            app.ExportPressureButton.Text = 'Export Pressure';

            % Create Label_2
            app.Label_2 = uilabel(app.PressurePanel);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Label_2.Position = [104 13 25 22];
            app.Label_2.Text = '';

            % Create LampPressure
            app.LampPressure = uilamp(app.PressurePanel);
            app.LampPressure.Position = [144 14 20 20];

            % Create RecordPressureButton
            app.RecordPressureButton = uibutton(app.PressurePanel, 'push');
            app.RecordPressureButton.ButtonPushedFcn = createCallbackFcn(app, @RecordPressureButtonPushed, true);
            app.RecordPressureButton.BackgroundColor = [0.8 0.8 0.8];
            app.RecordPressureButton.FontWeight = 'bold';
            app.RecordPressureButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.RecordPressureButton.Position = [14 13 111 23];
            app.RecordPressureButton.Text = 'Record Pressure';

            % Create LoadCellPanel
            app.LoadCellPanel = uipanel(app.TestOneGUI);
            app.LoadCellPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.LoadCellPanel.BorderWidth = 2;
            app.LoadCellPanel.TitlePosition = 'centertop';
            app.LoadCellPanel.Title = 'Load Cell';
            app.LoadCellPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.LoadCellPanel.FontWeight = 'bold';
            app.LoadCellPanel.FontSize = 14;
            app.LoadCellPanel.Position = [780 106 307 71];

            % Create RecordWeightButton
            app.RecordWeightButton = uibutton(app.LoadCellPanel, 'push');
            app.RecordWeightButton.ButtonPushedFcn = createCallbackFcn(app, @RecordWeightButtonPushed, true);
            app.RecordWeightButton.BackgroundColor = [0.8 0.8 0.8];
            app.RecordWeightButton.FontWeight = 'bold';
            app.RecordWeightButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.RecordWeightButton.Position = [12 12 111 23];
            app.RecordWeightButton.Text = 'Record Weight';

            % Create ExportWeightButton
            app.ExportWeightButton = uibutton(app.LoadCellPanel, 'push');
            app.ExportWeightButton.ButtonPushedFcn = createCallbackFcn(app, @ExportWeightButtonPushed, true);
            app.ExportWeightButton.BackgroundColor = [0.8 0.8 0.8];
            app.ExportWeightButton.FontWeight = 'bold';
            app.ExportWeightButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportWeightButton.Position = [187 12 108 23];
            app.ExportWeightButton.Text = 'Export Weight';

            % Create Label_3
            app.Label_3 = uilabel(app.LoadCellPanel);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Label_3.Position = [103 13 25 22];
            app.Label_3.Text = '';

            % Create LampWeight
            app.LampWeight = uilamp(app.LoadCellPanel);
            app.LampWeight.Position = [143 14 20 20];

            % Create LoadCellSettingsPanel
            app.LoadCellSettingsPanel = uipanel(app.TestOneGUI);
            app.LoadCellSettingsPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.LoadCellSettingsPanel.BorderWidth = 2;
            app.LoadCellSettingsPanel.TitlePosition = 'centertop';
            app.LoadCellSettingsPanel.Title = 'Load Cell Settings';
            app.LoadCellSettingsPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.LoadCellSettingsPanel.FontWeight = 'bold';
            app.LoadCellSettingsPanel.FontSize = 14;
            app.LoadCellSettingsPanel.Position = [17 18 1071 74];

            % Create LoadCellCapacitygLabel
            app.LoadCellCapacitygLabel = uilabel(app.LoadCellSettingsPanel);
            app.LoadCellCapacitygLabel.HorizontalAlignment = 'center';
            app.LoadCellCapacitygLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.LoadCellCapacitygLabel.Position = [7 15 169 22];
            app.LoadCellCapacitygLabel.Text = 'Capacity (g)';

            % Create CapacitygSpinner
            app.CapacitygSpinner = uispinner(app.LoadCellSettingsPanel);
            app.CapacitygSpinner.ValueChangedFcn = createCallbackFcn(app, @CapacitygSpinnerValueChanged, true);
            app.CapacitygSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CapacitygSpinner.BackgroundColor = [0 1 1];
            app.CapacitygSpinner.Position = [132 15 72 21];
            app.CapacitygSpinner.Value = 300;

            % Create ExcitationVoltageVSpinnerLabel
            app.ExcitationVoltageVSpinnerLabel = uilabel(app.LoadCellSettingsPanel);
            app.ExcitationVoltageVSpinnerLabel.HorizontalAlignment = 'center';
            app.ExcitationVoltageVSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExcitationVoltageVSpinnerLabel.Position = [225 15 120 22];
            app.ExcitationVoltageVSpinnerLabel.Text = 'Excitation Voltage (V)';

            % Create ExcitationVoltageVSpinner
            app.ExcitationVoltageVSpinner = uispinner(app.LoadCellSettingsPanel);
            app.ExcitationVoltageVSpinner.Step = 0.1;
            app.ExcitationVoltageVSpinner.ValueChangedFcn = createCallbackFcn(app, @ExcitationVoltageVSpinnerValueChanged, true);
            app.ExcitationVoltageVSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExcitationVoltageVSpinner.BackgroundColor = [0 1 1];
            app.ExcitationVoltageVSpinner.Position = [350 15 72 21];
            app.ExcitationVoltageVSpinner.Value = 5.4;

            % Create TareScaleButton
            app.TareScaleButton = uibutton(app.LoadCellSettingsPanel, 'push');
            app.TareScaleButton.ButtonPushedFcn = createCallbackFcn(app, @TareScaleButtonPushed, true);
            app.TareScaleButton.BackgroundColor = [0.8 0.8 0.8];
            app.TareScaleButton.FontWeight = 'bold';
            app.TareScaleButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.TareScaleButton.Position = [907 15 145 23];
            app.TareScaleButton.Text = 'Tare Scale';

            % Create FullScaleOutputmVVSpinnerLabel
            app.FullScaleOutputmVVSpinnerLabel = uilabel(app.LoadCellSettingsPanel);
            app.FullScaleOutputmVVSpinnerLabel.HorizontalAlignment = 'center';
            app.FullScaleOutputmVVSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FullScaleOutputmVVSpinnerLabel.Position = [440 15 145 22];
            app.FullScaleOutputmVVSpinnerLabel.Text = 'Full Scale Output (mV/V)';

            % Create FullScaleOutputmVVSpinner
            app.FullScaleOutputmVVSpinner = uispinner(app.LoadCellSettingsPanel);
            app.FullScaleOutputmVVSpinner.ValueChangedFcn = createCallbackFcn(app, @FullScaleOutputmVVSpinnerValueChanged, true);
            app.FullScaleOutputmVVSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FullScaleOutputmVVSpinner.BackgroundColor = [0 1 1];
            app.FullScaleOutputmVVSpinner.Position = [588 15 72 21];
            app.FullScaleOutputmVVSpinner.Value = 1;

            % Create AmplifierGainSpinnerLabel
            app.AmplifierGainSpinnerLabel = uilabel(app.LoadCellSettingsPanel);
            app.AmplifierGainSpinnerLabel.HorizontalAlignment = 'right';
            app.AmplifierGainSpinnerLabel.Position = [685 15 80 22];
            app.AmplifierGainSpinnerLabel.Text = 'Amplifier Gain';

            % Create AmplifierGainSpinner
            app.AmplifierGainSpinner = uispinner(app.LoadCellSettingsPanel);
            app.AmplifierGainSpinner.Step = 0.01;
            app.AmplifierGainSpinner.ValueChangedFcn = createCallbackFcn(app, @AmplifierGainSpinnerValueChanged, true);
            app.AmplifierGainSpinner.BackgroundColor = [0 1 1];
            app.AmplifierGainSpinner.Position = [779 15 72 21];
            app.AmplifierGainSpinner.Value = 200;

            % Create O2SensorPanel
            app.O2SensorPanel = uipanel(app.TestOneGUI);
            app.O2SensorPanel.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.O2SensorPanel.BorderWidth = 2;
            app.O2SensorPanel.TitlePosition = 'centertop';
            app.O2SensorPanel.Title = 'O2 Sensor';
            app.O2SensorPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.O2SensorPanel.FontWeight = 'bold';
            app.O2SensorPanel.FontSize = 14;
            app.O2SensorPanel.Position = [780 182 307 71];

            % Create RecordO2Button
            app.RecordO2Button = uibutton(app.O2SensorPanel, 'push');
            app.RecordO2Button.ButtonPushedFcn = createCallbackFcn(app, @RecordO2ButtonPushed, true);
            app.RecordO2Button.BackgroundColor = [0.8 0.8 0.8];
            app.RecordO2Button.FontWeight = 'bold';
            app.RecordO2Button.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.RecordO2Button.Position = [12 12 111 23];
            app.RecordO2Button.Text = 'Record %O2';

            % Create ExportO2Button
            app.ExportO2Button = uibutton(app.O2SensorPanel, 'push');
            app.ExportO2Button.ButtonPushedFcn = createCallbackFcn(app, @ExportO2ButtonPushed, true);
            app.ExportO2Button.BackgroundColor = [0.8 0.8 0.8];
            app.ExportO2Button.FontWeight = 'bold';
            app.ExportO2Button.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportO2Button.Position = [187 12 108 23];
            app.ExportO2Button.Text = 'Export %O2';

            % Create Label_4
            app.Label_4 = uilabel(app.O2SensorPanel);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Label_4.Position = [103 13 25 22];
            app.Label_4.Text = '';

            % Create LampO2
            app.LampO2 = uilamp(app.O2SensorPanel);
            app.LampO2.Position = [143 14 20 20];

            % Show the figure after all components are created
            app.TestOneGUI.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TestOneProject

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.TestOneGUI)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.TestOneGUI)
        end
    end
end

