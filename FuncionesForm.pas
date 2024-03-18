unit FuncionesForm;

interface
uses
  Dialogs, windows, Controls, FileCtrl, {DBTables, }Sysutils, ComObj, DB, StdCtrls, Forms,
  Math, ADODB, Buttons, DBCtrls, ShellAPI, ExtCtrls, PrinterS, Graphics, IdHTTP,
  DateUtils,Messages, Classes, Registry,idMessageClient, IdSMTP, idmessage, IdException,
  IdAttachmentFile;//PideResolucion,

var
  ResolucionX :Integer;
  ResolucionY :Integer;  {Resolucion de Pantalla}
  Resolucion:String;
  EstamosEnPlus : Boolean;
  EstamosEnPDAs : Boolean;
  EstamosEnTerminalServer : Boolean;
  // NORMALES
procedure CierraTeclado;
Procedure MuestraTeclado(Alfabetico,Numerico,permitePunto:Boolean;Origen:TCustomEdit;
               x,y:Integer;Muestratecleado:Byte;Formulario:TForm;EnviaIntro:Boolean;Ira:TWinControl);
Function FormProcesandoActivo:Boolean;
procedure MuestraProcesa(EsPrincipio, EsFinal: Boolean; Pasos: Integer;
                         Cliente, Documento, Procesando: string);
procedure SacaAviso(tiempo: Integer;Texto1,Texto2: string);
procedure PopUpCie(tiempo: Integer;Texto1: string);
procedure Inicializa(Aplicacion, EstoyEnCof_Lonj, IMPRESORATERMINAL_, DirectorioTrabajo_, DirectorioRaiz_: string;
                     ConexionListados : TADOConnection;SqlBusquedaListados:String);
function InputBoxCie(Titulo, Texto, Cadena: string; Minimo, Maximo: Integer): string;
function EntradaTexto(Titulo, Mensage, Defecto, Ultimo: string;
                      Icono, Minimo, Maximo: Integer; MuestraUltimo:Boolean;
                      MuestraTeclado: Byte): string;
function BuscarSQLADO(StrSqlquiere, NombreDeLaTabla, CadenaABuscar,
                   CampoDeLaBusqueda, CampoDelOrden, CampoDelCodigo: string;
                   MostrarSiempre, EnsenyaTextoBusqueda, OrdenDescendente, EsSoloTexto: Boolean;
                   Tabla: TCustomADODataSet; QuierePrecondicion: string): String;
function LLamaListados(Quien: string; deDondeaDonde: Integer;
                       SourceMaestro1, SourceMaestro2,
                       SourceDetalle1, SourceDetalle2, SourceDetalle3: TDataSource;
                       Tabla: TDataset; Filtro: string; DesactivarControles: Boolean;
                       Soporte_NPEF: Char; EMailFax, RutaFicheroPdf,mascara: string;
                       P_I_Todo:Char;Orden,Copias:Integer): Integer;
Function BuscarBotones(TablaAux : TDAtaSet; CampoCodigo,CampoDescripcion : String;
                       Orden : array of string;StrSQL:String;ComoCaption: Byte):String;

//function MuestraConsultaBde(Titulo, SentenciaSQL, Proceso,ExplicaProceso: string;
//                       Modificable: string; var Campo, Campo2, Campo3: string;
//                       CampoAMarcar, Marca: string; TablaAuxEjecutaConsulta: TQuery): string;
function PantallaEnviarEmail(EmailOrigen, EmailDestino, HostSMTP, PuertoSMTP, UsuarioSMTP, PassSMTP,
                           Titulo, Cuerpo: string; DetalleCuerpo,FicherosAdjuntos:
                           TStrings; BorrarFicherosAlEnviar, Fijo: Boolean):String;
procedure SacaTexto(Texto: string);
procedure ListadosTServer(como: integer);

procedure LlamaPaint(RutaFichero: string);
function MessageDlgCie(const Msg: string; DlgType: TMsgDlgType;
                       Botones: TMsgDlgButtons; Defecto: Longint): Integer;
// INTERNET
procedure LlamaCorreoElectronico(Direccionelectronica: string);
procedure InicializaInternetListados(EMailOrigen, Ruta, HostSMTP,
                    PuertoSMTP, UsuarioSMTP, ContrasenaSMTP, Asunto, Cuerpo: string);
function EnviarEMail(EmailorigenAux, EmailDestinoAux, tituloAux,
                     PuertoSMTP, HostSMTP, UsuarioSMTP, PassSMTP, sMensaje: string; slMensaje, slFicherosAdjuntos: TStrings;
                     RegistraEnvio:Byte;TablaSQLAux: TADOQuery;MuestraProgreo:Boolean): string;


// BASE DE DATOS
function PasaTablaATxt(NomFic, DirIn, Separador: string; Entrada: TDataSet; PideForm, ConCabecera: boolean; aFormato: array of string): char;
function PasaTxtATabla(NomFic, DIrIn, DirOut, AccionTXT: string; var Error: string; Separador: char; Salida: TDataSet; PideForm: boolean): Boolean;

// PDA
function EstamosEnPDA :boolean;
procedure MostrarPDA(AClass: TFormClass; PanelPDA: string);
Function AdaptarResolucion ( Ventana : TForm;cPixelsPerInch,cFontHeight,AnchoTiempoDiseno,AltoTiempoDiseno : Integer ):Boolean;

implementation


uses Funciones,  InputBoxCieForm, PreguntaForm, BuscarForm,
     ListadosForm, EnviarEmailForm,
     SacaAvisosForm,
     MessagedlgCieForm,AspectoForm,
     PopUpForm, FuncIdiom, DatosModulo, TxtDataSetForm, Procesando,
  BuscarBotonesForm, TecladoForm;


var Memo,EstoyEn: string;
    EmailsEnviados: Integer;
    DirectorioTrabajo, DirectorioRaiz:String;
    FormProcesandoActivo_:Boolean;


// EstoyEn indica si estoy en oficina central (cofradia) o sucursal (lonja) para diferenciar por ejemplo 2 impresoras
//------------------------------------------------------------------------------

procedure Inicializa(Aplicacion, EstoyEnCof_Lonj, IMPRESORATERMINAL_, DirectorioTrabajo_, DirectorioRaiz_: string;
                     ConexionListados : TADOConnection;SqlBusquedaListados:String);
begin
  EstamosEnPDAs:=False;
  EstamosEnTerminalServer:=False;
  Application.CreateForm(TFormInputBoxCie, FormInputBoxCie);
  Application.CreateForm(TFormPregunta, FormPregunta);
  Application.CreateForm(TFormBuscar, FormBuscar);
  Application.CreateForm(TFormListados, FormListados);
//  FormListados.TablaListados.Connection:= ConexionListados ;
//  FormListados.TablaSQLlist.Connection := ConexionListados ;
//  FormListados.SqlBusquedaListados     := SqlBusquedaListados;
//  FormListados.TablaListados.Active    :=True;
  DirectorioTrabajo       := DirectorioTrabajo_;
  DirectorioRaiz          := DirectorioRaiz_;
  FuerzaCopiasImprimir    := 1;
  QueAplicacion           := Aplicacion;
  EstoyEn                 := EstoyEnCof_Lonj;
  IMPRESORATERMINAL       := IMPRESORATERMINAL_;
  EmailsEnviados := 0;
  memo := '';
  // ----------------------------------------------------------------------
  FuncionesForm.ResolucionX := Screen.Width;
  FuncionesForm.ResolucionY := Screen.Height;
