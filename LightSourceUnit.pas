unit LightSourceUnit;
// -----------------------------------------------
// Excitation Light Source Module
// -----------------------------------------------
// (c) J. Dempster, University of Strathclyde 2004
// 18.08.04 V1.0
// 07.09.04 V1.1 User wavelength calibration added
// 15.12.04 V1.2 Simpled voltage-driven LED source added
// 22.03.05 .WavelengthMin and .WavelengthMax functions added
// 11.09.05 Now supports Optoscans with 1800 and 2000 lpm gratings
// 17.02.06 Optoscan + lasers supported added for Tom Carter TIRF systems
// 04.04.06 Now works with 2000 line Optoscan (voltage offset added)
// 29.08.06 ShutterBlankingTime added
// 10.01.07 Optoscan + lasers updated to support user configurable lasers
//          Laser intensity no longer derived from bandwidth
// 16.01.08 Upper wavelength limit for Till monochromators now 693.5 nm
//          LED light source updated, can now output user-defined values for LED on and off
// 24.01.08 Coding for "Optoscan + Lasers" modified to allow monochromator wavelength combined with
//          any combination of lasers
// 04.04.08 Cairn Optoscan 1800 mono now has correct voltage offset
// 16.04.08 Sutter DG4 fast filter changer added
// 12.05.08 NumVControl lines now returned consistently for all light sources
// 19.01.09 ShutterClosedWavelength added. Shutter closed wavelength can now be set by user.
// 09.03.09 VControl array now a record which includes DAC/DIG channel, delay and device
// 19.03.09 JD OptoScanWithLasers, Optoscan bandwidth kept constant when lasers selected
//             Laser 1 shutter now works
// 15.12.10 JD Support for Cairn TIRF system (supplied to Nigel Emptage) added

interface

uses
  Windows,SysUtils, Classes, math ;

{$Include osCodes.inc}
{$Include osLibraryDAC.inc}

const
    lsNone = 0 ;
    lsOptoScan1200 = 1 ;
    lsOptoScan1800 = 2 ;
    lsOptoScan2000 = 3 ;
    lsTill = 4 ;
    lsLambda10 = 5 ;
    lsLED = 6 ;
    lsOptoscanWithLasers = 7 ;
    lsSutterDG4 = 8 ;
    lsCairnTIRF = 9 ;
    lsMaxVControl = 199 ;

    lsMaxLasers = 3 ;
    lsMaxTIRFGalvos = 2 ;

type

  TLSVControl = record
      V : Single ;
      Delay : Single ;
      Device : Integer ;
      Chan : Integer ;
      Name : String ;
      end ;

  TLightSource = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    NumVControlInUse : Integer ;
    VControlInUse : Array[0..lsMaxVControl] of TLSVcontrol ;
    LastOptoscanBandwidth : Single ;

    procedure OptoScanWavelengthToVoltage(
              Wavelength : Single ;
              BandWidth : Single ;
              var VControl : Array of TLSVControl ;
              var NumVControl : Integer
              ) ;

    procedure TillWavelengthToVoltage(
          Wavelength : Single ;
          var VControl : Array of TLSVControl ;
          var NumVControl : Integer
          ) ;

    procedure Lambda10FilterNumToVoltage(
              FilterNum : Integer ;
              var VControl : Array of TLSVControl ;
              var NumVControl : Integer
              ) ;

    procedure LEDFilterNumToVoltage(
              FilterNum : Integer ;
              var VControl : Array of TLSVControl ;
              var NumVControl : Integer
              ) ;

    procedure OptoScanWithLasersWavelengthToVoltage(
              Wavelength : Single ;
              BandWidth : Single ;
              var VControl : Array of TLSVControl ;
              var NumVControl : Integer
              ) ;

    function LaserVoltage(
         LaserNum : Integer ;         // Laser # 1 or 2
         PercentageIntensity : Single // % of maximum intensity
         ) : Single ;

    procedure SutterDG4FilterNumToVoltage(
              FilterNum : Integer ;
              var VControl : Array of TLSVControl ;
              var NumVControl : Integer
              ) ;

    procedure CairnTIRFPositionToVoltage(
              GalvoPosition : Single ;                  // TIRF Galvo position
              var VControl : Array of TLSVControl ;    // Control voltages
              var NumVControl : Integer ) ;            // No. control channels

  public
    { Public declarations }
    DeviceType : Integer ;        // Light source device in use
    Wavelength1 : Single ;
    Voltage1 : Single ;
    Wavelength2 : Single ;
    Voltage2 : Single ;

    LEDOffVoltage : Single ; // Voltage at which LED is off
    LEDMaxVoltage : Single ; // Voltaged at which LED output is maximal

    ShutterClosedWavelength : Single ; // Wavelength selected when shutter is closed
    ShutterBlankingPeriod : Single ;   // Closed period at end of wavelength cycle

    // User defined laser settings (for lsOptoScanWithLasers2)
    LaserWavelength: Array[1..lsMaxLasers] of Single ;
    LaserDelay: Array[1..lsMaxLasers] of Single ;
    LaserOffVoltage: Array[1..lsMaxLasers] of Single ;
    LaserOnVoltage: Array[1..lsMaxLasers] of Single ;
    LaserIntensity: Array[1..lsMaxLasers] of Single ;

    // TIRF angle galvo control voltages
    TIRFOff: Array[1..lsMaxTIRFGalvos] of Single ; // Off position
    TIRFOn: Array[1..lsMaxTIRFGalvos] of Single ;  // TIRF position
    TIRFWF: Array[1..lsMaxTIRFGalvos] of Single ;  // Wide field position

    // Get list of supported light source devices
    procedure GetList( List : TStrings ) ;

    // Get control voltages for selected wavelength/bandwidth
    procedure WavelengthToVoltage(
              FilterNum : Integer ;
              Wavelength : Single ;
              BandWidth : Single ;
              var VControl : Array of TLSVControl ;
              var NumVControl : Integer
              ) ;

    procedure ShutterClosedVoltages(
              var VControl : Array of TLSVControl ;
              var NumVControl : Integer
              ) ;

    function WavelengthChangeTime : Single ;
    function WavelengthMin : Single ;
    function WavelengthMax : Single ;
    function UserCalibrationRequired : Boolean ;
    function LaserSettingsRequired : Boolean ;
    function LEDSettingsRequired : Boolean ;
    function TIRFSettingsRequired : Boolean ;
    function WavelengthControlRequired : Boolean ;
    function ShutterControlRequired : Boolean ;
    function DACOutputsRequired : Boolean ;
    function ShutterClosedWavelengthRequired : Boolean ;
    function ShutterBlankingTime : Single ;

  end;

