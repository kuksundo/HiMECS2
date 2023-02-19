object SnapShotNaviF: TSnapShotNaviF
  Left = 0
  Top = 0
  Caption = 'SnapShot Navigation'
  ClientHeight = 503
  ClientWidth = 408
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
  inline SSNaviTVFrame: TSSNaviTVFrame
    Left = 0
    Top = 0
    Width = 408
    Height = 503
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 408
    ExplicitHeight = 503
    inherited Panel1: TPanel
      Width = 408
      ExplicitWidth = 408
    end
    inherited Edit1: TEdit
      Width = 408
      ExplicitWidth = 408
    end
    inherited VST1: TVirtualStringTree
      Width = 408
      Height = 402
      ExplicitWidth = 408
      ExplicitHeight = 402
    end
    inherited Panel2: TPanel
      Top = 464
      Width = 408
      ExplicitTop = 464
      ExplicitWidth = 408
    end
  end
end
