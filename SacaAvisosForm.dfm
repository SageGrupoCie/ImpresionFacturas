object FormSacaAvisos: TFormSacaAvisos
  Left = 336
  Top = 337
  Width = 797
  Height = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = AdvMainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 32
    Top = 24
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    OnClick = Memo1Click
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 352
    Top = 80
  end
  object PrintDialog1: TPrintDialog
    Left = 288
    Top = 104
  end
  object AdvMainMenu1: TAdvMainMenu
    MenuStyler = FormAspecto.AdvMenuStyler1
    Version = '1.2.3.0'
    Left = 72
    Top = 128
    object Archivo2: TMenuItem
      Caption = 'Archivo'
      object Imprimir2: TMenuItem
        Caption = 'Imprimir'
        ShortCut = 116
        OnClick = Imprimir2Click
      end
      object Guardar1: TMenuItem
        Caption = 'Guardar'
        OnClick = Guardar1Click
      end
      object Foto2: TMenuItem
        Caption = 'Foto'
        OnClick = Foto2Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Salir2: TMenuItem
        Caption = 'Salir'
        ShortCut = 27
        OnClick = Salir2Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.txt'
    Filter = 'txt|.txt'
    Left = 136
    Top = 168
  end
end
