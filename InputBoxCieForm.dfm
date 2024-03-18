object FormInputBoxCie: TFormInputBoxCie
  Left = 606
  Top = 307
  Width = 273
  Height = 182
  Caption = 'entrada de texto'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel6: TAdvPanel
    Left = 8
    Top = 8
    Width = 249
    Height = 129
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
    Caption.Indent = 4
    Caption.ShadeLight = 255
    Caption.Text = 'Cambios'
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
    Styler = FormAspecto.EstiloPanelDegradado
    DesignSize = (
      249
      129)
    FullHeight = 233
    object Label2: TLabel
      Left = 227
      Top = 97
      Width = 6
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '0'
      Transparent = True
    end
    object Label1: TLabel
      Left = 10
      Top = 16
      Width = 215
      Height = 113
      AutoSize = False
      Caption = 'Label1'
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel
      Left = 0
      Top = 116
      Width = 249
      Height = 13
      Align = alBottom
      Caption = '0'
      Transparent = True
    end
    object Edit1: TEdit
      Left = 8
      Top = 92
      Width = 217
      Height = 19
      Anchors = [akLeft, akBottom]
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      Text = 'Edit1'
      OnKeyPress = Edit1KeyPress
      OnKeyUp = Edit1KeyUp
    end
  end
end
