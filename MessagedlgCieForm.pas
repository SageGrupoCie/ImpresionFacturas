unit MessagedlgCieForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ImgList, ExtCtrls, AdvPanel;

type
  TFormMessageDlgCIE = class(TForm)
    AdvPanel6: TAdvPanel;
    Label1: TLabel;
    Image1: TImage;
    Ok: TButton;
    Cancelar: TButton;
    BitBtn6: TSpeedButton;
    BitBtn5: TSpeedButton;
    BitBtn4: TSpeedButton;
    BitBtn3: TSpeedButton;
    BitBtn2: TSpeedButton;
    BitBtn1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BotonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    Procedure Inicializar;
    procedure MostrarFormNormal;
    procedure InicializarPDA;
  public
    Pulsado,Defecto:Integer;
    { Public declarations }
  end;

var
  FormMessageDlgCIE: TFormMessageDlgCIE;
  var  TamanyoX,TamanyoY :Integer;
implementation

uses AspectoForm,Funcionesform, Math;

{$R *.dfm}
//------------------------------------------------------------------------------
procedure TFormMessageDlgCIE.FormCreate(Sender: TObject);
begin
  AdvPanel6.Align:=alClient;
  Inicializar;
  Ok.Top :=0;  Cancelar.Top :=0;
  Ok.Left:=0;  Cancelar.Left:=0;
  Pulsado:=1;
  TamanyoX:= FormMessageDlgCIE.Width;
  TamanyoY:= FormMessageDlgCIE.Height;

end;
//------------------------------------------------------------------------------
procedure TFormMessageDlgCIE.BotonClick(Sender: TObject);
begin
 if Sender is TSpeedButton
   then ModalResult:=(Sender as TSpeedButton).Tag;
end;
//------------------------------------------------------------------------------
Procedure TFormMessageDlgCIE.Inicializar;
begin
 with FormAspecto do
   begin
     FormMessageDlgCIE.Color   :=FormAspecto.ColorCIE2.COLOR;//ColorBase.color;
     PonEstiloPanelCIE(FormMessageDlgCIE,AdvPanel6,false);
//     AdvPanel6.ColorTo := clWhite;//FormAspecto.ColorCIE2.Color;
     //PonEstiloPanelCIE(FormMessageDlgCIE,AdvPanel1,false);
     PonBoton(BitBtn1,Nil,1,False,'C','I',True);  BitBtn1.Font := ColorBotonesCie.Font;
     PonBoton(BitBtn2,Nil,1,False,'C','I',False); BitBtn2.Font := ColorBotonesCie.Font;
     PonBoton(BitBtn3,Nil,1,False,'C','I',False); BitBtn3.Font := ColorBotonesCie.Font;
     PonBoton(BitBtn4,Nil,1,False,'C','I',False); BitBtn4.Font := ColorBotonesCie.Font;
     PonBoton(BitBtn5,Nil,1,False,'C','I',False); BitBtn5.Font := ColorBotonesCie.Font;
     PonBoton(BitBtn6,Nil,1,False,'C','I',False); BitBtn6.Font := ColorBotonesCie.Font;
   end;
end;
//------------------------------------------------------------------------------
Procedure TFormMessageDlgCIE.InicializarPDA;
begin

end;
//------------------------------------------------------------------------------
procedure TFormMessageDlgCIE.FormShow(Sender: TObject);
begin
//  AdvPanel6.color  := FormAspecto.ColorCIE.Color;
 // AdvPanel6.colorto:= FormAspecto.ColorDegradado2.Color;
  if FormAspecto.EstiloTServer
    then begin
           AdvPanel6.color   := FormAspecto.ColorCIETServer.Color;
           AdvPanel6.colorto := FormAspecto.ColorCIETServer.Color;
         end;
  MostrarFormNormal;
end;
//------------------------------------------------------------------------------
procedure TFormMessageDlgCIE.MostrarFormNormal;
var TamanoMaximo,TamanoBotones,LineasTexto : Integer;
    anchoTextPix:Integer;//cvb
begin
 // Label1.Autosize:=True;//cvb
  anchoTextPix:=Label1.Width; //cvb

  AdvPanel6.Caption.Visible:=False;
  if FormAspecto.EstamosEnPDAs
    then TamanoMaximo := trunc(Screen.Width +100)
    else TamanoMaximo := trunc(Screen.Width /3*2);
  TamanoBotones:=0;
  if BitBtn1.visible then TamanoBotones:=TamanoBotones+BitBtn1.Width+8;
  if BitBtn2.visible then TamanoBotones:=TamanoBotones+BitBtn2.Width+8;
  if BitBtn3.visible then TamanoBotones:=TamanoBotones+BitBtn3.Width+8;
  if BitBtn4.visible then TamanoBotones:=TamanoBotones+BitBtn4.Width+8;
  if BitBtn5.visible then TamanoBotones:=TamanoBotones+BitBtn5.Width+8;
  if BitBtn6.visible then TamanoBotones:=TamanoBotones+BitBtn6.Width+8;

  if TamanoBotones>AnchoTextPix+20+Label1.Left  //CVB
    then FormMessageDlgCIE.Width:=TamanoBotones
    else FormMessageDlgCIE.Width:=AnchoTextPix+20+Label1.Left;
  AdvPanel6.Height:=Label1.Top+Label1.Height+10;
  FormMessageDlgCIE.height:=AdvPanel6.Height+BitBtn1.Height+60;//CVB

  FuncionesForm.AdaptarResolucion(FormMessageDlgCIE,10,10,TamanoMaximo,FormMessageDlgCIE.height);
  FormMessageDlgCIE.Position:=poScreenCenter;
  Label1.Width :=FormMessageDlgCIE.Width-40;
  Label1.Height:=FormMessageDlgCIE.height-20;
end;
//------------------------------------------------------------------------------
procedure TFormMessageDlgCIE.OkClick(Sender: TObject);
begin
  if Ok.Tag>0
     then ModalResult:= Ok.Tag;
end;
//------------------------------------------------------------------------------
procedure TFormMessageDlgCIE.FormKeyPress(Sender: TObject; var Key: Char);
var Mayuscula:Char;
begin
  Mayuscula:= upcase(key);
  if (BitBtn1.Caption<>'') and (upcase(BitBtn1.Caption[1])=Mayuscula)  then BotonClick(BitBtn1);
  if (BitBtn2.Caption<>'') and (upcase(BitBtn2.Caption[1])=Mayuscula)  then BotonClick(BitBtn2);
  if (BitBtn3.Caption<>'') and (upcase(BitBtn3.Caption[1])=Mayuscula)  then BotonClick(BitBtn3);
  if (BitBtn4.Caption<>'') and (upcase(BitBtn4.Caption[1])=Mayuscula)  then BotonClick(BitBtn4);
  if (BitBtn5.Caption<>'') and (upcase(BitBtn5.Caption[1])=Mayuscula)  then BotonClick(BitBtn5);
  if (BitBtn6.Caption<>'') and (upcase(BitBtn6.Caption[1])=Mayuscula)  then BotonClick(BitBtn6);
end;
//------------------------------------------------------------------------------

end.
