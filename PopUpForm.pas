unit PopUpForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,AspectoForm, ExtCtrls, StdCtrls, frmshape;

type
  TFormMensagePop = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public    { Public declarations }
    Duracion : Integer;
  end;

var
  FormMensagePop: TFormMensagePop;

implementation

{$R *.dfm}

procedure TFormMensagePop.FormCreate(Sender: TObject);
begin
  FormMensagePop.Left := Screen.Width-FormMensagePop.Width-10;
  FormMensagePop.Top  := screen.Height-FormMensagePop.Height-35;
//  FormMensagePop.Color:= FormAspecto.ColorCIE.Color;}
  Label1.Caption      :='';
  Duracion            :=1000;
  FormMensagePop.Visible:=False;
end;

procedure TFormMensagePop.Timer1Timer(Sender: TObject);
begin
  FormMensagePop.Visible:=False;
end;

procedure TFormMensagePop.FormShow(Sender: TObject);
begin
  FormMensagePop.Visible:=true;
  Timer1.Interval       :=Duracion;
end;

end.
