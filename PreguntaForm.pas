unit PreguntaForm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,Funciones, AdvPanel;

type
  TFormPregunta = class(TForm)
    OKBtn: TSpeedButton;
    CancelBtn: TSpeedButton;
    BitBtnRetry: TSpeedButton;
    SpeedButton5: TSpeedButton;
    AdvPanel6: TAdvPanel;
    Ultimo: TLabel;
    ImageBuscar: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtnRetryClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Inicializa;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UltimoValor:String;
    Minimo,Maximo:Integer;
    MuestraUltimo :Boolean;
  end;

var
  FormPregunta      : TFormPregunta;
  TamanyoX,TamanyoY :Integer;
  Escalado  :Boolean;
implementation

uses TecladoNumForm, AspectoForm,FuncionesForm;

{$R *.DFM}
//------------------------------------------------------------------------------
procedure TFormPregunta.Inicializa;
begin
  with FormAspecto do begin
    PonBoton(OkBtn,Aceptar2,2,False,'C','I',False);
    PonBoton(CancelBtn,Cancelar2,2,False,'C','I',False);
    PonBoton(BitBtnRetry,FormAspecto.Reciclar,1,False,'C','I',False);
  end;
  ImageBuscar.Picture:= FormAspecto.Buscar1.Picture;
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.CancelBtnClick(Sender: TObject);
begin Edit1.Text:=''; close; end;
//------------------------------------------------------------------------------
procedure TFormPregunta.FormShow(Sender: TObject);
begin
  if tag=0
    then begin
           Top:=top-180;
           Tag:=1;
         end;
  FormPregunta.Color   :=FormAspecto.ColorBase2.color;
  if FormAspecto.EstiloTServer
    then FormPregunta.Color   :=FormAspecto.ColorCIETServer.Color;

  FormAspecto.PonEstiloPanelCIE(FormPregunta,AdvPanel6,true);

  if MuestraUltimo
    then begin
           if trim(UltimoValor)=''
               then FormPregunta.Ultimo.caption:=''
               else FormPregunta.Ultimo.caption:='F2 -> Último valor : "'+trim(UltimoValor)+'"';
               BitBtnRetry.Visible:=trim(UltimoValor)<>'';
               //if Edit1.text<>'' then BitBtnRetry.Visible:=False;
               BitBtnRetry.Caption:=trim(UltimoValor);
        end
    else begin
           BitBtnRetry.Visible:=False;
           Ultimo.caption:='';
         end;
  Edit1.setfocus;
  label2.Caption:=inttoStr(length(Edit1.Text));
  AdvPanel6.Caption.Visible:=False;
  if FormAspecto.EstamosEnPdas
    then begin
           if (Escalado=False) and
              (FuncionesForm.AdaptarResolucion(FormPregunta,10,10,TamanyoX,TamanyoY))
              then Escalado:=True;
           OKBtn.Caption    :='';
           CancelBtn.Caption:='';
           OKBtn.Height     := 55;
           CancelBtn.Height := 55;
           OKBtn.Top        := BitBtnRetry.Top-15;
           CancelBtn.Top    := BitBtnRetry.Top-15;
         end
    else begin
           FormPregunta.Width := TamanyoX;
           FormPregunta.Height:= TamanyoY;
           OKBtn.Caption      :='Aceptar';
           CancelBtn.Caption  :='Cancelar';
           FormPregunta.Scaled:=False;
           Escalado           :=False;
           OKBtn.Height       := BitBtnRetry.Height;
           CancelBtn.Height   := BitBtnRetry.Height;
           OKBtn.Top          := BitBtnRetry.Top;
           CancelBtn.Top      := BitBtnRetry.Top;
         end;
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.FormCreate(Sender: TObject);
begin
  TamanyoX:= FormPregunta.Width;
  TamanyoY:= FormPregunta.Height;
  Escalado:= False;
  AdvPanel6.Align:=alTop;
  Inicializa;
  MuestraUltimo:=False;
  UltimoValor:='';
  Label3.caption:='';
  
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if (Key=VK_F2) and (trim(UltimoValor)<>'')
    then BitBtnRetryclick(NIL);
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.BitBtnRetryClick(Sender: TObject);
begin
  Edit1.Text  := trim(UltimoValor);
  ModalResult := mrOK;
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.OKBtnClick(Sender: TObject);
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
procedure TFormPregunta.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    Label3.Caption:='';
    if key=#13 then  OKBtnClick(NIL);
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.Edit1KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
 label2.Caption:=inttoStr(length(Edit1.Text));
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then OKBtnClick(nil);
  if key = #27 then Close;
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.SpeedButton5Click(Sender: TObject);
begin
  case SpeedButton5.Tag of
    0 :;
    1 : begin
          if FormTecladoNumerico=Nil
            then Application.CreateForm(TFormTecladoNumerico, FormTecladoNumerico);
          if FormTecladoNumerico.showmodal<>mrOk
            then exit;
          if FormTecladoNumerico.Edit1.text='' then exit;
          Edit1.Text:= FormTecladoNumerico.Edit1.text;
          OKBtnClick(NIL);
        end;
    2 : begin
          funcionesForm.MuestraTeclado(false,true,false,edit1,-1,-1,1,FormPregunta,True,Edit1);
        end;
    3 : begin
          funcionesForm.MuestraTeclado(true,true,false,edit1,-1,-1,1,FormPregunta,True,Edit1);
        end;
  end;
end;
//------------------------------------------------------------------------------
procedure TFormPregunta.Edit1Change(Sender: TObject);
begin
  if pos(#13,edit1.Text)=0
     then exit;
  edit1.Text:= Funciones.QuitaCaracter(Edit1.Text,#13);
end;

end.
