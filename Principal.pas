// problemas que tengo
{
Los ficheros escaneados no pueden ser muy grandes-> escanear en escala de
  grises y no mucha resolucion para que fast report pueda trabajar con ellos

el componente que imrime le PDF, no se por que NO puede leer los documentos
 hechos con fast report, aí que el fast repor tendrá que imprimr el solo   
}


// Pruebas Jordi

unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvPanel, Buttons, ExtCtrls, AdvMenus, AdvMenuStylers, Menus,
  StdCtrls, ComCtrls, Grids, DBGrids, AdvProgressBar, frxClass, frxDBSet,
  frxPreview, frxExportPDF, frxDesgn, Mask, MaskEdEx,Printers;

type
  TForm1 = class(TForm)
    AdvPanel1: TAdvPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    Edit6: TEdit;
    Label9: TLabel;
    Edit7: TEdit;
    Label10: TLabel;
    Edit8: TEdit;
    SpeedButton2: TSpeedButton;
    Label11: TLabel;
    ComboBox1: TComboBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    AdvPanel2: TAdvPanel;
    SpeedButton1: TSpeedButton;
    FechaDesde: TMaskEditEx;
    FechaHasta: TMaskEditEx;
    AdvMainMenu1: TAdvMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    SpeedButton8: TSpeedButton;
    Acercade1: TMenuItem;
    Acercade2: TMenuItem;
    Label12: TLabel;
    ComboBox2: TComboBox;
    RadioTipoImpresion: TRadioGroup;
    RadioClientes: TRadioGroup;
    CheckImpresionSegunFichaCliente: TCheckBox;

    procedure SimulaTAB;
    procedure Abreseleccion;

    procedure SpeedButton1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Inicializar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DateTimePicker1KeyPress(Sender: TObject; var Key: Char);
    procedure DateTimePicker2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Configuracin1Click(Sender: TObject);

    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Acercade2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

uses DatosModulo,Funciones, ConfiguracionForm, Resultado, AcercaDeForm;

{$R *.dfm}
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin  Close; end;
//------------------------------------------------------------------------------
procedure TForm1.Salir1Click(Sender: TObject);
begin SpeedButton1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TForm1.Inicializar1Click(Sender: TObject);
var STRSQL:String;
begin
  FechaDesde.Text:=FormatDatetime('dd/mm/yy',Date());
  FechaHasta.Text:=FechaDesde.Text;


  Edit3.Text := '';        Edit4.Text := 'ZZ';
  Edit1.Text := '0';       Edit2.Text := '999999999';
  Edit5.Text := '0';       Edit6.Text := '999999999';
  Edit7.Text := '0';       Edit8.Text := '999999999';



//  FechaDesde.Text:='15/01/09';   FechaHasta.Text:='31/01/10';

  FechaDesde.Text:=FormatDateTime('dd/mm/yy', Date());
  FechaHasta.Text:=FormatDateTime('dd/mm/yy', Date());
//  Edit1.Text     :='900015' ;    Edit2.Text     :='900017' ;

//  Edit3.Text     :='RE' ;        Edit4.Text     :='RE' ;   //serie
//  Edit5.Text := '1004';          Edit6.Text := '1004';
//  showmessage('cuidado, nº factura a piñon fijo');


  StrSQL:='SELECT CodigoEmpresa,Empresa FROM Empresas Order By CodigoEmpresa ';
  Funciones.AbrirAdo(ModuloDatos.TablaAux,StrSQL);
  Funciones.RellenaCombo(ComboBox1,ModuloDatos.TablaAux,'CodigoEmpresa','Empresa','','');

  //ComboBox1.Text:=ModuloDatos.EmpresaenUso;
  ComboBox1.ItemIndex:=ModuloDatos.IndiceEmpresaEnUso;

  StrSQL:='SELECT sysUsuario, sysUserName FROM lsysUsuarios ORDER BY sysUsuario ';
  Funciones.AbrirAdo(ModuloDatos.TablaAux,StrSQL);
  Funciones.RellenaCombo(ComboBox2,ModuloDatos.TablaAux,'sysUsuario','sysUserName','','');
  ComboBox2.Text := ModuloDatos.UsuarioLogic;
