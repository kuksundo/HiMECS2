object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 677
  ClientWidth = 1110
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1110
    Height = 145
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 64
      Top = 16
      Width = 88
      Height = 16
      Caption = 'Folder Select : '
    end
    object Label2: TLabel
      Left = 600
      Top = 16
      Width = 94
      Height = 16
      Caption = 'PDF To Folder : '
      Enabled = False
    end
    object Label3: TLabel
      Left = -4
      Top = 123
      Width = 62
      Height = 16
      Caption = 'EngType : '
    end
    object Label4: TLabel
      Left = 407
      Top = 119
      Width = 94
      Height = 16
      Caption = 'Prefix DrawNo : '
    end
    object JvDirectoryEdit1: TJvDirectoryEdit
      Left = 152
      Top = 13
      Width = 393
      Height = 24
      DialogKind = dkWin32
      ImeName = 'Microsoft IME 2010'
      TabOrder = 0
      Text = 'E:\pjh\project\util\HiMECS\Application\Bin\Doc\Manual\H35DF '#50896#48376
    end
    object Button1: TButton
      Left = 64
      Top = 56
      Width = 257
      Height = 25
      Caption = #54260#45908#50640#49436' Manual '#51221#48372' '#44032#51256#50724#44592
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 64
      Top = 87
      Width = 257
      Height = 25
      Caption = 'Doc file'#50640#49436' Manual '#51221#48372' '#44032#51256#50724#44592
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 495
      Top = 56
      Width = 162
      Height = 25
      Caption = 'Save As .info'
      TabOrder = 3
      OnClick = Button4Click
    end
    object JvDirectoryEdit2: TJvDirectoryEdit
      Left = 688
      Top = 13
      Width = 393
      Height = 24
      DialogKind = dkWin32
      ImeName = 'Microsoft IME 2010'
      Enabled = False
      TabOrder = 4
      Text = 'E:\pjh\project\util\HiMECS\Application\Bin\Doc\Manual\pdf'
    end
    object CheckBox1: TCheckBox
      Left = 551
      Top = 38
      Width = 97
      Height = 17
      Caption = 'Save PDF'
      TabOrder = 5
      OnClick = CheckBox1Click
    end
    object Button5: TButton
      Left = 495
      Top = 87
      Width = 162
      Height = 25
      Caption = 'Save As .Sqlite'
      TabOrder = 6
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 328
      Top = 87
      Width = 161
      Height = 25
      Caption = 'From File .sqlite'
      TabOrder = 7
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 688
      Top = 41
      Width = 394
      Height = 25
      Caption = #54260#45908#51032' '#54028#51068#51060#47492#51004#47196'DB'#54028#51068' '#52280#51312#54616#50668' ManualItem '#52292#50864#44592
      TabOrder = 8
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 688
      Top = 68
      Width = 394
      Height = 25
      Hint = '"H35DF Control System" '#54260#45908' '#49440#53469' '#54980' '#51060' '#48260#53948#51012' '#45572#47476#47732' '
      Caption = #54260#45908#51032' '#54028#51068#51060#47492#51004#47196' Control System ManualItem '#52292#50864#44592
      TabOrder = 9
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 687
      Top = 93
      Width = 394
      Height = 25
      Hint = #54028#51068#51060#47492'.txt'#50640#49436' '#47785#52264#47484' '#51069#50612#49436' '#47785#52264#51060#47492'.pdf '#54028#51068#51012' '#49373#49457#54632
      Caption = 'PDF '#54028#51068#51060#47492#51004#47196' Control System ManualItem '#54028#51068' '#45208#45572#44592
      TabOrder = 10
      OnClick = Button9Click
    end
    object EngTypeEdit: TEdit
      Left = 64
      Top = 118
      Width = 121
      Height = 24
      TabOrder = 11
    end
    object Button10: TButton
      Left = 190
      Top = 117
      Width = 211
      Height = 25
      Caption = 'Set RelFilePath From EngType'
      TabOrder = 12
      OnClick = Button10Click
    end
    object Button11: TButton
      Left = 688
      Top = 118
      Width = 394
      Height = 25
      Hint = #54028#51068#51060#47492'.txt'#50640#49436' '#47785#52264#47484' '#51069#50612#49436' '#47785#52264#51060#47492'.pdf '#54028#51068#51012' '#49373#49457#54632
      Caption = #54260#45908#51032' '#54028#51068#51060#47492#51004#47196' Control System '#47564' ManualItem'#50640' '#52292#50864#44592
      TabOrder = 13
      OnClick = Button11Click
    end
    object PrefixDrawNoEdit: TEdit
      Left = 498
      Top = 115
      Width = 146
      Height = 24
      TabOrder = 14
      Text = 'B94-'
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 145
    Width = 1110
    Height = 532
    Align = alClient
    Columns = <
      item
        Caption = #54028#51068#51060#47492
        Width = 200
      end
      item
        Caption = 'Section No'
        Width = 80
      end
      item
        Caption = 'Rev No'
      end
      item
        Caption = 'Category No'
      end
      item
        Caption = 'System Desc (Eng)'
        Width = 200
      end
      item
        Caption = 'System Desc (Kor)'
        Width = 200
      end
      item
        Caption = 'Part Desc (Eng)'
        Width = 200
      end
      item
        Caption = 'Part Desc (Kor)'
        Width = 200
      end
      item
        Caption = 'File Path'
        Width = 100
      end
      item
        Caption = 'Rel File Path'
      end
      item
        Caption = 'DrawNo'
      end>
    MultiSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 1
    ViewStyle = vsReport
  end
  object Button2: TButton
    Left = 327
    Top = 56
    Width = 162
    Height = 25
    Caption = 'From File .info'
    TabOrder = 2
    OnClick = Button2Click
  end
  object SaveDialog1: TSaveDialog
    Left = 552
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Left = 584
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 16
    Top = 16
    object ChangeManualFilePath1: TMenuItem
      Caption = 'Change Manual File Path'
      OnClick = ChangeManualFilePath1Click
    end
    object FileText1: TMenuItem
      Caption = 'File Test'
      OnClick = FileText1Click
    end
    object GetDrawNofrompdffile1: TMenuItem
      Caption = 'Get DrawNo from pdf file'
      OnClick = GetDrawNofrompdffile1Click
    end
  end
end
