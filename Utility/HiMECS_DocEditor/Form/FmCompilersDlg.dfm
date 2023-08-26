inherited CompilersDlg: TCompilersDlg
  Caption = 'Configure Compilers'
  ClientHeight = 381
  ClientWidth = 588
  ExplicitWidth = 594
  ExplicitHeight = 410
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBody: TPanel
    Width = 539
    ExplicitWidth = 539
    object pbBanner: TPaintBox
      Left = 169
      Top = 0
      Width = 370
      Height = 23
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCaptionText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lbCompilers: TListBox
      Left = 0
      Top = 0
      Width = 163
      Height = 292
      Style = lbOwnerDrawFixed
      Ctl3D = True
      IntegralHeight = True
      ItemHeight = 36
      ParentCtl3D = False
      TabOrder = 0
    end
    object pcCompiler: TPageControl
      Left = 169
      Top = 29
      Width = 370
      Height = 263
      ActivePage = tsCompiler
      TabOrder = 1
      OnMouseDown = pcCompilerMouseDown
      object tsCompiler: TTabSheet
        Caption = 'Compiler'
        inline frmCompiler: TCompilersDlgCompilerFrame
          Left = 0
          Top = 0
          Width = 362
          Height = 235
          Align = alClient
          TabOrder = 0
        end
      end
      object tsSwitches: TTabSheet
        Caption = 'Switches'
        ImageIndex = 2
        inline frmSwitches: TCompilersDlgSwitchesFrame
          Left = 0
          Top = 0
          Width = 362
          Height = 235
          Align = alClient
          TabOrder = 0
        end
      end
      object tsNamespaces: TTabSheet
        Caption = 'Namespaces'
        ImageIndex = 4
        inline frmNamespaces: TCompilersDlgNamespacesFrame
          Left = 0
          Top = 0
          Width = 362
          Height = 235
          Align = alClient
          TabOrder = 0
        end
      end
      object tsSearchDirs: TTabSheet
        Caption = 'Search Paths'
        ImageIndex = 3
        inline frmSearchDirs: TCompilersDlgSearchDirsFrame
          Left = 0
          Top = 0
          Width = 362
          Height = 235
          Align = alClient
          TabOrder = 0
        end
      end
      object tsLog: TTabSheet
        Caption = 'Output Log'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        inline frmLog: TCompilersDlgLogFrame
          Left = 0
          Top = 0
          Width = 362
          Height = 235
          Align = alClient
          TabOrder = 0
        end
      end
    end
  end
  inherited btnHelp: TButton
    TabOrder = 5
  end
  inherited btnCancel: TButton
    TabOrder = 4
  end
  inherited btnOK: TButton
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnDetect: TButton
    Left = 8
    Top = 304
    Width = 153
    Height = 25
    Caption = '&Detect Delphi Compilers'
    TabOrder = 2
    OnClick = btnDetectClick
  end
  object chkStartupDetection: TCheckBox
    Left = 8
    Top = 336
    Width = 417
    Height = 17
    Caption = 
      'Automatically register newly installed Delphi compilers at progr' +
      'am startup'
    TabOrder = 1
  end
end