end;
//------------------------------------------------------------------------------
procedure TForm1.FormShow(Sender: TObject);
begin  Inicializar1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TForm1.SimulaTAB;
begin  Perform(WM_NEXTDLGCTL,0,0); end;
//------------------------------------------------------------------------------
procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin   if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin   if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin   if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin   if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
begin   if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.Edit6KeyPress(Sender: TObject; var Key: Char);
begin   if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.Edit7KeyPress(Sender: TObject; var Key: Char);
begin   if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
{  if ModuloDatos.MessageDlgCie('¿procesamos?', mtConfirmation,
                [mbYes, mbNo],0) = mrYes
   then SpeedButton2Click(NIL)
   else SimulaTAB;
}
end;
//------------------------------------------------------------------------------
procedure TForm1.DateTimePicker1KeyPress(Sender: TObject; var Key: Char);
begin  if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.DateTimePicker2KeyPress(Sender: TObject; var Key: Char);
begin  if Key = #13 then SimulaTAB; end;
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if ModuloDatos.UsuarioLogic=''
    then begin
           MessageDlg('Se necesita un ususario', mtWarning,[mbOk], 0);
           exit;
         end;
  Abreseleccion;
  FormResultado.tipoImpresion:=RadioTipoImpresion.itemIndex;
  //FormResultado.CheckBox6.Checked:=CheckClientesAdjuntanAlbaranes.Checked;

  FormResultado.ImpresionSegunFichacliente:=CheckImpresionSegunFichaCliente.Checked;

  FormResultado.showmodal;
end;
//------------------------------------------------------------------------------
procedure TForm1.Abreseleccion;
var StrSQL,Ruta,Fecha1,Fecha2,Orden:String;
    StrTipoImpresion:string;
    StrClientesAdjuntanAlbaranes:string;
begin
  Fecha1 :=QuotedStr(FechaDesde.Text);
  Fecha2 :=QuotedStr(FechaHasta.Text);
  Empresa:=Funciones.DimeCombo(ComboBox1,1);

  if trim(Edit3.Text) = '' then Edit3.Text:='  ';        //serie Ini
  if trim(Edit4.Text) = '' then Edit4.Text:='  ';        //serie Fin
  if trim(Edit1.Text) = '' then Edit1.Text:='0';         //Fra Ini
  if trim(Edit2.Text) = '' then Edit2.Text:='999999999'; //Fra Fin
  if trim(Edit5.Text) = '' then Edit5.Text:='0';         //Cli Ini
  if trim(Edit6.Text) = '' then Edit6.Text:='999999999'; //Cli Fin
  if trim(Edit7.Text) = '' then Edit7.Text:='0';         //Obra Ini
  if trim(Edit8.Text) = '' then Edit8.Text:='999999999'; //Obra Fin


  Ruta   :=QuotedStr(ModuloDatos.RutaFacturas);
  StrSQL :=QuotedStr('+trim(ResumenCliente.CodigoCliente)+');
  Ruta   :=funciones.CambiarSubCadena(Ruta,'@',StrSQL);
  StrSQL :=QuotedStr(' +ltrim(rtrim(Str(EjercicioFactura)))+ ');
  Ruta   :=funciones.CambiarSubCadena(Ruta,'#',StrSQL);
  StrSQL :=QuotedStr(' +ltrim(rtrim(Str(NumeroFactura)))+ ');
  Ruta   :=funciones.CambiarSubCadena(Ruta,'%',StrSQL);
  StrSQL :=QuotedStr('__')+QuotedStr('+ltrim(rtrim(SerieFactura))+ ');
  Ruta   :=funciones.CambiarSubCadena(Ruta,'$',StrSQL);
  Ruta   :=Ruta+ '+LcDOCPdf.DOCNombrePdfLc  as Ruta ';

  case RadioClientes.ItemIndex of
     0: StrClientesAdjuntanAlbaranes:=' (Clientes.CieAdjuntarAlbaranes = -1) and ';
     1: StrClientesAdjuntanAlbaranes:=' (Clientes.CieAdjuntarAlbaranes =  0) and ';
     2: StrClientesAdjuntanAlbaranes:='  ';
  end;


  {if checkClientesAdjuntanAlbaranes.Checked then
     StrClientesAdjuntanAlbaranes:=' (Clientes.CieAdjuntarAlbaranes = -1) and '
  else
     StrClientesAdjuntanAlbaranes:=' (Clientes.CieAdjuntarAlbaranes = 0) and '
  }

  if moduloDatos.PapelPreImpresoFacturas then
  begin
   case RadioTipoImpresion.ItemIndex of
    0: StrTipoImpresion:= ' (Clientes.CIEEnvioFra = ''P'') and LcDOCPdf.codigoProyecto=''P'' and   ';
    1: StrTipoImpresion:= ' (Clientes.CIEEnvioFra = ''E'') and LcDOCPdf.codigoProyecto=''E'' and ';
    2: StrTipoImpresion:= ' (Clientes.CIEEnvioFra = ''A'') and ';
    3: StrTipoImpresion:= ' (Clientes.CIEEnvioFra <> ''N'') and ';
   end;//del case
  end
  else
  begin
   case RadioTipoImpresion.ItemIndex of
    0: StrTipoImpresion:= ' (Clientes.CIEEnvioFra = ''P'') and ';
    1: StrTipoImpresion:= ' (Clientes.CIEEnvioFra = ''E'') and ';
    2: StrTipoImpresion:= ' (Clientes.CIEEnvioFra = ''A'') and ';
    3: StrTipoImpresion:= ' (Clientes.CIEEnvioFra <> ''N'') and  ';
   end;//del case
  end;



  case ModuloDatos.OrdenSeleccion of
    0: Orden:= 'ORDER BY ResumenCliente.EjercicioFactura,ResumenCliente.SerieFactura,ResumenCliente.NumeroFactura ';
    1: Orden:= 'ORDER BY ResumenCliente.CodigoCliente,ResumenCliente.SerieFactura,ResumenCliente.EjercicioFactura,ResumenCliente.NumeroFactura ';
    2: Orden:= 'ORDER BY ResumenCliente.SerieFactura,ResumenCliente.CodigoCliente,ResumenCliente.EjercicioFactura,ResumenCliente.NumeroFactura ';
    3: Orden:= 'ORDER BY ResumenCliente.RazonSocial,ResumenCliente.SerieFactura,ResumenCliente.EjercicioFactura,ResumenCliente.NumeroFactura ';
    else Orden:= 'ORDER BY ResumenCliente.EjercicioFactura,ResumenCliente.SerieFactura,ResumenCliente.NumeroFactura ';
  end;//del case

  StrSQL:='SELECT ResumenCliente.RazonSocial as RazonSocial,ResumenCliente.CodigoEmpresa , SerieFactura ,NumeroFactura , FechaFactura, '+
                 'ResumenCliente.CodigoCliente as CodigoCliente,EjercicioFactura, LcDOCPdf.DOCNombrePdfLc as FicheroPdf, '+
                 'Clientes.CodigoCliente as CieClienteCadena,'+
                 'ResumenCliente.IdDelegacion,ResumenCliente.CodigoEmpresa,LcDOCPdf.CodigoProyecto as TipoEnvio, '+
                 'Clientes.Email1,Clientes.CieAdjuntarAlbaranes, Clientes.Email2,Clientes.CIEEnvioFra,'+Ruta+
