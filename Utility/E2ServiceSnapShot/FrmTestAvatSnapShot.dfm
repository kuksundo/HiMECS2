object TestAvatSSF: TTestAvatSSF
  Left = 0
  Top = 0
  Caption = 'TestAvatSSF'
  ClientHeight = 556
  ClientWidth = 1128
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 113
    Width = 829
    Height = 443
    Align = alClient
    ImeName = 'Microsoft IME 2010'
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ListView1: TListView
    Left = 0
    Top = 89
    Width = 1128
    Height = 24
    Align = alTop
    Columns = <>
    TabOrder = 1
    ViewStyle = vsList
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1128
    Height = 89
    Align = alTop
    TabOrder = 2
    object Button1: TButton
      Left = 16
      Top = 10
      Width = 129
      Height = 33
      Caption = 'Open Zip File To Memo'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 151
      Top = 10
      Width = 129
      Height = 33
      Caption = 'Open Zip File To ListView'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 12
      Top = 51
      Width = 105
      Height = 32
      Caption = 'Read value info'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 123
      Top = 49
      Width = 122
      Height = 32
      Caption = 'Read value monitoring'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 246
      Top = 49
      Width = 99
      Height = 32
      Caption = 'Read value states'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 348
      Top = 49
      Width = 84
      Height = 32
      Caption = 'Read Plc Info'
      TabOrder = 5
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 435
      Top = 49
      Width = 126
      Height = 32
      Caption = 'Read Discrete Value List'
      TabOrder = 6
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 564
      Top = 49
      Width = 149
      Height = 32
      Caption = 'Read History Configurations'
      TabOrder = 7
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 286
      Top = 18
      Width = 75
      Height = 25
      Caption = 'Clear Memo'
      TabOrder = 8
      OnClick = Button9Click
    end
    object Button10: TButton
      Left = 367
      Top = 18
      Width = 103
      Height = 25
      Caption = 'Read Variant Test'
      TabOrder = 9
      OnClick = Button10Click
    end
    object Button11: TButton
      Left = 716
      Top = 48
      Width = 99
      Height = 32
      Caption = 'Read UITextPool'
      TabOrder = 10
      OnClick = Button11Click
    end
  end
  inline SShotFrame1: TSnapShotFrame2
    Left = 829
    Top = 113
    Width = 299
    Height = 443
    Align = alRight
    TabOrder = 3
    ExplicitLeft = 829
    ExplicitTop = 113
    ExplicitHeight = 443
    inherited SnapShotCheckTV: TdecTreeView
      Height = 398
      PopupMenu = PopupMenu1
      ExplicitHeight = 398
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 16
    Top = 120
  end
  object OpenDialog2: TOpenDialog
    Left = 48
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 120
    object LoadParameterFromDB1: TMenuItem
      Caption = 'Load Parameter From DB'
      OnClick = LoadParameterFromDB1Click
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
  end
end