end;
//------------------------------------------------------------------------------
function InputBoxCie(Titulo, Texto, Cadena: string; Minimo, Maximo: Integer): string;
// SI CADENA = ##  ACTUA COMO PETICION DE CONTRASEÑAS
begin
  // Ejemplo InputBoxCie('Entrada de Codigo','Introduzca el codigo a buscar','',3,0);
  if cadena = '##'
    then begin cadena:='';  FormInputBoxCie.Edit1.PasswordChar:='*';   end
    else FormInputBoxCie.Edit1.PasswordChar:=#0;
    
  FormInputBoxCie.Caption := Titulo;
  FormInputBoxCie.Label1.Caption := Texto;
  FormInputBoxCie.Edit1.text := Cadena;
  FormInputBoxCie.Minimo := Minimo;
  FormInputBoxCie.Maximo := maximo;

  if FormInputBoxCie.ShowModal = mrOK
    then Cadena := FormInputBoxCie.Edit1.text
    else Cadena := '';
  Result := Cadena;
end;
//------------------------------------------------------------------------------
function EntradaTexto(Titulo, Mensage, Defecto, Ultimo: string;
                      Icono, Minimo, Maximo: Integer; MuestraUltimo:Boolean;
                      MuestraTeclado: Byte): string;
//MuestraTeclado -> 0 NO Muestra; 1 Pequeño y numerico, 2 Numerico Grande (bmp), 3 alfa-numerico
begin
  FormPregunta.Caption        := Titulo;
  FormPregunta.label1.caption := Mensage;
  FormPregunta.MuestraUltimo  := MuestraUltimo;
  FormPregunta.UltimoValor    := Ultimo;
  FormPregunta.SpeedButton5.Visible := MuestraTeclado>0;
  FormPregunta.SpeedButton5.Tag     := MuestraTeclado;
  if Defecto <> ''
    then FormPregunta.Edit1.text := Defecto
    else FormPregunta.Edit1.text := '';
  if FormPregunta.ShowModal = mrOk
    then Result := FormPregunta.Edit1.text
    else Result := '';
end;
//------------------------------------------------------------------------------
function BuscarSQLAdo(StrSqlquiere, NombreDeLaTabla, CadenaABuscar,
  CampoDeLaBusqueda, CampoDelOrden, CampoDelCodigo: string;
  MostrarSiempre, EnsenyaTextoBusqueda, OrdenDescendente, EsSoloTexto: Boolean;
  Tabla: TCustomADODataSet; QuierePrecondicion: string): String;
begin
  result := FormBuscar.BuscarSQLAdo(StrSqlquiere, NombreDeLaTabla, CadenaABuscar,
                CampoDeLaBusqueda, CampoDelOrden, CampoDelCodigo,Tabla.Connection,
                MostrarSiempre, EnsenyaTextoBusqueda, OrdenDescendente, EsSoloTexto,
                Tabla, QuierePrecondicion)
end;
//------------------------------------------------------------------------------
Function BuscarSQLBDE(StrSqlquiere,NombreDeLaTabla,CadenaABuscar,
                       CampoDeLaBusqueda,CampoDelOrden,CampoDelCodigo,NombreBaseDatos:String;
                       MostrarSiempre,EnsenyaTextoBusqueda,OrdenDescendente,EsSoloTexto:Boolean;
                       Tabla:TDataSet;QuierePrecondicion:String):String;
begin
  result :=FormBuscar.BuscarSQLBDE(StrSqlquiere,NombreDeLaTabla,CadenaABuscar,
                       CampoDeLaBusqueda,CampoDelOrden,CampoDelCodigo,NombreBaseDatos,
                       MostrarSiempre,EnsenyaTextoBusqueda,OrdenDescendente,EsSoloTexto,
                       Tabla,QuierePrecondicion);
end;
//*****************************************************************************
function LLamaListados(Quien: string; DeDondeaDonde: Integer;
                       SourceMaestro1, SourceMaestro2,
                       SourceDetalle1, SourceDetalle2, SourceDetalle3: TDataSource;
                       Tabla: TDataset; Filtro: string; DesactivarControles: Boolean;
                       Soporte_NPEF: Char; EMailFax, RutaFicheroPdf,mascara: string;
                       P_I_Todo:Char;Orden,Copias:Integer): Integer;


// Como = 0 -->Primero-Ultimo   Como = 1 -->Actual-Actual    Como = 2 -->Primero-Actual
// Como = 3 -->Actual-Ultimo    Como = 4 -->Primero-Numero   Como = 5 -->Actual-Numero
// P_I_Todo= P previsualiza en pantalla
// P_I_Todo= I directo a impresora antiguo llamalistadofijo
// P_I_Todo= T lo normal, saca la pantalla de todos los listados

var Aux, Email2: string;
    tipo     : Char;
begin
{
  if RutaFicheroPdf = ''
    then begin
    RutaFicheroPdf := 'C:\Grupocie\email\' + quien + '\' + quien + FormatDatetime('_ddmmyy_hhnnss', now()) + '.pdf';
    RutaFicheroPdf := LimpiaRuta(RutaFicheroPdf);
    Forcedirectories(ExtractFileDir(RutaFicheroPdf));
  end;
  FormListados.IMPRESORATERMINAL := IMPRESORATERMINAL;
  Tipo                       := Upcase(Soporte_NPEF); // si lo queremos normal -> papel, fax, mail pdf
  FormListados.EditMail.Text := '';
  FormListados.EditPDF.Text  := RutaFicheroPdf;
  FormListados.EditFax.Text  := '';
  FormListados.EstoyEn       := EstoyEn;
  Email2                     := EmailFax;
  FormListados.EditMail.Text := '';
  while length(Email2)>0 do
    begin
       Aux := Descomponer(Email2, ';');
       if pos('@', Aux) > 0 //es de internet
        then if FormListados.EditMail.Text=''
                  then FormListados.EditMail.Text := Aux
                  else FormListados.EditMail.Text := FormListados.EditMail.Text+';'+Aux
        else FormListados.EditFax.Text   := Aux;
   end;

  if Tipo = '' then Tipo := 'N'; //Por defecto va por papel

  FormListados.DirectorioTrabajo    := DirectorioTrabajo;
  FormListados.CheckBoxPapel.checked:= False;
  FormListados.CheckBoxFax.checked  := False;
  FormListados.CheckBoxMail.checked := False;
  FormListados.CheckBoxPdf.checked  := False;

  case Tipo of
    'N': FormListados.CheckBoxPapel.checked:= true;
    'P': FormListados.CheckBoxpdf.checked:= true;
    'E': FormListados.CheckBoxMail.checked:= true;
    'F': FormListados.CheckBoxfax.checked:= true;
    'T': begin
           FormListados.CheckBoxPapel.checked:= true;
           FormListados.CheckBoxpdf.checked  := true;
           if FormListados.EditFax.Text<>''
             then FormListados.CheckBoxFax.checked := True;
           if FormListados.EditMail.Text<>''
             then FormListados.CheckBoxMail.checked := True;
         end;
    'B':
  end; //del Case

  if Tipo in ['P', 'F', 'E']
    then ForceDirectories(extractfiledir(RutaFicheroPdf));

  FormListados.Maestro1.DataSource := SourceMaestro1;
  FormListados.Maestro2.DataSource := SourceMaestro2;
  FormListados.Detalle1.DataSource := SourceDetalle1;
  FormListados.Detalle2.DataSource := SourceDetalle2;
  FormListados.Detalle3.DataSource := SourceDetalle3;
  FormListados.IraListado          := Orden;
  FormListados.Quien               := Quien;
  FormListados.CopiasSolicitadas   := Copias;
  FormListados.LabelCopiasSolicitadas.Caption := InttoStr(Copias);
//  FormListados.DesdeHasta := Como;
  FormListados.EditCopias.Text :=InttoStr(Copias);
  if DesactivarControles
    then SourceMaestro1.DataSet.DisableControls;


  case P_I_Todo of
    'T' : FormListados.ShowModal;
//    'P' : if FormListados.CargaListado  then FormList//ados.frxReport1.ShowReport;//Pantalla;
    'P' : begin
            FormListados.PonSources;// FormListados.N1Click(NIL);
            FormListados.PantallaBtnClick(NIL);

          end;

    'I' : begin
            FormListados.PonSources;// FormListados.N1Click(NIL);
            FormListados.Imprimir(False, False, Tipo);//Impresora;
          end;
    'B' : begin
            ForceDirectories(extractfiledir(RutaFicheroPdf));
            FormListados.ImprimirImagen(RutaFicheroPdf);
          end;
    else FormListados.ShowModal;
  end;//del case
  Result := FormListados.Orden;
  if DesactivarControles
    then SourceMaestro1.DataSet.EnableControls;
}
end;