//                 '''jsamper@grupocie.com'' as Email1,Clientes.CieAdjuntarAlbaranes, ''jsamper@grupocie.com'' as Email2,Clientes.CIEEnvioFra,'+Ruta+
                 ', Clientes.CieUnionPdfFrasAlb ';
{ comentado para bertomeu
  StrSQL:='SELECT ResumenCliente.RazonSocial,ResumenCliente.CodigoEmpresa , SerieFactura ,NumeroFactura , FechaFactura, '+
                 'ResumenCliente.CodigoCliente,EjercicioFactura, LcDOCPdf.DOCNombrePdfLc as FicheroPdf, '+
                 'ResumenCliente.IdDelegacion,ResumenCliente.CodigoEmpresa, '+
                 'Clientes.Email1, Clientes.Email2,Clientes.CIEEnvioFra '+','+Ruta+
}
  if modulodatos.UtilizarEmpresaClientes then
  begin
     StrSQL:=StrSQL+'FROM ResumenCliente LEFT OUTER JOIN '+
                     ' LcDOCPdf ON ResumenCliente.CodigoEmpresa = LcDOCPdf.CodigoEmpresa AND ResumenCliente.CodigoCliente = LcDOCPdf.CodigoCliente AND '+
                     ' ResumenCliente.EjercicioFactura = LcDOCPdf.EjercicioDocumentoLc AND ResumenCliente.SerieFactura = LcDOCPdf.SerieDocumentoLc AND '+
                     ' ResumenCliente.NumeroFactura = LcDOCPdf.NumeroDocumentoLc ';
     // JAU - 24/09/2013
     if ModuloDatos.TrabajoConCadenas then
       StrSQL:=StrSQL+' LEFT OUTER JOIN Clientes ON ResumenCliente.CieClienteCadena = Clientes.CodigoCliente '
     else
       StrSQL:=StrSQL+' LEFT OUTER JOIN Clientes ON ResumenCliente.CodigoCliente = Clientes.CodigoCliente ';
  end
  else
  begin
     StrSQL:=StrSQL+'FROM  ResumenCliente LEFT OUTER JOIN '+
                 'LcDOCPdf ON ResumenCliente.CodigoEmpresa = LcDOCPdf.CodigoEmpresa AND ResumenCliente.CodigoCliente = LcDOCPdf.CodigoCliente AND '+
                 'ResumenCliente.EjercicioFactura = LcDOCPdf.EjercicioDocumentoLc AND ResumenCliente.SerieFactura = LcDOCPdf.SerieDocumentoLc AND '+
                 'ResumenCliente.NumeroFactura = LcDOCPdf.NumeroDocumentoLc ';
     // JAU - 24/09/2013
     if ModuloDatos.TrabajoConCadenas then
       StrSQL:=StrSQL+' LEFT OUTER JOIN Clientes ON ResumenCliente.CodigoEmpresa = Clientes.CodigoEmpresa AND ResumenCliente.CieClienteCadena = Clientes.CodigoCliente '
     else
       StrSQL:=StrSQL+' LEFT OUTER JOIN Clientes ON ResumenCliente.CodigoEmpresa = Clientes.CodigoEmpresa AND ResumenCliente.CodigoCliente = Clientes.CodigoCliente ';
  end;

