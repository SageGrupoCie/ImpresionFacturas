unit ConfiguracionForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl,ExtCtrls, AdvPanel, Buttons, LayeredForm,
  AdvPageControl, ComCtrls,Printers, Mask;

type
  TFormConfiguracion = class(TForm)
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    AdvPanel2: TAdvPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Label13: TLabel;
    Edit5: TEdit;
    Label14: TLabel;
    Edit6: TEdit;
    Label15: TLabel;
    Edit7: TEdit;
    Label16: TLabel;
    Edit8: TEdit;
    AdvTabSheet3: TAdvTabSheet;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Label18: TLabel;
    Edit10: TMaskEdit;
    RadioGroup2: TRadioGroup;
    Edit11: TEdit;
    Label19: TLabel;
    Edit12: TEdit;
    Edit13: TEdit;
    AdvPanel1: TAdvPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    AdvTabSheet4: TAdvTabSheet;
    FontDialog1: TFontDialog;
    AdvTabSheet5: TAdvTabSheet;
    AdvTabSheet6: TAdvTabSheet;
    AdvPanel3: TAdvPanel;
    Label37: TLabel;
    Edit17: TEdit;
    Label17: TLabel;
    Edit9: TEdit;
    SpeedButton4: TSpeedButton;
    AdvPanel4: TAdvPanel;
    Label6: TLabel;
    Edit4: TEdit;
    Label3: TLabel;
    Edit1: TEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    AdvPanel5: TAdvPanel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox1: TCheckBox;
    AdvPanel7: TAdvPanel;
    AdvPanel8: TAdvPanel;
    AdvPanel9: TAdvPanel;
    Label42: TLabel;
    Edit19: TEdit;
    RadioGroup5: TRadioGroup;
    AdvPanelGroup2: TAdvPanelGroup;
    Label43: TLabel;
    Label44: TLabel;
    ListBox3: TListBox;
    Label34: TLabel;
    Edit16: TEdit;
    AdvPanel10: TAdvPanel;
    Label36: TLabel;
    Edit15: TEdit;
    SpeedButton5: TSpeedButton;
    RadioGroup3: TRadioGroup;
    Label35: TLabel;
    Edit14: TEdit;
    AdvPanel11: TAdvPanel;
    Label38: TLabel;
    AdvPanel6: TAdvPanel;
    Label1: TLabel;
    Edit2: TEdit;
    RadioGroup1: TRadioGroup;
    AdvPanelGroup1: TAdvPanelGroup;
    Label25: TLabel;
    Label26: TLabel;
    ListBox1: TListBox;
    Label40: TLabel;
    Label41: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    CheckBox5: TCheckBox;
    Label48: TLabel;
    Label49: TLabel;
    Label39: TLabel;
    Edit18: TEdit;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Label50: TLabel;
    Label51: TLabel;
    RadioGroup4: TRadioGroup;
    CheckBox4: TCheckBox;
    Label52: TLabel;
    ComboBox1: TComboBox;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Edit20: TEdit;
    SpeedButton8: TSpeedButton;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Label56: TLabel;
    Edit24: TEdit;
    Label57: TLabel;
    Edit25: TEdit;
    Label58: TLabel;
    Edit26: TEdit;
    Label59: TLabel;
    Label60: TLabel;
    AdvPanel12: TAdvPanel;
    Label61: TLabel;
    EditImpresoraCopiaFactura: TEdit;
    RadioImpresoraCopiaFactura: TRadioGroup;
    AdvPanelGroup3: TAdvPanelGroup;
    Label62: TLabel;
    Label63: TLabel;
    ListBox2: TListBox;
    CheckPapelPreImpresoFacturas: TCheckBox;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    RadioColorFactura: TRadioGroup;
    RadioBandejaFactura: TRadioGroup;
    RadioBandejaCopiaFactura: TRadioGroup;
    RadioColorCopiaFactura: TRadioGroup;
    Label67: TLabel;
    ComboEmpresa: TComboBox;
    CheckUtilizarClientesEmpresaSeleccionada: TCheckBox;
    trabajoConCadenasCheckBox: TCheckBox;
    Label68: TLabel;
    EditEmailCopia: TEdit;
    Label69: TLabel;
    Edit27: TEdit;
    Label70: TLabel;
    Edit28: TEdit;
    Label71: TLabel;
    Edit29: TEdit;

    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Label45Click(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure CheckBox3Enter(Sender: TObject);
    procedure CheckBox3Exit(Sender: TObject);
    procedure CheckBox2Enter(Sender: TObject);
    procedure CheckBox2Exit(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Edit22Change(Sender: TObject);
    procedure Edit21Change(Sender: TObject);
    procedure Edit24DblClick(Sender: TObject);
    procedure Edit25DblClick(Sender: TObject);
    procedure Edit26DblClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    function GetBinSelection: integer;
    procedure CheckUtilizarClientesEmpresaSeleccionadaClick(Sender: TObject);
    procedure trabajoConCadenasCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    UserCollateCode:integer;
  public
    { Public declarations }
  end;

var
  FormConfiguracion: TFormConfiguracion;

implementation

uses DatosModulo,Funciones;

{$R *.dfm}

procedure TFormConfiguracion.SpeedButton1Click(Sender: TObject);
begin
  ModuloDatos.Conectar(True);
end;

procedure TFormConfiguracion.SpeedButton2Click(Sender: TObject);
var Dir: string;
begin
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], 1000)=False
    then exit;
  Edit4.Text:=Dir;
