unit EnviarEmailForm;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent,
    IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, idmessage, Buttons,
    IdException, ComCtrls, ImgList, AdvEdit, advlued, AdvListV, paramlst,
    AdvMemo, AdvToolBtn, Menus, AdvMenus, AdvPanel, PictureContainer, ShellApi;

type
    TFormEnviarEmail = class(TForm)
        OpenDialog1: TOpenDialog;
    AdvPopupMenu1: TAdvPopupMenu;
    Adjuntarfichero1: TMenuItem;
    Quitarfichero1: TMenuItem;
    AbrirFichero1: TMenuItem;
    AdvMainMenu1: TAdvMainMenu;
    Archivo1: TMenuItem;
    Salir1: TMenuItem;
    Mensaje1: TMenuItem;
    Enviar1: TMenuItem;
    N1: TMenuItem;
    AdjuntarFichero2: TMenuItem;
    Quitarfichero2: TMenuItem;
    Verfichero1: TMenuItem;
    AdvPanel3: TAdvPanel;
    AdvPanel1: TAdvPanel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    AdvMemo1: TAdvMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    AdvPanel6: TAdvPanel;
    SpeedButton2: TSpeedButton;
    ListaFicheros: TAdvListView;
    AdvPanel2: TAdvPanel;
    EnviarButton1: TSpeedButton;
    Opciones1: TMenuItem;
    RegistraEventos1: TMenuItem;


    procedure FormShow(Sender: TObject);
    function ReEnviarFicheros: Boolean;
    procedure FormCreate(Sender: TObject);
    procedure RellenarListaAdjuntos;
    procedure Inicializa;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Adjuntarfichero1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure EnviarButton1Click(Sender: TObject);
    procedure Enviar1Click(Sender: TObject);
    procedure AdjuntarFichero2Click(Sender: TObject);
    procedure Verfichero1Click(Sender: TObject);
    procedure AbrirFichero1Click(Sender: TObject);
    procedure Quitarfichero2Click(Sender: TObject);
    procedure Quitarfichero1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure RegistraEventos1Click(Sender: TObject);
    private
    { Private declarations }
     lBorrar:Boolean;
    public
    { Public declarations }
        _EmailOrigen,
        _EmailDestino,
        _HostSMTP,
        _PuertoSMTP,
        _UsuarioSMTP,
        _PassSMTP,
        _Titulo,
        _Mensaje: string;
        _slMensaje,
        _slFicherosAdjuntos: TStrings;
        _sError:String;
    end;

var
    FormEnviarEmail: TFormEnviarEmail;

implementation

uses AspectoForm,Funciones, FuncionesForm,ListadosForm{, DataEntorno},
  DatosModulo;

{$R *.dfm}
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.FormShow(Sender: TObject);
var Lista: TListItem;
    permiso,idForm : integer;
begin
{   idForm  := MEntorno.DamePantalla((Sender as TForm).Name,'M',(Sender as TForm).Caption);
   Permiso := MEntorno.DamePermiso(idForm,True);
   case Permiso of
      0: ;                                          // 0 -> Permiso Total
      1:  Funciones.BloquearTablas(Self as TForm);  // 1 -> Solo Lectura
      2: Close;                                     // 2 -> Disable
      3: Close;                                     // 3 -> Invisible
   end;}
    FormEnviarEmail.Top :=Screen.Height- FormEnviarEmail.Height- 25;
    FormEnviarEmail.Left:=Screen.Width - FormEnviarEmail.Width;

    Edit2.Text := _EmailDestino;
    Edit3.Text := _Titulo;
    Edit1.Text := _EmailOrigen;
    if (_slMensaje<>nil) and (_slMensaje.count<>0) then
    ADVMemo1.Lines.AddStrings(_slMensaje) else ADVMemo1.Lines.Add(_Mensaje);
    RellenarListaAdjuntos;
    Inicializa;
    if EnviarButton1.Enabled=False
      then EnviarButton1.Caption:=''
      else EnviarButton1.Caption:='Enviar';

    AdvPanel2.Color  :=FormAspecto.ColorBase.color;
    AdvPanel2.ColorTo:=FormAspecto.ColorBase.color;
    AdvPanel2.Text   :='';
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.FormCreate(Sender: TObject);
begin
  FormEnviarEmail.Left := Screen.Width - FormEnviarEmail.Width - 30;
  FormEnviarEmail.Top := Screen.Height - FormEnviarEmail.Height - 30;
  _slFicherosAdjuntos:=TStringList.Create;
  lBorrar:=False;