//------------------------------------------------------------------------------
{
function MuestraConsultaBDE(Titulo, SentenciaSQL, Proceso,ExplicaProceso: string;
                            Modificable: String;
                            var Campo, Campo2, Campo3: string;
                            CampoAMarcar, Marca: string; TablaAuxEjecutaConsulta: TQuery): string;
//Titulo de la ventana
//SentenciaSQL para ver que datos va a mostrar
//Proceso si quiere hacer una consulta para hacer algo con una SQL
//Modificable si se pueden o no modificar los datos en el grild
//var Campo,Campo2,Campo3 son tres posible variables o valores que puede devolver
//CampoAMarcar si este proceso tiene que marcar algun campo al pulsar intro,
//  para luego poder hacer algo con ese registro
//Marca si hay que marcar, cual es el valor a poner
var R3, R2: string;
begin
  R3 := ''; R2 := '';   Result := '';
  Application.CreateForm(TFormMuestraConsulta, FormMuestraConsulta);
  FormMuestraConsulta.Modificable    := Modificable;
  FormMuestraConsulta.ExplicaProceso := ExplicaProceso;
  FormMuestraConsulta.SoyADO         := False;
  FormMuestraConsulta.SentenciaSQL   := SentenciaSQL;
  FormMuestraConsulta.Mensage        := Titulo;
  FormMuestraConsulta.Proceso        := Proceso;
  FormMuestraConsulta.TablaParaProcesarBDE   := TablaAuxEjecutaConsulta;
  FormMuestraConsulta.ResultadoBDE.DatabaseName := TablaAuxEjecutaConsulta.DatabaseName;
  if (FormMuestraConsulta.ShowModal = mrOK) and
    (Campo <> '')
    then begin
           Result := FormMuestraConsulta.ResultadoBDE.fieldByName(campo).asString;
           if Campo2 <> ''
              then R2 := FormMuestraConsulta.ResultadoBDE.fieldByName(campo2).asString;
           if Campo3 <> ''
              then R3 := FormMuestraConsulta.ResultadoBDE.fieldByName(campo3).asString
         end;
  Campo2 := R2; Campo3 := R3;
  if CampoAMarcar <> ''
    then begin
           FormMuestraConsulta.ResultadoBDE.Edit;
           FormMuestraConsulta.ResultadoBDE.fieldByName(CampoAMarcar).asString := Marca;
           FormMuestraConsulta.ResultadoBDE.Post;
         end;
  FormMuestraConsulta.Free;
end;
}
//------------------------------------------------------------------------------
Function PantallaEnviarEmail(EmailOrigen, EmailDestino, HostSMTP, PuertoSMTP,
                           UsuarioSMTP, PassSMTP, Titulo, Cuerpo: string;
                           DetalleCuerpo,FicherosAdjuntos: TStrings;
                           BorrarFicherosAlEnviar, Fijo: Boolean):String;
var EnvioOK: Boolean;
begin
  if ((Trim(EmailDestino) = '') or (Trim(HostSMTP) = '')) then
  begin
    MessageDlgCIE('Se debe indicar la Dirección de Correo Electrónico Destino y/o Máquina SMTP.', mtWarning, [mbYes], 0);
    exit;
  end;

  if Trim(PuertoSMTP) = '' then PuertoSMTP := '25';
  if FormEnviarEmail = nil then
  begin
    Application.CreateForm(TFormEnviarEmail, FormEnviarEmail);
    FormEnviarEmail._EmailOrigen  := EmailOrigen;
    FormEnviarEmail._EmailDestino := EmailDestino;
    FormEnviarEmail._HostSMTP     := HostSMTP;
    FormEnviarEmail._PuertoSMTP   := PuertoSMTP;
    FormEnviarEmail._UsuarioSMTP  := UsuarioSMTP;
    FormEnviarEmail._PassSMTP     := PassSMTP;
    FormEnviarEmail._Titulo       := Titulo;
    FormEnviarEmail._Mensaje      := Cuerpo;
    FormEnviarEmail._slMensaje    :=DetalleCuerpo;
    if FicherosAdjuntos<>nil
      then FormEnviarEmail._slFicherosAdjuntos:=FicherosAdjuntos;
  end;

  if Fijo
    then begin
           FormEnviarEmail.EnviarButton1.Enabled:=False;
           FormEnviarEmail.AlphaBlend:=true;
           FormEnviarEmail.AlphaBlendValue:=230;
           FormEnviarEmail.Show;
           EnvioOK := FormEnviarEmail.ReEnviarFicheros;
         end
    else begin
           FormEnviarEmail.EnviarButton1.Enabled:=True;
           FormEnviarEmail.AlphaBlend:=False;
           FormEnviarEmail.ShowModal;
           if FormEnviarEmail.ModalResult = mrOk
             then EnvioOK := True
             else EnvioOK := False;
         end;
  result:=FormEnviarEmail._sError;
  FormEnviarEmail.Free;
  FormEnviarEmail := nil;
  if ((EnvioOK) and (BorrarFicherosAlEnviar))
    then BorrarArchivosTemporalesInternet(FicherosAdjuntos);
end;
//------------------------------------------------------------------------------
procedure SacaTexto(Texto: string);
begin
  Application.CreateForm(TFormSacaAvisos, FormSacaAvisos);
  FormSacaAvisos.Memo1.text := Texto;
  FormSacaAvisos.Showmodal;
  FormSacaAvisos.free;
end;

procedure ListadosTServer(como: integer);
begin
//  Formlistados.EstoyEnTerminalServer := Como;
end;

procedure InicializaInternetListados(EMailOrigen, Ruta, HostSMTP,PuertoSMTP,
                             UsuarioSMTP, ContrasenaSMTP, Asunto, Cuerpo: string);
begin
  FormListados.Internet.Inicializado := True;
  FormListados.Internet.EMailOrigen := EMailOrigen;
  FormListados.Internet.Ruta := Ruta;
  FormListados.Internet.HostSMTP := HostSMTP;
  FormListados.Internet.PuertoSMTP := PuertoSMTP;
  FormListados.Internet.UsuarioSMTP := UsuarioSMTP;
  FormListados.Internet.ContrasenaSMTP := ContrasenaSMTP;
  FormListados.Internet.Asunto := Asunto;
  FormListados.Internet.Cuerpo := Cuerpo;
