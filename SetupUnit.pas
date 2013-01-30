unit SetupUnit;
// ------------------------------------------
// WinFluor - Camera/Lab.Interface Setup Form
// ------------------------------------------
// (c) J. Dempster, University of Strathclyde 2002, All Rights Reserved
// 29.7.03 TIDRFile component added
// 1/8/03 .FrameInterval can now be edited
// 8/10/03 A/D input, ion binding & diagnostics moved to separate dialog forms
// 11/1/07 User-entered Laser calibration settings added for OptoScan + Lasers
// 31.01.07 Readout speed now set to maximum when camera selected
// 26.02.07 Third laser added to Optoscan + Lasers
// 16.01.08 LED Off/Max voltages added
// 25.01.08 Support for an auxiliary camera for use when main camera is an LSM added
// 21.01.09 User-set extra camera readout time box added
//          Shutter closed wavelength for monochromators added
//          Camer trigger offset now set to default value when light source selected
// 23.01.09 Nicholas Schwarz's modifications added
// 09.03.09 JD .. Separate laser control output range added to light source configuration
// 13.03.09 JD .. Memory violation which ocurred when switching to NIDAQ-MX with no NIDAQ-MX Dll
//                fixed. Card list now also cleared
// 04.10.09 NS .. Added third DAC channel, Vout2
// 01.02.11 JD Post-exposure readout check box added. Exposure time in ext. trigger mode
//             can now be shortened to account for post-exposure readout in camera which do not support
//             overlap readout mode.
// 30.04.12 JD Clocked digital outputs of X series devices (634X,635X,636X) now detected
//             Reset Boards no longer results in repeated digital stimulus output lists

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Grids, ValEdit, ValidatedEdit, IDRFile, maths, math ;
const
     MaxADCChannel = 7 ;
type


  TSetupFrm = class(TForm)
    bOK: TButton;
    bCancel: TButton;
    CardGrp: TGroupBox;
    rbNIDAQ: TRadioButton;
    rbNIDAQMX: TRadioButton;
    meDeviceList: TMemo;
    bResetDevices: TButton;
    ckAutoReset: TCheckBox;
    TabPage: TPageControl;
    CameraTab: TTabSheet;
    GroupBox4: TGroupBox;
    Label41: TLabel;
    cbCamera: TComboBox;
    ModePanel: TPanel;
    lbCameraMode: TLabel;
    cbCameraMode: TComboBox;
    ComPanel: TPanel;
    lbComPort: TLabel;
    cbCameraPort: TComboBox;
    ReadoutSpeedPanel: TPanel;
    Label1: TLabel;
    cbReadoutSpeed: TComboBox;
    edTemperatureSetPoint: TValidatedEdit;
    ADCPanel: TPanel;
    Label48: TLabel;
    cbCameraADC: TComboBox;
    AuxCameraPanel: TPanel;
    Label37: TLabel;
    cbAuxCamera: TComboBox;
    LightSourceTab: TTabSheet;
    LightSourceGrp: TGroupBox;
    cbLightSource: TComboBox;
    LSCalGrp: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edWavelength1: TValidatedEdit;
    edVoltage1: TValidatedEdit;
    edWavelength2: TValidatedEdit;
    edVoltage2: TValidatedEdit;
    LSWaveGrp: TGroupBox;
    Label2: TLabel;
    Label21: TLabel;
    cbLSWavelengthStart: TComboBox;
    cbLSWavelengthEnd: TComboBox;
    LSLEDGrp: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    edLEDOffVoltage: TValidatedEdit;
    edLEDMaxVoltage: TValidatedEdit;
    lsTIRFGrp: TGroupBox;
    GroupBox5: TGroupBox;
    Label49: TLabel;
    Label50: TLabel;
    Label57: TLabel;
    edTIRFOff1: TValidatedEdit;
    edTIRFOn1: TValidatedEdit;
    edTIRFWF1: TValidatedEdit;
    GroupBox8: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    edTIRFOff2: TValidatedEdit;
    edTIRFOn2: TValidatedEdit;
    edTIRFWF2: TValidatedEdit;
    LSLaserGrp: TGroupBox;
    Label38: TLabel;
    Label39: TLabel;
    LSLaserPage: TPageControl;
    Laser1Tab: TTabSheet;
    Label7: TLabel;
    Label26: TLabel;
    edLaser1Wavelength: TValidatedEdit;
    GroupBox2: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label8: TLabel;
    edLaser1OffVoltage: TValidatedEdit;
    edLaser1OnVoltage: TValidatedEdit;
    edLaser1Delay: TValidatedEdit;
    edLaser1Intensity: TValidatedEdit;
    Laser2Tab: TTabSheet;
    Label9: TLabel;
    Label22: TLabel;
    edLaser2Wavelength: TValidatedEdit;
    edLaser2Intensity: TValidatedEdit;
    GroupBox10: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    edlaser2OffVoltage: TValidatedEdit;
    edLaser2OnVoltage: TValidatedEdit;
    edLaser2Delay: TValidatedEdit;
    Laser3Tab: TTabSheet;
    Label30: TLabel;
    Label31: TLabel;
    edLaser3Wavelength: TValidatedEdit;
    edLaser3Intensity: TValidatedEdit;
    GroupBox12: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edLaser3OffVoltage: TValidatedEdit;
    edLaser3OnVoltage: TValidatedEdit;
    edLaser3Delay: TValidatedEdit;
    cbLSLaserStart: TComboBox;
    cbLSLaserEnd: TComboBox;
    TabSheet1: TTabSheet;
    AnalogInputTab: TTabSheet;
    ADCGrp: TGroupBox;
    Label10: TLabel;
    Label18: TLabel;
    cbADCIn: TComboBox;
    cbADCInputMode: TComboBox;
    ZStageTab: TTabSheet;
    GroupBox14: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    Label61: TLabel;
    edLensMagnification: TValidatedEdit;
    edPixelWidth: TValidatedEdit;
    edCalibrationBarSize: TValidatedEdit;
    edCalibrationBarThickness: TValidatedEdit;
    GroupBox7: TGroupBox;
    Label11: TLabel;
    Label5: TLabel;
    edADCInterval: TValidatedEdit;
    cbClockSynchronisation: TComboBox;
    GroupBox13: TGroupBox;
    cbZStageControl: TComboBox;
    Label62: TLabel;
    GroupBox15: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    edZStagePos1: TValidatedEdit;
    edZStageV1: TValidatedEdit;
    edZstagePos2: TValidatedEdit;
    edZStageV2: TValidatedEdit;
    GroupBox9: TGroupBox;
    Label16: TLabel;
    Label42: TLabel;
    cbCameraStart: TComboBox;
    rbCameraStartActiveHigh: TRadioButton;
    rbCameraStartActiveLow: TRadioButton;
    edCameraTriggerOffset: TValidatedEdit;
    edCameraReadoutTime: TValidatedEdit;
    ckCCDClearPreExposure: TCheckBox;
    ckPostExposureReadout: TCheckBox;
    LSShutterGrp: TGroupBox;
    Label43: TLabel;
    Label40: TLabel;
    edShutterClosedWavelength: TValidatedEdit;
    edShutterBlankingPeriod: TValidatedEdit;
    GroupBox3: TGroupBox;
    cbLSShutter: TComboBox;
    rbLSShutterActiveHigh: TRadioButton;
    rbLSShutterActiveLow: TRadioButton;
    GroupBox11: TGroupBox;
    Label3: TLabel;
    Label17: TLabel;
    Label47: TLabel;
    cbVCommand0: TComboBox;
    cbVCommand1: TComboBox;
    cbVCommand2: TComboBox;
    GroupBox6: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    cbDigitalStimStart: TComboBox;
    cbDigitalStimEnd: TComboBox;
    PhotoStimGrp: TGroupBox;
    PhotoStimPage: TPageControl;
    GalvosTab: TTabSheet;
    Label55: TLabel;
    Label56: TLabel;
    cbPhotoStimX: TComboBox;
    cbPhotoStimY: TComboBox;
    AttenuatorsTab: TTabSheet;
    Label51: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    cbPhotoStimIntensity1: TComboBox;
    cbPhotoStimIntensity2: TComboBox;
    cbPhotoStimIntensity3: TComboBox;
    ShutterTab: TTabSheet;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    cbPhotoStimShutter: TComboBox;
    edPhotoStimShutterLatency: TValidatedEdit;
    rbPhotoStimShutterActiveHigh: TRadioButton;
    rbPhotoStimShutterActiveLow: TRadioButton;
    MeterTab: TTabSheet;
    Label44: TLabel;
    cbPhotoStimMeterInput: TComboBox;
    GroupBox1: TGroupBox;
    Label69: TLabel;
    Label70: TLabel;
    edZStageVMin: TValidatedEdit;
    edZStageVMax: TValidatedEdit;
    GroupBox16: TGroupBox;
    Label67: TLabel;
    edZStageMinStepSize: TValidatedEdit;
    ckZStageEnabled: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure cbCameraChange(Sender: TObject);
    procedure cbCameraPortChange(Sender: TObject);
    procedure cbLightSourceChange(Sender: TObject);
    procedure rbNIDAQClick(Sender: TObject);
    procedure rbNIDAQMXClick(Sender: TObject);
    procedure edLensMagnificationKeyPress(Sender: TObject; var Key: Char);
    procedure bResetDevicesClick(Sender: TObject);
    procedure cbCameraModeChange(Sender: TObject);
    procedure cbCameraADCChange(Sender: TObject);
  private
    { Private declarations }
    CameraOpenRequired : Boolean ;
    procedure NewCamera ;
    procedure NewInterfaceCards ;
  public
    { Public declarations }
  end;