var
  LightSource: TLightSource;

implementation

uses Main, LabIOUnit;

{$R *.dfm}

procedure TLightSource.GetList( List : TStrings ) ;
// -----------------------------------
// Get list of supported light sources
// -----------------------------------
begin
     List.Clear ;
     List.Add('None') ;
     List.Add('Cairn Optoscan (1200)') ;
     List.Add('Cairn Optoscan (1800)') ;
     List.Add('Cairn Optoscan (2000)') ;
     List.Add('Till monochromator') ;
     List.Add('Sutter Lambda-10') ;
     List.Add('LED') ;
     List.Add('OptoScan + Lasers') ;
     List.Add('Sutter DG4') ;
     List.Add('Cairn TIRF') ;

     end ;


function TLightSource.WavelengthChangeTime : Single ;
// -------------------------------
// Time taken to change wavelength
// -------------------------------
begin
    case DeviceType of
        lsOptoScan1200,
        lsOptoScan1800,
        lsOptoScan2000,
        lsOptoscanWithLasers : Result := 0.001 ;
        lsTill : Result := 0.001 ;
        lsLambda10 : Result := 0.1 ;
        lsLED : Result := 0.0 ;
        lsSutterDG4 : Result := 0.001 ;
        lsCairnTIRF : Result := 0.001 ;
        else begin
             Result := 0 ;
             end ;
        end ;
    end ;


function TLightSource.WavelengthMin : Single ;
// ------------------
// Minimum wavelength
// -------------------
var
    MinWavelength : Double ;
begin
    case DeviceType of

        lsOptoScan1200,lsOptoscanWithLasers : begin
            os_Set_Grating_Lines( 1200 ) ;
            os_Min_Wavelength(@MinWavelength) ;
            Result := 300 ; //MinWavelength ;
            end ;

        lsOptoScan1800 : begin
            os_Set_Grating_Lines( 1800 ) ;
            os_Min_Wavelength(@MinWavelength) ;
            Result := 300 ; //MinWavelength ;
            end ;

        lsOptoScan2000 : begin
            os_Set_Grating_Lines( 2000 ) ;
            os_Min_Wavelength(@MinWavelength) ;
            Result := 300 ; //MinWavelength ;
            end ;

        lsTill : Result := 305.0 ;
        lsLambda10 : Result := 0.0 ;
        lsLED : Result := 0.0 ;
        lsSutterDG4 : Result := 0.0 ;
        lsCairnTIRF : Result := 0.0 ;
        else begin
             Result := 0 ;
             end ;
        end ;
    end ;


Function TLightSource.WavelengthMax : Single ;
// ------------------
// Maximum wavelength
// -------------------
var
    MaxWavelength : Double ;
