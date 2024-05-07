object ReverseProxyF: TReverseProxyF
  Left = 0
  Top = 0
  Caption = 'ReverseProxyF'
  ClientHeight = 534
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 298
    Width = 635
    Height = 10
    Cursor = crVSplit
    Align = alTop
  end
  object Memo1: TMemo
    Left = 0
    Top = 97
    Width = 635
    Height = 201
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 136
    ExplicitWidth = 457
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 97
    Align = alTop
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 0
    Top = 308
    Width = 635
    Height = 226
    Align = alClient
    TabOrder = 2
    ExplicitTop = 105
    ExplicitHeight = 201
  end
  object IdMappedPortTCP1: TIdMappedPortTCP
    Bindings = <>
    DefaultPort = 0
    MappedPort = 0
    OnExecute = IdMappedPortTCP1Execute
    Left = 32
    Top = 32
  end
end
