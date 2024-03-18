unit InputBoxCieForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AdvPanel;

type
  TFormInputBoxCie = class(TForm)
    AdvPanel6: TAdvPanel;
    Label2: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Salir;
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Minimo,Maximo:Integer;
  end;

var
  FormInputBoxCie: TFormInputBoxCie;
  TamanyoX,TamanyoY :Integer;
  Escalado : Boolean;
implementation
Uses AspectoForm,FuncionesForm;
{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFormInputBoxCie.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    Label3.Caption:='';
  case Key of
    #13 : Salir;
    #27 : ModalResult := mrCancel;
  end;//del case
end;
//------------------------------------------------------------------------------
procedure TFormInputBoxCie.Salir;
begin
  if (Minimo>0) and (Length(Edit1.text)<Minimo)
    then begin
           Label3.caption:='Longitud Mínima '+inttoStr(Minimo);
           exit;
         end;
  if (Maximo>0) and (Length(Edit1.text)>Maximo)
    then begin
           Label3.caption:='Longitud Máxima '+inttoStr(Maximo);
           exit;
         end;
  ModalResult := mrOK;
end;
//------------------------------------------------------------------------------
procedure TFormInputBoxCie.FormShow(Sender: TObject);
begin
  label2.Caption:=inttoStr(length(Edit1.Text));
  Label3.Caption:='';
  if FormAspecto.EstamosEnPdas
    then begin
           if (Escalado=False) and
              (FuncionesForm.AdaptarResolucion(FormInputBoxCie,10,10,TamanyoX,TamanyoY))
              then Escalado:=True;
         end
    else begin
           FormInputBoxCie.Scaled:= False;
           FormInputBoxCie.Width := TamanyoX;
           FormInputBoxCie.Height:= TamanyoY;
           Escalado:=False;
         end;
end;
//------------------------------------------------------------------------------
procedure TFormInputBoxCie.Edit1KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  label2.Caption:=inttoStr(length(Edit1.Text));
end;
//------------------------------------------------------------------------------
procedure TFormInputBoxCie.FormCreate(Sender: TObject);
begin
  AdvPanel6.Align:=alClient;
  FormInputBoxCie.Color   :=FormAspecto.ColorBase.color;
  FormAspecto.PonEstiloPanelCIE(FormInputBoxCie,AdvPanel6,true);
  AdvPanel6.Caption.Visible:=False;

  TamanyoX:= FormInputBoxCie.Width;
  TamanyoY:= FormInputBoxCie.Height;
end;
//------------------------------------------------------------------------------

end.