var
  SetupFrm: TSetupFrm;

implementation

uses Main, shared, LabIOUnit, TimeCourseUnit, AmpModule , LightSourceUnit,
  RecUnit, SnapUnit, RecADCOnlyUnit, Sealtest, LogUnit, ZStageUnit;


{$R *.DFM}

procedure TSetupFrm.FormShow(Sender: TObject);
// ---------------------------------------------
// Initial control settings when form is opened
// ---------------------------------------------
begin

     // Set NI API type
     if LabIO.NIDAQAPI = NIDAQ then rbNIDAQ.Checked := True
                               else rbNIDAQMX.Checked := True ;

     // Set up controls for new interface cards
     NewInterfaceCards ;

     CameraOpenRequired :=  False ;
     MainFrm.mnCameraSetup.Enabled := False ;

     // Close any form which might be acquiring images
     if MainFrm.FormExists('RecordFrm') then RecordFrm.Close ;
     if MainFrm.FormExists('SnapFrm') then SnapFrm.Close ;
     if MainFrm.FormExists('RecADCOnlyFrm') then RecADCOnlyFrm.Close ;
     if MainFrm.FormExists('SealTestFrm') then SealTestFrm.Close ;

     // Set main camera
     MainFrm.Cam1.GetCameraNameList( cbCamera.Items ) ;
     cbCamera.ItemIndex := MainFrm.CameraType ;

     // Set auxiliary camera
     MainFrm.Cam1.GetCameraNameList( cbAuxCamera.Items ) ;
     cbAuxCamera.ItemIndex := MainFrm.AuxCameraType ;

     // Get camera COM port
     cbCameraPort.ItemIndex := MainFrm.Cam1.ComPort - 1 ;

     // Reset camera
     NewCamera ;

     // Get CCD pre-exposure clear setting
     ckCCDClearPreExposure.Checked := MainFrm.Cam1.CCDClearPreExposure ;

     // Get CCD post-exposure readout setting
     ckPostExposureReadout.Checked := MainFrm.Cam1.CCDPostExposureReadout ;

     // Hardware in use

     edCalibrationBarSize.Value := MainFrm.CalibrationBarSize ;
     edCalibrationBarThickness.Value := MainFrm.CalibrationBarThickness ;

     // Get list of light sources
     LightSource.GetList( cbLightSource.Items ) ;
     cbLightSource.ItemIndex := LightSource.DeviceType ;
     LSCalGrp.Visible := LightSource.UsercalibrationRequired ;
     LSLaserGrp.Visible := LightSource.LaserSettingsRequired ;
     LSLEDGrp.Visible := LightSource.LEDSettingsRequired ;
     LSTIRFGrp.Visible := LightSource.TIRFSettingsRequired ;

     // Set wavelength calibration values (for user-calibrated monochromators)
     edWavelength1.Value := LightSource.Wavelength1 ;
     edVoltage1.Value := LightSource.Voltage1 ;
     edWavelength2.Value := LightSource.Wavelength2 ;
     edVoltage2.Value := LightSource.Voltage2 ;

     // Laser calibration settings
     edLaser1Wavelength.Value := LightSource.LaserWavelength[1] ;
     edLaser1Delay.Value := LightSource.LaserDelay[1] ;
     edLaser1OffVoltage.Value := LightSource.LaserOffVoltage[1] ;
     edLaser1OnVoltage.Value := LightSource.LaserOnVoltage[1] ;
     edLaser1Intensity.Value := LightSource.LaserIntensity[1] ;

     edLaser2Wavelength.Value := LightSource.LaserWavelength[2] ;
     edLaser2Delay.Value := LightSource.LaserDelay[2] ;
     edLaser2OffVoltage.Value := LightSource.LaserOffVoltage[2] ;
     edLaser2OnVoltage.Value := LightSource.LaserOnVoltage[2] ;
     edLaser2Intensity.Value := LightSource.LaserIntensity[2] ;

     edLaser3Wavelength.Value := LightSource.LaserWavelength[3] ;
     edLaser3Delay.Value := LightSource.LaserDelay[3] ;
     edLaser3OffVoltage.Value := LightSource.LaserOffVoltage[3] ;
     edLaser3OnVoltage.Value := LightSource.LaserOnVoltage[3] ;
     edLaser3Intensity.Value := LightSource.LaserIntensity[3] ;

     // LED control settings
     edLEDOffVoltage.Value := LightSource.LEDOffVoltage ;
     edLEDMaxVoltage.Value := LightSource.LEDMaxVoltage ;

     // TIRF control settings
     edTIRFOff1.Value := LightSource.TIRFOff[1] ;
     edTIRFOn1.Value := LightSource.TIRFOn[1] ;
     edTIRFWF1.Value := LightSource.TIRFWF[1] ;
     edTIRFOff2.Value := LightSource.TIRFOff[2] ;
     edTIRFOn2.Value := LightSource.TIRFOn[2] ;
     edTIRFWF2.Value := LightSource.TIRFWF[2] ;

     edShutterClosedWavelength.Value := LightSource.ShutterClosedWavelength ;
     edShutterBlankingPeriod.Value := LightSource.ShutterBlankingPeriod ;

     edADCInterval.Value := MainFrm.ADCScanInterval ;

     // Calibration settings
     edLensMagnification.Value := MainFrm.Cam1.LensMagnification ;
     edPixelWidth.Value := MainFrm.Cam1.PixelWidth ;
     edPixelWidth.Units := MainFrm.Cam1.PixelUnits ;
     edCalibrationBarSize.Units := MainFrm.Cam1.PixelUnits ;
     edCalibrationBarSize.Value := MainFrm.CalibrationBarSize ;
     edCalibrationBarThickness.Value := MainFrm.CalibrationBarThickness ;

     edADCInterval.LoLimit := ADCMinInterval ;

     edTemperatureSetPoint.Value := MainFrm.Cam1.CameraTemperatureSetPoint ;

     // Z Stage
     ckZStageEnabled.Checked := ZStage.Available ;
     edZStagePos1.Value := ZStage.CalPosition1 ;
     edZStagePos2.Value := ZStage.CalPosition2 ;
     edZStageV1.Value := ZStage.CalVoltage1 ;
     edZStageV2.Value := ZStage.CalVoltage2 ;
     edZStageVMin.Value := ZStage.VMin ;
     edZStageVMax.Value := ZStage.VMax ;
     edZStageMinStepSize.Value := ZStage.MinStepSize ;

     ClientWidth := TabPage.Left + TabPage.Width + 5 ;
     ClientHeight := bOk.Top + bOk.Height + 5 ;

     // Auto reset interface cards
     ckAutoReset.Checked := MainFrm.AutoResetInterfaceCards ;

     end ;


