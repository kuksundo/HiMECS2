object PDFViewMDIChildF: TPDFViewMDIChildF
  Left = 0
  Top = 0
  Caption = 'PDF View MDI'
  ClientHeight = 647
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  inline PdfViewFrame1: TPdfViewFrame
    Left = 0
    Top = 0
    Width = 655
    Height = 647
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 655
    ExplicitHeight = 647
    inherited Panel1: TPanel
      Width = 655
      ExplicitWidth = 655
    end
  end
end
