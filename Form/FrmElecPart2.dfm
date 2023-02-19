object ElecPartF: TElecPartF
  Left = 0
  Top = 0
  Caption = 'Electric Part'
  ClientHeight = 391
  ClientWidth = 425
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
  object Panel1: TPanel
    Left = 0
    Top = 343
    Width = 425
    Height = 48
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 91
      Top = 6
      Width = 91
      Height = 35
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 283
      Top = 6
      Width = 91
      Height = 35
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 51
    Top = 300
    Width = 89
    Height = 33
    Caption = 'View Drawing'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 256
    Top = 300
    Width = 89
    Height = 33
    Caption = 'View Manual'
    TabOrder = 1
    OnClick = Button2Click
  end
  inline ElecPartFrame: TFrameElecPartEdit2
    Left = 0
    Top = 8
    Width = 417
    Height = 281
    TabOrder = 3
    ExplicitTop = 8
    ExplicitWidth = 417
    inherited PageControl1: TPageControl
      Width = 417
      ActivePage = ElecPartFrame.TabSheet4
      ExplicitWidth = 417
      inherited TabSheet4: TTabSheet
        ExplicitWidth = 409
      end
      inherited TabSheet1: TTabSheet
        ExplicitWidth = 409
      end
      inherited TabSheet3: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 316
        ExplicitHeight = 250
      end
      inherited NodeInfoTabSheet: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 316
        ExplicitHeight = 250
      end
    end
  end
end