begin
    case DeviceType of

        lsOptoScan1200 : begin
            os_Set_Grating_Lines( 1200 ) ;
            os_Max_Wavelength(@MaxWavelength) ;
            Result := 750 ; //MaxWavelength ;
            end ;

        lsOptoScan1800 : begin
            os_Set_Grating_Lines( 1800 ) ;
            os_Max_Wavelength(@MaxWavelength) ;
            Result := 750 ; //MaxWavelength ;
            end ;

        lsOptoScan2000 : begin
            os_Set_Grating_Lines( 2000 ) ;
            os_Max_Wavelength(@MaxWavelength) ;
            Result := 750 ; //MaxWavelength ;
            end ;

        lsOptoscanWithLasers : begin
            os_Set_Grating_Lines( 1200 ) ;
            os_Max_Wavelength(@MaxWavelength) ;
            Result := 3000 ; //MaxWavelength ;
            end ;

        lsTill : Result := 693.5 ; //original value 550; changed 14.12.2007 M.Ascherl
        lsLambda10 : Result := 0.0 ;
        lsLED : Result := 0.0 ;
        lsSutterDG4 : Result := 0.0 ;
        lsCairnTIRF : Result := 0.0 ;
        else begin
             Result := 0 ;
             end ;
        end ;
    end ;


function TLightSource.UserCalibrationRequired : Boolean ;
// ---------------------------------------------------------
// Returns TRUE if user calibration of light source required
// ---------------------------------------------------------
begin
    case DeviceType of
        lsTill : Result := True ;
        else Result := False ;
        end ;
    end ;


function TLightSource.LaserSettingsRequired : Boolean ;
// ---------------------------------------------------------
// Returns TRUE if used must supply laser settings
// ---------------------------------------------------------
begin
    case DeviceType of
        lsOptoscanWithLasers : Result := True ;
        else Result := False ;
        end ;
    end ;


function TLightSource.LEDSettingsRequired : Boolean ;
// ---------------------------------------------------------
// Returns TRUE if used must supply LED on/off voltages
// ---------------------------------------------------------
begin
    case DeviceType of
        lsLED : Result := True ;
        else Result := False ;
        end ;
    end ;


function TLightSource.TIRFSettingsRequired : Boolean ;
// ---------------------------------------------------------
// Returns TRUE if used must TIRF galvo voltage settings
// ---------------------------------------------------------
begin
    case DeviceType of
        lsCairnTIRF : Result := True ;
        else Result := False ;
        end ;
    end ;


function TLightSource.WavelengthControlRequired : Boolean ;
// ----------------------------------------------------------------
// Returns TRUE if wavelength control line required by light source
// ----------------------------------------------------------------
begin
    case DeviceType of
        lsOptoScan1200,lsOptoScan1800,lsOptoScan2000 : Result := True ;
        lsOptoscanWithLasers : Result := True ;
        lsTill : Result := True ;
        lsLambda10 : Result := True ;
        lsLED : Result := True ;
        lsSutterDG4 : Result := True ;
        lsCairnTIRF : Result := True ;
        else Result := False ;
        end ;
    end ;


function TLightSource.ShutterControlRequired : Boolean ;
// ----------------------------------------------------------------
// Returns TRUE if shutter control line required by light source
// ----------------------------------------------------------------
begin
    case DeviceType of
        lsOptoScan1200,lsOptoScan1800,lsOptoScan2000 : Result := false ;
        lsOptoscanWithLasers : Result := false ;
        lsTill : Result := false ;
        lsLambda10 : Result := True ;
        lsLED : Result := false ;
        lsSutterDG4 : Result := False ;
        else Result := False ;
        end ;
    end ;


function TLightSource.DACOutputsRequired : Boolean ;
// ----------------------------------------------------------------
// Returns TRUE if DAC outputs required for controlling light source
// ----------------------------------------------------------------
begin
    case DeviceType of
        lsOptoScan1200,lsOptoScan1800,lsOptoScan2000 : Result := True ;
        lsOptoscanWithLasers : Result := True ;
        lsTill : Result := True ;
        lsLambda10 : Result := False ;
        lsLED : Result := false ;
        lsCairnTIRF : Result := True ;
        else Result := False ;
        end ;
    end ;


function TLightSource.ShutterClosedWavelengthRequired : Boolean ;
// ----------------------------------------------------------------
// Returns TRUE if shutter closed wavelength supported by light source
// ----------------------------------------------------------------
begin
    case DeviceType of
        lsOptoScan1200,lsOptoScan1800,lsOptoScan2000 : Result := True ;
        lsOptoscanWithLasers : Result := True ;
        lsTill : Result := True ;
        lsLambda10 : Result := False ;
        lsLED : Result := False ;
        lsSutterDG4 : Result := False ;
        lsCairnTIRF : Result := True ;
        else Result := False ;
        end ;
    end ;


function TLightSource.ShutterBlankingTime : Single ;
// ----------------------------------------------------------------
// Returns time to hold shutter closed at being of a frame
// ----------------------------------------------------------------
begin
    case DeviceType of
        lsOptoScan1200,lsOptoScan1800,lsOptoScan2000 : Result := 0.0 ;
        lsOptoscanWithLasers : Result := 0.0 ;
        lsTill : Result := 0.0 ;
        lsLambda10 : Result := 0.0 ;
        lsLED : Result := 0.0 ;
        lsSutterDG4 : Result := 0.0 ;
        lsCairnTIRF : Result := 0.0 ;
        else begin
             Result := 0.0 ;
             end ;
        end ;
    end ;


