object SnapShotFrame2: TSnapShotFrame2
  Left = 0
  Top = 0
  Width = 299
  Height = 477
  TabOrder = 0
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 299
    Height = 45
    Align = alTop
    Color = clWhite
    TabOrder = 0
    object ManualSearchEdit: TEdit
      Left = 1
      Top = 21
      Width = 297
      Height = 23
      Align = alClient
      ImeName = 'Microsoft IME 2010'
      TabOrder = 0
      OnChange = ManualSearchEditChange
      ExplicitHeight = 21
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 297
      Height = 20
      Align = alTop
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object DescRB: TRadioButton
        Left = 1
        Top = 1
        Width = 48
        Height = 18
        Align = alLeft
        Caption = 'Desc'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object Desc_EngRB: TRadioButton
        Left = 49
        Top = 1
        Width = 73
        Height = 18
        Align = alLeft
        Caption = 'Desc_Eng'
        TabOrder = 1
      end
      object ParamNoRB: TRadioButton
        Left = 122
        Top = 1
        Width = 80
        Height = 18
        Align = alLeft
        Caption = 'Param No'
        TabOrder = 2
      end
    end
  end
  object SnapShotCheckTV: TdecTreeView
    Left = 0
    Top = 45
    Width = 299
    Height = 432
    Align = alClient
    Indent = 19
    MultiSelectStyle = [msControlSelect, msShiftSelect]
    TabOrder = 1
    AlternativeView = False
  end
end
