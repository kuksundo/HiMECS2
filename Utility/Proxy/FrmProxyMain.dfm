object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 160
    Width = 635
    Height = 8
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 185
  end
  object Memo1: TMemo
    Left = 0
    Top = 168
    Width = 635
    Height = 131
    Align = alBottom
    TabOrder = 0
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnExecute = IdTCPServer1Execute
    Left = 96
    Top = 40
  end
  object IdMappedPortTCP1: TIdMappedPortTCP
    Bindings = <>
    DefaultPort = 0
    MappedPort = 0
    Left = 144
    Top = 40
  end
end