procedure TLightSource.WavelengthToVoltage(
          FilterNum : Integer ;
          Wavelength : Single ;
          BandWidth : Single ;
          var VControl : Array of TLSVControl ;
          var NumVControl : Integer
          ) ;
// --------------------------------------------------------
// Get control voltages for selected wavelength & bandwidth
// --------------------------------------------------------
var
    i : Integer ;
begin

    // Exit if no control lines defined
    if not MainFrm.IOResourceAvailable(MainFrm.IOConfig.LSWavelengthStart) then begin
       NumVControl := 0 ;
       Exit ;
       end ;

    case DeviceType of
        lsOptoScan1200,lsOptoScan1800,lsOptoScan2000 : begin
            OptoScanWavelengthToVoltage( Wavelength,
                                         BandWidth,
                                         VControl,
                                         NumVControl ) ;
            end ;

        lsTill : begin
            TillWavelengthToVoltage( Wavelength,
                                     VControl,
                                     NumVControl ) ;
            end ;
        lsLambda10 : Begin
            Lambda10FilterNumToVoltage( FilterNum,
                                        VControl,
                                        NumVControl ) ;
            end ;
        lsLED : Begin
            LEDFilterNumToVoltage( FilterNum,
                                   VControl,
                                   NumVControl ) ;
            end ;
        lsOptoScanWithLasers : begin
            OptoScanWithLasersWavelengthToVoltage( Wavelength,
                                                   BandWidth,
                                                   VControl,
                                                   NumVControl ) ;
            end ;

        lsSutterDG4 : Begin
            SutterDG4FilterNumToVoltage( FilterNum,
                                         VControl,
                                         NumVControl ) ;
            end ;

        lsCairnTIRF : Begin
            CairnTIRFPositionToVoltage(  Wavelength,
                                         VControl,
                                         NumVControl ) ;
            end ;

        else begin
             NumVControl := 0 ;
             end ;
        end ;

    // Keep last voltage control settings used
    NumVControlInUse := NumVControl ;
    for i := 0 to NumVControl-1 do VControlInUse[i] := VControl[i] ;

    end ;


procedure TLightSource.ShutterClosedVoltages(
          var VControl : Array of TLSVControl ;
          var NumVControl : Integer
          ) ;
// -------------------------------------------------
// Return DAC voltages which close all light sources
// -------------------------------------------------
var
    i : Integer ;
begin

    // Exit if no control lines defined
    if not MainFrm.IOResourceAvailable(MainFrm.IOConfig.LSWavelengthStart) then begin
       NumVControl := 0 ;
       Exit ;
       end ;

    case DeviceType of
        lsOptoScan1200,lsOptoScan1800,lsOptoScan2000 : begin
            OptoScanWavelengthToVoltage( LightSource.ShutterClosedWavelength,
                                         0.0,
                                         VControl,
                                         NumVControl ) ;
            end ;

        lsTill : begin
            TillWavelengthToVoltage(
            LightSource.ShutterClosedWavelength,
                                     VControl,
                                     NumVControl ) ;
            end ;

        lsLambda10 : Begin
  //          Lambda10FilterNumToVoltage( 0,
  //                                      VControl,
  //                                      VDelay,
  //                                      NumVControl ) ;
            // Use last settings
            NumVControl := NumVControlInUse ;
            for i := 0 to NumVControl-1 do VControl[i] := VControlInUse[i] ;

            end ;

        lsLED : Begin
            LEDFilterNumToVoltage( -1, {-1 forces off setting}
                                   VControl,
                                   NumVControl ) ;
            end ;

        lsOptoScanWithLasers : begin
            OptoScanWithLasersWavelengthToVoltage( LightSource.ShutterClosedWavelength,
                                                   0.0,
                                                   VControl,
                                                   NumVControl ) ;
            end ;

        lsSutterDG4 : Begin
            SutterDG4FilterNumToVoltage( -1, {-1 forces off setting}
                                         VControl,
                                        NumVControl ) ;
            end ;

        lsCairnTIRF : Begin
            CairnTIRFPositionToVoltage(  0,        // Both TIRF galvos in off position
                                         VControl,
                                         NumVControl ) ;
            end ;

        else begin
             NumVControl := 0 ;
             end ;
        end ;
    end ;


procedure TLightSource.OptoScanWavelengthToVoltage(
          Wavelength : Single ;                      // Selected wavelength
          BandWidth : Single ;                       // Selected bandwidth
          var VControl : Array of TLSVControl ;      // Control voltage array (returned)
          var NumVControl : Integer                  // No. entries in VControl (returned)
          ) ;
// -----------------------------------------------------------------
// Get OptoScan control voltages for selected wavelength & bandwidth
// -----------------------------------------------------------------
var
     DValue : Double ;
     NumLines : DWord ;
     FileName : String ;
     VOffset : Double ;
