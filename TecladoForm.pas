unit TecladoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Funciones, ExtCtrls, Mask;

type
  TFormTeclado = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image2: TImage;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label4: TLabel;
    Image3: TImage;
    Panel4: TPanel;
    Image4: TImage;
    Image5: TImage;
    Panel3: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Edit2: TMaskEdit;

    procedure AnadeLetra(car:Char);
    procedure PasaaMayuscula(etiqueta:TLabel);
    procedure PasaaMinuscula(etiqueta:TLabel);


    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label64Click(Sender: TObject);
    procedure Label42Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label21Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure Label28Click(Sender: TObject);
    procedure Label29Click(Sender: TObject);
    procedure Label30Click(Sender: TObject);
    procedure Label31Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label22Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure Label26Click(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure Label48Click(Sender: TObject);
    procedure Label49Click(Sender: TObject);
    procedure Label50Click(Sender: TObject);
    procedure Label44Click(Sender: TObject);
    procedure Label45Click(Sender: TObject);
    procedure Label46Click(Sender: TObject);
    procedure Label47Click(Sender: TObject);
    procedure Label51Click(Sender: TObject);
    procedure Label40Click(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure Label62Click(Sender: TObject);
    procedure Label63Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    PuedeUsarPunto,Mayuscula:Boolean;
    EditComodin : TCustomEdit;
    irA : TWinControl;
    { Public declarations }
  end;

var
  FormTeclado: TFormTeclado;

implementation

uses RTLConsts;

{$R *.dfm}

procedure TFormTeclado.AnadeLetra(car:Char);
begin
  if Panel3.Tag=0
     then begin
            Panel3.Color     := clWhite;
            Panel4.Color     := clWhite;
            Panel3.Font.Color:= clNavy;
            Panel3.tag       := 1;
            EditComodin.Text := '';
          end;


  if Mayuscula
    then car:=Upcase(car);
  EditComodin.Text:=EditComodin.Text+Car;
  panel3.Caption :=EditComodin.Text;
  Edit2.Text     :=EditComodin.Text;
end;

procedure TFormTeclado.Label1Click(Sender: TObject);
begin AnadeLetra('1'); end;

procedure TFormTeclado.Label2Click(Sender: TObject);
begin AnadeLetra('2'); end;

procedure TFormTeclado.Label3Click(Sender: TObject);
begin AnadeLetra('3'); end;

procedure TFormTeclado.Label5Click(Sender: TObject);
begin AnadeLetra('4'); end;

procedure TFormTeclado.Label6Click(Sender: TObject);
begin AnadeLetra('5'); end;

procedure TFormTeclado.Label7Click(Sender: TObject);
begin AnadeLetra('6'); end;

procedure TFormTeclado.Label8Click(Sender: TObject);
begin  AnadeLetra('7'); end;

procedure TFormTeclado.Label9Click(Sender: TObject);
begin AnadeLetra('8'); end;

procedure TFormTeclado.Label10Click(Sender: TObject);
begin AnadeLetra('9'); end;

procedure TFormTeclado.Label11Click(Sender: TObject);
begin AnadeLetra('0'); end;


procedure TFormTeclado.Label14Click(Sender: TObject);
begin
 if pos('-', EditComodin.Text)=0
   then  EditComodin.Text:='-'+EditComodin.Text
   else  EditComodin.Text:= Funciones.QuitaCaracter(EditComodin.Text,'-');
 Panel3.Caption:=EditComodin.Text;
end;

procedure TFormTeclado.Label13Click(Sender: TObject);
begin
// ModalResult:= mrOk;
 close;
 ira.SetFocus;
end;

procedure TFormTeclado.Label4Click(Sender: TObject);
begin
 EditComodin.Text:='';
 Panel3.Caption:=EditComodin.Text;
end;

procedure TFormTeclado.FormCreate(Sender: TObject);
begin
  //Teclado Numerico
{  Label1.Caption  := '';  Label2.Caption  := '';  Label3.Caption  := '';
  Label4.Caption  := '';  Label5.Caption  := '';  Label6.Caption  := '';
  Label7.Caption  := '';  Label8.Caption  := '';  Label9.Caption  := '';
  Label10.Caption := '';  Label11.Caption := '';  Label12.Caption := '';
  Label13.Caption := '';  Label14.Caption := '';  PuedeUsarPunto:=True;
 }
  //teclado normal
  Edit2.Text       := '';
  Label38.Caption  := '';
  Label43.Caption  := '';
  Label62.Caption  := '';
  Mayuscula:=False;
end;

procedure TFormTeclado.Label12Click(Sender: TObject);
begin
  if (PuedeUsarPunto) and
     (pos('.', EditComodin.Text)=0)
    then  AnadeLetra('.');
  Panel3.Caption:=EditComodin.Text;
end;

procedure TFormTeclado.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    'a'..'z', 'A'..'Z',
    '0'..'9',
    ',',' ','-':AnadeLetra(key);
    #13      : Label13Click(NIL);
  end;
end;


procedure TFormTeclado.PasaaMayuscula(etiqueta:TLabel);
begin
  etiqueta.Caption:=UpperCase(etiqueta.Caption);
end;

procedure TFormTeclado.PasaaMinuscula(etiqueta:TLabel);
begin
  etiqueta.Caption:=LowerCase(etiqueta.Caption);
end;


procedure TFormTeclado.Label64Click(Sender: TObject);
begin
  Mayuscula:=not(Mayuscula);
  Image3.Visible:=not(Mayuscula);
  if mayuscula
    then begin
          PasaaMayuscula(Label15); PasaaMayuscula(Label16); PasaaMayuscula(Label17);
          PasaaMayuscula(Label19); PasaaMayuscula(Label20); PasaaMayuscula(Label21);
          PasaaMayuscula(Label24); PasaaMayuscula(Label25); PasaaMayuscula(Label28);
          PasaaMayuscula(Label29); PasaaMayuscula(Label30); PasaaMayuscula(Label31);
          PasaaMayuscula(Label18); PasaaMayuscula(Label22); PasaaMayuscula(Label23);
          PasaaMayuscula(Label26); PasaaMayuscula(Label27); PasaaMayuscula(Label48);
          PasaaMayuscula(Label49); PasaaMayuscula(Label50); PasaaMayuscula(Label44);
          PasaaMayuscula(Label45); PasaaMayuscula(Label46); PasaaMayuscula(Label47);
          PasaaMayuscula(Label51); PasaaMayuscula(Label40); PasaaMayuscula(Label41);
          Label50.Caption:='Ñ'
         end

    else begin
          PasaaMinuscula(Label15); PasaaMinuscula(Label16); PasaaMinuscula(Label17);
          PasaaMinuscula(Label19); PasaaMinuscula(Label20); PasaaMinuscula(Label21);
          PasaaMinuscula(Label24); PasaaMinuscula(Label25); PasaaMinuscula(Label28);
          PasaaMinuscula(Label29); PasaaMinuscula(Label30); PasaaMinuscula(Label31);
          PasaaMinuscula(Label18); PasaaMinuscula(Label22); PasaaMinuscula(Label23);
          PasaaMinuscula(Label26); PasaaMinuscula(Label27); PasaaMinuscula(Label48);
          PasaaMinuscula(Label49); PasaaMinuscula(Label50); PasaaMinuscula(Label44);
          PasaaMinuscula(Label45); PasaaMinuscula(Label46); PasaaMinuscula(Label47);
          PasaaMinuscula(Label51); PasaaMinuscula(Label40); PasaaMinuscula(Label41);
          Label50.Caption:='ñ'
         end
end;

procedure TFormTeclado.Label42Click(Sender: TObject);
begin  AnadeLetra('.'); end;
procedure TFormTeclado.Label15Click(Sender: TObject);
begin  AnadeLetra('q'); end;
procedure TFormTeclado.Label16Click(Sender: TObject);
begin  AnadeLetra('w'); end;
procedure TFormTeclado.Label17Click(Sender: TObject);
begin  AnadeLetra('e'); end;
procedure TFormTeclado.Label19Click(Sender: TObject);
begin  AnadeLetra('r'); end;
procedure TFormTeclado.Label20Click(Sender: TObject);
begin  AnadeLetra('t'); end;
procedure TFormTeclado.Label21Click(Sender: TObject);
begin  AnadeLetra('y'); end;
procedure TFormTeclado.Label24Click(Sender: TObject);
begin  AnadeLetra('u'); end;
procedure TFormTeclado.Label25Click(Sender: TObject);
begin  AnadeLetra('i'); end;
procedure TFormTeclado.Label28Click(Sender: TObject);
begin  AnadeLetra('o'); end;
procedure TFormTeclado.Label29Click(Sender: TObject);
begin  AnadeLetra('p'); end;
procedure TFormTeclado.Label30Click(Sender: TObject);
begin  AnadeLetra('a'); end;
procedure TFormTeclado.Label31Click(Sender: TObject);
begin  AnadeLetra('s'); end;
procedure TFormTeclado.Label18Click(Sender: TObject);
begin  AnadeLetra('d'); end;
procedure TFormTeclado.Label22Click(Sender: TObject);
begin  AnadeLetra('f'); end;
procedure TFormTeclado.Label23Click(Sender: TObject);
begin  AnadeLetra('g'); end;
procedure TFormTeclado.Label26Click(Sender: TObject);
begin  AnadeLetra('h'); end;
procedure TFormTeclado.Label27Click(Sender: TObject);
begin  AnadeLetra('j'); end;
procedure TFormTeclado.Label48Click(Sender: TObject);
begin  AnadeLetra('k'); end;
procedure TFormTeclado.Label49Click(Sender: TObject);
begin  AnadeLetra('l'); end;
procedure TFormTeclado.Label50Click(Sender: TObject);
begin  AnadeLetra('ñ'); end;
procedure TFormTeclado.Label44Click(Sender: TObject);
begin  AnadeLetra('z'); end;
procedure TFormTeclado.Label45Click(Sender: TObject);
begin  AnadeLetra('x'); end;
procedure TFormTeclado.Label46Click(Sender: TObject);
begin  AnadeLetra('c'); end;
procedure TFormTeclado.Label47Click(Sender: TObject);
begin  AnadeLetra('v'); end;
procedure TFormTeclado.Label51Click(Sender: TObject);
begin  AnadeLetra('b'); end;
procedure TFormTeclado.Label40Click(Sender: TObject);
begin  AnadeLetra('n'); end;
procedure TFormTeclado.Label41Click(Sender: TObject);
begin  AnadeLetra('m'); end;
procedure TFormTeclado.Label62Click(Sender: TObject);
begin  AnadeLetra('*'); end;
procedure TFormTeclado.Label63Click(Sender: TObject);
begin
  EditComodin.Text:= Funciones.PrimerasLetras(EditComodin.Text,length(EditComodin.Text)-2);
  Panel3.Caption:=EditComodin.Text;
end;

procedure TFormTeclado.FormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  case key of
    VK_ESCAPE   : Label13Click(NIL);
    VK_ADD      : Label14Click(NIL);
    VK_Decimal  : Label12Click(nil);
    VK_CAPITAL  : Label64Click(nil);
    VK_DELETE ,8: Label63Click(nil);
  end;
end;

procedure TFormTeclado.FormShow(Sender: TObject);
begin
  Panel3.Caption   := EditComodin.Text;
  Panel3.Color     := clMoneyGreen;
  Panel4.Color     := clMoneyGreen;
  Panel3.Font.Color:= clWhite;
  Panel3.tag       := 0;
  Edit2.Width      := Panel3.Width;
  Edit2.Height     := Panel3.Height;
  Edit2.Top        := 0;
  Edit2.Left       := 0;
  
end;

procedure TFormTeclado.Image4Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
  Close;
end;

end.