end;

procedure LlamaPaint(RutaFichero: string);
var Aux: array[0..250] of char;
begin
  RutaFichero := '"' + RutaFichero + '"';
  StrPCopy(Aux, RutaFichero);
  ShellExecute(formlistados.Handle, 'open', 'mspaint.exe', aux, nil, SW_SHOWDEFAULT);
end;

procedure LlamaCorreoElectronico(Direccionelectronica: string);
var Aux: string;
begin
  Aux := 'mailto:' + DireccionElectronica;
  ShellExecute(formlistados.Handle, 'open', PChar(Aux), nil, nil, SW_SHOW);
end;


/////////////////////////////////////////////////////////////////////////////////////////
//  PasaTablaATxt(NomFic,DirIn:String;Separador:char;Entrada:TDataSet;PideForm:boolean,ConCabecera:boolean):char;
//
//  Pasa los  datos de un dataset (Entrada) a un fichero plano  (NomFic)
//  en un directorio (DirIn) con un caracter (Separador) entre cada uno de los campos.
//  (ConCabecera) si es verdadero saca en la primera linea los nombres de los campos
//  Si (PideForm) es verdadero se despliega un formulario para meter los parametros.
//  Formato es una lista con varios string que nos indica como debe salir los datos.
//  Admite los siguientes valores:
//
//
//  La funcion devuelve:
//  0-> Ok, 1->Fallo apertura, 2-> Fallo cabecera, 3->Fallo grabación, 4-> Fallo cierre
/////////////////////////////////////////////////////////////////////////////////////////

function PasaTablaATxt(NomFic, DirIn, Separador: string; Entrada: TDataSet; PideForm, ConCabecera: boolean; aFormato: array of string): char;
var
  i: integer;
  OutFile: TextFile;
  sCadena, sAux: string;
  CamposCabecera: TStringList;
  lHayFormato: Boolean;
begin
  if PideForm then
  begin

    Application.CreateForm(TFormTxTDataset, FormTxTDataset);
    FormTxTDataset.Label3.Visible := False;
    FormTxTDataset.Label5.Visible := False;
    FormTxTDataset.DirOut.Visible := False;
    FormTxTDataset.CbAccionFic.Visible := False;

// Mueve parametros a Form
    FormTxTDataset.NomFic.Text := NomFic;
    FormTxTDataset.Separador.Text := Separador;
    FormTxTDataset.DirIn.Text := DirIn;
    FormTxTDataset.CkConCabecera.Checked := ConCabecera;
//

    FormTxTDataset.ShowModal;
// Mueve parametros de Form
    NomFic := FormTxTDataset.NomFic.Text;
    sAux := FormTxTDataset.Separador.Text;
    Separador := sAux[1];
    DirIn := FormTxTDataset.DirIn.Text;
    ConCabecera := FormTxTDataset.CkConCabecera.Checked;
//
    if FormTxTDataset.Pulsado <> 'Ok' then
    begin
      FormTxTDataset.Free;
      exit;
    end
    else
      FormTxTDataset.Free;
  end;
  Entrada.DisableControls;
  Result := '0';
{$I-}
// Nombre por defecto
  if Trim(NomFic) = '' then
  begin
    NomFic := Entrada.Name + FormatDateTime('-yyyymmddhhnnzzz', Now());
  end;

  lHayFormato := (aFormato[0] <> '');
  try
