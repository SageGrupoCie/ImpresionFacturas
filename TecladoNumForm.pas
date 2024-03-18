unit TecladoNumForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, AdvPanel;

type
  TFormTecladoNumerico = class(TForm)
    AdvPanel1: TAdvPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    SpeedButton15: TSpeedButton;
    procedure Situame(x,y:Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
  private
    { Private declarations }
  public
    ConDecimales:Boolean;
    { Public declarations }
  end;

var
  FormTecladoNumerico: TFormTecladoNumerico;

implementation

uses AspectoForm;

{$R *.dfm}

procedure TFormTecladoNumerico.FormCreate(Sender: TObject);
begin
  ConDecimales:=True;
  AdvPanel1.Caption.Visible:= False;
  AdvPanel1.Top:=0;
  AdvPanel1.left:=0;
  FormAspecto.PonBoton(SpeedButton13,FormAspecto.Cancelar2,2,False,'I','I',False);
  FormAspecto.PonBoton(SpeedButton10,FormAspecto.Aceptar2,2,False,'I','I',False);
  FormAspecto.PonBoton(SpeedButton15,FormAspecto.Borrar,1,False,'I','I',False);
  FormTecladoNumerico.AutoSize:=True;
  Situame(-1,-1);
end;


procedure TFormTecladoNumerico.Situame(x,y:Integer);
begin
  if (x<0) and (y<0)
    then begin
           FormTecladoNumerico.Top:=Screen.Height-FormTecladoNumerico.Height-30;
           FormTecladoNumerico.left:=Screen.Width-FormTecladoNumerico.Width;
         end
    else begin
           FormTecladoNumerico.Top:=y;
           FormTecladoNumerico.left:=x;
         end
end;


procedure TFormTecladoNumerico.FormShow(Sender: TObject);
begin
  Edit1.Text:='';
  if ConDecimales
    then SpeedButton12.Caption:='.'
    else SpeedButton12.Caption:='';
  SpeedButton12.Enabled:=SpeedButton12.Caption='.';
  Formaspecto.PonEstiloPanelCIE(FormTecladoNumerico,AdvPanel1,true);
  AdvPanel1.Caption.visible:=False;
end;

procedure TFormTecladoNumerico.SpeedButton7Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'7';
end;

procedure TFormTecladoNumerico.SpeedButton8Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'8';
end;

procedure TFormTecladoNumerico.SpeedButton9Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'9';
end;

procedure TFormTecladoNumerico.SpeedButton4Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'4';
end;

procedure TFormTecladoNumerico.SpeedButton5Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'5';
end;

procedure TFormTecladoNumerico.SpeedButton6Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'6';
end;

procedure TFormTecladoNumerico.SpeedButton1Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'1';
end;

procedure TFormTecladoNumerico.SpeedButton2Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'2';
end;

procedure TFormTecladoNumerico.SpeedButton3Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'3';
end;

procedure TFormTecladoNumerico.SpeedButton11Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'0';
end;

procedure TFormTecladoNumerico.SpeedButton12Click(Sender: TObject);
begin
Edit1.Text:=Edit1.Text+'.';
end;

procedure TFormTecladoNumerico.SpeedButton10Click(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFormTecladoNumerico.SpeedButton13Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFormTecladoNumerico.Button1Click(Sender: TObject);
begin
  SpeedButton10Click(NIL);
end;

procedure TFormTecladoNumerico.Button2Click(Sender: TObject);
begin
  SpeedButton13Click(NIL);
end;

procedure TFormTecladoNumerico.Edit1KeyPress(Sender: TObject;var Key: Char);
begin
  if (ConDecimales=False) and
     ((Key='.') or (Key=','))
     then key:=#0;
  if key in ['0'..'9','.',',']
    then
    else  key:=#0;
end;

procedure TFormTecladoNumerico.SpeedButton14Click(Sender: TObject);
var Cadena:String;
begin
  Cadena:=trim(Edit1.Text);
  if Cadena=''
    then Cadena:='-'
    else if Cadena[1]='-'
              then Cadena[1]:=' '
              else Cadena:='-'+Cadena;
  Edit1.Text:=trim(cadena);
end;

procedure TFormTecladoNumerico.SpeedButton15Click(Sender: TObject);
begin Edit1.text:=''; end;

end.
