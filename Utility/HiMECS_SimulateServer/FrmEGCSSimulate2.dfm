object EGCSOpSimF: TEGCSOpSimF
  Left = 0
  Top = 0
  Caption = 'EGCSOpSimF'
  ClientHeight = 424
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ShadowButton1: TShadowButton
    Tag = 1
    Left = 5
    Top = 96
    Width = 438
    Height = 41
    Caption = 'Prepare'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    OnClick = ShadowButton1Click
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton2: TShadowButton
    Tag = 2
    Left = 5
    Top = 143
    Width = 438
    Height = 41
    Caption = 'Start Open Loop'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    OnClick = ShadowButton2Click
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton3: TShadowButton
    Tag = 3
    Left = 5
    Top = 190
    Width = 438
    Height = 41
    Caption = 'Open To Close C/O'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    OnClick = ShadowButton3Click
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton4: TShadowButton
    Tag = 4
    Left = 5
    Top = 237
    Width = 438
    Height = 41
    Caption = 'Close To Open C/O'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    OnClick = ShadowButton4Click
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton5: TShadowButton
    Tag = 5
    Left = 5
    Top = 284
    Width = 438
    Height = 41
    Caption = 'Stop Open Loop'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    OnClick = ShadowButton5Click
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton6: TShadowButton
    Tag = 6
    Left = 5
    Top = 331
    Width = 438
    Height = 41
    Caption = 'Start Close Loop'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    OnClick = ShadowButton6Click
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton7: TShadowButton
    Tag = 7
    Left = 5
    Top = 378
    Width = 438
    Height = 41
    Caption = 'Stop Close Loop'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    OnClick = ShadowButton7Click
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton8: TShadowButton
    Tag = 8
    Left = 5
    Top = 425
    Width = 438
    Height = 41
    Caption = 'Holding Tank Discharge'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShadowButton9: TShadowButton
    Tag = 9
    Left = 5
    Top = 472
    Width = 438
    Height = 41
    Caption = 'Spill Over Tank Discharge'
    Color = clAqua
    Shadow = True
    Shape = stRoundRect
    Border = True
    BorderColor = clBlack
    Deepth = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 81
    Align = alTop
    Color = 16777175
    TabOrder = 0
    UseDockManager = True
    Version = '2.3.0.5'
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.Text = '<SHAD><B>EGCS Operation Simulate</B></SHAD>'
    ColorTo = 14286809
    GradientDirection = gdHorizontal
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    Text = 
      '<SHAD><B><FONT  size="24" face="Tahoma"><P align="center"></P>EG' +
      'CS Operation Simulate</FONT></B></SHAD>'
    TextVAlign = tvaCenter
    FullHeight = 200
    object SystemModeCheck: TCheckBox
      Left = 8
      Top = 8
      Width = 97
      Height = 17
      Caption = 'System Mode'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object Edit1: TEdit
    Left = 106
    Top = 5
    Width = 33
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 1
    OnKeyDown = Edit1KeyDown
  end
end