begin

     // No. of channels available to control light source
     NumVControl := LabIO.Resource[MainFrm.IOConfig.LSWavelengthEnd].StartChannel -
                    LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
     NumVControl := Min(NumVControl,3) ;

     FileName := MainFrm.ProgramDirectory + 'oslibrary.ini' ;
     os_Load_Interface_Defaults( PChar(FileName));

     // Set lines/mm of grating
     case DeviceType of
          lsOptoScan1200 : begin
              NumLines := 1200 ;
              VOffset := 0.0 ;
              end ;
          lsOptoScan1800 : begin
              NumLines := 1800 ;
              VOffset := -1.25 ;
              end ;
          else begin // lsOptoScan2000
              NumLines := 2000 ;
              VOffset := -1.8 ;
              end ;
          end ;
     os_Set_Grating_Lines( NumLines ) ;

     // Set input slit bandwidth
     DValue := Bandwidth ;
     os_In_Slit_Bandwidth_To_Width( @DValue ) ;
     os_In_Slit_Width_To_Voltage( @DValue ) ;
     VControl[0].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel ;
     VControl[0].V := DValue ;
     VControl[0].Delay := 0.0 ;
     VControl[0].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
     VControl[0].Name := format('Optoscan: Input slit: Dev%d:AO%d ',
                         [VControl[0].Device,VControl[0].Chan]) ;

     // Set centre wavelength
     DValue := Wavelength ;
     os_Wavelength_To_Voltage( @DValue ) ;
     DValue := DValue + VOffset ;
     VControl[1].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
     VControl[1].V := DValue ;
     VControl[1].Delay := 0.0 ;
     VControl[1].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
     VControl[1].Name := format('Optoscan: Centre wavelength: Dev%d:AO%d ',
                         [VControl[1].Device,VControl[1].Chan]) ;

     // Set output slit bandwidth
     DValue := Bandwidth ;
     os_Out_Slit_Bandwidth_To_Width( @DValue ) ;
     os_Out_Slit_Width_To_Voltage( @DValue ) ;
     VControl[2].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 2 ;
     VControl[2].V := DValue ;
     VControl[2].Delay := 0.0 ;
     VControl[2].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
     VControl[2].Name := format('Optoscan: Output slit: Dev%d:AO%d ',
                         [VControl[2].Device,VControl[2].Chan]) ;

//      outputdebugString(PChar(format('V0=%.4g V1=%.4g V2=%.4g',[VControl[0],VControl[1],VControl[2]]))) ;

     end;


procedure TLightSource.TillWavelengthToVoltage(
          Wavelength : Single ;
          var VControl : Array of TLSVControl ;
          var NumVControl : Integer
          ) ;
// ---------------------------------------------------
// Get Till control voltages for selected wavelength
// ---------------------------------------------------
const
    WavelengthMin = 305.0 ;
    WavelengthMax = 693.5;  //original value 550.0; changed 14.12.2007 M.Ascherl
    //Wavelength0 = 340.0 ;
    //V0 = -2.25 ;
    //Wavelength1 = 495.0 ;
    //V1 = 0.2 ;
var
     VScale : Single ;
begin

     // No. of channels available to control light source
     NumVControl := LabIO.Resource[MainFrm.IOConfig.LSWavelengthEnd].StartChannel -
                      LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
     NumVControl := Min(NumVControl,1) ;

     // Set wavelength
     if Wavelength < WavelengthMin then Wavelength := WavelengthMin ;
     if Wavelength > WavelengthMax then Wavelength := WavelengthMax ;
     if Abs(Wavelength2 - Wavelength1) > 0.1 then begin
        VScale := (Voltage2 - Voltage1) / (Wavelength2 - Wavelength1) ;
        VControl[0].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel ;
        VControl[0].V := (Wavelength - Wavelength1)*VScale + Voltage1 ;
        VControl[0].Delay := 0.0 ;
        VControl[0].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
        VControl[0].Name := format('Till Monochromator: Centre Wavelength: : Dev%d:AO%d ',
                            [VControl[0].Device,VControl[0].Chan]) ;
        end
     else begin
       VControl[0].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel ;
       VControl[0].V := 0.0 ;
       VControl[0].Delay := 0.0 ;
       VControl[0].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
       VControl[0].Name := format('Till Monochromator: Centre Wavelength: : Dev%d:AO%d ',
                            [VControl[0].Device,VControl[0].Chan]) ;
       end ;

     end;


procedure TLightSource.Lambda10FilterNumToVoltage(
          FilterNum : Integer ;
          var VControl : Array of TLSVControl ;
          var NumVControl : Integer
          ) ;
// ---------------------------------------
// Get Lambd10 filter # selection voltages
// ---------------------------------------
var
     iBit : Integer ;
     i : Integer ;
     OutputType : String ;