procedure TSetupFrm.NewInterfaceCards ;
// ---------------------------------------------
// Setup up dialog box for new interface cards
// ---------------------------------------------
var
     i :Integer ;
     s : string ;
     Device :Integer ;
begin

     // List available interface cards
     meDeviceList.Clear ;
     for Device := 1 to LabIO.NumDevices do begin
         s := format('Device %d: %s, %d ADC channels, %d DAC channels',
                     [Device,
                      LabIO.DeviceBoardName[Device],
                      LabIO.NumADCs[Device],
                      LabIO.NumDACs[Device]] ) ;
         meDeviceList.Lines.Add(s) ;
         end ;

     // Analogue input channels
     cbADCIn.Clear ;
     cbADCIn.Items.AddObject('None',TObject(MaxResources+1)) ;
     for i := 0 to LabIO.NumResources-1 do
         if LabIO.Resource[i].ResourceType = ADCIn then begin
         s := format('Device %d: ADC%d-%d',
              [LabIO.Resource[i].Device,
               LabIO.Resource[i].StartChannel,
               LabIO.Resource[i].EndChannel]) ;
         cbADCIn.Items.AddObject(s,TObject(i))
         end ;
     cbADCIn.ItemIndex := Max( 0,
     cbADCIn.Items.IndexOfObject(TObject(MainFrm.IOConfig.ADCIn))) ;

     // A/D channel input mode
     LABIO.GetADCInputModes( cbADCInputMode.Items ) ;
     cbADCInputMode.ItemIndex := Min(LABIO.ADCInputMode,cbADCInputMode.Items.Count-1) ;

     // Camera start trigger line options
     // ---------------------------------

     cbCameraStart.Clear ;
     cbCameraStart.Items.AddObject('Internal',TObject(MaxResources+1)) ;
     for i := 0 to LabIO.NumResources-1 do begin
         if LabIO.Resource[i].ResourceType = DACOut then begin
            // DAC outputs
            s := format('Device %d: DAC%d',
                 [LabIO.Resource[i].Device,
                  LabIO.Resource[i].StartChannel]) ;
            cbCameraStart.Items.AddObject(s,TObject(i))
            end
         else if (LabIO.Resource[i].ResourceType = DIGOut) and
                 LabIO.DigitalWaveFormCapable[LabIO.Resource[i].Device] then begin
            // Digital outputs
            s := format('Device %d: DIG%d',
                 [LabIO.Resource[i].Device,
                  LabIO.Resource[i].StartChannel]) ;
                cbCameraStart.Items.AddObject(s,TObject(i))
            end ;
         end ;

     cbCameraStart.ItemIndex := Max( 0,
     cbCameraStart.Items.IndexOfObject(TObject(MainFrm.IOConfig.CameraStart))) ;
     rbCameraStartActiveHigh.Checked := MainFrm.IOConfig.CameraStartActiveHigh ;
     rbCameraStartActiveLow.Checked := not rbCameraStartActiveHigh.Checked ;

     // Patch clamp command voltage
     // Light source wavelength control
     // Digital stimulus output

     // Voltage stimulus O/P lines 1 & 2

     cbVCommand0.Clear ;
     cbVCommand0.Items.AddObject('None',TObject(MaxResources+1)) ;
     for i := 0 to LabIO.NumResources-1 do
         if LabIO.Resource[i].ResourceType = DACOut then begin
         s := format('Device %d: DAC%d',
              [LabIO.Resource[i].Device,
               LabIO.Resource[i].StartChannel]) ;
         cbVCommand0.Items.AddObject(s,TObject(i))
         end ;
    cbVCommand0.ItemIndex := Max( 0,
    cbVCommand0.Items.IndexOfObject(TObject(MainFrm.IOConfig.VCommand[0]))) ;

    cbVCommand1.Items.Assign(cbVCommand0.Items) ;
    cbVCommand1.ItemIndex := Max( 0,
    cbVCommand1.Items.IndexOfObject(TObject(MainFrm.IOConfig.VCommand[1]))) ;

    cbVCommand2.Items.Assign(cbVCommand0.Items) ;
    cbVCommand2.ItemIndex := Max( 0,
    cbVCommand2.Items.IndexOfObject(TObject(MainFrm.IOConfig.VCommand[2]))) ;

    // Light source control lines
    // --------------------------

     cbLSWavelengthStart.Clear ;
     cbLSWavelengthStart.Items.AddObject('None',TObject(MaxResources+1)) ;
     for i := 0 to LabIO.NumResources-1 do begin
         if LabIO.Resource[i].ResourceType = DACOut then begin
            // DAC outputs
            s := format('Device %d: DAC%d',
                 [LabIO.Resource[i].Device,
                  LabIO.Resource[i].StartChannel]) ;
            cbLSWavelengthStart.Items.AddObject(s,TObject(i))
            end
         else if (LabIO.Resource[i].ResourceType = DIGOut) and
                 (not LightSource.DACOutputsRequired) and
                 LabIO.DigitalWaveFormCapable[LabIO.Resource[i].Device] then begin
                 // Digital outputs
                 s := format('Device %d: DIG%d',
                     [LabIO.Resource[i].Device,
                      LabIO.Resource[i].StartChannel]) ;
                cbLSWavelengthStart.Items.AddObject(s,TObject(i))
            end ;
         end ;
    cbLSWavelengthEnd.Items.Assign(cbLSWavelengthStart.Items) ;

    // Light source wavelength control (start and end line)
    cbLSWavelengthStart.ItemIndex := Max( 0,
        cbLSWavelengthStart.Items.IndexOfObject(TObject(MainFrm.IOConfig.LSWavelengthStart))) ;
    cbLSWavelengthEnd.ItemIndex := Max( 0,
        cbLSWavelengthEnd.Items.IndexOfObject(TObject(MainFrm.IOConfig.LSWavelengthEnd))) ;

    // Laser start/end control lines
    cbLSLaserStart.Items.Assign(cbLSWavelengthStart.Items) ;
    cbLSLaserEnd.Items.Assign(cbLSWavelengthStart.Items) ;
    cbLSLaserStart.ItemIndex := Max( 0,
        cbLSLaserStart.Items.IndexOfObject(TObject(MainFrm.IOConfig.LSLaserStart))) ;
    cbLSLaserEnd.ItemIndex := Max( 0,
        cbLSLaserEnd.Items.IndexOfObject(TObject(MainFrm.IOConfig.LSLaserEnd))) ;

    // Digital stimulus output channels (both digital and DAC)
    cbDigitalStimStart.Clear ;
    cbDigitalStimStart.Items.AddObject('None',TObject(MaxResources+1)) ;
    // Add digital outputs (if supported)
    for i := 0 to LabIO.NumResources-1 do
         if (LabIO.Resource[i].ResourceType = DIGOut) and
            LabIO.DigitalWaveFormCapable[LabIO.Resource[i].Device] then begin
         s := format('Device %d: DIG%d',
              [LabIO.Resource[i].Device,
               LabIO.Resource[i].StartChannel]) ;
         cbDigitalStimStart.Items.AddObject(s,TObject(i))
         end ;
    // Add D/A outputs
    for i := 0 to LabIO.NumResources-1 do
         if LabIO.Resource[i].ResourceType = DACOut then begin
            // DAC outputs
            s := format('Device %d: DAC%d',
                 [LabIO.Resource[i].Device,
                  LabIO.Resource[i].StartChannel]) ;
            cbDigitalStimStart.Items.AddObject(s,TObject(i))
            end ;

    cbDigitalStimEnd.Items.Assign( cbDigitalStimStart.Items) ;

    // Digital stimulus output (start line)
    cbDigitalStimStart.ItemIndex := Max( 0,
    cbDigitalStimStart.Items.IndexOfObject(TObject(MainFrm.IOConfig.DigitalStimStart))) ;

    // Digital stimulus output (start line)
    cbDigitalStimEnd.ItemIndex := Max( 0,
    cbDigitalStimEnd.Items.IndexOfObject(TObject(MainFrm.IOConfig.DigitalStimEnd))) ;


     // Photo-stimulus control lines

     cbPhotoStimX.Clear ;
     cbPhotoStimX.Items.AddObject('None',TObject(MaxResources+1)) ;
     for i := 0 to LabIO.NumResources-1 do
         if LabIO.Resource[i].ResourceType = DACOut then begin
         s := format('Device %d: DAC%d',
              [LabIO.Resource[i].Device,
               LabIO.Resource[i].StartChannel]) ;
         cbPhotoStimX.Items.AddObject(s,TObject(i))
         end ;
    cbPhotoStimX.ItemIndex := Max( 0,
                              cbPhotoStimX.Items.IndexOfObject(TObject(MainFrm.IOConfig.PhotoStimX))) ;

    cbPhotoStimY.Items.Assign(cbPhotoStimX.Items) ;
    cbPhotoStimY.ItemIndex := Max( 0,
                              cbPhotoStimY.Items.IndexOfObject(TObject(MainFrm.IOConfig.PhotoStimY))) ;

    cbPhotoStimIntensity1.Items.Assign(cbPhotoStimX.Items) ;
    cbPhotoStimIntensity1.ItemIndex := Max( 0,
                                      cbPhotoStimIntensity1.Items.IndexOfObject(TObject(MainFrm.IOConfig.PhotoStimI1))) ;

    cbPhotoStimIntensity2.Items.Assign(cbPhotoStimX.Items) ;
    cbPhotoStimIntensity2.ItemIndex := Max( 0,
                                      cbPhotoStimIntensity2.Items.IndexOfObject(TObject(MainFrm.IOConfig.PhotoStimI2))) ;

    cbPhotoStimIntensity3.Items.Assign(cbPhotoStimX.Items) ;
    cbPhotoStimIntensity3.ItemIndex := Max( 0,
                                      cbPhotoStimIntensity3.Items.IndexOfObject(TObject(MainFrm.IOConfig.PhotoStimI3))) ;


     // Analogue input channels for power meter
     cbPhotoStimMeterInput.Clear ;
     cbPhotoStimMeterInput.Items.AddObject('None',TObject(MaxResources+1)) ;
     for i := 0 to LabIO.NumResources-1 do
         if LabIO.Resource[i].ResourceType = ADCIn then begin
         s := format('Device %d: ADC%d',
              [LabIO.Resource[i].Device,
               LabIO.Resource[i].StartChannel]) ;
         cbPhotoStimMeterInput.Items.AddObject(s,TObject(i))
         end ;
     cbPhotoStimMeterInput.ItemIndex := Max( 0,
                                        cbPhotoStimMeterInput.Items.IndexOfObject(TObject(MainFrm.IOConfig.PhotoStimMeter))) ;

    // Photo-stimulus source shutter
    // Modified by NS 17 September 2008
    // Modified by NS 22 September 2008
    // Modified by NS 23 September 2008
    cbPhotoStimShutter.Clear ;
    cbPhotoStimShutter.Items.Assign(cbPhotoStimX.Items) ;
    cbPhotoStimShutter.ItemIndex := Max( 0,
                                    cbPhotoStimShutter.Items.IndexOfObject(TObject(MainFrm.IOConfig.PhotoStimShutter))) ;
    rbPhotoStimShutterActiveHigh.Checked := MainFrm.IOConfig.PhotoStimShutterActiveHigh ;
    rbPhotoStimShutterActiveLow.Checked := not rbPhotoStimShutterActiveHigh.Checked ;
    edPhotoStimShutterLatency.Value := MainFrm.IOConfig.PhotoStimShutterLatency ;

    // Moving to PhotoStimFrm
    //edPowerMinimum.Value := MainFrm.IOConfig.PhotoStimIPowerMin ;
    //edPowerMaximum.Value := MainFrm.IOConfig.PhotoStimIPowerMax ;
    //edBiasSetting.Value := MainFrm.IOConfig.PhotoStimIBias ;
    //edVoltagePi.Value := MainFrm.IOConfig.PhotoStimIVoltagePi ;

    //if MainFrm.IOConfig.PhotoStimIPolarizationCross then rbPolarizationCross.Checked := True ;
    //rbPolarizationParallel.Checked := Not rbPolarizationCross.Checked ;

    //if MainFrm.IOConfig.PhotoStimIConoptics302 then rbConoptics302.Checked := True;
    //rbConoptics302RM.Checked := Not rbConoptics302.Checked ;

     // Light source shutter
     cbLSShutter.Clear ;
     cbLSShutter.Items.AddObject('None',TObject(MaxResources+1)) ;
     for i := 0 to LabIO.NumResources-1 do
         if (LabIO.Resource[i].ResourceType = DIGOut) then begin
         s := format('Device %d: DIG%d',
              [LabIO.Resource[i].Device,
               LabIO.Resource[i].StartChannel]) ;
         cbLSShutter.Items.AddObject(s,TObject(i))
         end ;
     cbLSShutter.ItemIndex := Max( 0,
     cbLSShutter.Items.IndexOfObject(TObject(MainFrm.IOConfig.LSShutter))) ;
     rbLSShutterActiveHigh.Checked := MainFrm.IOConfig.LSShutterActiveHigh ;
     rbLSShutterActiveLow.Checked := not rbLSShutterActiveHigh.Checked ;

     // Clock synchronisation line
     cbClockSynchronisation.Clear ;
     cbClockSynchronisation.Items.AddObject('RTSI 0',TObject(0)) ;
     cbClockSynchronisation.Items.AddObject('PFI 5',TObject(1)) ;
     cbClockSynchronisation.ItemIndex :=  Max( 0,MainFrm.IOConfig.ClockSyncLine ) ;

     // Z stage control

     cbZStageControl.Clear ;
     for i := 0 to LabIO.NumResources-1 do
         if LabIO.Resource[i].ResourceType = DACOut then begin
         s := format('Device %d: DAC%d',
              [LabIO.Resource[i].Device,
               LabIO.Resource[i].StartChannel]) ;
         cbZStageControl.Items.AddObject(s,TObject(i))
         end ;
    cbZStageControl.ItemIndex := Max( 0,
        cbZStageControl.Items.IndexOfObject(TObject(MainFrm.IOConfig.ZStageControl))) ;


     end ;


