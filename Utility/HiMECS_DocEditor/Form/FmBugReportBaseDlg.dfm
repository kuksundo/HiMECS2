inherited BugReportBaseDlg: TBugReportBaseDlg
  Caption = 'BugReportBaseDlg'
  ExplicitWidth = 474
  ExplicitHeight = 375
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBody: TPanel
    Width = 449
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 449
    object lblBugTracker: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 256
      Width = 105
      Height = 13
      Cursor = crHandPoint
      Caption = 'Go to the Bug Tracker'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblBugTrackerClick
    end
    object lblBugTrackerKey: TLabel
      Left = 104
      Top = 256
      Width = 35
      Height = 13
      Caption = '(Alt+B)'
    end
  end
  object alMain: TActionList
    Left = 8
    Top = 296
    object actBugTracker: TAction
      Caption = 'actBugTracker'
      ShortCut = 32834
      OnExecute = actBugTrackerExecute
    end
  end
end