begin

     // No. of channels available to control light source
     NumVControl := LabIO.Resource[MainFrm.IOConfig.LSWavelengthEnd].StartChannel -
                      LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
     NumVControl := Min(NumVControl,4) ;

     if LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].ResourceType = DigOut then OutputType := 'DO'
                                                                                 else OutputType := 'AO' ;
     iBit := 1 ;
     for i := 0 to NumVControl-1 do begin
         if (FilterNum and iBit) <> 0 then VControl[i].V := 4.9
                                      else VControl[i].V := 0.0 ;
         VControl[i].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + i ;
         iBit := iBit*2 ;
         VControl[i].Delay := 0.0 ;
         VControl[i].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
         VControl[i].Name := format('Lambda 10: Filter control bit%d : Dev%d:%s%d',
                             [i-1,VControl[i].Device,OutputType,VControl[i].Chan]) ;
         end ;

     end;


procedure TLightSource.LEDFilterNumToVoltage(
          FilterNum : Integer ;
          var VControl : Array of TLSVControl ;
          var NumVControl : Integer
          ) ;
// ---------------------------------------
// Get LED filter # selection voltages
// ---------------------------------------
var
    i : Integer ;
    OutputType : String ;
begin

     // No. of channels available to control light source
     NumVControl := LabIO.Resource[MainFrm.IOConfig.LSWavelengthEnd].StartChannel -
                      LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
     NumVControl := Min(NumVControl,4) ;

     if LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].ResourceType = DigOut then OutputType := 'DO'
                                                                                 else OutputType := 'AO' ;

     for i := 0 to NumVControl-1 do begin
         VControl[i].V := LEDOffVoltage ;
         VControl[i].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + i ;
         VControl[i].Delay := 0.0 ;
         VControl[i].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
         VControl[i].Name := format('LED: No.%d : Dev%d:%s%d',
                             [i+1,VControl[i].Device,OutputType,VControl[i].Chan]) ;
         end ;

     if (FilterNum >= 0) and (FilterNum < NumVControl) then VControl[FilterNum].V := LEDMaxVoltage ;

     end;


procedure TLightSource.OptoScanWithLasersWavelengthToVoltage(
          Wavelength : Single ;
          BandWidth : Single ;
          var VControl : Array of TLSVControl ;  // Control voltages (out)
          var NumVControl : Integer         // No. of control voltages (out)
          ) ;
// -------------------------------------------------------------------------
// Return OptoScan & laser control voltages for selected wavelength & bandwidth
// -------------------------------------------------------------------------
const
    InputSlitDAC = 0 ;      // Optoscan
    GratingDAC = 1 ;        // Optoscan
    OutputSlitDAC = 2 ;      // Optoscan
    Laser1DAC = 3 ;          // Laser #1 Intensity control
    Laser2DAC = 4 ;          // Laser #2 Intensity control
    Laser3DAC = 5 ;          // Laser #3 Intensity control
    Laser1Shutter = 6 ;      // Laser #1 shutter control

    // Values added to wavelength to select laser
    Laser1Value = 1000.0 ;
    Laser2Value = 10000.0 ;
    Laser3Value = 100000.0 ;
    OptoScanWavelengthMin = 100.0 ;

var
     NumVOpto : Integer ;
     DValue : Double ;
     NumLines : DWord ;
     LaserDAC : Integer ;
     i : Integer ;
     OptoScanWavelength : Single ;
     LaserOn : Array[1..lsMaxLasers] of Boolean ;
     iVControl : Integer ;
