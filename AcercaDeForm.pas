unit AcercaDeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvPageControl, ComCtrls, ExtCtrls, Buttons, ShellAPI,
  AdvPanel, jpeg;

type
  TFormAcercaDe = class(TForm)
    AdvPanel1: TAdvPanel;
    Label3: TLabel;
    ProductName: TLabel;
    Version: TLabel;
    Label2: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelMemory: TLabel;
    LabelFree: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function BuscarMemo(memo: TMemo; Cadena: String):string;
  end;

var
  FormAcercaDe: TFormAcercaDe;

implementation

Uses Funciones, AspectoForm;

{$R *.dfm}

procedure TFormAcercaDe.FormShow(Sender: TObject);
var cad,Entorno,Trabajo :string;
    MS: TMemoryStatus;
begin

  FormAspecto.PonBoton(SpeedButton1,FormAspecto.Aceptar2,2,True,'I','I',False);
  MS.dwLength := SizeOf(MS);
  GlobalMemoryStatus(MS);
  LabelMemory.Caption := FormatFloat('Memoria Total:     #, KB', MS.dwTotalPhys div 1024);
  LabelFree.Caption   := FormatFloat('Memoria Libre:     #, KB', MS.dwAvailPhys div 1024);
 // Label2.Caption := PChar(VERSION);
  Label3.Caption:='';
  version.Caption:='';


  {// Truquillo para mostrar en un TImage el icono de la aplicación. Raúl
  Icono := SendMessage(Self.handle, WM_GETICON, ICON_BIG, 0);
  Image1.Picture.Icon.Handle := icono;}
  Label11.Caption:= 'Programa : '+ Application.ExeName;
  Label9.Caption:='IP Pública';
  try
    Label9.Caption:=funciones.ObtenerIPPublicaPCLocal('','');
  except
  end;
end;

Function TFormAcercaDe.BuscarMemo(memo: TMemo; Cadena: String) :string;
var n:integer;
begin
  for n:= 0 to memo.Lines.Count -1 do
  if pos(cadena,memo.Lines[n]) > 0
  then begin
      Result := memo.Lines[n];
      Exit;
  end;

end;

procedure TFormAcercaDe.Label7Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','mailto:admon@grupocie.es',nil,nil,SW_SHOW);
end;


procedure TFormAcercaDe.FormCreate(Sender: TObject);
begin
  Image1.align:=alClient;
  AdvPanel1.align:=alClient;
  AdvPanel1.Caption.visible:=False;
end;

end.