//Apertura
    Entrada.First;
    AssignFile(OutFile, CambiarSubCadena(DirIn + '\' + NomFic, '\\', '\'));
    Rewrite(OutFile);
// fin apertura
  except
    result := '1';
    CloseFile(OutFile);
    Entrada.Cancel;
    Entrada.EnableControls;
{$I+}
    exit;
  end;
  try
// proceso de generación de cabecera
    CamposCabecera := TStringList.Create; // Creo La lista que contiene los Campos
    Entrada.GetFieldNames(CamposCabecera);
    sCadena := '*' + Separador + CamposCabecera.Strings[0];
    for I := 1 to CamposCabecera.Count - 1 do
    begin
      sCadena := sCadena + Separador + CamposCabecera.Strings[I]
    end;
    if ConCabecera then
    begin
      Writeln(OutFile, sCadena);
    end;
// fin proceso generación de cabecera
  except
    result := '2';
    CloseFile(OutFile);
    Entrada.Cancel;
    Entrada.EnableControls;
{$I+}
    CamposCabecera.Free;
    exit;
  end;
  try
// proceso de generación de datos
    while not (Entrada.Eof) do
    begin
      sCadena := Entrada.FieldByName(CamposCabecera.Strings[0]).AsString;
      for I := 1 to CamposCabecera.Count - 1 do
      begin
        if not lHayFormato then
          sCadena := sCadena + Separador + Entrada.FieldByName(CamposCabecera.Strings[I]).AsString
        else
          sCadena := sCadena + Separador + Formatea(Entrada.FieldByName(CamposCabecera.Strings[I]).AsString, aFormato[I], CamposCabecera.Strings[I]);
      end;
      Writeln(OutFile, scadena);
      Entrada.Next;
    end;
// fin proceso generación de datos
  except
    result := '3';
    CloseFile(OutFile);
    Entrada.Cancel;
    Entrada.EnableControls;
{$I+}
    CamposCabecera.Free;
    exit;
  end;
  try
// Cierre
    CloseFile(OutFile);
    Entrada.First;
// Fin cierre
  except
    result := '4';
  end;
  Entrada.EnableControls;
{$I+}
  CamposCabecera.Free;
end;
///////////////////////////////////////////////////////////////////////////////////////////////
//  PasaTxtATabla(NomFic,DirIn,DirOut,AccionTXT,Error:String;Separador:char;Salida:TDataSet;PideForm:boolean):String;
//
//  Pasa los datos de un fichero plano (DirIn+NomFic) con/sín cabeceras de campo a un dataset (Salida)
//  en un directorio (Path) con un caracter (Separador) entre cada uno de los campos.
//  AccionTXT-> Indica que hacer con el fichero plano: 'B'-> Borrarlo  ''-> Dejarlo como está
//                    'M'-> Moverlo  'R'->Renombrarlo
//  para estas últimas opciones esta el parametro (DirOut).
//  Si (PideForm) es verdadero se despliega un formulario para meter los parametros
//  Devuelve:Boolean -> si False hay error y esta indicado en (Error).
//
///////////////////////////////////////////////////////////////////////////////////////////////

function PasaTxtATabla(NomFic, DirIn, DirOut, AccionTXT: string; var Error: string; Separador: char; Salida: TDataSet; PideForm: boolean): Boolean;
var
  i, j: integer;
  InFile: TextFile;
  sCadena, sAux: string;
  CamposOrigen, CamposDestino: TStringList;
  EstaActDataSet: Boolean;
//  HayCabecera: Boolean;
begin

  if PideForm then
  begin
    Application.CreateForm(TFormTxTDataset, FormTxTDataset);

// Mueve parametros a Form
    FormTxTDataset.NomFic.Text := NomFic;
    FormTxTDataset.Separador.Text := Separador;
    FormTxTDataset.DirIn.Text := DirIn;
    FormTxTDataset.DirOut.Text := DirOut;
    if AccionTxt = '' then FormTxTDataset.CbAccionFic.ItemIndex := 0; //Ninguna;
    if AccionTxt = 'R' then FormTxTDataset.CbAccionFic.ItemIndex := 1; //Renombrar
    if AccionTxt = 'M' then FormTxTDataset.CbAccionFic.ItemIndex := 2; //Mover de directorio
    if AccionTxt = 'B' then FormTxTDataset.CbAccionFic.ItemIndex := 3; //Borrar
    FormTxTDataset.CkConCabecera.visible := false;
//

    FormTxTDataset.ShowModal;
// Mueve parametros de Form
    NomFic := FormTxTDataset.NomFic.Text;
    sAux := FormTxTDataset.Separador.Text;
    Separador := sAux[1];
    DirIn := FormTxTDataset.DirIn.Text;
    DirIn := FormTxTDataset.DirIn.Text;
    DirOut := FormTxTDataset.DirOut.Text;
    AccionTxt := copy(FormTxTDataset.CbAccionFic.Text, 1, 1);
    if AccionTxt = 'N' then AccionTxt := '';

//
    if FormTxTDataset.Pulsado <> 'Ok' then
    begin
      FormTxTDataset.Free;
      exit;
    end
    else
      FormTxTDataset.Free;
  end;
  EstaActDataSet := True;
  Result := True;
//  HayCabecera := False;
{$I-}
  try
// Apertura
    if Salida.Active <> true then
    begin
      Salida.Open;
      EstaActDataSet := False;
    end;
    AssignFile(InFile, CambiarSubCadena(DirIn + '\' + NomFic, '\\', '\'));
    Reset(InFile);
// fin apertura
  except
    result := False;
    Error := 'Error en apertura';
    CloseFile(InFile);
    if EstaActDataSet = false then Salida.Close;
{$I+}
    exit;
  end;

  CamposOrigen := TStringList.Create; // Creo La lista que contiene los Campos
  CamposDestino := TStringList.Create; // Creo La lista que contiene los Campos

  Readln(InFile, sCadena);

// compone Stringlist de nombre de campos entrada
  sAux := Descomponer(sCadena, Separador);
  if sAux = '*' then
  begin
    while sCadena <> '' do
    begin
      CamposOrigen.Add(Descomponer(sCadena, Separador));
    end;
// fin compone Stringlist de nombre de campos entrada

// Compone Stringlist de Destino
    Salida.GetFieldNames(CamposDestino);
    CamposDestino.Sort;
// fin

// -----------------------Proceso de llenado de tabla con cabeceras
    while not (eof(InFile)) do
    begin
      try
        Readln(InFile, sCadena);
        Salida.Insert;
        for I := 0 to CamposDestino.Count - 1 do
        begin
          if CamposDestino.Find(CamposOrigen[i], J) then
            Salida.FieldByName(CamposOrigen.Strings[I]).AsString := Descomponer(sCadena, Separador)
          else Descomponer(sCadena, Separador);
        end;
        Salida.Post;
      except
//        on E: EDbEngineError do
//        begin
//          if funciones.PrimerasLetras(Format('%s.', [E.Message]), 12) <> 'Key violation' then
//          begin
//            Error := Format('%s.', [E.Message]);
//            CloseFile(InFile);
//            if EstaActDataSet = false then Salida.Close;
//            result := False;
//{$I+}
//            CamposOrigen.free;
//            CamposDestino.free;
//            exit;
//          end
//          else
//          begin
//            Error := Error + 'Clave duplicada: ' + Salida.Fields[0].AsString + #13;
//            Salida.Cancel;
//            result := False;
//                 // vuelve a por otro registro
//          end;
//        end;
        on E: EDataBaseError do
        begin
          Error := Format('%s.', [E.Message]);
          CloseFile(InFile);
          if EstaActDataSet = false then Salida.Close;
          result := False;
{$I+}
          CamposOrigen.free;
          CamposDestino.free;
          exit;
        end;
      else
        begin
          Error := 'Error de llenado de tabla';
          CloseFile(InFile);
          if EstaActDataSet = false then Salida.Close;
          result := False;
{$I+}
          CamposOrigen.free;
          CamposDestino.free;
          exit;
        end;
      end; // try
    end; // while
// ----------------Fin Proceso de llenado de tabla con cabecera
    CamposOrigen.free;
    CamposDestino.free;
  end
  else
  begin
//--------- Proceso de llenado de tabla sín cabecera
    Salida.Insert;
    Salida.Fields[0].AsString := sAux;
    for I := 1 to Salida.Fields.Count - 1 do
    begin
      Salida.Fields[I].AsString := Descomponer(sCadena, Separador)
    end;
    Salida.Post;

    while not (eof(InFile)) do
    begin
      try
        Readln(InFile, sCadena);
        Salida.Insert;
        for I := 0 to Salida.Fields.Count - 1 do
        begin
          Salida.Fields[I].AsString := Descomponer(sCadena, Separador)
        end;
        Salida.Post;
      except
//        on E: EDbEngineError do
//        begin
//          if funciones.PrimerasLetras(Format('%s.', [E.Message]), 12) <> 'Key violation' then
//          begin
//            Error := Format('%s.', [E.Message]);
//            CloseFile(InFile);
//            if EstaActDataSet = false then Salida.Close;
//            result := False;
//{$I+}
//            CamposOrigen.free;
//            CamposDestino.free;
//            exit;
//          end
//          else
//          begin
//            Error := Error + 'Clave duplicada: ' + Salida.Fields[0].AsString + #13;
//            Salida.Cancel;
//            result := False;
//                 // vuelve a por otro registro
//          end;
//        end;
        on E: EDataBaseError do
        begin
          Error := Format('%s.', [E.Message]);
          CloseFile(InFile);
          if EstaActDataSet = false then Salida.Close;
          result := False;
{$I+}
          CamposOrigen.free;
          CamposDestino.free;
          exit;
        end;
      else
        begin
          Error := 'Error de llenado de tabla';
          CloseFile(InFile);
          if EstaActDataSet = false then Salida.Close;
          result := False;
{$I+}
          CamposOrigen.free;
          CamposDestino.free;
          exit;
        end;
      end; // try
    end; // while


//---------------- Fin Proceso de llenado de tabla sín cabecera
  end;
// cierre
  try
    if EstaActDataSet = false then Salida.Close;
    CloseFile(InFile);
    sCadena := '';
 // Fin Cierre
  except
    result := False;
    Error := 'Error al cerrar';
{$I+}
    exit;
  end;
  if uppercase(AccionTXT) = 'B' then
    if not DeleteFile(CambiarSubCadena(DirIn + '\' + NomFic, '\\', '\')) then
    begin
      result := False;
      Error := 'Error al borrar fichero';
    end;
  if uppercase(AccionTXT) = 'R' then
    if not RenameFile(CambiarSubCadena(DirIn + '\' + NomFic, '\\', '\'), CambiarSubCadena(DirIn + '\' + Copy(NomFic, 1, pos('.', NomFic) - 1) + '.bkp', '\\', '\')) then
    begin
      result := False;
      Error := 'Error al renombrar fichero';
    end;
  if uppercase(AccionTXT) = 'M' then
    if not RenameFile(CambiarSubCadena(DirIn + '\' + NomFic, '\\', '\'), CambiarSubCadena(DirOut + '\' + NomFic, '\\', '\')) then
    begin
      result := False;
      Error := 'Error al borrar fichero';
    end;
{$I+}
end;


function MessageDlgCie(const Msg: string; DlgType: TMsgDlgType;
                       Botones: TMsgDlgButtons; Defecto: Longint): Integer;//array of TMsgDlgBtn
var
//    dialogUnit:TPoint;
    Bot:TMsgDlgBtn;
//--------------------------------------
  procedure pronunciaDlgType(DlgType: TMsgDlgType);
  begin
    case DlgType of
      mtInformation : Funciones.Habla('Información');
      mtError       : Funciones.Habla('Error');
      mtWarning     : Funciones.Habla('atención');
      mtConfirmation: Funciones.Habla('Confirme');
    end;
  end;
//--------------------------------------
  procedure ponboton(Boton,tag,NrGlyph:Integer;caption:String;Imagen:TImage);
  Var Btn :TspeedButton;
  begin
    case boton of
      1:Btn := FormMessageDlgCIE.BitBtn1;
      2:Btn := FormMessageDlgCIE.BitBtn2;
      3:Btn := FormMessageDlgCIE.BitBtn3;
      4:Btn := FormMessageDlgCIE.BitBtn4;
      5:Btn := FormMessageDlgCIE.BitBtn5;
      6:Btn := FormMessageDlgCIE.BitBtn6;
    end;


    Case Tag of
      mrOk     : FormMessageDlgCIE.Ok.Tag     :=Boton;
      mrCancel : FormMessageDlgCIE.Cancelar.Tag :=Boton;
    end;

    Btn.Caption:=Caption;
    Btn.tag:=tag;
    Btn.Visible:=true;
    Btn.NumGlyphs:=NrGlyph;
    Btn.Glyph:=Imagen.Picture.Bitmap;
    if Defecto=tag
      then begin
             Btn.Font.Style := [fsBold];
             FormMessageDlgCIE.Ok.Tag:=Tag;
           end
      else if boton = 1
           then Btn.Font.Style := [];

  end;
//--------------------------------------
begin
  if (FuncionesForm.EstamosEnPDAs) or (FuncionesForm.EstamosEnTerminalServer)
    then begin
           Result:=Messagedlg(Msg,DlgType,Botones,Defecto);
           exit;
         end;

  Result:=0;
  Application.CreateForm(TFormMessageDlgCIE, FormMessageDlgCIE);
  case Funciones.HablaOrdenador of
    0 : ;//nada
    1 :  pronunciaDlgType(DlgType);
    2 : begin
           pronunciaDlgType(DlgType);
           Funciones.Habla(Msg)
        end;
    3:Funciones.Habla(Msg);
  end;

  FormMessageDlgCIE.Caption:='';
  FormMessageDlgCIE.Ok.tag:=Defecto; //  FormMessageDlgCIE.Ok.Modalresult:=Defecto;
  FormMessageDlgCIE.Label1.caption:=Traduce(Msg);
  case DlgType of
    mtInformation : FormMessageDlgCIE.image1.Picture:=FormAspecto.Informacion.Picture;
    mtError       : FormMessageDlgCIE.image1.Picture:=FormAspecto.Informacion.Picture;
    mtWarning     : FormMessageDlgCIE.image1.Picture:=FormAspecto.Caution.Picture;
    mtConfirmation: FormMessageDlgCIE.image1.Picture:=FormAspecto.Pregunta.Picture;
    else FormMessageDlgCIE.image1.Picture:=NIL;
  end;//del case
  i:=0;
  for Bot := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if Bot in Botones
        then begin
               inc(i);
               case Bot of
                  // si se cambia la Picture acordarse de ajustar el tercer parametro de Ponboton
                  // al numero de imagenes contenidas en la Picture
                  mbOk	     : ponboton(i,mrOk,2,'Ok',FormAspecto.Aceptar2);
                  mbCancel   : ponboton(i,mrCancel,2,'Cancelar',FormAspecto.Cancelar2);
                  mbYes	     : ponboton(i,mrYes,2,'Sí',FormAspecto.Aceptar2);
                  mbNo	     : ponboton(i,mrNo,2,'No',FormAspecto.Cancelar2);
                  mbAbort    : ponboton(i,mrAbort,2,'Abortar',FormAspecto.Cancelar2);
                  mbRetry    : ponboton(i,mrRetry,1,'Reintentar',FormAspecto.Reintentar);
                  mbIgnore   : ponboton(i,mrIgnore,1,'Ignorar',NIL);
                  mbAll	     : ponboton(i,mrAll,1,'Todos',NIL);
                  mbNoToAll  : ponboton(i,mrNoToAll,1,'No a Todo',NIL);
                  mbYesToAll : ponboton(i,mrYesToAll,1,'Sí a Todo',FormAspecto.SiaTodo);
                end;//del case
             end;

  Result := FormMessageDlgCIE.showmodal;
  FormMessageDlgCIE.free;
end;
//------------------------------------------------------------------------------
Function FormProcesandoActivo:Boolean;
begin
  Result:=FormProcesandoActivo_;
end;
//------------------------------------------------------------------------------
procedure MuestraProcesa(EsPrincipio, EsFinal: Boolean; Pasos: Integer;
                         Cliente, Documento, Procesando: string);
// si pasos = -100 -> muestra una pequeña traza de los documentos
//Cliente, Documento, Procesando = @ -> conserva el texto que tuviera
var aux:String;
begin
  if EsPrincipio
    then begin
            Application.CreateForm(TFormProcesando, FormProcesando);
            FormProcesando.Show;
            FormProcesando.AdvPanel1.Caption.Visible:=False;
            FormProcesando.HoraInicio:=Time();
            FormProcesando.HoraInicio2:=FormProcesando.HoraInicio;
            FormProcesando.ProgressBar1.Position := 0;
            FormProcesando.ProgressBar1.Max := Pasos;
            FormProcesando.Label1.Caption:=FormProcesando.Reloj[0];
            FormProcesandoActivo_:=True;
         end;
  if FormProcesando=nil
    then exit;
  if EsFinal
    then begin FormProcesando.Close; FormProcesandoActivo_:=False; end;

  Aux:=formatdatetime('nn:ss:zzz',Time()-FormProcesando.HoraInicio);
  Aux:=Aux+'   '+formatdatetime('nn:ss:zzz',Time()-FormProcesando.HoraInicio2);
  Aux:=InttoStr(FormProcesando.ProgressBar1.Position)+'   '+
       aux+'   '+
       FormProcesando.Documento.Caption+'   '+
       FormProcesando.Cliente.Caption+'   '+
       FormProcesando.Procesando.Caption;
  FormProcesando.Memo1.Text:=FormProcesando.Memo1.Text+Aux+#13+#10;
  FormProcesando.HoraInicio2:=time();
  if Pasos=-100
    then begin
            SacaTexto(FormProcesando.Memo1.Text)
         end;

  FormProcesando.Label1.Caption:=FormProcesando.Reloj[FormProcesando.Label1.tag];
  FormProcesando.Label1.tag:=FormProcesando.Label1.tag+1;
  if FormProcesando.Label1.tag>10 then FormProcesando.Label1.tag:=1;
  FormProcesando.ProgressBar1.Position := FormProcesando.ProgressBar1.Position + 1;
  if Documento<>'@'
    then FormProcesando.Documento.Caption     := Documento;
  if Cliente<>'@'
    then FormProcesando.Cliente.Caption       := Cliente;
  if Procesando<>'@'
    then FormProcesando.Procesando.Caption    := Procesando;
  Application.ProcessMessages;
end;
//------------------------------------------------------------------------------
procedure SacaAviso(tiempo: Integer;Texto1,Texto2: string);
begin
  MuestraProcesa(True, False,1,Texto1,'',Texto2);
  Sleep(tiempo);
  MuestraProcesa(False, True,1,Texto1,'',Texto2);
end;
//------------------------------------------------------------------------------
procedure PopUpCie(tiempo: Integer;Texto1: string);
//tiempo = 1..infinito -> tiempo que dura la pantalla
//tiempo = 0 solo cambia el caption
//tiempo = -1 cierra el formulario
begin
 if FormMensagePop=Nil
    then Application.CreateForm(TFormMensagePop, FormMensagePop);
 if Tiempo > 0
    then  FormMensagePop.Duracion      :=Tiempo;
 FormMensagePop.Label1.Caption:=Texto1;
 application.ProcessMessages;
 case tiempo of
   0:;
   -1: FormMensagePop.close
   else FormMensagePop.show;
 end;
end;
//------------------------------------------------------------------------------
function EstamosEnPDA :Boolean;
{var x,y :integer;
    CambiarResolucion, reso :string;
    FicheroINI : TregIniFile;}
begin
  exit;
{  reso := funciones.ResolucionPantalla(x,y);
  // Para hacer pruebas en Diseño
  FicheroINI := TregIniFile.Create('COFRAWIN');
  CambiarResolucion := FicheroINI.ReadString('OPCIONES', 'Cambiar Resolucion', 'No');

  if (x > 499) AND (CambiarResolucion = 'SI')
  then begin
    if Resolucion = ''
    then begin
        Application.CreateForm(TFormResolucion, FormResolucion);
        FormResolucion.ShowModal;
        if FormResolucion.x > 0
        then begin
          x := FormResolucion.x;
          y := FormResolucion.y;
        end;
        FormResolucion.Free;
    end
    else begin
      x := ResolucionX;
      y := ResolucionY;
    end;
  end;

  ResolucionX := x;
  ResolucionY := y;
  Resolucion:= Reso;
  Result := ResolucionX < 500;}
end;
//------------------------------------------------------------------------------
procedure MostrarPDA(AClass: TFormClass; PanelPDA: string);
// Le pasamos el Panell que contiene la pantalla de PDA y la Clase del formulario
var x,n,I,J : integer;
    tiene_que_verse : boolean;

  function esta_en_Panel_PDA(control :Twincontrol):Boolean;
  begin
      Result := False;
      if Control.HasParent
      then if Control.Parent.Name = PanelPDA
           then Result := True
           Else Result := esta_en_Panel_PDA(Control.Parent);
  end;

begin
  n := 0;
  j := 0;
  for I := Screen.FormCount - 1 downto 0 do
    if Screen.Forms[I] is AClass then J := I;

  for x := 0 to Screen.Forms[J].ComponentCount - 1 do
  begin
    tiene_que_verse := False;
    If (Screen.Forms[J].Components[x] is TWinControl)
      then begin {Si es el Panel PDA lo mostramos}
             if (Screen.Forms[J].Components[x] as TWinControl).Name = PanelPDA
               then begin
                      tiene_que_verse := True;
                      n := x;
                    end;

            {Si está el Panel PDA o en algun objeto del Panel PDA, lo mostramos}
            if (n <> x) and
               (esta_en_Panel_PDA(Screen.Forms[J].Components[x] as TWinControl))
               then tiene_que_verse := True;

      {Si en diseño lo tenemos visible, lo mostramos}
      (Screen.Forms[J].Components[x] as TWinControl).Visible :=
                                    tiene_que_verse
                                    and (Screen.Forms[J].Components[x] as TWinControl).Visible;
    end;
  end;

  Screen.Forms[J].Menu := Nil;
  Screen.Forms[J].Position := poDesktopCenter;
  Screen.Forms[J].HorzScrollBar.Visible := False;
  Screen.Forms[J].VertScrollBar.Visible := False;
  Screen.Forms[J].BorderIcons := [];
  Screen.Forms[J].BorderStyle := bsNone;
  Screen.Forms[J].Caption := '';
  if FuncionesForm.ResolucionX <> (Screen.Forms[J].Components[n] as TWinControl).Width
    then Screen.Forms[J].ScaleBy(FuncionesForm.ResolucionX, (Screen.Forms[J].Components[n] as TWinControl).Width);

  If n > 0
    then (Screen.Forms[J].Components[n] as TWinControl).Top := 0;
 (Screen.Forms[J].Components[n] as TWinControl).Left := 0;
  Screen.Forms[J].Width  := FuncionesForm.ResolucionX;
  Screen.Forms[J].Height := FuncionesForm.ResolucionY;
end;

//------------------------------------------------------------------------------
Function BuscarBotones(TablaAux : TDAtaSet; CampoCodigo,CampoDescripcion : String;
                       Orden : array of string;StrSQL:String;ComoCaption: Byte):String;
//ComoCaption 0 Codigo, 1 Descripcion, 2 Codigo - descripcion                       
var i:Integer;
begin
  Result:='';
  if FormBuscarBotones = Nil
    then Application.CreateForm(TFormBuscarBotones, FormBuscarBotones);

  FormBuscarBotones.ComboOrden.Items.clear;

  for i := 0 to High(Orden) do //nuevo santos 16/01/07
    FormBuscarBotones.ComboOrden.Items.Add(Orden[i]);
  FormBuscarBotones.ComboOrden.ItemIndex:=0;

  FormBuscarBotones.Tabla       := TablaAux;
  FormBuscarBotones.CampoCodigo := CampoCodigo;
  FormBuscarBotones.CampoDescripcion := CampoDescripcion;
  FormBuscarBotones.StrSQL      := StrSQL;
  FormBuscarBotones.Edit1.Text  :='';
  if FormBuscarBotones.ShowModal= mrok
    then Result:= FormBuscarBotones.Codigo+' - '+FormBuscarBotones.Descripcion
end;

//------------------------------------------------------------------------------
Function AdaptarResolucion ( Ventana : TForm;cPixelsPerInch,cFontHeight,AnchoTiempoDiseno,AltoTiempoDiseno :integer ):Boolean;
{Esta función reescala los componentes de una ventana a una nueva resolución}
Var OldFormWidth,A,B: integer;
begin
  Result         := False;
  Ventana.Scaled := true;
  A := Screen.Width;
  B := Screen.Height;
  if A < AnchoTiempoDiseno
    then begin
           Result:=True;
{          OldFormWidth  := Ventana.Width;
           Javier hizo esto
           Ventana.Height:= longint(AltoTiempoDiseno) * longint(B ) DIV AltoTiempoDiseno;
           Ventana.width := longint(AnchoTiempoDiseno) * longint(A ) DIV AnchoTiempoDiseno;
           Ventana.ScaleBy (A-20, AnchoTiempoDiseno );
           Ventana.Font.size := ( AnchoTiempoDiseno DIV OldFormWidth ) * Ventana.font.size;}
           Ventana.ScaleBy (Screen.Width, AnchoTiempoDiseno );
         end;
End;
//////////////////////////////////////////////////////////////////////////////
// EnviarEmail: Función para enviar un solo e-mail con Attachments multiples
// o con ninguno.
// Los parametros son obvios, devuleve un string vacio si ha ido todo bien o en caso
// contrario la descripción del error.
// Graba en un fichero plano los errores (ErrEMail.txt)
// sMensaje se diferencia de slMensaje en que este último permite por parte del usuario
// formatear en lineas el mensaje (saber donde terminan y donde acaban,Lineas en blanco, tabulaciones...)
// mientras que en sMensaje sale al monton.
//---------------------------------------------------------------------------

function EnviarEmail(EmailorigenAux, EmailDestinoAux, tituloAux,
                     PuertoSMTP, HostSMTP, UsuarioSMTP, PassSMTP, sMensaje: string;
                     slMensaje, slFicherosAdjuntos: TStrings;
                     RegistraEnvio:Byte;TablaSQLAux: TADOQuery;MuestraProgreo:Boolean): string;
// RegistraEnvio =1 Registra siempre, 0 Nunca, 2 si bien 3 si mal
var
  i: Integer;
  sError: string;
  servidorSmtp: TIdSMTP;
  mensajeCorreo: TIdMessage;
  TipoEnvio:String;
begin


  RegistraEnvio:=0;
  result:='';
  sError := '';
  if MuestraProgreo
  then PopUpCie(60000,'Conectando...');

  servidorSmtp := TIdSMTP.Create(nil);

  mensajeCorreo := TIdMessage.Create(nil);
  with mensajeCorreo do
  begin
    Subject := TituloAux;
//    Body.Text := 'Cuerpo del correo';
    if (slMensaje <> nil) and (slMensaje.Count > 0)
      then Body.AddStrings(slMensaje)
      else Body.Add(sMensaje);
    From.Address := EmailorigenAux;
    ReplyTo.EMailAddresses := EmailorigenAux;
    Recipients.EMailAddresses := EmailDestinoAux;
    ReceiptRecipient.Text := '';
    Priority := TidMessagePriority(mpHighest);
    if (slFicherosAdjuntos <> nil) and (slFicherosAdjuntos.Count > 0)
      then begin
            i := 0;
            while i < slFicherosAdjuntos.Count do
              begin
                if FileExists(slFicherosAdjuntos.Strings[i])
                  then  TIdAttachmentFile.Create(MessageParts, slFicherosAdjuntos.Strings[i]);
                inc(i);
              end;
            end;
          end;

    with servidorSmtp do
     begin
       Port := StrToInt(PuertoSMTP);
       Host := HostSMTP;
       if Trim(UsuarioSMTP) <> '' then UserNAME := UsuarioSMTP;
       if Trim(PassSMTP) <> '' then Password := PassSMTP;
//       if ((Trim(UsuarioSMTP) <> '') and (Trim(PassSMTP) <> '')) then
//         AuthenticationType := AtLogin;
       AuthType := satDefault; //atNone;
       try
         Connect();
         try
          if MuestraProgreo
            then PopUpCie(0,'Enviando datos...');

           Send(mensajeCorreo);
         finally
         Disconnect;
       end;
       except
//        on E: EIdProtocolReplyError do
//          sError := 'Incorrecto el email o el usuario o la password. Error(' + E.Message + ')';
        on E: EFOpenError do
          sError := 'Fichero Adjunto desconocido o erróneo. Error(' + E.Message + ')';
//        on E: EIdSocketError do
//          sError := 'Host desconocido o incorrecto. Error(' + IntToStr(E.LastError) + ')';
        on E: Exception do
          sError := ' Error(' + E.Message + ')';
        else begin
               sError := 'Fallo en el envio de email (error no perteneciente al protocolo).';
               raise; //para que muestre el error.
             end;
       end;
     end;
     if servidorSmtp.Connected then servidorSmtp.Disconnect;
     if MuestraProgreo
        then PopUpCie(-1,'Desconectando...');

     servidorSmtp.Free;
     mensajeCorreo.Free;

    if not (sError = '')
      then begin
             EscribeFichero('ErrEMail.txt', 'Email dest:'
                            + EmailDestinoAux + '  PuertoSMTP:' + PuertoSMTP + '  UsuarioSMTP:'
                            + UsuarioSMTP + '  Con:' + PassSMTP + ' Desc. Error:' + sError);
            if MuestraProgreo then PopUpCie(500,'ERROR : '+SError);

    Result := sError;
    if sError=''
      then TipoEnvio:='E'
      else TipoEnvio:='R';

 end;

    case ModuloDatos.RegistEmail of
      0 : begin // Nunca registra
          end;
      1 : begin // Registra siempre, l
            RegistraEMail_2(EmailDestinoAux, tituloAux,sMensaje,
                          slMensaje, slFicherosAdjuntos,
                          TipoEnvio,serror,TablaSQLAux);
          end;
      2 : begin // Registra si bien
            if sError=''
              then  RegistraEMail_2(EmailDestinoAux, tituloAux,sMensaje,
                          slMensaje, slFicherosAdjuntos,
                          TipoEnvio,serror,TablaSQLAux);
          end;
      3 : begin // Registra si mal
            if sError<>''
              then  RegistraEMail_2(EmailDestinoAux, tituloAux,sMensaje,
                          slMensaje, slFicherosAdjuntos,
                          TipoEnvio,serror,TablaSQLAux);
          end;

    end;
end;
//------------------------------------------------------------------------------
procedure CierraTeclado;
begin
 // david-jero 20-01-11
 if FormTeclado<>nil then
 begin
    FormTeclado.Close;
    formteclado := nil;
 end;
end;
//------------------------------------------------------------------------------
Procedure MuestraTeclado(Alfabetico,Numerico,permitePunto:Boolean;
                         Origen:TCustomEdit;x,y:Integer;Muestratecleado:Byte;
                         Formulario:TForm;EnviaIntro:Boolean;Ira:TWinControl);
//Muestratecleado:  0 ->NO,    1 -> Sí,   2 -> si pero con redondeles
var Ancho : Integer;
    TextoOriginal:String;
begin
  CierraTeclado;
  Ancho:=0;
  if FormTeclado=Nil
  then begin
          Application.CreateForm(TFormTeclado, FormTeclado);
          //AdaptarResolucion ( Formulario,20,20,Formulario.width,Formulario.height);
  end;

  if Alfabetico then Ancho:=Ancho+FormTeclado.Panel1.Width;
  if Numerico   then Ancho:=Ancho+FormTeclado.Panel2.Width;
  FormTeclado.Width:=Ancho;

  if FormTeclado.Tag=0
    then begin
           FormTeclado.ScaleBy(screen.Width ,1280); //resolucion de cuando estoy programando
           FormTeclado.Tag:= 1;
         end;

  if x>=0
    then FormTeclado.Left := x
    else FormTeclado.Left := screen.Width-FormTeclado.Width-5;
  if y>=0
    then FormTeclado.Top  := y
    else FormTeclado.top  := screen.Height-FormTeclado.Height-35;

  TextoOriginal              := Origen.Text;
  FormTeclado.Panel3.Visible:= Muestratecleado>0;
  FormTeclado.Panel1.Visible := Alfabetico;
  FormTeclado.Panel2.Visible := Numerico;
  FormTeclado.PuedeUsarPunto := permitePunto;
  FormTeclado.EditComodin    := Origen;
  FormTeclado.ira            :=Ira;// TWinControl

  case Muestratecleado of
    1: begin
         FormTeclado.Panel3.Font.Name:='MS Sans Serif';
         FormTeclado.Edit2.Visible   := False;
       end;

    2: begin
         FormTeclado.Panel3.Font.Name:='Wingdings';
         FormTeclado.Edit2.Visible   := true;
       end;
  end;
  FormTeclado.Show;
 { if (FormTeclado.ShowModal=mrOk) and (EnviaIntro)
    then  Formulario.Perform(WM_NEXTDLGCTL,0,0);
  FormTeclado.Free;
  FormTeclado:=Nil;   }
end;
//------------------------------------------------------------------------------

end.