end;

procedure TFormConfiguracion.SpeedButton3Click(Sender: TObject);
var Dir: string;
begin
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], 1000)=False
    then exit;
  Edit1.Text:=Dir;
end;

procedure TFormConfiguracion.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  if trim(Edit15.Text)=''  then Edit15.Text:='0';
  if trim(Edit16.Text)=''  then Edit16.Text:='99';
  if trim(Edit17.Text)=''  then Edit17.Text:='99';

  ModuloDatos.RutaAlbaranes   := Trim(Edit4.Text);
  ModuloDatos.RutaFacturas    := Trim(Edit1.Text);
  ModuloDatos.Impresora       := Trim(Edit2.Text) ;
  ModuloDatos.ImpresoraFra    := Trim(Edit19.Text) ;
  ModuloDatos.ImpresoraCopiaFra    := Trim(EditImpresoraCopiaFactura.Text) ;
  ModuloDatos.FicheroFRF      := Trim(Edit9.Text) ;
  ModuloDatos.EligeImpresora  := RadioGroup1.ItemIndex;
  ModuloDatos.EligeImpresoraFra  := RadioGroup5.ItemIndex;
  ModuloDatos.EligeImpresoraCopiaFra  := RadioImpresoraCopiaFactura.ItemIndex;

  ModuloDatos.ColorFactura  := RadioColorFactura.ItemIndex;
  ModuloDatos.ColorCopiaFactura  := RadioColorCopiaFactura.ItemIndex;
  ModuloDatos.BandejaFactura  := RadioBandejaFactura.ItemIndex;
  ModuloDatos.BandejaCopiaFactura  := RadioBandejaCopiaFactura.ItemIndex;


  ModuloDatos.NombreFactura  := Edit29.Text;
  ModuloDatos.FastReporDirecto:= CheckBox1.Checked;
  ModuloDatos.OrdenSeleccion  := ComboBox1.ItemIndex ;
  ModuloDatos.SMTPEmailCOPIA := Trim(EditEmailCopia.Text);
  ModuloDatos.SMTPEmailYo := Trim(Edit7.Text);
  ModuloDatos.SMTPPuerto  := Trim(Edit5.Text);
  ModuloDatos.SMTPUsuario := Trim(Edit6.Text);
  ModuloDatos.SMTPPass    := Trim(Edit10.Text);
  ModuloDatos.SMTPAsunto  := Edit8.Text;
  ModuloDatos.SMTPHost    := Trim(Edit3.Text);
  ModuloDatos.SMTPCuerpo1 := Edit11.Text;
  ModuloDatos.SMTPCuerpo2 := Edit12.Text;
  ModuloDatos.SMTPCuerpo3 := Edit13.Text;
  ModuloDatos.UsoEmail    := RadioGroup2.ItemIndex;
  ModuloDatos.RegistEmail := RadioGroup4.ItemIndex;
  ModuloDatos.Copia.FontSize := Edit14.Font.Size;
  ModuloDatos.Copia.FontName := Edit14.Font.Name;
  ModuloDatos.Copia.Color    := Edit14.Font.Color;
  ModuloDatos.Copia.Texto    := Edit14.Text;
  ModuloDatos.RutaImpresionExe := Edit27.Text;
  ModuloDatos.RutaUnificarExe := Edit28.Text;
  ModuloDatos.Copia.Angulo   :=strtoint(Edit15.Text);
  ModuloDatos.Copia.Orden    :=RadioGroup3.ItemIndex;
  ModuloDatos.MaxErrores     :=strtoint(Edit16.Text);
  ModuloDatos.RedudirJPG     :=strtoint(Edit17.Text);
  ModuloDatos.plegadora      :=CheckBox4.checked;
  ModuloDatos.ProgramaReaderPdf:=Edit18.Text;
  ModuloDatos.RutaTemporal   :=trim(Edit20.Text);
  ModuloDatos.RepasaRutaTemporales;
  Edit24.Text:=trim(Edit24.Text);
  if (Edit24.Text='') or (Edit24.Text='0')
    then Edit24.Text:='15';
  ModuloDatos.LongitudCliente:=Strtoint(Edit24.Text);

  Edit25.Text:=trim(Edit25.Text);
  if (Edit25.Text='') or (Edit25.Text='0')
    then Edit25.Text:='10';
  ModuloDatos.LongitudSerieCliente:=Strtoint(Edit25.Text);


  Edit26.Text:=trim(Edit26.Text);
  if (Edit26.Text='') or (Edit26.Text='0')
    then Edit26.Text:='10';
  ModuloDatos.LongitudNumeroCliente:=Strtoint(Edit26.Text);

  ModuloDatos.PapelPreImpresoFacturas:=checkPapelPreImpresoFacturas.Checked;
  ModuloDatos.IndiceEmpresaClientes:=ComboEmpresa.ItemIndex;
  ModuloDatos.UtilizarEmpresaClientes:=CheckUtilizarClientesEmpresaSeleccionada.Checked;
  ModuloDatos.EmpresaClientes:=Funciones.DimeCombo(ComboEmpresa,1);