procedure TSetupFrm.NewCamera ;
// ---------------------------------------------
// Setup up dialog box for newly selected camera
// ---------------------------------------------
var
    i : Integer ;
    iTop : Integer ;
begin

     // Close existing camera and re-open new if camera changed

     if (cbCamera.ItemIndex <> MainFrm.CameraType) or
        (cbAuxCamera.ItemIndex <> MainFrm.AuxCameraType) or
        (cbCameraPort.ItemIndex <> (MainFrm.Cam1.ComPort-1))  then begin

        Screen.Cursor := crHourglass ;
        MainFrm.StatusBar.SimpleText := ' WAIT: Initialising camera ... ' ;
        MainFrm.Cam1.CloseCamera ;

        // Update main camera type
        MainFrm.CameraType := cbCamera.ItemIndex ;
        MainFrm.AuxCameraType := cbAuxCamera.ItemIndex ;

        // Open new camera
        // (use auxiliary camera setting if main camera is an LSM)
        MainFrm.Cam1.ComPort :=  cbCameraPort.ItemIndex + 1 ;
        if MainFrm.Cam1.IsLSM( MainFrm.CameraType ) then begin
           MainFrm.Cam1.OpenCamera( MainFrm.AuxCameraType ) ;
           end
        else begin
           MainFrm.Cam1.OpenCamera( MainFrm.CameraType ) ;
           end ;

        MainFrm.Cam1.FrameInterval := 0.1 ;

        // Initialise look-up tables
        for i := 0 to MaxFrameType do begin
            MainFrm.GreyLo[i] := 0 ;
            MainFrm.GreyHi[i] := MainFrm.Cam1.GreyLevelMax ;
            MainFrm.UpdateLUT( i, MainFrm.Cam1.GreyLevelMax ) ;
            end ;

        MainFrm.StatusBar.SimpleText := ' Camera Initialised ' ;
        Screen.Cursor := crDefault ;

        end ;

     // Get list of available camera operating modes

     iTop := cbCamera.Top + cbCamera.Height + 5 ;

     // Show auxiliary camera panel if many camera is an LSM
     AuxCameraPanel.Top := iTop ;
     AuxCameraPanel.Visible := MainFrm.Cam1.IsLSM( MainFrm.CameraType ) ;
     if AuxCameraPanel.Visible then iTop := iTop + AuxCameraPanel.Height ;

     ModePanel.Top := iTop ;
     MainFrm.Cam1.GetCameraModeList( cbCameraMode.Items );

     if cbCameraMode.Items.Count > 1 then ModePanel.Visible := True
                                     else ModePanel.Visible := False ;
     cbCameraMode.ItemIndex := Min(MainFrm.Cam1.CameraMode,cbCameraMode.Items.Count-1) ;
     if ModePanel.Visible then iTop := iTop + ModePanel.Height ;

     // Get list of available camera A/D converters
     ADCPanel.Top := iTop ;
     MainFrm.Cam1.GetCameraADCList( cbCameraADC.Items );
     cbCameraADC.ItemIndex := MainFrm.Cam1.CameraADC ;
     if cbCameraADC.Items.Count > 1 then ADCPanel.Visible := True
                                    else ADCPanel.Visible := False ;
     if ADCPanel.Visible then iTop := iTop + ADCPanel.Height ;

     // Get list of available camera readout speeds
     ReadoutSpeedPanel.Top := iTop ;
     MainFrm.Cam1.GetCameraReadoutSpeedList( cbReadoutSpeed.Items );
     cbReadoutSpeed.ItemIndex := MainFrm.Cam1.ReadoutSpeed ;
     if cbReadoutSpeed.Items.Count > 0 then ReadoutSpeedPanel.Visible := True
                                       else ReadoutSpeedPanel.Visible := False ;
     if ReadoutSpeedPanel.Visible then iTop := iTop + ReadoutSpeedPanel.Height ;

     // Display camera control COM port (if present)
     ComPanel.Top := iTop ;
     if MainFrm.Cam1.ComPortUsed then begin
        ComPanel.Visible := True ;
        iTop := iTop + ComPanel.Height ;
        cbCameraPort.ItemIndex := MainFrm.Cam1.ComPort - 1 ;
        end
     else begin
        cbCameraPort.ItemIndex := -1 ;
        ComPanel.Visible := False ;
        end ;

     edCameraTriggerOffset.Value := MainFrm.CameraTriggerOffset ;
     edCameraReadoutTime.Value := MainFrm.Cam1.AdditionalReadoutTime ;

     end ;


