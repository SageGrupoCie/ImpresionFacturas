unit BuscarBotonesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, AdvPanel, DB, ADODB, StdCtrls;

type
  TFormBuscarBotones = class(TForm)
    AdvPanel7: TAdvPanel;
    BotonSiguiente: TSpeedButton;
    BotonAnterior: TSpeedButton;
    BotonPrimero: TSpeedButton;
    SpeedButton17: TSpeedButton;
    BotonUltimo: TSpeedButton;
    Panel1: TAdvPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    BntSeleccion1: TAdvPanel;
    BntSeleccion2: TAdvPanel;
    BntSeleccion3: TAdvPanel;
    BntSeleccion4: TAdvPanel;
    BntSeleccion5: TAdvPanel;
    BntSeleccion6: TAdvPanel;
    BntSeleccion7: TAdvPanel;
    BntSeleccion8: TAdvPanel;
    BntSeleccion13: TAdvPanel;
    BntSeleccion14: TAdvPanel;
    BntSeleccion15: TAdvPanel;
    BntSeleccion16: TAdvPanel;
    BntSeleccion12: TAdvPanel;
    BntSeleccion11: TAdvPanel;
    BntSeleccion10: TAdvPanel;
    BntSeleccion9: TAdvPanel;
    BntSeleccion21: TAdvPanel;
    BntSeleccion22: TAdvPanel;
    BntSeleccion23: TAdvPanel;
    BntSeleccion24: TAdvPanel;
    BntSeleccion20: TAdvPanel;
    BntSeleccion19: TAdvPanel;
    BntSeleccion18: TAdvPanel;
    BntSeleccion17: TAdvPanel;
    BntSeleccion27: TAdvPanel;
    BntSeleccion26: TAdvPanel;
    BntSeleccion25: TAdvPanel;
    SpeedButton1: TSpeedButton;
    AdvPanel1: TAdvPanel;
    BotonBorrar: TSpeedButton;
    BotonRetroceso: TSpeedButton;
    Edit1: TEdit;
    BotonBuscar: TSpeedButton;
    ComboOrden: TComboBox;
    Panel3: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    Label25: TLabel;

    procedure PonBotones;
    procedure ColoresBotones;
    procedure MuestraAyuda(Sender: TObject;Shift: TShiftState; X, Y: Integer);
    procedure BotonRetrocesoClick(Sender: TObject);
    procedure BotonBorrarClick(Sender: TObject);
    procedure BotonUltimoClick(Sender: TObject);
    procedure BotonSiguienteClick(Sender: TObject);
    procedure BotonAnteriorClick(Sender: TObject);
    procedure BotonBuscarClick(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Seleccionar(Sender: TObject);

    procedure BotonPrimeroClick(Sender: TObject);
    procedure Label29Click(Sender: TObject);
    procedure Label30Click(Sender: TObject);
    procedure ComboOrdenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    Indice :integer;

    ACodigo : array of Integer;
    ADescripcion : array of string;
    procedure MontarArray;
    procedure AsignarValor;

  public
    { Public declarations }
    Tabla :TDataSet;
    Tipo_Panel_Botones :char;
    CampoCodigo,CampoDescripcion,StrSQL:String;
    ControlActivo :TWinControl;
    Codigo, Descripcion :String;
    ComoCaption: Byte;
    procedure Inicializar;
    procedure RellenaBotones(Empieza:Boolean;Accion:char);
    procedure RellenaLetras;
    procedure BotonesVacios;
    procedure BotonesVisibles;
    procedure Posicionar(cadena:string);


  end;

var
  FormBuscarBotones: TFormBuscarBotones;
  TamanyoX,TamanyoY :Integer;

implementation
Uses Funciones, FuncionesForm, AspectoForm;
{$R *.dfm}
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonRetrocesoClick(Sender: TObject);
begin
  Edit1.Text := Copy(Edit1.Text,1,Length(Edit1.Text)-1);
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonBorrarClick(Sender: TObject);
begin
  Edit1.Text := '';
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonUltimoClick(Sender: TObject);
begin  RellenaBotones(False,'U');end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonSiguienteClick(Sender: TObject);
begin  RellenaBotones(False,'S');end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonAnteriorClick(Sender: TObject);
begin  RellenaBotones(False,'A');end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonBuscarClick(Sender: TObject);
begin
  if BotonBuscar.Down
  then begin
         Edit1.Text := '';
         AdvPanel1.Visible:=True;
         RellenaLetras;
         FormBuscarBotones.Height:=FormBuscarBotones.Height+AdvPanel1.Height;
         Panel3.visible:=False;
       end
  else begin
         Posicionar(Edit1.Text);
         AdvPanel1.Visible:=False;
         BotonesVisibles;
         FormBuscarBotones.Height:=FormBuscarBotones.Height-AdvPanel1.Height;
         Panel3.visible:=True;
       end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.SpeedButton17Click(Sender: TObject);
begin
  CLose
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.Label1Click(Sender: TObject);
begin
  Label1.Transparent:=True;     Label2.Transparent:=True;    Label3.Transparent:=True;
  Label4.Transparent:=True;     Label5.Transparent:=True;    Label6.Transparent:=True;
  Label7.Transparent:=True;     Label8.Transparent:=True;    Label9.Transparent:=True;
  Label10.Transparent:=True;    Label11.Transparent:=True;   Label12.Transparent:=True;
  Label13.Transparent:=True;    Label14.Transparent:=True;   Label15.Transparent:=True;
  Label16.Transparent:=True;    Label17.Transparent:=True;   Label18.Transparent:=True;
  Label19.Transparent:=True;    Label20.Transparent:=True;   Label21.Transparent:=True;
  Label22.Transparent:=True;    Label23.Transparent:=True;   Label24.Transparent:=True;
  Label26.Transparent:=True;    Label27.Transparent:=True;   Label28.Transparent:=True;
  Edit1.Text:= (Sender as TLabel).Caption;
  (Sender as TLabel).Transparent:=False;
  Posicionar(Edit1.Text);
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.Seleccionar(Sender: TObject);
var i :integer;
begin
  //if Not (Sender is TSpeedButton) then exit;
  if Not (Sender is TAdvPanel) then exit;

  if BotonBuscar.Down
    then begin
           Edit1.Text := Edit1.Text + (Sender as TadvPanel).Caption.Text;
         end
    else begin
            i := (Sender as TAdvPanel).Tag;
            Codigo      := inttostr(ACodigo[i]);
            Descripcion := ADescripcion[i];
            AsignarValor;
            ModalResult:=mrOk;
          //  Close;
         end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.Posicionar(cadena:string);
var n,i :Integer;
begin
  cadena:=UpperCase(Cadena);
  for i := 0 to High(ADescripcion) do
    If Pos(Cadena,ADescripcion[i]) = 1 then
    begin
       Indice := i;
       Break;
    end;
  RellenaBotones(False,'B');
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.AsignarValor;
begin
  If (ControlActivo is TComboBox)
    then begin
          (ControlActivo as TComboBox).Text := Codigo + ' - ' + Descripcion;
           Funciones.BuscarEnCombo((ControlActivo as TComboBox),Codigo);
         end;
  If (ControlActivo is TEdit)
    then (ControlActivo as TEdit).Text := Codigo + ' - ' + Descripcion;
  If (ControlActivo is TBitBtn)
    then (ControlActivo as TBitBtn).Caption := Codigo + ' - ' + Descripcion;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonPrimeroClick(Sender: TObject);
begin
  RellenaBotones(False,'P');
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonesVisibles;
var n :integer;
begin
  for n := 0 to Self.ComponentCount - 1 do
    If Self.Components[n] Is TAdvPanel
      then if Copy((Self.Components[n] As TAdvPanel).Name,1,12) = 'BntSeleccion'
         then begin
                (Self.Components[n] As TAdvPanel).Visible := (Self.Components[n] As TAdvPanel).Caption.Text <> '';
                //showmessage((Self.Components[n] As TAdvPanel).Name+'  '+(Self.Components[n] As TAdvPanel).Caption);
             end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.BotonesVacios;
var n :integer;
begin
  for n := 0 to Self.ComponentCount - 1 do
    If Self.Components[n] Is TAdvPanel
      then if Copy((Self.Components[n] As TAdvPanel).Name,1,12) = 'BntSeleccion'
         then  (Self.Components[n] As TAdvPanel).Caption.Text:= '';
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.RellenaLetras;
var i :Byte;
    n :Integer;
begin
  BotonesVacios;
  for i := 1 to 26 do
    for n := 0 to Self.ComponentCount - 1 do
       If Self.Components[n] Is TAdvPanel
       then if (Self.Components[n] As TAdvPanel).Name = 'BntSeleccion' + inttostr(i)
            then (Self.Components[n] As TAdvPanel).Caption.Text:= CHR(i+64);
  BotonesVisibles;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.RellenaBotones(Empieza:Boolean;Accion:char);
var i,n : Integer;
    x,y:real;
    Boton,TextoCaption :string;
begin
  if (Empieza)
  then begin
         MontarArray;
         Accion := 'P';
       end;

  Case Accion of
  'P': begin  //Primero
         Indice := 0;
       end;
  'A': begin  //anterior
         Indice := Indice - 27;
         if Indice < 0 then Indice := 0;
       end;
  'S': begin //siguiente
         Indice := Indice + 27;
         if Indice > High(ACodigo) then Indice := Indice - 28;
       end;
  'U': begin  //Ultimo
         x := High(ACodigo) / 28;
         y := Trunc(High(ACodigo) / 28);
         Indice := High(ACodigo) - Round((x-y)*28);
       end;
  'B': {begin
         x := Indice / 28;
         y := Trunc(Indice / 28);
         Indice := Indice - Round((x-y)*28);
       end};
  end;

  {Primero borramos todos los caption}
  BotonesVacios;

  {Rellenamos Lo botones}
  for i := Indice to Indice + 27 do
    if i <= High(ACodigo)
    then for n := 0 to Self.ComponentCount - 1 do
         begin
           Boton := 'BntSeleccion' + inttostr(i - indice + 1);
           If Self.Components[n] Is TAdvPanel
           then if (Self.Components[n] As TAdvPanel).Name = Boton
                then begin
                       case ComoCaption of
                         0: TextoCaption:= InttoStr(Acodigo[i]);
                         1: TextoCaption:= ADescripcion[i];
                         2: TextoCaption:= InttoStr(Acodigo[i])+'<UL>'+ADescripcion[i]+'</UL></P>';
                       end;//del case
                       TextoCaption:= '<P align="center">'+TextoCaption+'</P>';
                       (Self.Components[n] As TAdvPanel).Caption.Text:=TextoCaption;
                       (Self.Components[n] As TAdvPanel).Hint:= InttoStr(Acodigo[i])+' - '+ ADescripcion[i];
                       (Self.Components[n] As TAdvPanel).Tag:= i;
                        {                       if length(ADescripcion[i])<12
                          then (Self.Components[n] As TAdvPanel).Margin := -1
                          else (Self.Components[n] As TAdvPanel).Margin := 1;}
                    end;
         end;
  {Ponemos invisibles los botones vacios}
 // BotonesVisibles;
end;

//------------------------------------------------------------------------------
procedure TFormBuscarBotones.Inicializar;
begin

  //if (FuncionesForm.ResolucionX>0) and (FuncionesForm.ResolucionX <> Self.Width)
  //then
 // Self.ScaleBy(FuncionesForm.ResolucionX,Self.Width );
//  Self.Top    := 0;
//  Self.Left   := 0;
//  Self.Width  := FuncionesForm.ResolucionX;
//  Self.Height := FuncionesForm.ResolucionY;
//  Self.BringToFront;
 { if FuncionesForm.EstamosEnPDAs
    then FormBuscarBotones.WindowState:= wsMaximized
    else FormBuscarBotones.WindowState:= wsNormal;}
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.MontarArray;
var
  n:integer;
  Registros:integer;
  strOrden :string;
begin
  SetLength(ACodigo,0);
  SetLength(ADescripcion,0);
  n:= -1;

  if ComboOrden.text=''
    then strOrden := ''
    else strOrden := ' Order by ' + ComboOrden.text;

  Funciones.AbrirAdo((Tabla as TADOQuery),StrSQL + strOrden);
  Registros:=Tabla.RecordCount;
  SetLength(ACodigo,Registros);
  SetLength(ADescripcion,Registros);
  Tabla.First;
  While not Tabla.Eof do
  begin
    inc(n);
    ACodigo[n]     := Tabla.fieldByName(CampoCodigo).asInteger;
    ADescripcion[n]:= Tabla.fieldByName(CampoDescripcion).asString;
    Tabla.Next;
  end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.Label29Click(Sender: TObject);
begin
{  BotonRetrocesoClick(nil);
  Posicionar(Edit1.Text);}
  if Label1.Transparent=False then begin Label1Click(Label28); exit; end;
  if Label2.Transparent=False then begin Label1Click(Label1); exit; end;
  if Label3.Transparent=False then begin Label1Click(Label2); exit; end;
  if Label4.Transparent=False then begin Label1Click(Label3); exit; end;
  if Label5.Transparent=False then begin Label1Click(Label4); exit; end;
  if Label6.Transparent=False then begin Label1Click(Label5); exit; end;
  if Label7.Transparent=False then begin Label1Click(Label6); exit; end;
  if Label8.Transparent=False then begin Label1Click(Label7); exit; end;
  if Label9.Transparent=False then begin Label1Click(Label8); exit; end;
  if Label10.Transparent=False then begin Label1Click(Label9); exit; end;
  if Label11.Transparent=False then begin Label1Click(Label10); exit; end;
  if Label12.Transparent=False then begin Label1Click(Label11); exit; end;
  if Label13.Transparent=False then begin Label1Click(Label12); exit; end;
  if Label14.Transparent=False then begin Label1Click(Label13); exit; end;
  if Label15.Transparent=False then begin Label1Click(Label14); exit; end;
  if Label16.Transparent=False then begin Label1Click(Label15); exit; end;
  if Label17.Transparent=False then begin Label1Click(Label16); exit; end;
  if Label18.Transparent=False then begin Label1Click(Label17); exit; end;
  if Label19.Transparent=False then begin Label1Click(Label18); exit; end;
  if Label20.Transparent=False then begin Label1Click(Label19); exit; end;
  if Label21.Transparent=False then begin Label1Click(Label20); exit; end;
  if Label22.Transparent=False then begin Label1Click(Label21); exit; end;
  if Label23.Transparent=False then begin Label1Click(Label22); exit; end;
  if Label24.Transparent=False then begin Label1Click(Label23); exit; end;
  if Label26.Transparent=False then begin Label1Click(Label24); exit; end;
  if Label27.Transparent=False then begin Label1Click(Label26); exit; end;
  if Label28.Transparent=False then begin Label1Click(Label27); exit; end;

end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.Label30Click(Sender: TObject);
begin
  if Label1.Transparent=False then begin Label1Click(Label2); exit; end;
  if Label2.Transparent=False then begin Label1Click(Label3); exit; end;
  if Label3.Transparent=False then begin Label1Click(Label4); exit; end;
  if Label4.Transparent=False then begin Label1Click(Label5); exit; end;
  if Label5.Transparent=False then begin Label1Click(Label6); exit; end;
  if Label6.Transparent=False then begin Label1Click(Label7); exit; end;
  if Label7.Transparent=False then begin Label1Click(Label8); exit; end;
  if Label8.Transparent=False then begin Label1Click(Label9); exit; end;
  if Label9.Transparent=False then begin Label1Click(Label10); exit; end;
  if Label10.Transparent=False then begin Label1Click(Label11); exit; end;
  if Label11.Transparent=False then begin Label1Click(Label12); exit; end;
  if Label12.Transparent=False then begin Label1Click(Label13); exit; end;
  if Label13.Transparent=False then begin Label1Click(Label14); exit; end;
  if Label14.Transparent=False then begin Label1Click(Label15); exit; end;
  if Label15.Transparent=False then begin Label1Click(Label16); exit; end;
  if Label16.Transparent=False then begin Label1Click(Label17); exit; end;
  if Label17.Transparent=False then begin Label1Click(Label18); exit; end;
  if Label18.Transparent=False then begin Label1Click(Label19); exit; end;
  if Label19.Transparent=False then begin Label1Click(Label20); exit; end;
  if Label20.Transparent=False then begin Label1Click(Label21); exit; end;
  if Label21.Transparent=False then begin Label1Click(Label22); exit; end;
  if Label22.Transparent=False then begin Label1Click(Label23); exit; end;
  if Label23.Transparent=False then begin Label1Click(Label24); exit; end;
  if Label24.Transparent=False then begin Label1Click(Label26); exit; end;
  if Label26.Transparent=False then begin Label1Click(Label27); exit; end;
  if Label27.Transparent=False then begin Label1Click(Label28); exit; end;
  if Label28.Transparent=False then begin Label1Click(Label1); exit; end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.ComboOrdenClick(Sender: TObject);
begin
  RellenaBotones(True,'P');
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.FormCreate(Sender: TObject);
begin
//  BotonRetroceso.Left := BotonPrimero.Left;
//  BotonBorrar.Left    := BotonAnterior.Left;
//  ComboOrden.Left     := Edit1.Left;
  ComboOrden.Width    := Edit1.Width;
  ComoCaption         := 2;
  Panel2.Align        := alClient;
  Label25.Align       := alClient;
  Label25.Caption     :='';
  AdvPanel1.Caption.Visible :=False;
  TamanyoX := FormBuscarBotones.Width;
  TamanyoY := FormBuscarBotones.Height;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.ColoresBotones;
var Color1,color2:TColor;
begin
  if (FormAspecto.EstiloTServer)
    then begin
           Color1:= FormAspecto.ColorCIETServer.Color;
           Color2:=Color1;
         end
    else begin
           Color1:= FormAspecto.ColorDegradado.Color;
           Color2:= FormAspecto.ColorDegradado2.Color;
         end;
  if Color1=BntSeleccion1.color
    then exit;

  BntSeleccion1.Caption.Color:=Color1;  BntSeleccion1.Caption.ColorTo:=Color2;
  BntSeleccion2.Caption.Color:=Color1;  BntSeleccion2.Caption.ColorTo:=Color2;
  BntSeleccion3.Caption.Color:=Color1;  BntSeleccion3.Caption.ColorTo:=Color2;
  BntSeleccion4.Caption.Color:=Color1;  BntSeleccion4.Caption.ColorTo:=Color2;
  BntSeleccion5.Caption.Color:=Color1;  BntSeleccion5.Caption.ColorTo:=Color2;
  BntSeleccion6.Caption.Color:=Color1;  BntSeleccion6.Caption.ColorTo:=Color2;
  BntSeleccion7.Caption.Color:=Color1;  BntSeleccion7.Caption.ColorTo:=Color2;
  BntSeleccion8.Caption.Color:=Color1;  BntSeleccion8.Caption.ColorTo:=Color2;
  BntSeleccion9.Caption.Color:=Color1;  BntSeleccion9.Caption.ColorTo:=Color2;
  BntSeleccion10.Caption.Color:=Color1; BntSeleccion10.Caption.ColorTo:=Color2;
  BntSeleccion11.Caption.Color:=Color1; BntSeleccion11.Caption.ColorTo:=Color2;
  BntSeleccion12.Caption.Color:=Color1; BntSeleccion12.Caption.ColorTo:=Color2;
  BntSeleccion13.Caption.Color:=Color1; BntSeleccion13.Caption.ColorTo:=Color2;
  BntSeleccion14.Caption.Color:=Color1; BntSeleccion14.Caption.ColorTo:=Color2;
  BntSeleccion15.Caption.Color:=Color1; BntSeleccion15.Caption.ColorTo:=Color2;
  BntSeleccion16.Caption.Color:=Color1; BntSeleccion16.Caption.ColorTo:=Color2;
  BntSeleccion17.Caption.Color:=Color1; BntSeleccion17.Caption.ColorTo:=Color2;
  BntSeleccion18.Caption.Color:=Color1; BntSeleccion18.Caption.ColorTo:=Color2;
  BntSeleccion19.Caption.Color:=Color1; BntSeleccion19.Caption.ColorTo:=Color2;
  BntSeleccion20.Caption.Color:=Color1; BntSeleccion20.Caption.ColorTo:=Color2;
  BntSeleccion21.Caption.Color:=Color1; BntSeleccion21.Caption.ColorTo:=Color2;
  BntSeleccion22.Caption.Color:=Color1; BntSeleccion22.Caption.ColorTo:=Color2;
  BntSeleccion23.Caption.Color:=Color1; BntSeleccion23.Caption.ColorTo:=Color2;
  BntSeleccion24.Caption.Color:=Color1; BntSeleccion24.Caption.ColorTo:=Color2;
  BntSeleccion25.Caption.Color:=Color1; BntSeleccion25.Caption.ColorTo:=Color2;
  BntSeleccion26.Caption.Color:=Color1; BntSeleccion26.Caption.ColorTo:=Color2;
  BntSeleccion27.Caption.Color:=Color1; BntSeleccion27.Caption.ColorTo:=Color2;

  Panel1.Color:=Color1;     Panel1.ColorTo:=Color2;
  AdvPanel7.Color :=Color1; AdvPanel7.ColorTo:=Color2;
  AdvPanel1.Color :=Color1; AdvPanel1.ColorTo:=Color2;
  ComboOrden.Color:=Color2;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.PonBotones;
var Ancho,Alto, Top,Izq:Integer;
begin
 if FormAspecto.EstamosEnPdas
   then begin
          FormBuscarBotones.Width := Screen.Width;
          FormBuscarBotones.Height:= Screen.Height-10;
          FormBuscarBotones.Top   := 0;
          FormBuscarBotones.Left  := 0;
          Ancho:= trunc(FormBuscarBotones.Width/3)-1;
          Alto := FormBuscarBotones.Height-AdvPanel7.Height-(Label25.Height*2)-20;
          Alto := trunc(Alto/9);
          FormBuscarBotones.Font.Size:=6;
        end
   else begin
          Ancho:= 170;
          Alto := 45;
          FormBuscarBotones.Font.Size:=8;
        end;

 if BntSeleccion1.Width=Ancho
   then exit;
 Top:=0;
 Izq:=1;
 BntSeleccion1.Left:=Izq; BntSeleccion1.Width:=Ancho; BntSeleccion1.Caption.Height:=Alto; BntSeleccion1.Height:=Alto; BntSeleccion1.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion2.Left:=Izq; BntSeleccion2.Width:=Ancho; BntSeleccion2.Caption.Height:=Alto; BntSeleccion2.Height:=Alto; BntSeleccion2.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion3.Left:=Izq; BntSeleccion3.Width:=Ancho; BntSeleccion3.Caption.Height:=Alto; BntSeleccion3.Height:=Alto; BntSeleccion3.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;

 Izq:=1;
 BntSeleccion4.Left:=Izq; BntSeleccion4.Width:=Ancho; BntSeleccion4.Caption.Height:=Alto; BntSeleccion4.Height:=Alto; BntSeleccion4.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion5.Left:=Izq; BntSeleccion5.Width:=Ancho; BntSeleccion5.Caption.Height:=Alto; BntSeleccion5.Height:=Alto; BntSeleccion5.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion6.Left:=Izq; BntSeleccion6.Width:=Ancho; BntSeleccion6.Caption.Height:=Alto; BntSeleccion6.Height:=Alto; BntSeleccion6.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;
 Izq:=1;
 BntSeleccion7.Left:=Izq; BntSeleccion7.Width:=Ancho; BntSeleccion7.Caption.Height:=Alto; BntSeleccion7.Height:=Alto; BntSeleccion7.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion8.Left:=Izq; BntSeleccion8.Width:=Ancho; BntSeleccion8.Caption.Height:=Alto; BntSeleccion8.Height:=Alto; BntSeleccion8.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion9.Left:=Izq; BntSeleccion9.Width:=Ancho; BntSeleccion9.Caption.Height:=Alto; BntSeleccion9.Height:=Alto; BntSeleccion9.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;
 Izq:=1;
 BntSeleccion10.Left:=Izq; BntSeleccion10.Width:=Ancho; BntSeleccion10.Caption.Height:=Alto; BntSeleccion10.Height:=Alto; BntSeleccion10.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion11.Left:=Izq; BntSeleccion11.Width:=Ancho; BntSeleccion11.Caption.Height:=Alto; BntSeleccion11.Height:=Alto; BntSeleccion11.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion12.Left:=Izq; BntSeleccion12.Width:=Ancho; BntSeleccion12.Caption.Height:=Alto; BntSeleccion12.Height:=Alto; BntSeleccion12.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;
 Izq:=1;
 BntSeleccion13.Left:=Izq; BntSeleccion13.Width:=Ancho; BntSeleccion13.Caption.Height:=Alto; BntSeleccion13.Height:=Alto; BntSeleccion13.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion14.Left:=Izq; BntSeleccion14.Width:=Ancho; BntSeleccion14.Caption.Height:=Alto; BntSeleccion14.Height:=Alto; BntSeleccion14.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion15.Left:=Izq; BntSeleccion15.Width:=Ancho; BntSeleccion15.Caption.Height:=Alto; BntSeleccion15.Height:=Alto; BntSeleccion15.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;
 Izq:=1;
 BntSeleccion16.Left:=Izq; BntSeleccion16.Width:=Ancho; BntSeleccion16.Caption.Height:=Alto; BntSeleccion16.Height:=Alto; BntSeleccion16.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion17.Left:=Izq; BntSeleccion17.Width:=Ancho; BntSeleccion17.Caption.Height:=Alto; BntSeleccion17.Height:=Alto; BntSeleccion17.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion18.Left:=Izq; BntSeleccion18.Width:=Ancho; BntSeleccion18.Caption.Height:=Alto; BntSeleccion18.Height:=Alto; BntSeleccion18.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;
 Izq:=1;
 BntSeleccion19.Left:=Izq; BntSeleccion19.Width:=Ancho; BntSeleccion19.Caption.Height:=Alto; BntSeleccion19.Height:=Alto; BntSeleccion19.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion20.Left:=Izq; BntSeleccion20.Width:=Ancho; BntSeleccion20.Caption.Height:=Alto; BntSeleccion20.Height:=Alto; BntSeleccion20.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion21.Left:=Izq; BntSeleccion21.Width:=Ancho; BntSeleccion21.Caption.Height:=Alto; BntSeleccion21.Height:=Alto; BntSeleccion21.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;
 Izq:=1;
 BntSeleccion22.Left:=Izq; BntSeleccion22.Width:=Ancho; BntSeleccion22.Caption.Height:=Alto; BntSeleccion22.Height:=Alto; BntSeleccion22.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion23.Left:=Izq; BntSeleccion23.Width:=Ancho; BntSeleccion23.Caption.Height:=Alto; BntSeleccion23.Height:=Alto; BntSeleccion23.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion24.Left:=Izq; BntSeleccion24.Width:=Ancho; BntSeleccion24.Caption.Height:=Alto; BntSeleccion24.Height:=Alto; BntSeleccion24.Top :=Top; Izq:=Izq+Ancho;
 Top:=Top+Alto;
 Izq:=1;
 BntSeleccion25.Left:=Izq; BntSeleccion25.Width:=Ancho; BntSeleccion25.Caption.Height:=Alto; BntSeleccion25.Height:=Alto; BntSeleccion25.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion26.Left:=Izq; BntSeleccion26.Width:=Ancho; BntSeleccion26.Caption.Height:=Alto; BntSeleccion26.Height:=Alto; BntSeleccion26.Top :=Top; Izq:=Izq+Ancho;
 BntSeleccion27.Left:=Izq; BntSeleccion27.Width:=Ancho; BntSeleccion27.Caption.Height:=Alto; BntSeleccion27.Height:=Alto; BntSeleccion27.Top :=Top; Izq:=Izq+Ancho+9;
 Top:=Top+Alto;
 Panel2.Height:= Top;
 if FormAspecto.EstamosEnPdas=False
  then begin
          FormBuscarBotones.Width := Izq-2;
          FormBuscarBotones.Height:= (Alto*9)+Label1.Height+AdvPanel7.Height+Label25.Height+36;
          SpeedButton1.Left   := FormBuscarBotones.Width-(2*SpeedButton1.Width)-10;
          SpeedButton17.Left  := SpeedButton1.Left+SpeedButton1.Width+1;
       end;
 SpeedButton1.Left   := FormBuscarBotones.Width-(2*SpeedButton1.Width)-10;
 SpeedButton17.Left  := SpeedButton1.Left+SpeedButton1.Width+1;
 Ancho:=trunc(Izq/ 30);
 Izq:=1;
 Label1.Left  :=Izq;   Label1.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label2.Left  :=Izq;   Label2.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label3.Left  :=Izq;   Label3.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label4.Left  :=Izq;   Label4.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label5.Left  :=Izq;   Label5.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label6.Left  :=Izq;   Label6.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label7.Left  :=Izq;   Label7.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label8.Left  :=Izq;   Label8.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label9.Left  :=Izq;   Label9.Width:=Ancho;  Izq:=Izq+Ancho+1;
 Label10.Left  :=Izq;  Label10.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label11.Left  :=Izq;  Label11.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label12.Left  :=Izq;  Label12.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label13.Left  :=Izq;  Label13.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label14.Left  :=Izq;  Label14.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label15.Left  :=Izq;  Label15.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label16.Left  :=Izq;  Label16.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label17.Left  :=Izq;  Label17.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label18.Left  :=Izq;  Label18.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label19.Left  :=Izq;  Label19.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label20.Left  :=Izq;  Label20.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label21.Left  :=Izq;  Label21.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label22.Left  :=Izq;  Label22.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label23.Left  :=Izq;  Label23.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label24.Left  :=Izq;  Label24.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label26.Left  :=Izq;  Label26.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label27.Left  :=Izq;  Label27.Width:=Ancho; Izq:=Izq+Ancho+1;
 Label28.Left  :=Izq;  Label28.Width:=Ancho; Izq:=Izq+Ancho+1;



end;

//------------------------------------------------------------------------------
procedure TFormBuscarBotones.FormShow(Sender: TObject);
begin
  PonBotones;
  if FormAspecto.EstamosEnPdas
    then begin
           ComoCaption :=1;
  //         FormBuscarBotones.Top :=0;
    //       FormBuscarBotones.Left:=0;
         end
    else begin
           ComoCaption :=2;
//           FormBuscarBotones.Scaled:= False;

         end;
   ColoresBotones;
   RellenaBotones(True,'P');
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.MuestraAyuda(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  Label25.Caption:=(Sender as TAdvPanel).Hint;
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Posicionar(Key);
end;
//------------------------------------------------------------------------------
procedure TFormBuscarBotones.SpeedButton1Click(Sender: TObject);
begin
  Codigo      := funciones.DimeCadena(Label25.Caption,1);
  Descripcion := funciones.DimeCadena(Label25.Caption,2);
  AsignarValor;
  ModalResult:=mrOk;
end;
//------------------------------------------------------------------------------
end.
