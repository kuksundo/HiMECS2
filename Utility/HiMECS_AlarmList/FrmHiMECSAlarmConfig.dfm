object AlarmConfigF: TAlarmConfigF
  Left = 0
  Top = 0
  Caption = 'Alarm Config'
  ClientHeight = 402
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 414
    Height = 361
    ActivePage = TabSheet4
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Tabsheet2: TTabSheet
      Caption = 'File'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        406
        330)
      object Label1: TLabel
        Left = 70
        Top = 82
        Width = 70
        Height = 16
        Caption = 'Manual File:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label3: TLabel
        Left = 24
        Top = 107
        Width = 119
        Height = 16
        Caption = 'Alarm DB File Name:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label2: TLabel
        Left = 47
        Top = 49
        Width = 93
        Height = 16
        Caption = 'Alarm Item File:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label4: TLabel
        Left = 72
        Top = 140
        Width = 68
        Height = 16
        Caption = 'Alarm Font:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object AlarmDBFilenameEdit: TJvFilenameEdit
        Left = 148
        Top = 107
        Width = 204
        Height = 24
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 0
        Text = ''
      end
      object ManualFileEdit: TJvFilenameEdit
        Left = 149
        Top = 77
        Width = 204
        Height = 24
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 1
        Text = ''
      end
      object AlarmItemFileEdit: TJvFilenameEdit
        Left = 149
        Top = 46
        Width = 204
        Height = 24
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 2
        Text = ''
      end
      object RelPathCB: TCheckBox
        Left = 149
        Top = 15
        Width = 98
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = 'Relative Path'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 3
      end
      object CreateDBIntervalRG: TRadioGroup
        Left = 76
        Top = 177
        Width = 229
        Height = 125
        Caption = 'Create Alarm DB in'
        ItemIndex = 1
        Items.Strings = (
          'Every Day'
          'Every Month'
          'Fixed File Name')
        TabOrder = 4
      end
      object ED_csv: TEdit
        Left = 76
        Top = 308
        Width = 169
        Height = 24
        Enabled = False
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 5
      end
      object Button1: TButton
        Left = 152
        Top = 136
        Width = 73
        Height = 25
        Caption = 'Font...'
        TabOrder = 6
        OnClick = Button1Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Property'
      ImageIndex = 3
      object Label5: TLabel
        Left = 15
        Top = 40
        Width = 98
        Height = 16
        Caption = 'Alarm Cell Color:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label11: TLabel
        Left = 207
        Top = 40
        Width = 102
        Height = 16
        Caption = 'Alarm Text Color:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label14: TLabel
        Left = 32
        Top = 88
        Width = 80
        Height = 16
        Caption = 'SD Cell Color:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label15: TLabel
        Left = 225
        Top = 88
        Width = 84
        Height = 16
        Caption = 'SD Text Color:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object AlarmCellColorSelector: TAdvOfficeColorSelector
        Left = 118
        Top = 34
        Width = 81
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.4.7.0'
        TabOrder = 0
        AllowFloating = False
        CloseOnSelect = False
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = -2
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object AlarmTextColorSelector: TAdvOfficeColorSelector
        Left = 310
        Top = 34
        Width = 81
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.4.7.0'
        TabOrder = 1
        AllowFloating = False
        CloseOnSelect = False
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = -2
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object ShutdownCellColorSelector: TAdvOfficeColorSelector
        Left = 118
        Top = 82
        Width = 81
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.4.7.0'
        TabOrder = 2
        AllowFloating = False
        CloseOnSelect = False
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = -2
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object ShutdownTextColorSelector: TAdvOfficeColorSelector
        Left = 310
        Top = 82
        Width = 81
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.4.7.0'
        TabOrder = 3
        AllowFloating = False
        CloseOnSelect = False
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = -2
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Comm Server'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label20: TLabel
        Left = 61
        Top = 27
        Width = 66
        Height = 16
        Caption = 'IP Address:'
      end
      object Label21: TLabel
        Left = 82
        Top = 90
        Width = 47
        Height = 16
        Caption = 'User ID:'
      end
      object Label22: TLabel
        Left = 43
        Top = 226
        Width = 83
        Height = 16
        Caption = 'Shared Name:'
      end
      object Label25: TLabel
        Left = 16
        Top = 172
        Width = 111
        Height = 16
        Caption = 'Reconnect Interval:'
      end
      object Label26: TLabel
        Left = 223
        Top = 174
        Width = 27
        Height = 13
        Caption = 'mSec'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 82
        Top = 58
        Width = 47
        Height = 16
        Caption = 'Port No:'
      end
      object Label23: TLabel
        Left = 79
        Top = 120
        Width = 48
        Height = 16
        Caption = 'Passwd:'
      end
      object ServerIPEdit: TEdit
        Left = 136
        Top = 24
        Width = 185
        Height = 24
        Hint = 'Comm Server;Server IP'
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 0
      end
      object UserEdit: TEdit
        Left = 136
        Top = 87
        Width = 185
        Height = 24
        Hint = 'Comm Server;User ID'
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 1
      end
      object PasswdEdit: TEdit
        Left = 136
        Top = 117
        Width = 185
        Height = 24
        Hint = 'Comm Server;PassWord'
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 2
      end
      object ReConnectIntervalEdit: TSpinEdit
        Left = 136
        Top = 169
        Width = 81
        Height = 26
        Hint = 'Comm Server;'
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 1
      end
      object ServerPortEdit: TEdit
        Left = 136
        Top = 55
        Width = 185
        Height = 24
        Hint = 'Comm Server;Server Port'
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 4
      end
      object SharedNameEdit: TEdit
        Left = 136
        Top = 218
        Width = 185
        Height = 24
        Hint = 'Comm Server;Shared Name'
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 5
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'DB Server'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label6: TLabel
        Left = 13
        Top = 28
        Width = 112
        Height = 16
        Caption = 'DB Server Address:'
      end
      object Label7: TLabel
        Left = 82
        Top = 66
        Width = 47
        Height = 16
        Caption = 'User ID:'
      end
      object Label8: TLabel
        Left = 67
        Top = 101
        Width = 60
        Height = 16
        Caption = 'Password:'
      end
      object Label10: TLabel
        Left = 18
        Top = 138
        Width = 106
        Height = 16
        Caption = 'Save Table Name:'
      end
      object Label12: TLabel
        Left = 16
        Top = 188
        Width = 111
        Height = 16
        Caption = 'Reconnect Interval:'
      end
      object Label13: TLabel
        Left = 231
        Top = 190
        Width = 27
        Height = 13
        Caption = 'mSec'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ServerEdit: TEdit
        Left = 144
        Top = 32
        Width = 185
        Height = 24
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 144
        Top = 63
        Width = 185
        Height = 24
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 1
      end
      object Edit2: TEdit
        Left = 144
        Top = 98
        Width = 185
        Height = 24
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 2
      end
      object TableNameCombo: TComboBox
        Left = 144
        Top = 136
        Width = 185
        Height = 24
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 3
      end
      object SpinEdit1: TSpinEdit
        Left = 144
        Top = 185
        Width = 81
        Height = 26
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 361
    Width = 414
    Height = 41
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 66
      Top = 6
      Width = 75
      Height = 25
      Caption = #54869' '#51064
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 198
      Top = 6
      Width = 75
      Height = 25
      Caption = #52712' '#49548
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    OnApply = FontDialog1Apply
    Left = 372
    Top = 315
  end
end