end;
//------------------------------------------------------------------------------
procedure TFormConfiguracion.FormShow(Sender: TObject);
var
   StrSQL:string;
begin
  ListBox1.Items := printer.Printers;
  ListBox3.Items := printer.Printers;
  ListBox2.Items := printer.Printers;
  Edit4.Text     := ModuloDatos.RutaAlbaranes;
  Edit1.Text     := ModuloDatos.RutaFacturas;
  Edit2.Text     := ModuloDatos.Impresora;
  Edit19.Text    := ModuloDatos.ImpresoraFra;
  EditImpresoraCopiaFactura.Text    := ModuloDatos.ImpresoraCopiaFra;

  Edit9.Text     := ModuloDatos.FicheroFRF;
  RadioGroup1.ItemIndex := ModuloDatos.EligeImpresora;
  RadioGroup5.ItemIndex := ModuloDatos.EligeImpresoraFra;
  RadioImpresoraCopiaFactura.ItemIndex:=ModuloDatos.EligeImpresoraCopiaFra;


  RadioColorFactura.ItemIndex:=ModuloDatos.ColorFactura;
  RadioColorCopiaFactura.ItemIndex:=ModuloDatos.ColorCopiaFactura;
  RadioBandejaFactura.ItemIndex:=ModuloDatos.BandejaFactura;
  RadioBandejaCopiaFactura.ItemIndex:=ModuloDatos.BandejaCopiaFactura;

  Edit27.Text    := ModuloDatos.RutaImpresionExe;
  Edit28.Text    := ModuloDatos.RutaUnificarExe;
  CheckBox1.Checked     := ModuloDatos.fastReporDirecto;
  EditEmailCopia.Text   :=ModuloDatos.SMTPEmailCOPIA;
  Edit7.Text     :=ModuloDatos.SMTPEmailYo;
  Edit5.Text     :=ModuloDatos.SMTPPuerto;
  Edit6.Text     :=ModuloDatos.SMTPUsuario;
  Edit10.Text    :=ModuloDatos.SMTPPass;//   hay que encriptar y desencrptar
  Edit29.Text    :=ModuloDatos.NombreFactura;
  Edit8.Text     :=ModuloDatos.SMTPAsunto;
  Edit11.Text    :=ModuloDatos.SMTPCuerpo1;
  Edit12.Text    :=ModuloDatos.SMTPCuerpo2;
  Edit13.Text    :=ModuloDatos.SMTPCuerpo3;
  Edit3.Text     :=ModuloDatos.SMTPHost;
  RadioGroup2.ItemIndex:=ModuloDatos.UsoEmail;
  RadioGroup4.ItemIndex:=ModuloDatos.RegistEmail;
{  if ModuloDatos.PrioridadEnvios =3
    then RadioGroup3.ItemIndex:=2
    else RadioGroup3.ItemIndex:=ModuloDatos.PrioridadEnvios;}
  Edit21.Text     :=ModuloDatos.SMTPPass;


  Edit14.Font.Size := ModuloDatos.Copia.FontSize;
  Edit14.Font.Name := ModuloDatos.Copia.FontName;
  Edit14.Font.Color:= ModuloDatos.Copia.Color;
