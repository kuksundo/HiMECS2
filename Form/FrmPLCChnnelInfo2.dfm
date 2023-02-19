object PLCChannelInfoF: TPLCChannelInfoF
  Left = 0
  Top = 0
  Caption = 'PLCChannelInfoF'
  ClientHeight = 281
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 761
    Height = 97
    Align = alTop
    TabOrder = 0
    object JvLabel10: TJvLabel
      AlignWithMargins = True
      Left = 34
      Top = 53
      Width = 120
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = 'Description'
      Color = 14671839
      FrameColor = clGrayText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
      Layout = tlCenter
      Margin = 5
      ParentColor = False
      ParentFont = False
      RoundedFrame = 3
      Transparent = True
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -13
      HotTrackFont.Name = #47569#51008' '#44256#46357
      HotTrackFont.Style = []
    end
    object JvLabel1: TJvLabel
      AlignWithMargins = True
      Left = 34
      Top = 23
      Width = 120
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = 'Tag Name'
      Color = 14671839
      FrameColor = clGrayText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
      Layout = tlCenter
      Margin = 5
      ParentColor = False
      ParentFont = False
      RoundedFrame = 3
      Transparent = True
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -13
      HotTrackFont.Name = #47569#51008' '#44256#46357
      HotTrackFont.Style = []
    end
    object DescEdit: TEdit
      Left = 160
      Top = 53
      Width = 361
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ImeName = 'Microsoft IME 2010'
      ParentFont = False
      TabOrder = 0
    end
    object TagNameEdit: TEdit
      Left = 160
      Top = 23
      Width = 361
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ImeName = 'Microsoft IME 2010'
      ParentFont = False
      TabOrder = 1
    end
    object Button1: TButton
      Left = 568
      Top = 19
      Width = 169
      Height = 33
      Caption = 'Show Wire Path Form'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