procedure TSetupFrm.bOKClick(Sender: TObject);
// ------------------------------------
// Update settings and close setup form
// ------------------------------------
begin

    Screen.Cursor := crDefault ;

    // Update I/O configuration
    MainFrm.IOConfig.ADCIn :=
    Integer(cbADCIn.Items.Objects[cbADCIn.ItemIndex]) ;

    // A/D channel input mode
    LABIO.ADCInputMode := cbADCInputMode.ItemIndex ;

    MainFrm.IOConfig.CameraStart :=
    Integer(cbCameraStart.Items.Objects[cbCameraStart.ItemIndex]) ;
    MainFrm.IOConfig.CameraStartActiveHigh := rbCameraStartActiveHigh.Checked ;

    // Get CCD pre-exposure clear setting
    MainFrm.Cam1.CCDClearPreExposure := ckCCDClearPreExposure.Checked ;

     // Get CCD post-exposure readout setting
    MainFrm.Cam1.CCDPostExposureReadout := ckPostExposureReadout.Checked ;

    // Command voltage O/P lines 1 & 2

    MainFrm.IOConfig.VCommand[0] :=
    Integer(cbVCommand0.Items.Objects[cbVCommand0.ItemIndex]) ;

    MainFrm.IOConfig.VCommand[1] :=
    Integer(cbVCommand1.Items.Objects[cbVCommand1.ItemIndex]) ;

    MainFrm.IOConfig.VCommand[2] :=
    Integer(cbVCommand2.Items.Objects[cbVCommand2.ItemIndex]) ;

    MainFrm.IOConfig.LSShutter :=
    Integer(cbLSShutter.Items.Objects[cbLSShutter.ItemIndex]) ;
    MainFrm.IOConfig.LSShutterActiveHigh := rbLSShutterActiveHigh.Checked ;

    // Monochromator/filter wavelength control lines
    MainFrm.IOConfig.LSWavelengthStart :=
    Integer(cbLSWavelengthStart.Items.Objects[cbLSWavelengthStart.ItemIndex]) ;
    MainFrm.IOConfig.LSWavelengthEnd :=
    Integer(cbLSWavelengthEnd.Items.Objects[cbLSWavelengthEnd.ItemIndex]) ;

    // Laser control lines
    MainFrm.IOConfig.LSLaserStart :=
    Integer(cbLSLaserStart.Items.Objects[cbLSLaserStart.ItemIndex]) ;
    MainFrm.IOConfig.LSLaserEnd :=
    Integer(cbLSLaserEnd.Items.Objects[cbLSLaserEnd.ItemIndex]) ;
    MainFrm.IOConfig.DigitalStimStart :=
    Integer(cbDigitalStimStart.Items.Objects[cbDigitalStimStart.ItemIndex]) ;

    MainFrm.IOConfig.DigitalStimEnd :=
    Integer(cbDigitalStimEnd.Items.Objects[cbDigitalStimEnd.ItemIndex]) ;

    // Photo stimulator settings

    MainFrm.IOConfig.PhotoStimX :=
    Integer(cbPhotoStimX.Items.Objects[cbPhotoStimX.ItemIndex]) ;
    MainFrm.IOConfig.PhotoStimY :=
    Integer(cbPhotoStimY.Items.Objects[cbPhotoStimY.ItemIndex]) ;
    MainFrm.IOConfig.PhotoStimI1 :=
    Integer(cbPhotoStimIntensity1.Items.Objects[cbPhotoStimIntensity1.ItemIndex]) ;
    MainFrm.IOConfig.PhotoStimI2 :=
    Integer(cbPhotoStimIntensity2.Items.Objects[cbPhotoStimIntensity2.ItemIndex]) ;
    MainFrm.IOConfig.PhotoStimI3 :=
    Integer(cbPhotoStimIntensity3.Items.Objects[cbPhotoStimIntensity3.ItemIndex]) ;

    MainFrm.IOConfig.PhotoStimShutter :=
    Integer(cbPhotoStimShutter.Items.Objects[cbPhotoStimShutter.ItemIndex]) ;
    MainFrm.IOConfig.PhotoStimShutterActiveHigh := rbPhotoStimShutterActiveHigh.Checked ;
    MainFrm.IOConfig.PhotoStimShutterLatency := edPhotoStimShutterLatency.Value ;

    MainFrm.IOConfig.PhotoStimMeter :=
    Integer(cbPhotoStimMeterInput.Items.Objects[cbPhotoStimMeterInput.ItemIndex]) ;

    // Moving to PhotoStimFrm
    //MainFrm.IOConfig.PhotoStimIPowerMin := edPowerMinimum.Value ;
    //MainFrm.IOConfig.PhotoStimIPowerMax := edPowerMaximum.Value ;
    //MainFrm.IOConfig.PhotoStimIBias := edBiasSetting.Value ;
    //MainFrm.IOConfig.PhotoStimIVoltagePi := edVoltagePi.Value ;

    //if rbPolarizationCross.Checked then MainFrm.IOConfig.PhotoStimIPolarizationCross := True ;
    //if rbPolarizationParallel.Checked then MainFrm.IOConfig.PhotoStimIPolarizationCross := False ;

    //if rbConoptics302.Checked then MainFrm.IOConfig.PhotoStimIConoptics302 := True ;
    //if rbConoptics302RM.Checked then MainFrm.IOConfig.PhotoStimIConoptics302 := False ;

    MainFrm.IOConfig.ClockSyncLine := Integer(cbClockSynchronisation.Items.Objects[
                                       cbClockSynchronisation.ItemIndex]) ;

    // User-calibrated monochromator settings
    LightSource.DeviceType := cbLightSource.ItemIndex ;
    LightSource.Wavelength1 := edWavelength1.Value ;
    LightSource.Voltage1 := edVoltage1.Value ;
    LightSource.Wavelength2 := edWavelength2.Value ;
    LightSource.Voltage2 := edVoltage2.Value ;

    // Laser calibration settings
    LightSource.LaserWavelength[1] := edLaser1Wavelength.Value ;
    LightSource.LaserDelay[1] := edLaser1Delay.Value ;
    LightSource.LaserOffVoltage[1] := edLaser1OffVoltage.Value ;
    LightSource.LaserOnVoltage[1] := edLaser1OnVoltage.Value ;
    LightSource.LaserIntensity[1] := edLaser1Intensity.Value ;

    LightSource.LaserWavelength[2] := edLaser2Wavelength.Value ;
    LightSource.LaserDelay[2] := edLaser2Delay.Value ;
    LightSource.LaserOffVoltage[2] := edLaser2OffVoltage.Value ;
    LightSource.LaserOnVoltage[2] := edLaser2OnVoltage.Value ;
    LightSource.LaserIntensity[2] := edLaser2Intensity.Value ;

    LightSource.LaserWavelength[3] := edLaser3Wavelength.Value ;
    LightSource.LaserDelay[3] := edLaser3Delay.Value ;
    LightSource.LaserOffVoltage[3] := edLaser3OffVoltage.Value ;
    LightSource.LaserOnVoltage[3] := edLaser3OnVoltage.Value ;
    LightSource.LaserIntensity[3] := edLaser3Intensity.Value ;

    LightSource.LEDOffVoltage := edLEDOffVoltage.Value ;
    LightSource.LEDMaxVoltage := edLEDMaxVoltage.Value ;

     // TIRF control settings
     LightSource.TIRFOff[1] := edTIRFOff1.Value ;
     LightSource.TIRFOn[1] := edTIRFOn1.Value ;
     LightSource.TIRFWF[1] := edTIRFWF1.Value;
     LightSource.TIRFOff[2] := edTIRFOff2.Value ;
     LightSource.TIRFOn[2] := edTIRFOn2.Value ;
     LightSource.TIRFWF[2] := edTIRFWF2.Value ;

    // If outputs are digital force LED voltages to TTL values (0 and 5V)
    if LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].ResourceType = DIGOut then begin
       if LightSource.LEDMaxVoltage <> 0.0 then begin
          LightSource.LEDMaxVoltage := 5.0 ;
          LightSource.LEDOffVoltage := 0.0 ;
          end
       else begin
          LightSource.LEDMaxVoltage := 0.0 ;
          LightSource.LEDOffVoltage := 5.0 ;
          end ;
       end ;

    // Wavelength selected when light source shutters closed
    LightSource.ShutterClosedWavelength := edShutterClosedWavelength.Value ;

    // Shutter blanking period (at end of wavelength cycle
    LightSource.ShutterBlankingPeriod := edShutterBlankingPeriod.Value  ;
    LightSource.ShutterBlankingPeriod := Max(LightSource.ShutterBlankingPeriod,0.0) ;

    MainFrm.ADCScanInterval := edADCInterval.Value ;

    // Camera video mode
    MainFrm.Cam1.CameraMode := cbCameraMode.ItemIndex ;

    // Camera CCD readout speed
    MainFrm.Cam1.ReadoutSpeed := cbReadoutSpeed.ItemIndex ;

    // Calibration settings
    MainFrm.Cam1.LensMagnification := edLensMagnification.Value ;
    MainFrm.CalibrationBarSize := edCalibrationBarSize.Value ;
    MainFrm.CalibrationBarThickness := edCalibrationBarThickness.Value ;

    MainFrm.Cam1.CameraTemperatureSetPoint := edTemperatureSetPoint.Value ;

    MainFrm.Cam1.AdditionalReadoutTime := edCameraReadoutTime.Value ;

     // Z Stage
     ZStage.Available := ckZStageEnabled.Checked ;
     ZStage.CalPosition1 := edZStagePos1.Value ;
     ZStage.CalPosition2 := edZStagePos2.Value ;
     ZStage.CalVoltage1 := edZStageV1.Value ;
     ZStage.CalVoltage2 := edZStageV2.Value ;
     ZStage.VMin := edZStageVMin.Value ;
     ZStage.VMax := edZStageVMax.Value ;
     ZStage.MinStepSize := edZStageMinStepSize.Value ;

     MainFrm.IOConfig.ZStageControl :=
                         Integer(cbZStageControl.Items.Objects[cbZStageControl.ItemIndex]) ;


    // Update relevant forms if they are active
    if MainFrm.FormExists('TimeCourseFrm') then TimeCourseFrm.UpdateSettings ;

    MainFrm.CameraTriggerOffset := edCameraTriggerOffset.Value ;

    // Auto reset interface cards
    MainFrm.AutoResetInterfaceCards := ckAutoReset.Checked ;

    Close ;

    end;


