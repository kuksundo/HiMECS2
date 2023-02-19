object SSNaviTVFrame: TSSNaviTVFrame
  Left = 0
  Top = 0
  Width = 406
  Height = 408
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 406
    Height = 41
    Align = alTop
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 0
    Top = 41
    Width = 406
    Height = 21
    Align = alTop
    ImeName = 'Microsoft IME 2010'
    TabOrder = 1
    OnChange = Edit1Change
  end
  object VST1: TVirtualStringTree
    Left = 0
    Top = 62
    Width = 406
    Height = 307
    Align = alClient
    Colors.UnfocusedColor = clMedGray
    Header.AutoSizeIndex = 0
    Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize]
    TabOrder = 2
    OnDrawText = VST1DrawText
    OnGetText = VST1GetText
    OnGetPopupMenu = VST1GetPopupMenu
    OnInitNode = VST1InitNode
    OnNewText = VST1NewText
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 0
        Text = 'Items'
        Width = 300
      end
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 1
        Text = 'Value'
      end
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 2
        Text = 'Unit'
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 369
    Width = 406
    Height = 39
    Align = alBottom
    TabOrder = 3
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 8
  end
end