begin

     // No. of channels available to control optoscan
     NumVOpto := LabIO.Resource[MainFrm.IOConfig.LSWavelengthEnd].StartChannel -
                      LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
     NumVOpto := Min(NumVOpto,3) ;

     // No. of channels available to control lasers
     NumVControl := NumVOpto +
                    LabIO.Resource[MainFrm.IOConfig.LSLaserEnd].StartChannel -
                    LabIO.Resource[MainFrm.IOConfig.LSLaserStart].StartChannel + 1 ;
     NumVControl := Min(NumVControl,7) ;

     // Set lines/mm of grating
     NumLines := 1200 ;
     os_Set_Grating_Lines( NumLines ) ;

     // Determine which lasers are on
     // Wavelength = Optoscan + Laser 1 + Laser 2 + Laser 3
     // Laser 1 = 1000
     // Laser 2 = 10000
     // Laser 3 = 100000

     OptoScanWavelength := Wavelength ;
     for i := 1 to High(LaserOn) do LaserOn[i] := False ;
     if OptoScanWavelength >= Laser3Value then begin
        LaserOn[3] := True ;
        OptoScanWavelength := OptoScanWavelength - Laser3Value ;
        end ;
     if OptoScanWavelength >= Laser2Value then begin
        LaserOn[2] := True ;
        OptoScanWavelength := OptoScanWavelength - Laser2Value ;
        end ;
     if OptoScanWavelength >= Laser1Value then begin
        LaserOn[1] := True ;
        OptoScanWavelength := OptoScanWavelength - Laser1Value ;
        end ;

     // If any lasers are on, set monochromator to off wavelength
     // and keep bandwidth same as before
     if LaserOn[1] or LaserOn[2] or LaserOn[3] then begin
        OptoScanWavelength := LightSource.ShutterClosedWavelength ;
        Bandwidth := LastOptoscanBandwidth ;
        end ;

     // Initialise VControl index
     iVControl := 0 ;

     // Set Optoscan wavelength
     // ------------------------

     // Set input slit bandwidth
     if iVControl < NumVOpto then begin
        LastOptoscanBandwidth := Bandwidth ;
        DValue := Bandwidth ;
        os_In_Slit_Bandwidth_To_Width( @DValue ) ;
        os_In_Slit_Width_To_Voltage( @DValue ) ;
        VControl[iVControl].V := DValue ;
        VControl[iVControl].Delay := 0.0 ;
        VControl[iVControl].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel
                                    + InputSlitDAC ;
        VControl[iVControl].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
        VControl[iVControl].Name := format('Optoscan: Input slit: Dev%d:AO%d ',
                                    [VControl[iVControl].Device,VControl[iVControl].Chan]) ;

        Inc(iVControl) ;
        end ;

     // Set centre wavelength
     if iVControl < NumVOpto then begin
        DValue := OptoScanWavelength ;
        os_Wavelength_To_Voltage( @DValue ) ;
        VControl[iVControl].V := DValue ;
        VControl[iVControl].Delay := 0.0 ;
        VControl[iVControl].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel
                                    + GratingDAC ;
        VControl[iVControl].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
        VControl[iVControl].Name := format('Optoscan: Wavelength: Dev%d:AO%d ',
                                    [VControl[iVControl].Device,VControl[iVControl].Chan]) ;

        Inc(iVControl) ;
        end ;

     // Set output slit bandwidth
     if iVControl < NumVOpto then begin
        LastOptoscanBandwidth := Bandwidth ;
        DValue := Bandwidth ;
        os_Out_Slit_Bandwidth_To_Width( @DValue ) ;
        os_Out_Slit_Width_To_Voltage( @DValue ) ;
        VControl[iVControl].V := DValue ;
        VControl[iVControl].Delay := 0.0 ;
        VControl[iVControl].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel
                                    + OutputSlitDAC ;
        VControl[iVControl].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
        VControl[iVControl].Name := format('Optoscan: Output slit: Dev%d:AO%d ',
                                    [VControl[iVControl].Device,VControl[iVControl].Chan]) ;

        Inc(iVControl) ;
        end ;

    // Set laser control voltages

    LaserDAC := 0 ;
    for i := 1 to lsMaxLasers do if (iVControl < NumVControl) then begin

        // Laser delay
        VControl[iVControl].Delay := LaserDelay[i] ;

        // Set laser voltage
        if LaserOn[i] then VControl[iVControl].V := LaserVoltage( i, LaserIntensity[i] )
                      else VControl[iVControl].V := LaserVoltage( i, 0.0 ) ;

        VControl[iVControl].Chan := LabIO.Resource[MainFrm.IOConfig.LSLaserStart].StartChannel
                                    + LaserDAC ;

        VControl[iVControl].Device := LabIO.Resource[MainFrm.IOConfig.LSLaserStart].Device ;

        VControl[iVControl].Name := format('Laser #%d Intensity: Dev%d:AO%d ',
                                    [i,VControl[iVControl].Device,VControl[iVControl].Chan]) ;

        Inc(LaserDAC) ;
        Inc(iVControl) ;

        end ;

    // Open shutter for laser 1 if it has a non-zero intensity

    if iVControl < NumVControl then begin

       if LaserOn[1] then VControl[iVControl].V := 5.0
                     else VControl[iVControl].V := 0.0 ;

       VControl[iVControl].Chan := LabIO.Resource[MainFrm.IOConfig.LSLaserStart].StartChannel
                                   + LaserDAC ;

       VControl[iVControl].Device := LabIO.Resource[MainFrm.IOConfig.LSLaserStart].Device ;
       VControl[iVControl].Delay := LaserDelay[1] ;

       VControl[iVControl].Name := format('Laser #1 Shutter: Dev%d:AO%d ',
                                    [VControl[iVControl].Device,VControl[iVControl].Chan]) ;

       end ;

     end;


function TLightSource.LaserVoltage(
         LaserNum : Integer ;         // Laser # 1 or 2
         PercentageIntensity : Single // % of maximum intensity
         ) : Single ;
// -------------------------------------------------------------
// Return laser intensity control voltage for select laser # and
// desired % intensity
// -------------------------------------------------------------
begin


     Result := LaserOffVoltage[LaserNum] +
               Min(Max(Abs(PercentageIntensity*0.01),0.0),1.0)*
               (LaserOnVoltage[LaserNum] - LaserOffVoltage[LaserNum]) ;
     end ;