//  Edit14.Font.Style:= ModuloDatos.Copia.FontStyle;
  Edit14.Text      := ModuloDatos.Copia.Texto;

  Edit15.Text      := inttoStr(ModuloDatos.Copia.Angulo);
  RadioGroup3.ItemIndex:= ModuloDatos.Copia.Orden;
  ComboBox1.ItemIndex  := ModuloDatos.OrdenSeleccion;

  Edit16.Text      := inttoStr(ModuloDatos.MaxErrores);
  Edit17.Text      := inttoStr(ModuloDatos.RedudirJPG);
  Edit18.Text      := ModuloDatos.ProgramaReaderPdf;
  Edit20.Text      := ModuloDatos.RutaTemporal;
  CheckBox3.Checked:=false;
  CheckBox2.Checked:=false;
  CheckBox4.Checked:=ModuloDatos.plegadora;
  if ModuloDatos.JpgPdf='P'
    then CheckBox3.Checked:=true //Pdf
    else CheckBox2.Checked:=true;//jpg
  Edit24.Text:=InttoStr(ModuloDatos.LongitudCliente);
  Edit25.Text:=InttoStr(ModuloDatos.LongitudSerieCliente);
  Edit26.Text:=InttoStr(ModuloDatos.LongitudNumeroCliente);
  Label38.Enabled := CheckBox3.Checked;
  Label60.Enabled := CheckBox3.Checked;

  checkPapelPreImpresoFacturas.Checked:=ModuloDatos.PapelPreImpresoFacturas;

  StrSQL:='SELECT CodigoEmpresa,Empresa FROM Empresas Order By CodigoEmpresa ';
  Funciones.AbrirAdo(ModuloDatos.TablaAux,StrSQL);
  Funciones.RellenaCombo(ComboEmpresa,ModuloDatos.TablaAux,'CodigoEmpresa','Empresa','','');
  ComboEmpresa.ItemIndex:=ModuloDatos.IndiceEmpresaClientes;
  CheckUtilizarClientesEmpresaSeleccionada.Checked:=ModuloDatos.UtilizarEmpresaClientes;


  CheckUtilizarClientesEmpresaSeleccionada.OnClick(nil);

  // JAU - 24/09/2013
  trabajoConCadenasCheckBox.Checked:=ModuloDatos.TrabajoConCadenas;

end;

procedure TFormConfiguracion.ListBox1DblClick(Sender: TObject);
begin
  Edit2.Text := ListBox1.Items[ListBox1.ItemIndex]
end;




procedure TFormConfiguracion.SpeedButton4Click(Sender: TObject);
begin
  if OpenDialog1.Execute
    then edit9.Text:=OpenDialog1.FileName;
end;

procedure TFormConfiguracion.SpeedButton5Click(Sender: TObject);
begin
  FontDialog1.Font := Edit14.Font;

  if not FontDialog1.Execute
    then Exit;

  Edit14.Font := FontDialog1.Font;
end;

procedure TFormConfiguracion.FormCreate(Sender: TObject);
begin
  AdvPanel4.Align :=alclient;
  AdvPanel10.Align:=alclient;
end;

procedure TFormConfiguracion.ListBox3DblClick(Sender: TObject);
begin
  Edit19.Text := ListBox3.Items[ListBox3.ItemIndex]
end;

procedure TFormConfiguracion.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Tag=0 then exit;
  CheckBox3.Checked:=False;
  CheckBox2.Checked:=True;
  ModuloDatos.JpgPdf:='J';
end;

procedure TFormConfiguracion.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Tag=0 then exit;
  CheckBox3.Checked:=True;
  CheckBox2.Checked:=False;
  ModuloDatos.JpgPdf:='P';
  Label38.Enabled := CheckBox3.Checked;
  Label60.Enabled := CheckBox3.Checked;
 
end;

procedure TFormConfiguracion.Label45Click(Sender: TObject);
begin
  CheckBox2Click(NIL);
end;

procedure TFormConfiguracion.Label41Click(Sender: TObject);
begin
  CheckBox3Click(nil);
end;

