unit SacaAvisosForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, AdvMenus,Printers;

type
  TFormSacaAvisos = class(TForm)
    Memo1: TMemo;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    AdvMainMenu1: TAdvMainMenu;
    Archivo2: TMenuItem;
    Imprimir2: TMenuItem;
    Foto2: TMenuItem;
    N2: TMenuItem;
    Salir2: TMenuItem;
    Guardar1: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure Salir2Click(Sender: TObject);
    procedure Foto2Click(Sender: TObject);
    procedure Imprimir2Click(Sender: TObject);
    procedure Guardar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSacaAvisos: TFormSacaAvisos;

implementation

uses AspectoForm;

{$R *.dfm}

procedure TFormSacaAvisos.FormCreate(Sender: TObject);
begin
 Memo1.Align:=alClient;
 Memo1.Clear;
end;

procedure TFormSacaAvisos.Memo1Click(Sender: TObject);
begin
  Memo1.SelectAll;
end;

procedure TFormSacaAvisos.Salir2Click(Sender: TObject);
begin
Close;
end;

procedure TFormSacaAvisos.Foto2Click(Sender: TObject);
begin FormAspecto.ImprimeFoto(FormSacaAvisos); end;

procedure TFormSacaAvisos.Imprimir2Click(Sender: TObject);
var Impresora:TextFile;
    Copias,i:Integer;
begin
  if not(PrintDialog1.execute)
    then exit;
  with printer do
    begin
      assignPrn(Impresora);
      Canvas.Font:=Memo1.Font;
      Title:='Avisos';
      for Copias:=1 to PrintDialog1.Copies do
        begin
          rewrite(Impresora);
          for i:=0 to Memo1.Lines.Count do
            Writeln(Impresora,Memo1.Lines[i]);
          closeFile(Impresora)
        end;//for de copias
    end;//with
end;

procedure TFormSacaAvisos.Guardar1Click(Sender: TObject);
begin
  if OpenDialog1.Execute
    then memo1.Lines.SaveToFile(OpenDialog1.FileName);
end;

end.
