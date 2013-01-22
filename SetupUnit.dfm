object SetupFrm: TSetupFrm
  Left = 294
  Top = 267
  BorderStyle = bsDialog
  Caption = 'Camera/System Setup'
  ClientHeight = 590
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object bOK: TButton
    Left = 8
    Top = 551
    Width = 49
    Height = 24
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
    OnClick = bOKClick
  end
  object bCancel: TButton
    Left = 64
    Top = 551
    Width = 49
    Height = 17
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = bCancelClick
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 4
    Width = 225
    Height = 415
    Caption = ' Camera  '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label41: TLabel
      Left = 37
      Top = 388
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tempr. Set Point'
    end
    object cbCamera: TComboBox
      Left = 8
      Top = 16
      Width = 209
      Height = 22
      ItemHeight = 14
      TabOrder = 0
      Text = 'cbCamera'
      OnChange = cbCameraChange
    end
    object ModePanel: TPanel
      Left = 8
      Top = 40
      Width = 210
      Height = 44
      BevelOuter = bvNone
      TabOrder = 1
      object lbCameraMode: TLabel
        Left = 0
        Top = 3
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'Mode'
      end
      object cbCameraMode: TComboBox
        Left = 0
        Top = 19
        Width = 209
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
        OnChange = cbCameraModeChange
      end
    end
    object ComPanel: TPanel
      Left = 8
      Top = 124
      Width = 210
      Height = 30
      BevelOuter = bvNone
      TabOrder = 2
      object lbComPort: TLabel
        Left = 52
        Top = 3
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'COM Port'
      end
      object cbCameraPort: TComboBox
        Left = 112
        Top = 3
        Width = 97
        Height = 22
        ItemHeight = 14
        TabOrder = 0
        Text = 'cbCameraGain'
        OnChange = cbCameraPortChange
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4')
      end
    end
    object ReadoutSpeedPanel: TPanel
      Left = 8
      Top = 94
      Width = 210
      Height = 30
      BevelOuter = bvNone
      TabOrder = 3
      object Label1: TLabel
        Left = 21
        Top = 3
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'Readout Speed'
      end
      object cbReadoutSpeed: TComboBox
        Left = 112
        Top = 3
        Width = 97
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
      end
    end
    object GroupBox9: TGroupBox
      Left = 8
      Top = 236
      Width = 209
      Height = 147
      Caption = ' Exposure Trigger Output '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label16: TLabel
        Left = 10
        Top = 60
        Width = 115
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Trigger Delay'
      end
      object Label42: TLabel
        Left = 10
        Top = 116
        Width = 115
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Extra Readout Time'
      end
      object cbCameraStart: TComboBox
        Left = 8
        Top = 16
        Width = 193
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
      end
      object rbCameraStartActiveHigh: TRadioButton
        Left = 8
        Top = 40
        Width = 81
        Height = 17
        Caption = 'Active High'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rbCameraStartActiveLow: TRadioButton
        Left = 96
        Top = 40
        Width = 89
        Height = 17
        Caption = 'Active Low'
        TabOrder = 2
      end
      object edCameraTriggerOffset: TValidatedEdit
        Left = 128
        Top = 60
        Width = 73
        Height = 20
        Hint = 
          'Delay between wavelength change and camera exposure triggeradded' +
          ' to camera trigger'
        AutoSize = False
        Text = ' 0 ms'
        Scale = 1000.000000000000000000
        Units = 'ms'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E30
        HiLimit = 1.000000015047466E30
      end
      object edCameraReadoutTime: TValidatedEdit
        Left = 128
        Top = 116
        Width = 73
        Height = 20
        Hint = 'Extra readout camera readout time (subtracted from exposure)'
        AutoSize = False
        Text = ' 0 ms'
        Scale = 1000.000000000000000000
        Units = 'ms'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E30
        HiLimit = 1.000000015047466E30
      end
      object ckCCDClearPreExposure: TCheckBox
        Left = 16
        Top = 82
        Width = 185
        Height = 17
        Hint = 'Clear CCD image area before exposure (triggered exposures only)'
        Alignment = taLeftJustify
        Caption = 'Clear CCD before exposure'
        TabOrder = 5
      end
      object ckPostExposureReadout: TCheckBox
        Left = 16
        Top = 98
        Width = 185
        Height = 17
        Hint = 
          'Adjust exposure time to account for CCD readout time after expos' +
          'ure (triggered exposures only)'
        Alignment = taLeftJustify
        Caption = 'Post-exposure CCD Readout'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
    end
    object edTemperatureSetPoint: TValidatedEdit
      Left = 136
      Top = 388
      Width = 81
      Height = 20
      AutoSize = False
      Text = ' 0 DEGC'
      Scale = 1.000000000000000000
      Units = 'DEGC'
      NumberFormat = '%.4g'
      LoLimit = -1.000000015047466E30
      HiLimit = 1.000000015047466E30
    end
    object ADCPanel: TPanel
      Left = 7
      Top = 154
      Width = 210
      Height = 30
      BevelOuter = bvNone
      TabOrder = 6
      object Label48: TLabel
        Left = 27
        Top = 3
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'A/D Converter'
      end
      object cbCameraADC: TComboBox
        Left = 112
        Top = 3
        Width = 97
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
        OnChange = cbCameraADCChange
      end
    end
  end
  object ADCGrp: TGroupBox
    Left = 512
    Top = 4
    Width = 265
    Height = 73
    Caption = 'Analogue Inputs '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label10: TLabel
      Left = 50
      Top = 16
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = 'A/D channels'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 45
      Top = 42
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'A/D Input mode'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbADCIn: TComboBox
      Left = 136
      Top = 16
      Width = 121
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 0
    end
    object cbADCInputMode: TComboBox
      Left = 136
      Top = 42
      Width = 121
      Height = 22
      ItemHeight = 14
      TabOrder = 1
      Text = 'cbADCInputMode'
    end
  end
  object LightSourceGrp: TGroupBox
    Left = 240
    Top = 4
    Width = 265
    Height = 441
    Caption = ' Light Source '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object cbLightSource: TComboBox
      Left = 8
      Top = 20
      Width = 249
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 0
      OnChange = cbLightSourceChange
    end
    object LSCalGrp: TGroupBox
      Left = 7
      Top = 46
      Width = 250
      Height = 147
      Caption = ' Calibration '
      TabOrder = 1
      object Label12: TLabel
        Left = 59
        Top = 13
        Width = 64
        Height = 14
        Caption = 'Wavelength'
      end
      object Label13: TLabel
        Left = 146
        Top = 13
        Width = 42
        Height = 14
        Caption = 'Voltage'
      end
      object Label14: TLabel
        Left = 20
        Top = 29
        Width = 37
        Height = 14
        Alignment = taRightJustify
        Caption = 'Point 1'
      end
      object Label15: TLabel
        Left = 20
        Top = 55
        Width = 37
        Height = 14
        Alignment = taRightJustify
        Caption = 'Point 2'
      end
      object edWavelength1: TValidatedEdit
        Left = 59
        Top = 29
        Width = 70
        Height = 20
        AutoSize = False
        Text = ' 0 nm'
        Scale = 1.000000000000000000
        Units = 'nm'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E29
        HiLimit = 1.000000015047466E29
      end
      object edVoltage1: TValidatedEdit
        Left = 148
        Top = 29
        Width = 69
        Height = 20
        AutoSize = False
        Text = ' 0 V'
        Scale = 1.000000000000000000
        Units = 'V'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E29
        HiLimit = 1.000000015047466E29
      end
      object edWavelength2: TValidatedEdit
        Left = 59
        Top = 55
        Width = 70
        Height = 20
        AutoSize = False
        Text = ' 0 nm'
        Scale = 1.000000000000000000
        Units = 'nm'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E29
        HiLimit = 1.000000015047466E29
      end
      object edVoltage2: TValidatedEdit
        Left = 148
        Top = 55
        Width = 69
        Height = 20
        AutoSize = False
        Text = ' 0 V'
        Scale = 1.000000000000000000
        Units = 'V'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E29
        HiLimit = 1.000000015047466E29
      end
    end
    object LSWaveGrp: TGroupBox
      Left = 8
      Top = 240
      Width = 249
      Height = 65
      Caption = ' Wavelength Control Outputs (Range)  '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label2: TLabel
        Left = 8
        Top = 20
        Width = 28
        Height = 13
        Caption = 'Start'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 128
        Top = 20
        Width = 23
        Height = 13
        Caption = 'End'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbLSWavelengthStart: TComboBox
        Left = 8
        Top = 35
        Width = 110
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
      end
      object cbLSWavelengthEnd: TComboBox
        Left = 128
        Top = 35
        Width = 110
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 1
      end
    end
    object LSLEDGrp: TGroupBox
      Left = 7
      Top = 50
      Width = 250
      Height = 59
      Caption = ' LED O/P Voltages '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label35: TLabel
        Left = 11
        Top = 13
        Width = 61
        Height = 14
        Caption = 'Off Voltage'
      end
      object Label36: TLabel
        Left = 100
        Top = 13
        Width = 67
        Height = 14
        Caption = 'Max Voltage'
      end
      object edLEDOffVoltage: TValidatedEdit
        Left = 8
        Top = 29
        Width = 80
        Height = 20
        AutoSize = False
        Text = ' 0 V'
        Scale = 1.000000000000000000
        Units = 'V'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E29
        HiLimit = 1.000000015047466E29
      end
      object edLEDMaxVoltage: TValidatedEdit
        Left = 100
        Top = 29
        Width = 80
        Height = 20
        AutoSize = False
        Text = ' 5 V'
        Value = 5.000000000000000000
        Scale = 1.000000000000000000
        Units = 'V'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E29
        HiLimit = 1.000000015047466E29
      end
    end
    object LSShutterGrp: TGroupBox
      Left = 8
      Top = 308
      Width = 249
      Height = 125
      Caption = ' Shutter Control '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label43: TLabel
        Left = 8
        Top = 16
        Width = 160
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Shutter closed wavelength'
      end
      object Label40: TLabel
        Left = 8
        Top = 40
        Width = 160
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Frame blanking period'
      end
      object edShutterClosedWavelength: TValidatedEdit
        Left = 176
        Top = 16
        Width = 63
        Height = 20
        Hint = 'Laser #1 emission wavelength (nm)'
        AutoSize = False
        ShowHint = True
        Text = ' 10 nm'
        Value = 10.000000000000000000
        Scale = 1.000000000000000000
        Units = 'nm'
        NumberFormat = '%.4g'
        LoLimit = 1.000000000000000000
        HiLimit = 100000.000000000000000000
      end
      object edShutterBlankingPeriod: TValidatedEdit
        Left = 176
        Top = 40
        Width = 63
        Height = 20
        Hint = 
          'Closed shutter blanking period at end of exposure cycle for CCD ' +
          'readout'
        AutoSize = False
        ShowHint = True
        Text = ' 0 ms'
        Scale = 1000.000000000000000000
        Units = 'ms'
        NumberFormat = '%.4g'
        LoLimit = -1.000000015047466E30
        HiLimit = 1.000000015047466E29
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 60
        Width = 233
        Height = 57
        Caption = ' Shutter Control Output '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object cbLSShutter: TComboBox
          Left = 8
          Top = 19
          Width = 121
          Height = 22
          Style = csDropDownList
          ItemHeight = 14
          TabOrder = 0
        end
        object rbLSShutterActiveHigh: TRadioButton
          Left = 136
          Top = 16
          Width = 89
          Height = 17
          Caption = 'Active High'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object rbLSShutterActiveLow: TRadioButton
          Left = 136
          Top = 32
          Width = 89
          Height = 17
          Caption = 'Active Low'
          TabOrder = 2
        end
      end
    end
    object lsTIRFGrp: TGroupBox
      Left = 8
      Top = 48
      Width = 257
      Height = 113
      Caption = ' TIRF Angle Control Voltages '
      TabOrder = 5
      object GroupBox5: TGroupBox
        Left = 6
        Top = 16
        Width = 120
        Height = 89
        Caption = 'Laser 1 '
        TabOrder = 0
        object Label49: TLabel
          Left = 42
          Top = 16
          Width = 16
          Height = 14
          Alignment = taRightJustify
          Caption = 'Off'
        end
        object Label50: TLabel
          Left = 35
          Top = 38
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'TIRF'
        end
        object Label57: TLabel
          Left = 7
          Top = 61
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Widefield'
        end
        object edTIRFOff1: TValidatedEdit
          Left = 60
          Top = 16
          Width = 54
          Height = 20
          Hint = 'Laser #1 control voltage for minimum intensity '
          AutoSize = False
          ShowHint = True
          Text = ' 0 V'
          Scale = 1.000000000000000000
          Units = 'V'
          NumberFormat = '%.4g'
          LoLimit = -10.000000000000000000
          HiLimit = 10.000000000000000000
        end
        object edTIRFOn1: TValidatedEdit
          Left = 60
          Top = 37
          Width = 54
          Height = 20
          Hint = 'Laser #1 control voltage for maximum intensity '
          AutoSize = False
          ShowHint = True
          Text = ' 0 V'
          Scale = 1.000000000000000000
          Units = 'V'
          NumberFormat = '%.4g'
          LoLimit = -10.000000000000000000
          HiLimit = 10.000000000000000000
        end
        object edTIRFWF1: TValidatedEdit
          Left = 60
          Top = 61
          Width = 54
          Height = 20
          Hint = 'Laser #1 on/off transition delay (ms)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 V'
          Scale = 1.000000000000000000
          Units = 'V'
          NumberFormat = '%.4g'
          LoLimit = -10.000000000000000000
          HiLimit = 10.000000000000000000
        end
      end
      object GroupBox8: TGroupBox
        Left = 130
        Top = 16
        Width = 120
        Height = 89
        Caption = ' Laser 2 '
        TabOrder = 1
        object Label58: TLabel
          Left = 44
          Top = 16
          Width = 16
          Height = 14
          Alignment = taRightJustify
          Caption = 'Off'
        end
        object Label59: TLabel
          Left = 37
          Top = 38
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'TIRF'
        end
        object Label60: TLabel
          Left = 9
          Top = 61
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Widefield'
        end
        object edTIRFOff2: TValidatedEdit
          Left = 62
          Top = 16
          Width = 54
          Height = 20
          Hint = 'Laser #1 control voltage for minimum intensity '
          AutoSize = False
          ShowHint = True
          Text = ' 0 V'
          Scale = 1.000000000000000000
          Units = 'V'
          NumberFormat = '%.4g'
          LoLimit = -10.000000000000000000
          HiLimit = 10.000000000000000000
        end
        object edTIRFOn2: TValidatedEdit
          Left = 62
          Top = 37
          Width = 54
          Height = 20
          Hint = 'Laser #1 control voltage for maximum intensity '
          AutoSize = False
          ShowHint = True
          Text = ' 0 V'
          Scale = 1.000000000000000000
          Units = 'V'
          NumberFormat = '%.4g'
          LoLimit = -10.000000000000000000
          HiLimit = 10.000000000000000000
        end
        object edTIRFWF2: TValidatedEdit
          Left = 62
          Top = 61
          Width = 54
          Height = 20
          Hint = 'Laser #1 on/off transition delay (ms)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 V'
          Scale = 1.000000000000000000
          Units = 'V'
          NumberFormat = '%.4g'
          LoLimit = -10.000000000000000000
          HiLimit = 10.000000000000000000
        end
      end
    end
  end
  object GroupBox7: TGroupBox
    Left = 512
    Top = 376
    Width = 265
    Height = 69
    Caption = ' Master Clock  '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Label11: TLabel
      Left = 80
      Top = 17
      Width = 97
      Height = 13
      Alignment = taRightJustify
      Caption = 'Timing resolution'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 39
      Top = 40
      Width = 98
      Height = 13
      Alignment = taRightJustify
      Caption = 'Clock synch. link'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edADCInterval: TValidatedEdit
      Left = 183
      Top = 13
      Width = 72
      Height = 22
      Text = ' 0 ms'
      Scale = 1000.000000000000000000
      Units = 'ms'
      NumberFormat = '%.4g'
      LoLimit = -1.000000015047466E30
      HiLimit = 1.000000015047466E29
    end
    object cbClockSynchronisation: TComboBox
      Left = 146
      Top = 39
      Width = 110
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 1
    end
  end
  object CardGrp: TGroupBox
    Left = 240
    Top = 448
    Width = 537
    Height = 137
    Caption = ' Interface Cards '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object rbNIDAQ: TRadioButton
      Left = 8
      Top = 30
      Width = 137
      Height = 17
      Caption = 'NI-DAQ (Traditional)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = rbNIDAQClick
    end
    object rbNIDAQMX: TRadioButton
      Left = 8
      Top = 15
      Width = 81
      Height = 17
      Caption = 'NI-DAQ-MX'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = rbNIDAQMXClick
    end
    object meDeviceList: TMemo
      Left = 136
      Top = 13
      Width = 393
      Height = 76
      Lines.Strings = (
        'meDeviceList')
      ReadOnly = True
      TabOrder = 2
    end
    object bResetDevices: TButton
      Left = 24
      Top = 48
      Width = 89
      Height = 25
      Caption = 'Reset Devices'
      TabOrder = 3
      OnClick = bResetDevicesClick
    end
    object ckAutoReset: TCheckBox
      Left = 8
      Top = 75
      Width = 123
      Height = 17
      Caption = 'Auto reset devices'
      TabOrder = 4
    end
  end
  object GroupBox14: TGroupBox
    Left = 8
    Top = 424
    Width = 225
    Height = 121
    Caption = ' Calibration '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object Label19: TLabel
      Left = 39
      Top = 18
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lens magnification'
    end
    object Label20: TLabel
      Left = 92
      Top = 42
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pixel size'
    end
    object Label23: TLabel
      Left = 30
      Top = 66
      Width = 114
      Height = 14
      Alignment = taRightJustify
      Caption = 'Calibration bar (size)'
    end
    object Label61: TLabel
      Left = 22
      Top = 90
      Width = 122
      Height = 14
      Alignment = taRightJustify
      Caption = 'Calibration bar (width)'
    end
    object edLensMagnification: TValidatedEdit
      Left = 152
      Top = 18
      Width = 65
      Height = 20
      OnKeyPress = edLensMagnificationKeyPress
      AutoSize = False
      Text = ' 0 X'
      Scale = 1.000000000000000000
      Units = 'X'
      NumberFormat = '%.3g'
      LoLimit = -1.000000015047466E30
      HiLimit = 1.000000015047466E29
    end
    object edPixelWidth: TValidatedEdit
      Left = 152
      Top = 42
      Width = 65
      Height = 20
      AutoSize = False
      Text = ' 0 um'
      Scale = 1.000000000000000000
      Units = 'um'
      NumberFormat = '%.4g'
      LoLimit = -1.000000015047466E30
      HiLimit = 1.000000015047466E29
    end
    object edCalibrationBarSize: TValidatedEdit
      Left = 152
      Top = 66
      Width = 65
      Height = 20
      AutoSize = False
      Text = ' 0 um'
      Scale = 1.000000000000000000
      Units = 'um'
      NumberFormat = '%.4g'
      LoLimit = -1.000000015047466E30
      HiLimit = 1.000000015047466E29
    end
    object edCalibrationBarThickness: TValidatedEdit
      Left = 152
      Top = 90
      Width = 65
      Height = 20
      AutoSize = False
      Text = ' 0 pixels'
      Scale = 1.000000000000000000
      Units = 'pixels'
      NumberFormat = '%.3g'
      LoLimit = -1.000000015047466E30
      HiLimit = 1.000000015047466E29
    end
  end
  object GroupBox1: TGroupBox
    Left = 512
    Top = 79
    Width = 265
    Height = 295
    Caption = ' Stimulus Outputs'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object GroupBox6: TGroupBox
      Left = 8
      Top = 103
      Width = 249
      Height = 58
      Caption = ' Digital  Outputs (Range) '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label4: TLabel
        Left = 8
        Top = 14
        Width = 28
        Height = 13
        Caption = 'Start'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 128
        Top = 14
        Width = 23
        Height = 13
        Caption = 'End'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbDigitalStimStart: TComboBox
        Left = 8
        Top = 28
        Width = 110
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
      end
      object cbDigitalStimEnd: TComboBox
        Left = 128
        Top = 28
        Width = 110
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 1
      end
    end
    object GroupBox11: TGroupBox
      Left = 8
      Top = 13
      Width = 249
      Height = 89
      Caption = ' Voltage (D/A)  Outputs '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label3: TLabel
        Left = 86
        Top = 18
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vout 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 86
        Top = 41
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vout 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label47: TLabel
        Left = 86
        Top = 64
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vout 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbVCommand0: TComboBox
        Left = 128
        Top = 14
        Width = 110
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
      end
      object cbVCommand1: TComboBox
        Left = 128
        Top = 37
        Width = 110
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 1
      end
      object cbVCommand2: TComboBox
        Left = 128
        Top = 60
        Width = 110
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 2
      end
    end
    object PhotoStimGrp: TGroupBox
      Left = 8
      Top = 162
      Width = 249
      Height = 126
      Caption = ' Photo Stimulus'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object PhotoStimPage: TPageControl
        Left = 5
        Top = 16
        Width = 239
        Height = 103
        ActivePage = GalvosTab
        TabOrder = 0
        object GalvosTab: TTabSheet
          Caption = 'Galvos'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          object Label55: TLabel
            Left = 26
            Top = 30
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'Y Galvo Control'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label56: TLabel
            Left = 26
            Top = 6
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'X Galvo Control'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbPhotoStimX: TComboBox
            Left = 115
            Top = 2
            Width = 113
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            TabOrder = 0
          end
          object cbPhotoStimY: TComboBox
            Left = 115
            Top = 26
            Width = 113
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            TabOrder = 1
          end
        end
        object AttenuatorsTab: TTabSheet
          Caption = 'Attenuators'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ImageIndex = 1
          ParentFont = False
          object Label51: TLabel
            Left = 11
            Top = 6
            Width = 98
            Height = 14
            Caption = 'Control Channel 1'
          end
          object Label45: TLabel
            Left = 11
            Top = 30
            Width = 98
            Height = 14
            Caption = 'Control Channel 2'
          end
          object Label46: TLabel
            Left = 11
            Top = 54
            Width = 98
            Height = 14
            Caption = 'Control Channel 3'
          end
          object cbPhotoStimIntensity1: TComboBox
            Left = 115
            Top = 2
            Width = 113
            Height = 22
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 0
          end
          object cbPhotoStimIntensity2: TComboBox
            Left = 115
            Top = 26
            Width = 113
            Height = 22
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 1
          end
          object cbPhotoStimIntensity3: TComboBox
            Left = 115
            Top = 50
            Width = 113
            Height = 22
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 2
          end
        end
        object ShutterTab: TTabSheet
          Caption = 'Shutter'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ImageIndex = 2
          ParentFont = False
          object Label52: TLabel
            Left = 20
            Top = 6
            Width = 89
            Height = 14
            Alignment = taRightJustify
            Caption = 'Control Channel'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label53: TLabel
            Left = 22
            Top = 30
            Width = 87
            Height = 14
            Alignment = taRightJustify
            Caption = 'Shutter Latency'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label54: TLabel
            Left = 31
            Top = 53
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Shutter Active'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbPhotoStimShutter: TComboBox
            Left = 115
            Top = 2
            Width = 113
            Height = 22
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 0
          end
          object edPhotoStimShutterLatency: TValidatedEdit
            Left = 115
            Top = 26
            Width = 113
            Height = 20
            AutoSize = False
            ShowHint = True
            Text = ' 0 ms'
            Scale = 1000.000000000000000000
            Units = 'ms'
            NumberFormat = '%.3g'
            LoLimit = -1.000000015047466E30
            HiLimit = 1.000000015047466E29
          end
          object rbPhotoStimShutterActiveHigh: TRadioButton
            Left = 115
            Top = 52
            Width = 49
            Height = 17
            Caption = 'High'
            TabOrder = 2
          end
          object rbPhotoStimShutterActiveLow: TRadioButton
            Left = 180
            Top = 52
            Width = 45
            Height = 17
            Caption = 'Low'
            TabOrder = 3
          end
        end
        object MeterTab: TTabSheet
          Caption = 'Meter'
          ImageIndex = 3
          object Label44: TLabel
            Left = 44
            Top = 6
            Width = 64
            Height = 14
            Alignment = taRightJustify
            Caption = 'Meter Input'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbPhotoStimMeterInput: TComboBox
            Left = 115
            Top = 2
            Width = 113
            Height = 22
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 0
          end
        end
      end
    end
  end
  object LSLaserGrp: TGroupBox
    Left = 248
    Top = 54
    Width = 250
    Height = 187
    Caption = ' Lasers '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    object Label38: TLabel
      Left = 8
      Top = 140
      Width = 28
      Height = 13
      Caption = 'Start'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label39: TLabel
      Left = 128
      Top = 140
      Width = 23
      Height = 13
      Caption = 'End'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LSLaserPage: TPageControl
      Left = 8
      Top = 16
      Width = 232
      Height = 121
      ActivePage = Laser1Tab
      TabOrder = 0
      object Laser1Tab: TTabSheet
        Caption = 'Laser 1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        object Label7: TLabel
          Left = 9
          Top = 4
          Width = 64
          Height = 14
          Caption = 'Wavelength'
        end
        object Label26: TLabel
          Left = 9
          Top = 44
          Width = 72
          Height = 14
          Caption = 'Def. Intensity'
        end
        object edLaser1Wavelength: TValidatedEdit
          Left = 9
          Top = 18
          Width = 70
          Height = 20
          Hint = 'Laser #1 emission wavelength (nm)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 nm'
          Scale = 1.000000000000000000
          Units = 'nm'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E29
          HiLimit = 1.000000015047466E29
        end
        object GroupBox2: TGroupBox
          Left = 96
          Top = 0
          Width = 121
          Height = 89
          Caption = ' Control Voltages '
          TabOrder = 1
          object Label24: TLabel
            Left = 23
            Top = 16
            Width = 15
            Height = 14
            Alignment = taRightJustify
            Caption = '0%'
          end
          object Label25: TLabel
            Left = 11
            Top = 38
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = '100%'
          end
          object Label8: TLabel
            Left = 9
            Top = 61
            Width = 29
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delay'
          end
          object edLaser1OffVoltage: TValidatedEdit
            Left = 40
            Top = 16
            Width = 60
            Height = 20
            Hint = 'Laser #1 control voltage for minimum intensity '
            AutoSize = False
            ShowHint = True
            Text = ' 0 V'
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.3g'
            LoLimit = -10.000000000000000000
            HiLimit = 10.000000000000000000
          end
          object edLaser1OnVoltage: TValidatedEdit
            Left = 40
            Top = 37
            Width = 60
            Height = 20
            Hint = 'Laser #1 control voltage for maximum intensity '
            AutoSize = False
            ShowHint = True
            Text = ' 0 V'
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.3g'
            LoLimit = -10.000000000000000000
            HiLimit = 10.000000000000000000
          end
          object edLaser1Delay: TValidatedEdit
            Left = 40
            Top = 61
            Width = 60
            Height = 20
            Hint = 'Laser #1 on/off transition delay (ms)'
            AutoSize = False
            ShowHint = True
            Text = ' 0 ms'
            Scale = 1000.000000000000000000
            Units = 'ms'
            NumberFormat = '%.3g'
            LoLimit = -1.000000015047466E30
            HiLimit = 1.000000015047466E29
          end
        end
        object edLaser1Intensity: TValidatedEdit
          Left = 9
          Top = 58
          Width = 70
          Height = 20
          Hint = 'Laser #1 emission wavelength (nm)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 %'
          Scale = 1.000000000000000000
          Units = '%'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 100.000000000000000000
        end
      end
      object Laser2Tab: TTabSheet
        Caption = 'Laser 2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ImageIndex = 1
        ParentFont = False
        object Label9: TLabel
          Left = 9
          Top = 4
          Width = 64
          Height = 14
          Caption = 'Wavelength'
        end
        object Label22: TLabel
          Left = 9
          Top = 44
          Width = 72
          Height = 14
          Caption = 'Def. Intensity'
        end
        object edLaser2Wavelength: TValidatedEdit
          Left = 9
          Top = 18
          Width = 70
          Height = 20
          Hint = 'Laser #1 emission wavelength (nm)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 nm'
          Scale = 1.000000000000000000
          Units = 'nm'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E29
          HiLimit = 1.000000015047466E29
        end
        object edLaser2Intensity: TValidatedEdit
          Left = 9
          Top = 58
          Width = 70
          Height = 20
          Hint = 'Laser #1 emission wavelength (nm)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 %'
          Scale = 1.000000000000000000
          Units = '%'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 100.000000000000000000
        end
        object GroupBox10: TGroupBox
          Left = 96
          Top = 0
          Width = 121
          Height = 89
          Caption = ' Control Voltages '
          TabOrder = 2
          object Label27: TLabel
            Left = 23
            Top = 16
            Width = 15
            Height = 14
            Alignment = taRightJustify
            Caption = '0%'
          end
          object Label28: TLabel
            Left = 11
            Top = 38
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = '100%'
          end
          object Label29: TLabel
            Left = 9
            Top = 61
            Width = 29
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delay'
          end
          object edlaser2OffVoltage: TValidatedEdit
            Left = 40
            Top = 16
            Width = 60
            Height = 20
            Hint = 'Laser #1 control voltage for minimum intensity '
            AutoSize = False
            ShowHint = True
            Text = ' 0 V'
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.3g'
            LoLimit = -10.000000000000000000
            HiLimit = 10.000000000000000000
          end
          object edLaser2OnVoltage: TValidatedEdit
            Left = 40
            Top = 37
            Width = 60
            Height = 20
            Hint = 'Laser #1 control voltage for maximum intensity '
            AutoSize = False
            ShowHint = True
            Text = ' 0 V'
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.3g'
            LoLimit = -10.000000000000000000
            HiLimit = 10.000000000000000000
          end
          object edLaser2Delay: TValidatedEdit
            Left = 40
            Top = 61
            Width = 60
            Height = 20
            Hint = 'Laser #1 on/off transition delay (ms)'
            AutoSize = False
            ShowHint = True
            Text = ' 0 ms'
            Scale = 1000.000000000000000000
            Units = 'ms'
            NumberFormat = '%.3g'
            LoLimit = -1.000000015047466E30
            HiLimit = 1.000000015047466E29
          end
        end
      end
      object Laser3Tab: TTabSheet
        Caption = 'Laser 3'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ImageIndex = 2
        ParentFont = False
        object Label30: TLabel
          Left = 9
          Top = 4
          Width = 64
          Height = 14
          Caption = 'Wavelength'
        end
        object Label31: TLabel
          Left = 9
          Top = 44
          Width = 72
          Height = 14
          Caption = 'Def. Intensity'
        end
        object edLaser3Wavelength: TValidatedEdit
          Left = 9
          Top = 18
          Width = 70
          Height = 20
          Hint = 'Laser #1 emission wavelength (nm)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 nm'
          Scale = 1.000000000000000000
          Units = 'nm'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E29
          HiLimit = 1.000000015047466E29
        end
        object edLaser3Intensity: TValidatedEdit
          Left = 9
          Top = 58
          Width = 70
          Height = 20
          Hint = 'Laser #1 emission wavelength (nm)'
          AutoSize = False
          ShowHint = True
          Text = ' 0 %'
          Scale = 1.000000000000000000
          Units = '%'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 100.000000000000000000
        end
        object GroupBox12: TGroupBox
          Left = 96
          Top = 0
          Width = 121
          Height = 89
          Caption = ' Control Voltages '
          TabOrder = 2
          object Label32: TLabel
            Left = 23
            Top = 16
            Width = 15
            Height = 14
            Alignment = taRightJustify
            Caption = '0%'
          end
          object Label33: TLabel
            Left = 11
            Top = 38
            Width = 27
            Height = 14
            Alignment = taRightJustify
            Caption = '100%'
          end
          object Label34: TLabel
            Left = 9
            Top = 61
            Width = 29
            Height = 14
            Alignment = taRightJustify
            Caption = 'Delay'
          end
          object edLaser3OffVoltage: TValidatedEdit
            Left = 40
            Top = 16
            Width = 60
            Height = 20
            Hint = 'Laser #1 control voltage for minimum intensity '
            AutoSize = False
            ShowHint = True
            Text = ' 0 V'
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.3g'
            LoLimit = -10.000000000000000000
            HiLimit = 10.000000000000000000
          end
          object edLaser3OnVoltage: TValidatedEdit
            Left = 40
            Top = 37
            Width = 60
            Height = 20
            Hint = 'Laser #1 control voltage for maximum intensity '
            AutoSize = False
            ShowHint = True
            Text = ' 0 V'
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.3g'
            LoLimit = -10.000000000000000000
            HiLimit = 10.000000000000000000
          end
          object edLaser3Delay: TValidatedEdit
            Left = 40
            Top = 61
            Width = 60
            Height = 20
            Hint = 'Laser #1 on/off transition delay (ms)'
            AutoSize = False
            ShowHint = True
            Text = ' 0 ms'
            Scale = 1000.000000000000000000
            Units = 'ms'
            NumberFormat = '%.3g'
            LoLimit = -1.000000015047466E30
            HiLimit = 1.000000015047466E29
          end
        end
      end
    end
    object cbLSLaserStart: TComboBox
      Left = 8
      Top = 155
      Width = 110
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 1
    end
    object cbLSLaserEnd: TComboBox
      Left = 128
      Top = 155
      Width = 110
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 2
    end
  end
  object AuxCameraPanel: TPanel
    Left = 16
    Top = 48
    Width = 210
    Height = 49
    BevelOuter = bvNone
    TabOrder = 10
    object Label37: TLabel
      Left = 1
      Top = 4
      Width = 96
      Height = 14
      Caption = 'Auxilliary Camera'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbAuxCamera: TComboBox
      Left = 1
      Top = 20
      Width = 209
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
      Text = 'cbCamera'
      OnChange = cbCameraChange
    end
  end
end