procedure TSetupFrm.bCancelClick(Sender: TObject);
// -------------------------------------
// Exit without updating master settings
// -------------------------------------
begin
    Close ;
    end;


procedure TSetupFrm.FormClose(Sender: TObject; var Action: TCloseAction);
// -----------------------
// Close and destroy form
// -----------------------
begin
     MainFrm.mnCameraSetup.Enabled := True ;
     Action := caFree ;
     end;


procedure TSetupFrm.cbCameraChange(Sender: TObject);
// --------------
// Camera changed
// --------------
var
    i : Integer ;
    ReadSpeed, MaxSpeed : Single ;
begin

     CameraOpenRequired :=  True ;
     NewCamera ;

     // Set camera readout speed to maximum
     if cbReadoutSpeed.Visible then begin
        MaxSpeed := 0.0 ;
        for i := 0 to cbReadoutSpeed.Items.Count-1 do begin
            ReadSpeed := ExtractFloat( cbReadoutSpeed.Items.Strings[i], 0.0 ) ;
            if ReadSpeed > MaxSpeed then begin
               MaxSpeed := ReadSpeed ;
               cbReadoutSpeed.ItemIndex := i ;
               end ;
            end ;
        end ;

     end;

procedure TSetupFrm.cbCameraPortChange(Sender: TObject);
begin
     CameraOpenRequired :=  True ;
     NewCamera ;
     end;

