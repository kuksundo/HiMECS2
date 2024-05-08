object TraderConfigF: TTraderConfigF
  Left = 0
  Top = 0
  Caption = 'TraderConfigF'
  ClientHeight = 480
  ClientWidth = 389
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
    Top = 57
    Width = 389
    Height = 366
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 475
    object TabSheet1: TTabSheet
      Caption = #54028#51068
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 467
      object Label1: TLabel
        Left = 86
        Top = 40
        Width = 130
        Height = 19
        Caption = 'TR '#47785#47197' '#54028#51068' '#51060#47492' :'
      end
      object Label2: TLabel
        Left = 64
        Top = 76
        Width = 152
        Height = 19
        Caption = #49892#49884#44036' '#47785#47197' '#54028#51068' '#51060#47492' :'
      end
      object Label3: TLabel
        Left = 39
        Top = 7
        Width = 177
        Height = 19
        Caption = 'Company '#47785#47197' '#54028#51068' '#51060#47492' :'
      end
      object Label4: TLabel
        Left = 50
        Top = 109
        Width = 166
        Height = 19
        Caption = #46321#47197#46108' '#49892#49884#44036' '#47785#47197' '#54028#51068' :'
      end
      object Label6: TLabel
        Left = 51
        Top = 141
        Width = 165
        Height = 19
        Caption = 'Telegram ChatID '#54028#51068' :'
      end
      object TRFilenameEdit: TJvFilenameEdit
        Tag = 11
        Left = 222
        Top = 40
        Width = 225
        Height = 27
        Hint = 'Text'
        OnButtonClick = TRFilenameEditButtonClick
        TextHint = 'TR '#47785#47197' TreeView'#50640' '#54364#49884#54624' '#45936#51060#53552' '#54028#51068' '#51060#47492
        TabOrder = 0
        Text = ''
      end
      object RealTypeFileEdit: TJvFilenameEdit
        Tag = 12
        Left = 222
        Top = 73
        Width = 225
        Height = 27
        Hint = 'Text'
        OnButtonClick = RealTypeFileEditButtonClick
        TextHint = 'RealType Treeview'#50640' '#54364#49884#54624' '#45936#51060#53552' '#54028#51068' '#51060#47492
        TabOrder = 1
        Text = ''
      end
      object CompanyFilenameEdit: TJvFilenameEdit
        Tag = 10
        Left = 222
        Top = 7
        Width = 225
        Height = 27
        Hint = 'Text'
        OnButtonClick = CompanyFilenameEditButtonClick
        TextHint = 'Company '#47785#47197' TreeView'#50640' '#54364#49884#54624' '#45936#51060#53552' '#54028#51068' '#51060#47492
        TabOrder = 2
        Text = ''
      end
      object JvFilenameEdit1: TJvFilenameEdit
        Tag = 13
        Left = 222
        Top = 106
        Width = 225
        Height = 27
        Hint = 'Text'
        OnButtonClick = RealTypeFileEditButtonClick
        TextHint = 'RealType Treeview'#50640' '#54364#49884#54624' '#45936#51060#53552' '#54028#51068' '#51060#47492
        TabOrder = 3
        Text = ''
      end
      object JvFilenameEdit2: TJvFilenameEdit
        Tag = 14
        Left = 222
        Top = 139
        Width = 225
        Height = 27
        Hint = 'Text'
        OnButtonClick = RealTypeFileEditButtonClick
        TextHint = 'RealType Treeview'#50640' '#54364#49884#54624' '#45936#51060#53552' '#54028#51068' '#51060#47492
        TabOrder = 4
        Text = ''
      end
    end
    object TabSheet2: TTabSheet
      Caption = #53685#49888
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      ExplicitWidth = 467
      object Label5: TLabel
        Left = 87
        Top = 35
        Width = 62
        Height = 19
        Caption = 'Bind IP :'
      end
      object Label7: TLabel
        Left = 73
        Top = 68
        Width = 76
        Height = 19
        Hint = 'WatchForm'#50640' '#49569#49888#54616#45716' Interval'
        Caption = 'Bind Port :'
      end
      object Label8: TLabel
        Left = 63
        Top = 101
        Width = 86
        Height = 19
        Hint = 'WatchForm'#50640' '#49569#49888#54616#45716' Interval'
        Caption = 'Mapped IP :'
      end
      object Label9: TLabel
        Left = 49
        Top = 133
        Width = 100
        Height = 19
        Hint = 'WatchForm'#50640' '#49569#49888#54616#45716' Interval'
        Caption = 'Mapped Port :'
      end
      object Label10: TLabel
        Left = 107
        Top = 166
        Width = 42
        Height = 19
        Hint = 'WatchForm'#50640' '#49569#49888#54616#45716' Interval'
        Caption = 'Path :'
      end
      object Edit1: TEdit
        Tag = 10
        Left = 157
        Top = 32
        Width = 161
        Height = 27
        Hint = 'Text'
        TabOrder = 0
      end
      object Edit2: TEdit
        Tag = 11
        Left = 157
        Top = 65
        Width = 161
        Height = 27
        Hint = 'Text'
        TabOrder = 1
      end
      object Edit3: TEdit
        Tag = 12
        Left = 157
        Top = 98
        Width = 161
        Height = 27
        Hint = 'Text'
        TabOrder = 2
      end
      object Edit4: TEdit
        Tag = 13
        Left = 157
        Top = 131
        Width = 161
        Height = 27
        Hint = 'Text'
        TabOrder = 3
      end
      object Edit5: TEdit
        Tag = 14
        Left = 157
        Top = 164
        Width = 161
        Height = 27
        Hint = 'Text'
        TabOrder = 4
      end
    end
    object TabSheet3: TTabSheet
      Caption = #44592#53440
      ImageIndex = 2
      ExplicitWidth = 467
      object CheckBox1: TCheckBox
        Tag = 40
        Left = 48
        Top = 24
        Width = 337
        Height = 17
        Hint = 'Checked'
        Caption = #54532#47196#44536#47016' '#51333#47308#49884#50640' '#49892#54665' '#51473#51064' Watch '#54268' '#47784#46160' '#51333#47308
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Tag = 41
        Left = 48
        Top = 72
        Width = 337
        Height = 17
        Hint = 'Checked'
        Caption = #54532#47196#44536#47016' '#49884#51089' '#49884' DB '#49436#48260' '#50672#44208
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object CheckBox3: TCheckBox
        Tag = 42
        Left = 48
        Top = 113
        Width = 337
        Height = 17
        Hint = 'Checked'
        Caption = 'Main Thread'#50640#49436' GpShardMM '#49569#49688#49888
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 423
    Width = 389
    Height = 57
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 475
    object BitBtn1: TBitBtn
      Left = 64
      Top = 16
      Width = 89
      Height = 33
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 248
      Top = 16
      Width = 89
      Height = 33
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 389
    Height = 57
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 475
  end
end