//          'WHERE '+StrClientesAdjuntanAlbaranes+StrTipoImpresion+' (ResumenCliente.CieClienteCadena BETWEEN '+QuotedStr(Edit5.text)+' AND '+QuotedStr(Edit6.text)+') AND '+ //Cliente
  if modulodatos.UtilizarEmpresaClientes then
  begin
     // JAU - 24/09/2013
     StrSQL:=StrSQL+'WHERE '+StrClientesAdjuntanAlbaranes+StrTipoImpresion;
     if ModuloDatos.TrabajoConCadenas then
       StrSQL:=StrSQL+' (ResumenCliente.CieClienteCadena BETWEEN '+QuotedStr(Edit5.text)+' AND '+QuotedStr(Edit6.text)+') AND ' //Cliente
     else
       StrSQL:=StrSQL+' (ResumenCliente.CodigoCliente BETWEEN '+QuotedStr(Edit5.text)+' AND '+QuotedStr(Edit6.text)+') AND '; //Cliente

     StrSQL:=StrSQL+' (FechaFactura  BETWEEN '+Fecha1+               ' AND '+ Fecha2+') AND '+  //Fecha
                 '(NumeroFactura BETWEEN '+Edit1.text+           ' AND '+ Edit2.text+') AND '+ //nº fra
                 '(ResumenCliente.CodigoEmpresa  = '+Empresa+   ') AND '+
                 '(SerieFactura  BETWEEN '+QuotedStr(Edit3.text)+' AND '+ QuotedStr(Edit4.text)+') AND '+ //Series
                 '(ResumenCliente.CodigoComisionista  BETWEEN '+Edit7.text+' AND '+ Edit8.text+') '+ //Comisionista
                 ' AND (Clientes.CodigoEmpresa = '+ModuloDatos.Empresaclientes+') '
  end
  else
  begin
     // JAU - 24/09/2013
     StrSQL:=StrSQL+'WHERE '+StrClientesAdjuntanAlbaranes+StrTipoImpresion;
     if ModuloDatos.TrabajoConCadenas then
       StrSQL:=StrSQL+' (ResumenCliente.CieClienteCadena BETWEEN '+QuotedStr(Edit5.text)+' AND '+QuotedStr(Edit6.text)+') AND ' //Cliente
     else
       StrSQL:=StrSQL+' (ResumenCliente.CodigoCliente BETWEEN '+QuotedStr(Edit5.text)+' AND '+QuotedStr(Edit6.text)+') AND '; //Cliente

     StrSQL:=StrSQL+' (FechaFactura  BETWEEN '+Fecha1+               ' AND '+ Fecha2+') AND '+  //Fecha
                 '(NumeroFactura BETWEEN '+Edit1.text+           ' AND '+ Edit2.text+') AND '+ //nº fra
                 '(ResumenCliente.CodigoEmpresa  = '+Empresa+   ') AND '+
                 '(SerieFactura  BETWEEN '+QuotedStr(Edit3.text)+' AND '+ QuotedStr(Edit4.text)+') AND '+ //Series
                 '(ResumenCliente.CodigoComisionista  BETWEEN '+Edit7.text+' AND '+ Edit8.text+') '; //Comisionista
  end;