procedure TSetupFrm.cbLightSourceChange(Sender: TObject);
// --------------------
// Light source changed
// --------------------
begin

     LightSource.DeviceType := cbLightSource.ItemIndex ;
     LSCalGrp.Visible := LightSource.UsercalibrationRequired ;
     LSWaveGrp.Visible := LightSource.WavelengthControlRequired ;
//     LSShutterGrp.Visible := True ;
     LSLaserGrp.Visible := LightSource.LaserSettingsRequired ;
     LSLEDGrp.Visible := LightSource.LEDSettingsRequired ;
     LSTIRFGrp.Visible := LightSource.TIRFSettingsRequired ;

     // Set camera trigger offset with default value for light source
     edCameraTriggerOffset.Value := LightSource.WavelengthChangeTime ;

     // Force updates to control line list
     NewInterfaceCards ;

     end;

     
procedure TSetupFrm.rbNIDAQClick(Sender: TObject);
// ----------------------------
// Select Traditional NIDAQ API
// ----------------------------
var
    ch : Integer ;
begin
     if LabIO.NIDAQAPI <> NIDAQ then begin
         MainFrm.StatusBar.SimpleText := 'Wait ... switching to Traditional NIDAQ library' ;
         LabIO.Close ;
         LabIO.NIDAQAPI := NIDAQ ;
         NewInterfaceCards ;
         MainFrm.StatusBar.SimpleText := '' ;
         for ch := 0 to MaxADCChannels-1 do begin
            MainFrm.ADCChannel[ch].yMax := LabIO.ADCMaxValue[1] ;
            MainFrm.ADCChannel[ch].yMin := -LabIO.ADCMaxValue[1] - 1 ;
            end ;
         end ;
     end ;

