object FormProcesando: TFormProcesando
  Left = 519
  Top = 371
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Procesando ...'
  ClientHeight = 152
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 551
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    BevelWidth = 0
    Color = 16640730
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    OnDblClick = AdvPanel1DblClick
    Version = '1.6.0.3'
    AutoHideChildren = False
    BorderColor = clGray
    Caption.Color = 14059353
    Caption.ColorTo = 9648131
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWhite
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    Caption.Visible = True
    CollapsColor = clHighlight
    CollapsDelay = 0
    ColorTo = 14986888
    HoverColor = clBlack
    HoverFontColor = clBlack
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clWhite
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 14716773
    StatusBar.ColorTo = 16374724
    Styler = FormAspecto.EstiloPanelCIE
    FullHeight = 233
    object Image1: TImage
      Left = 0
      Top = 18
      Width = 37
      Height = 38
      Transparent = True
    end
    object Cliente: TLabel
      Left = 48
      Top = 24
      Width = 41
      Height = 16
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Documento: TLabel
      Left = 354
      Top = 24
      Width = 69
      Height = 16
      Alignment = taRightJustify
      Caption = 'Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Procesando: TLabel
      Left = 48
      Top = 72
      Width = 74
      Height = 16
      Caption = 'Procesando'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 2
      Top = 64
      Width = 49
      Height = 53
      AutoSize = False
      Caption = #183#184#185#186#187#188#189#190#191#192
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clNavy
      Font.Height = -48
      Font.Name = 'Wingdings'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Memo1: TMemo
      Left = 280
      Top = 96
      Width = 257
      Height = 89
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
      Visible = False
    end
  end
  object ProgressBar1: TAdvProgress
    Left = 0
    Top = 135
    Width = 551
    Height = 17
    Align = alBottom
    Position = 50
    TabOrder = 1
    BarColor = clHighlight
    BkColor = clWindow
    Version = '1.2.0.0'
  end
end