procedure TLightSource.SutterDG4FilterNumToVoltage(
          FilterNum : Integer ;
          var VControl : Array of TLSVControl ;
          var NumVControl : Integer
          ) ;
// ---------------------------------------
// Get Sutter DG4 filter # selection voltages
// ---------------------------------------
// -1 = closed
// 0-3 = Filters 0-3
var
    iBit : Integer ;
     i : Integer ;
     OutputType : String ;
begin

     // No. of channels available to control light source
     NumVControl := LabIO.Resource[MainFrm.IOConfig.LSWavelengthEnd].StartChannel -
                    LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
     NumVControl := Min(NumVControl,3) ;

     if LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].ResourceType = DigOut then OutputType := 'DO'
                                                                                 else OutputType := 'AO' ;

     iBit := 1 ;
     for i := 0 to NumVControl-1 do begin
         if ((FilterNum+1) and iBit) <> 0 then VControl[i].V := 4.9
                                          else VControl[i].V := 0.0 ;
         VControl[i].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + i ;
         VControl[i].Delay := 0.0 ;
         VControl[i].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
         VControl[i].Name := format('Sutter DG4: Filter bit%d : Dev%d:%s%d',
                             [i+1,VControl[i].Device,OutputType,VControl[i].Chan]) ;

         iBit := iBit*2 ;
         end ;

     end;

procedure TLightSource.CairnTIRFPositionToVoltage(
           GalvoPosition : Single ;                  // TIRF Galvo position
           var VControl : Array of TLSVControl ;    // Control voltages
           var NumVControl : Integer ) ;            // No. control channels
// ---------------------------------------------------
// Get Cairn TIRF galvo voltages for selected position
// ---------------------------------------------------
// 0 = All TIRF lasers off
// 1 = Laser #1 TIRF
// 2 = Laser #1 wide field
// 10 = Laser #2 TIRF
// 20 = Laser #2 wide field
// 11 = Laser #1 & #2 TIRF
// 12 = Laser #1 TIRF Laser #2 wide field
// 21 = Laser #2 TIRF Laser #1 wide field
var
    i : Integer ;
    V : Array[0..lsMaxTIRFGalvos-1] of Single ;

begin

    if not MainFrm.IOResourceAvailable(MainFrm.IOConfig.LSWavelengthStart) then begin
       NumVControl := 0 ;
       Exit ;
       end ;

    // No. of channels available to control light source
    NumVControl := LabIO.Resource[MainFrm.IOConfig.LSWavelengthEnd].StartChannel -
                   LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + 1 ;
    NumVControl := Min(NumVControl,2) ;

    // TIRF galvo #1
    case Round(GalvoPosition) mod 10 of
        1 : V[0] := TIRFOn[1] ;
        2 : V[0] := TIRFWF[1] ;
        else V[0] := TIRFOff[1] ;
        end ;

    // TIRF galvo #2
    case Round(GalvoPosition) div 10 of
        1 : V[1] := TIRFOn[2] ;
        2 : V[1] := TIRFWF[2] ;
        else V[1] := TIRFOff[2] ;
        end ;

    for i := 0 to NumVControl-1 do begin
        VControl[i].Chan := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].StartChannel + i ;
        VControl[i].Delay := 0.0 ;
        VControl[i].Device := LabIO.Resource[MainFrm.IOConfig.LSWavelengthStart].Device ;
        VControl[i].V := V[i] ;
        VControl[i].Name := format('Cairn TIRF : Laser #%d galvo: Dev%d:AO%d ',
                                    [i+1,VControl[i].Device,VControl[i].Chan]) ;
        end ;

     end ;


procedure TLightSource.DataModuleCreate(Sender: TObject);
// --------------------------------------
// Initialisations when module is created
// --------------------------------------
var
    i : Integer ;
begin
     DeviceType := lsNone ;
     for i := 0 to High(VControlInUse) do VControlInUse[i].V := 0.0 ;
     LastOptoscanBandwidth := 0.0 ;

     // Default laser settings
     LaserWavelength[1] := 488.0 ;
     LaserDelay[1] := 4E-4 ;
     LaserOffVoltage[1] := 0.0 ;
     LaserOnVoltage[1] := 10.0 ;
     LaserIntensity[1] := 0.0 ;

     LaserWavelength[2] := 561.0 ;
     LaserDelay[2] := 4E-4 ;
     LaserOffVoltage[2] := 0.0 ;
     LaserOnVoltage[2] := 10.0 ;
     LaserIntensity[2] := 0.0 ;

     LaserWavelength[3] := 561.0 ;
     LaserDelay[3] := 4E-4 ;
     LaserOffVoltage[3] := 0.0 ;
     LaserOnVoltage[3] := 10.0 ;
     LaserIntensity[3] := 0.0 ;

     LEDOffVoltage := 0.0 ;
     LEDMaxVoltage := 5.0 ;

     end;

end.