procedure TSetupFrm.rbNIDAQMXClick(Sender: TObject);
// ----------------------------
// Select NIDAQ-MX API
// ----------------------------
var
    ch : Integer ;
begin
     if LabIO.NIDAQAPI <> NIDAQMX then begin
         MainFrm.StatusBar.SimpleText := 'Wait ... switching to NIDAQ-MX library' ;
         LabIO.Close ;
         LabIO.NIDAQAPI := NIDAQMX ;
         NewInterfaceCards ;
         MainFrm.StatusBar.SimpleText := '' ;
         for ch := 0 to MaxADCChannels-1 do begin
            MainFrm.ADCChannel[ch].yMax := LabIO.ADCMaxValue[1] ;
            MainFrm.ADCChannel[ch].yMin := -LabIO.ADCMaxValue[1] - 1 ;
            end ;
         end ;
     end;

procedure TSetupFrm.edLensMagnificationKeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #13 then begin
        MainFrm.Cam1.LensMagnification := edLensMagnification.Value ;
        edPixelWidth.Value := MainFrm.Cam1.PixelWidth ;
        end ;
     end;

procedure TSetupFrm.bResetDevicesClick(Sender: TObject);
begin

  // Attempt to re-initialize NI cards
  LabIO.ResetNIBoards ;

  // Reload interface card properties
  NewInterfaceCards ;

end;

procedure TSetupFrm.cbCameraModeChange(Sender: TObject);
// -------------------
// Camera mode changed
// -------------------
begin

     // Set camera mode
     MainFrm.Cam1.CameraMode := cbCameraMode.ItemIndex ;

     // Update readout speed list
     MainFrm.Cam1.GetCameraReadoutSpeedList( cbReadoutSpeed.Items );
     cbReadoutSpeed.ItemIndex := Min(Max(MainFrm.Cam1.ReadoutSpeed,0),cbReadoutSpeed.Items.Count-1) ;
     if cbReadoutSpeed.Items.Count > 0 then ReadoutSpeedPanel.Visible := True
                                       else ReadoutSpeedPanel.Visible := False ;

     CameraOpenRequired :=  True ;

     end;

procedure TSetupFrm.cbCameraADCChange(Sender: TObject);
// -------------------
// Camera mode changed
// -------------------
begin

     // Set camera mode
     MainFrm.Cam1.CameraADC := cbCameraADC.ItemIndex ;

     // Update readout speed list
     MainFrm.Cam1.GetCameraReadoutSpeedList( cbReadoutSpeed.Items );
     cbReadoutSpeed.ItemIndex := Min(Max(MainFrm.Cam1.ReadoutSpeed,0),cbReadoutSpeed.Items.Count-1) ;
     if cbReadoutSpeed.Items.Count > 0 then ReadoutSpeedPanel.Visible := True
                                       else ReadoutSpeedPanel.Visible := False ;

     CameraOpenRequired :=  True ;

     end;


end.