{ comentamos esta parte para bertomeu
          'WHERE  (ResumenCliente.CodigoCliente BETWEEN '+QuotedStr(Edit5.text)+' AND '+QuotedStr(Edit6.text)+') AND '+ //Cliente
                 '(FechaFactura  BETWEEN '+Fecha1+               ' AND '+ Fecha2+') AND '+  //Fecha
                 '(NumeroFactura BETWEEN '+Edit1.text+           ' AND '+ Edit2.text+') AND '+ //nº fra
                 '(ResumenCliente.CodigoEmpresa  = '+Empresa+   ') AND '+
                 '(SerieFactura  BETWEEN '+QuotedStr(Edit3.text)+' AND '+ QuotedStr(Edit4.text)+') AND '+ //Series
                 '(ResumenCliente.CodigoComisionista  BETWEEN '+Edit7.text+' AND '+ Edit8.text+') '+ //Comisionista
}
  StrSQL:=StrSQL+Orden;

  FormResultado.memo3.lines.add(StrSQL);
  Funciones.AbrirAdo(ModuloDatos.TablaFacturas,StrSQL);


 { StrSQL:='SELECT  EjercicioAlbaran , SerieAlbaran,  NumeroAlbaran , FechaAlbaran '+
          'FROM    CabeceraAlbaranCliente '+
          'WHERE   (EjercicioFactura = :EjercicioFactura) and '+
                  '(CodigoEmpresa = :CodigoEmpresa) and '+
                  '(SerieFactura = :SerieFactura ) and '+
                  '(NumeroFactura = :NumeroFactura ) ';

{ StrSQL:='SELECT  EjercicioAlbaran , SerieAlbaran,  NumeroAlbaran , FechaAlbaran '+
          'FROM    CabeceraAlbaranCliente '+
          'WHERE   (EjercicioFactura = 2008) and '+
                  '(CodigoEmpresa = 1) and '+
                  '(SerieFactura = 10 ) and '+
                  '(NumeroFactura =  ) ';}
{  if ModuloDatos.TablaAlbaranes.Active
   then ModuloDatos.TablaAlbaranes.Active:=False;
  ModuloDatos.TablaAlbaranes.SQL.Clear;
  ModuloDatos.TablaAlbaranes.SQL.Add(StrSQL);
  ModuloDatos.TablaAlbaranes.Active:=true;}
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
begin
ModuloDatos.EmpresaenUso:=ComboBox1.Text;
ModuloDatos.IndiceEmpresaEnUso:=ComboBox1.ItemIndex;
end;
//------------------------------------------------------------------------------
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
   ModuloDatos.EmpresaenUso:=ComboBox1.Text;
   ModuloDatos.IndiceEmpresaEnUso:=ComboBox1.ItemIndex;

end;
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton3Click(Sender: TObject);
begin  FechaHasta.Text :=FechaDesde.Text end;
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton4Click(Sender: TObject);
begin  Edit4.Text:= Edit3.Text; end;
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton5Click(Sender: TObject);
begin  Edit2.Text:= Edit1.Text; end;
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton6Click(Sender: TObject);
begin  Edit6.Text:= Edit5.Text; end;
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton7Click(Sender: TObject);
begin  Edit8.Text:= Edit7.Text; end;
//------------------------------------------------------------------------------
procedure TForm1.Configuracin1Click(Sender: TObject);
begin
  Application.CreateForm(TFormConfiguracion, FormConfiguracion);
  FormConfiguracion.ShowModal;
  FormConfiguracion.Free;
end;
//------------------------------------------------------------------------------
procedure TForm1.MenuItem5Click(Sender: TObject);
begin SpeedButton1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TForm1.MenuItem2Click(Sender: TObject);
begin  Configuracin1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TForm1.MenuItem3Click(Sender: TObject);
begin Inicializar1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
begin  AdvPanel1.Align:=alClient; end;
//------------------------------------------------------------------------------
procedure TForm1.SpeedButton8Click(Sender: TObject);
begin Configuracin1Click(NIL); end;
//------------------------------------------------------------------------------
procedure TForm1.Acercade2Click(Sender: TObject);
begin
  Application.CreateForm(TFormAcercaDe, FormAcercaDe);
  FormAcercaDe.ShowModal;
  FormAcercaDe.free;
end;
//------------------------------------------------------------------------------
procedure TForm1.ComboBox2Change(Sender: TObject);
begin  ModuloDatos.UsuarioLogic := ComboBox2.Text; end;
//------------------------------------------------------------------------------
procedure TForm1.ComboBox2Click(Sender: TObject);
begin  ModuloDatos.UsuarioLogic := ComboBox2.Text; end;
//------------------------------------------------------------------------------




end.
