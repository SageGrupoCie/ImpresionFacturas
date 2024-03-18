unit Procesando;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, MPlayer, ExtCtrls, AdvPanel, AdvProgr;

type
  TFormProcesando = class(TForm)
    AdvPanel1: TAdvPanel;
    Image1: TImage;
    Cliente: TLabel;
    Documento: TLabel;
    Procesando: TLabel;
    Label1: TLabel;
    Memo1: TMemo;
    ProgressBar1: TAdvProgress;
    procedure FormCreate(Sender: TObject);
    procedure AdvPanel1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Reloj:String[15];
    HoraInicio,HoraInicio2:TTime;
  end;

var
  FormProcesando: TFormProcesando;

implementation

uses FuncionesForm,AspectoForm;

{$R *.DFM}

procedure TFormProcesando.FormCreate(Sender: TObject);
begin
  Memo1.Text:='';
  Reloj:='·¸¹º»¼½¾¿À';
   with FormAspecto do begin
     FormProcesando.Color   :=ColorBase.color;
     PonEstiloPanelCIE(FormProcesando,AdvPanel1,false);
     AdvPanel1.Align:=alClient;
     AdvPanel1.Caption.Visible:=False;
     Image1.Picture:=FormAspecto.Procesar2.picture;
   end;
end;

procedure TFormProcesando.AdvPanel1DblClick(Sender: TObject);
begin
  if FuncionesForm.MessageDlgCie('¿Cerramos Ventana?',mtConfirmation,
       [mbYes, mbNo], 0) = mrYes
      then close
end;

end.
