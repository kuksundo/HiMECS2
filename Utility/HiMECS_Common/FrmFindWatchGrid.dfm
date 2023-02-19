object FindWatchGridF: TFindWatchGridF
  Left = 0
  Top = 0
  Caption = 'Search...'
  ClientHeight = 142
  ClientWidth = 461
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object FindStrEdit: TEdit
    Left = 0
    Top = 65
    Width = 461
    Height = 21
    Align = alTop
    ImeName = 'Microsoft IME 2010'
    TabOrder = 0
  end
  object OptionRG: TRadioGroup
    Left = 0
    Top = 0
    Width = 461
    Height = 65
    Align = alTop
    Caption = 'Option'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Tag Name'
      'Tag Desc'
      'Modbus Address(Decimal)'
      'Modbus Address(Hex)')
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 445
  end
  object Panel1: TPanel
    Left = 0
    Top = 92
    Width = 461
    Height = 50
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 144
    object BitBtn1: TBitBtn
      Left = 272
      Top = 8
      Width = 81
      Height = 33
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 114
      Top = 8
      Width = 81
      Height = 33
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
