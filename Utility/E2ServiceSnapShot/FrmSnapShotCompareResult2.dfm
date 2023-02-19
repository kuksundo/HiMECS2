object SSCompareResultF: TSSCompareResultF
  Left = 0
  Top = 0
  Caption = 'Resut of snapshot file compare'
  ClientHeight = 489
  ClientWidth = 450
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
    Top = 448
    Width = 450
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 344
      Top = 1
      Width = 105
      Height = 39
      Align = alRight
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  inline SSCompareFrame1: TSnapShotCompareFrame2
    Left = 0
    Top = 0
    Width = 450
    Height = 448
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 450
    ExplicitHeight = 448
    inherited NextGrid1: TNextGrid
      Width = 450
      Height = 448
      ExplicitWidth = 450
      ExplicitHeight = 448
    end
  end
end