procedure TFormConfiguracion.CheckBox3Enter(Sender: TObject);
begin
  CheckBox3.Tag:=1;
  Label38.Enabled := CheckBox3.Checked;
  Label60.Enabled := CheckBox3.Checked;
  
end;

procedure TFormConfiguracion.CheckBox3Exit(Sender: TObject);
begin
  CheckBox3.Tag:=0;
  Label38.Enabled := CheckBox3.Checked;
  Label60.Enabled := CheckBox3.Checked;
end;

procedure TFormConfiguracion.CheckBox2Enter(Sender: TObject);
begin
  CheckBox2.Tag:=1;
end;

procedure TFormConfiguracion.CheckBox2Exit(Sender: TObject);
begin
  CheckBox2.Tag:=0;
end;

procedure TFormConfiguracion.SpeedButton6Click(Sender: TObject);
begin
  if OpenDialog1.Execute=False
    then exit;
  Edit18.Text:=OpenDialog1.FileName;
end;

procedure TFormConfiguracion.SpeedButton7Click(Sender: TObject);
begin
  ModuloDatos.PantallaEnviarEmail(
    Edit7.text,//EmailOrigen,
    'fcorcoles@grupocie.com',//EmailDestino,
    Edit3.text,//HostSMTP,
    Edit5.text,//PuertoSMTP,
    Edit6.text,//UsuarioSMTP,
    Edit10.text,//PassSMTP,
    Edit8.text,//Titulo,
    Edit11.text+#13+Edit12.text+#13+Edit13.text+#13,//Cuerpo: string;
    nil,nil,//DetalleCuerpo,FicherosAdjuntos: TStrings;
    False,False)// BorrarFicherosAlEnviar, Fijo: Boolean);
end;




procedure TFormConfiguracion.SpeedButton8Click(Sender: TObject);
begin
  if OpenDialog1.Execute=False
    then exit;
  Edit20.Text:=OpenDialog1.FileName;

end;

procedure TFormConfiguracion.Edit22Change(Sender: TObject);
begin
  Edit23.Text     :=Funciones.Desencriptar(Edit22.Text,80);
end;

procedure TFormConfiguracion.Edit21Change(Sender: TObject);
begin
  Edit22.Text     :=Funciones.encriptar(Edit21.Text,80);
end;

procedure TFormConfiguracion.Edit24DblClick(Sender: TObject);
begin
  Edit24.Text:=Inputbox('Cambiar Longitud m�xima cliente ','Introduzca el tama�o del codigo del cliente','15');
end;

procedure TFormConfiguracion.Edit25DblClick(Sender: TObject);
begin
  Edit25.Text:=Inputbox('Cambiar Longitud m�xima serie albar�n ','Introduzca el tama�o m�ximo de la serie del albar�n','10');
end;

procedure TFormConfiguracion.Edit26DblClick(Sender: TObject);
begin
  Edit26.Text:=Inputbox('Cambiar Longitud m�xima n�mero albar�n ','Introduzca el tama�o m�ximo del numero de albar�n','10');
end;

procedure TFormConfiguracion.ListBox2DblClick(Sender: TObject);
begin
  EditImpresoraCopiaFactura.Text := ListBox2.Items[ListBox2.ItemIndex]
end;

function TFormConfiguracion.GetBinSelection: integer;
var
     hDevMode: THandle;
     Device,Driver,Port: array [0..1024] of Char;
     bin: integer;
     DevMode : PDevMode;
begin
  Printer.GetPrinter (Device,Driver,Port,hDevMode);
  bin := -1;
  if hDevMode <> 0 then
  begin
        DevMode := GlobalLock (hDevMode);
        //aqui podemos capturar los mienbros de DevMode
        bin := DevMode^.DMDEFAULTSOURCE;
        UserCollateCode := DevMode^.dmCollate;
        GlobalUnlock (hDevMode);
  end;
  result := bin;
end;

procedure TFormConfiguracion.CheckUtilizarClientesEmpresaSeleccionadaClick(Sender: TObject);
begin
   ComboEmpresa.Enabled:=CheckUtilizarClientesEmpresaSeleccionada.Checked;

   if CheckUtilizarClientesEmpresaSeleccionada.Checked then
      ComboEmpresa.color:=clWhite
   else
      ComboEmpresa.color:=clGrayText;


end;

procedure TFormConfiguracion.trabajoConCadenasCheckBoxClick(
  Sender: TObject);
begin
  ModuloDatos.TrabajoConCadenas:=trabajoConCadenasCheckBox.Checked;
end;

end.