end;
//------------------------------------------------------------------------------
function TFormEnviarEmail.ReenviarFicheros: Boolean;
var RegistraEnvio : Byte;
begin
    AdvPanel2.Text:= AdvPanel2.Text+#13+#10+'Enviando e-mail...';
    if FormEnviarEmail.EnviarButton1.Enabled=False // RegistraEnvio =1 Registra siempre, 0 Nunca, 2 si bien 3 si mal
      then RegistraEnvio:=1 // aunque de error lo registramos
      else RegistraEnvio:=2;
    if RegistraEventos1.Checked=False
      then RegistraEnvio:=0;

    Application.ProcessMessages;
    _sError:='';
//    _sError := FuncionesForm.EnviarEmail(Edit1.text,Edit2.text, Edit3.text,_PuertoSMTP,_HostSMTP,_UsuarioSMTP,
//                          _PassSMTP,_Mensaje,_slMensaje, _slFicherosAdjuntos,RegistraEnvio,FormListados.tablasqllist,True);
{    _sError := FuncionesForm.EnviarEmail(Edit1.text,Edit2.text, Edit3.text,_PuertoSMTP,_HostSMTP,_UsuarioSMTP,
                          _PassSMTP,_Mensaje,_slMensaje, _slFicherosAdjuntos,RegistraEnvio,ModuloDatos.TablaAux2,True);}
    _sError := ModuloDatos.EnviarEmail(Edit1.text,Edit2.text, Edit3.text,_PuertoSMTP,_HostSMTP,_UsuarioSMTP,
                          _PassSMTP,_Mensaje,_slMensaje, _slFicherosAdjuntos,RegistraEnvio,ModuloDatos.TablaAux2,True);


    if _sError=''
      then begin
             ModalResult := mrOk; //Close;
             AdvPanel2.Text:= AdvPanel2.Text+#13+#10+'...correo enviado correctamente.';
             AdvPanel2.ColorTo:=FormAspecto.ColorDegradado.Color;
             Application.ProcessMessages;
             sleep(3000);
             Close;

             //Funciones.RegistraEMail(Edit2.text,Edit3.text,AdvMemo1.Lines.Text,nil,nil,'Email','no',)

             {Funciones.RegistraEMail(Edit2.text, Asunto,sMensaje:String;
                       slMensaje, slFicherosAdjuntos: TStrings;
                       TipoEnvio,error:String;TablaSQLAux: TADOQuery): string;}
           end
    else
    begin
        AdvPanel2.ColorTo:=$000B0BFF; // rojo demonio
        AdvPanel2.Text:= AdvPanel2.Text+#13+#10+_sError;
        Application.ProcessMessages;
        if FormEnviarEmail.EnviarButton1.Enabled=False
          then begin
                 sleep(3000);
                 ModalResult := mrCancel;
                 _sError:='';//para que al cerrar, no vuelva a registrar el error
               end;
    end;

end;



procedure TFormEnviarEmail.RellenarListaAdjuntos;
var Lista: TListItem;
    i: Integer;
begin
    if _slFicherosAdjuntos=nil then exit;
    if _slFicherosAdjuntos.count=0 then exit;
    ListaFicheros.Items.BeginUpdate;
    ListaFicheros.Items.Clear;
    for i := 0 to _slFicherosAdjuntos.Count-1 do
    begin
        Lista := ListaFicheros.Items.Add;
        Lista.ImageIndex := 0;
        Lista.Caption := _slFicherosAdjuntos.Strings[i];
        Lista.SubItems.Add(IntToStr(FileLength(_slFicherosAdjuntos.Strings[i])));
    end;
    ListaFicheros.Selected := ListaFicheros.Items[ListaFicheros.Items.Count - 1];
    ListaFicheros.Items.EndUpdate;
    ListaFicheros.SetFocus;
end;

procedure TFormEnviarEmail.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action:=caFree;
  if (_sError<>'')  and (RegistraEventos1.Checked) then
    Funciones.RegistraEMail(Edit2.text, Edit3.text,_Mensaje,_slMensaje, _slFicherosAdjuntos,'R',_sError,ModuloDatos.TablaAux);
//    Funciones.RegistraEMail(Edit2.text, Edit3.text,_Mensaje,_slMensaje, _slFicherosAdjuntos,'R',_sError,FormListados.tablaSQLlist);
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Edit1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if (Key=VK_DELETE)
     then lBorrar:=True;
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    case key of
        #13: Adjuntarfichero1Click(nil);
        #27: close;
    end;
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Edit1KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin lBorrar:=False; end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Adjuntarfichero1Click(Sender: TObject);
begin
    if OpenDialog1.Execute then
    begin
        _slFicherosAdjuntos.Add(OpenDialog1.FileName);
        RellenarListaAdjuntos;
    end;
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Salir1Click(Sender: TObject);
begin  Close; end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.EnviarButton1Click(Sender: TObject);
begin
    Edit1.Color := FormEnviarEmail.Color;
    Edit2.Color := FormEnviarEmail.Color;
    Edit3.Color := FormEnviarEmail.Color;
    ADVMemo1.BKColor := FormEnviarEmail.Color;

    ReenviarFicheros;
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Enviar1Click(Sender: TObject);
begin  EnviarButton1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.AdjuntarFichero2Click(Sender: TObject);
begin Adjuntarfichero1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Inicializa;
begin
  with FormAspecto do
   begin
     FormEnviarEmail.Color   :=ColorBase.color;
     PonBoton(EnviarButton1,nil,1,False,'I','I',False);
     FormAspecto.PonEstiloPanelCIE(FormEnviarEmail,AdvPanel3,false);
     FormAspecto.PonEstiloPanelCabecera(AdvPanel1);
     FormAspecto.PonEstiloPanelCabecera(AdvPanel2);
     FormAspecto.PonEstiloPanelCabecera(AdvPanel6);
     ListaFicheros.HeaderFont:=AdvPanel6.Caption.Font;
     AdvPanel3.Caption.Visible:=false;

   end;
  AdvPanel3.Align:=alclient;
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Verfichero1Click(Sender: TObject);
begin
    if (ListaFicheros.Items.Count=0) then exit;
    try
    if not ListaFicheros.Selected.Selected  then exit;
    except
    exit;
    end;
    if (ListaFicheros.Selected.Index=-1) then exit;

    showmessage(_slFicherosAdjuntos.Strings[ListaFicheros.Selected.Index]);
    ShellExecute(0, 'open', PWideChar(_slFicherosAdjuntos.Strings[ListaFicheros.Selected.Index]), nil, nil, SW_NORMAL);
    //WinExec(PChar(_slFicherosAdjuntos.Strings[ListaFicheros.Selected.Index]), 0);
end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.AbrirFichero1Click(Sender: TObject);
begin Verfichero1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Quitarfichero2Click(Sender: TObject);
begin
    if (ListaFicheros.Items.Count=0) then exit;
    try
    if not ListaFicheros.Selected.Selected then exit;
    except
    exit;
    end;

    if not lBorrar then
    begin
    Quitarfichero2Click(NIL);//AdvListView1DblClick(Sender);
    exit;
    end;
    if (ListaFicheros.Selected.Index=-1) then exit;
    if (MessageDlg('¿Desea retirar el fichero adjunto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
       begin
         _slFicherosAdjuntos.Delete(ListaFicheros.Selected.Index);
         ListaFicheros.Items[ListaFicheros.Selected.Index].Delete;
        end;

end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.Quitarfichero1Click(Sender: TObject);
begin    Quitarfichero2Click(nil); end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.SpeedButton2Click(Sender: TObject);
begin  Adjuntarfichero1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TFormEnviarEmail.RegistraEventos1Click(Sender: TObject);
begin
  RegistraEventos1.Checked:=not(RegistraEventos1.Checked);
end;
//------------------------------------------------------------------------------
end.

