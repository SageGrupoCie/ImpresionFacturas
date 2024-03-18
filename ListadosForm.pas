{ 26/07/2011 13:19:08 (GMT+2:00) > [jaume] checked in TEC: Aadida la funcion AsignaDSFR para asociar los datos del dmPrincipal al Report  }
unit ListadosForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  FileCtrl,
  Dialogs, frxExportCSV, frxExportPDF, frxExportMail, frxExportHTML,
  frxExportXLS, frxExportXML, frxExportRTF, frxExportImage, frxExportText,
  frxClass, frxDBSet, frxADOComponents, frxDMPExport, frxGZip, frxDCtrl,
  frxChart, frxBarcode, frxGradient, frxChBox, frxCross, frxRich, frxOLE,
  frxDesgn, ADODB, StdCtrls, Mask, DBCtrls, ComCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, DB, Menus, Registry, IniFiles, pngimage, frxExportBaseDialog;

const TODOS = 'Todos';
  SELDIRHELP = 1000;  //?
  VERSIONEXPORTAR = 1;   //?

type TInternet = record
    Inicializado: Boolean;
    EMailOrigen: string;
    Ruta: string; //ruta o E-Mail o Nº de Fax
    HostSMTP: string;
    PuertoSMTP: string;
    UsuarioSMTP: string;
    ContrasenaSMTP: string;
    Asunto: string;
    Cuerpo: string;
  end;

type TFicheroDat = record
    Clave: string[20];
    Descripcion: string[55];
    Sql: string[200];
    Sql2: string[200];
    Sql3: string[200];
    Mascara: string[120];
    Configurable: Boolean;
    Formulario: string[20];
    VerAntes: Boolean;
    PideLimites: Boolean;
    Orden: Integer;
    Impresora: string[120];
    ImpresoraLonja: string[120];
    ComoImpresora: string[1];
    CopyCie: string[1];
    Version: Integer;
    Registros: Integer;
  end;

type
  TFRDataSet = array of TfrxDBDataset;

  TFormListados = class(TForm)
    estadoLabel: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    PantallaBtn: TSpeedButton;
    ImprimirBtn: TSpeedButton;
    Label5: TLabel;
    LabelQuien: TLabel;
    ProgressBar1: TProgressBar;
    TablaListados: TADOTable;
    SourceListados: TDataSource;
    TablaSQLList: TADOQuery;
    SourceSQL: TDataSource;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PrintDialog1: TPrintDialog;
    frxReport1: TfrxReport;
    frxReport2: TfrxReport;
    frxDesigner1: TfrxDesigner;
    frxOLEObject1: TfrxOLEObject;
    frxRichObject1: TfrxRichObject;
    frxCrossObject1: TfrxCrossObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxGradientObject1: TfrxGradientObject;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxChartObject1: TfrxChartObject;
    frxDialogControls1: TfrxDialogControls;
    frxGZipCompressor1: TfrxGZipCompressor;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxUserDataSet1: TfrxUserDataSet;
    frxADOComponents1: TfrxADOComponents;
    Maestro1: TfrxDBDataset;
    Maestro2: TfrxDBDataset;
    Detalle1: TfrxDBDataset;
    Detalle2: TfrxDBDataset;
    Detalle3: TfrxDBDataset;
    SQL: TfrxDBDataset;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxGIFExport1: TfrxGIFExport;
    frxBMPExport1: TfrxBMPExport;
    frxRTFExport1: TfrxRTFExport;
    frxXMLExport1: TfrxXMLExport;
    frxXLSExport1: TfrxXLSExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxMailExport1: TfrxMailExport;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    TablaSQL: TfrxDBDataset;
    paginas: TPageControl;
    Descripcion: TTabSheet;
    Opciones: TTabSheet;
    Panel3: TPanel;
    AsignarFichero: TSpeedButton;
    DisenarBtn: TSpeedButton;
    SalvarBtn: TSpeedButton;
    NuevoBtn: TSpeedButton;
    DBNavigator2: TDBNavigator;
    Panel5: TPanel;
    Memo1: TMemo;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    Fuentes: TTabSheet;
    Mascaras: TTabSheet;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    Editar1: TMenuItem;
    VerTodos1: TMenuItem;
    N1: TMenuItem;
    VistaPreliminar: TMenuItem;
    N4: TMenuItem;
    Imprimir2: TMenuItem;
    Imprimir1: TMenuItem;
    N13: TMenuItem;
    Foto1: TMenuItem;
    N2: TMenuItem;
    Salir1: TMenuItem;
    Herramientas1: TMenuItem;
    AsignarMascara1: TMenuItem;
    SalvarMascara1: TMenuItem;
    Disear1: TMenuItem;
    N6: TMenuItem;
    VerTodosAntesdeImprimir1: TMenuItem;
    NoVerNingunoAntesdeImprimir1: TMenuItem;
    N11: TMenuItem;
    ImportarTiposdeListado1: TMenuItem;
    ImportarTodoslosListados1: TMenuItem;
    ImportarTodoslosListadossinohay1: TMenuItem;
    N14: TMenuItem;
    ExportarListados1: TMenuItem;
    N12: TMenuItem;
    RefrescarImpresoras1: TMenuItem;
    AsignarImpresoraExportacinTextoPDFTXT1: TMenuItem;
    AsignarImpresoraFax1: TMenuItem;
    Registros1: TMenuItem;
    VerenLista1: TMenuItem;
    Panel6: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    mascaraDBEdit: TDBEdit;
    VerAntes: TDBCheckBox;
    descripcionDBEdit: TDBEdit;
    ordenDBEdit: TDBEdit;
    impresoraDBEdit: TDBEdit;
    imprimirPorDBRadioGroup: TDBRadioGroup;
    ImpresorasListBox: TListBox;
    impresoraLonjaDBEdit: TDBEdit;
    DBGridListados2: TDBGrid;
    Panel7: TPanel;
    Label16: TLabel;
    ImageArriba: TImage;
    ImageAbajo: TImage;
    Label28: TLabel;
    DestinoBtn: TSpeedButton;
    Label34: TLabel;
    DBGridListados: TDBGrid;
    Desde: TRadioGroup;
    hasta: TRadioGroup;
    EditCopias: TEdit;
    RadioGroupTipoListado: TRadioGroup;
    EditEmailFax: TEdit;
    EditarEmail: TCheckBox;
    EditPDF: TEdit;
    Panel8: TPanel;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Maestro1L: TLabel;
    Maestro2L: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Detalle1L: TLabel;
    Detalle2L: TLabel;
    Detalle3L: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    GroupBox5: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    LabelFax: TLabel;
    LabelEMail: TLabel;
    Label35: TLabel;
    LabelQuiere: TLabel;
    Label33: TLabel;
    LabelRutaPDF: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    cambiaRutaBtn: TSpeedButton;
    cambiaTextoBtn: TSpeedButton;
    CambiarA: TRadioGroup;
    GroupBox1: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label24: TLabel;
    cambiarEdit: TEdit;
    porEdit: TEdit;
    GroupBox2: TGroupBox;
    rutaBtn: TSpeedButton;
    rutaEdit: TEdit;
    alImportarDBRadioGroup: TDBRadioGroup;
    Panel9: TPanel;
    Label20: TLabel;
    cambiaFicheroBtn: TSpeedButton;
    cambiaMascaraBtn: TSpeedButton;
    GroupBox4: TGroupBox;
    DBText1: TDBText;
    Label21: TLabel;
    ficheroEdit: TEdit;
    logoImage: TImage;

    Function  DameNOrden(Clave:String):Integer;
    procedure FiltraTabla;
    Function  CambiaNombre(Pregunta,CambiarFichero:Boolean):Boolean;
    Function  CargaListado:Boolean;
    procedure VerNoVer(Ver:Boolean);
    function  ExisteImpresoraWin(Impresora:String):Integer;
    procedure ImprimirConPregunta;
    procedure Imprimir(directo, MuestraDirecto: Boolean; Destino: Char);
    procedure PonSources;
    procedure Etiquetas;
    procedure ImprimirBtnClick(Sender: TObject);
    procedure PantallaBtnClick(Sender: TObject);
    procedure DisenarBtnClick(Sender: TObject);
    procedure SalvarBtnClick(Sender: TObject);
    procedure AsignarFicheroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SalirBtnClick(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure RefrescarImpresoras1Click(Sender: TObject);
    procedure ImageArribaClick(Sender: TObject);
    procedure ImageAbajoClick(Sender: TObject);
    procedure DestinoBtnClick(Sender: TObject);
    procedure PonVariablesBien;
    procedure LeerImpresoraPDF;
    procedure ImpresorasListBoxDblClick(Sender: TObject);
    procedure AsignarImpresoraExportacinTextoPDFTXT1Click(Sender: TObject);
    procedure AsignarImpresoraFax1Click(Sender: TObject);
    procedure DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
    procedure VerTodos1Click(Sender: TObject);
    procedure NuevoBtnClick(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
    procedure DBGridListadosKeyPress(Sender: TObject; var Key: Char);
    procedure TablaListadosNewRecord(DataSet: TDataSet);
    procedure GenerarFichero;
    procedure EnviarMail(verAntes:Boolean);
    procedure ExportarListados1Click(Sender: TObject);
    procedure ImportarListados(Todos:Char);
    procedure ImportarTiposdeListado1Click(Sender: TObject);
    procedure ImportarTodoslosListados1Click(Sender: TObject);
    procedure ImportarTodoslosListadossinohay1Click(Sender: TObject);
    procedure EditEmailFaxExit(Sender: TObject);
    procedure RadioGroupTipoListadoClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure rutaBtnClick(Sender: TObject);
    procedure cambiaFicheroBtnClick(Sender: TObject);
    procedure cambiaMascaraBtnClick(Sender: TObject);
    procedure cambiaRutaBtnClick(Sender: TObject);
    procedure cambiaTextoBtnClick(Sender: TObject);
    procedure CambiaPath(EsPorDirectorio:Boolean);
    procedure Foto1Click(Sender: TObject);
    procedure ordenDBEditChange(Sender: TObject);
    procedure VerTodosAntesdeImprimir1Click(Sender: TObject);
    procedure NoVerNingunoAntesdeImprimir1Click(Sender: TObject);
    procedure TablaListadosBeforePost(DataSet: TDataSet);
    procedure AsignaDSFR;
  private     { Private declarations }
    CurPage: Integer;
    _Destino:Integer;

  public      { Public declarations }
    Orden,IraListado: Integer;
    ListadoFijo: string[5]; // si quiero uno determinado
    Quien: string;
    EstoyEn: string; // EstoyEn indica si estoy en oficina central (cofradia) o sucursal (lonja) para diferenciar por ejemplo 2 impresoras

    IMPRESORATERMINAL: string;
    Internet: TInternet;
    SqlBusquedaListados: string;
    FRDataSet: TFRDataSet;
    sAnfitrion: string;
    slDataSets: TStringList;
    FormAnfitrion: Tform;
    FRDataSetAnfitrion: TFRxDataSet;
    lHayError: Boolean;
    CopiasSolicitadas:Integer;
    VecesLlamado : Integer;
    TipoListado:Integer;
    RutaFicheroPDF:String;
    DesdeHasta : Integer;
  end;

var
  FormListados: TFormListados;
  DirectorioAplicacion,Mascara : String;
  ImpresoraPDF, ImpresoraFAX, RutaFicheroPDF: string;
  wx,wy,nx: Integer;
  ofx,ofy,OldV,OldH: Integer;
  rg: HRgn;
  per: Double;
  mode: (mdNone,mdPageWidth,mdOnePage,mdTwoPages);
  PaintAllowed: Boolean;
  PaintPart: Boolean;
  DrawMode: (dmDraw,dmFind);
  COPIAS : INTEGER;
  obj_Mutex: THandle;

implementation

uses
  Printers, aspectoForm,
  ShellAPI,funciones, FuncionesForm, DatosModulo;

{$R *.dfm}


Function TFormListados.DameNOrden(Clave:String):Integer;
var TablaSQLAux: TADOQuery;
begin
  TablaSQLAux := TADOQuery.Create(Self);
  TablaSQLAux.Connection := TablaListados.Connection;
  TablaSQLAux.SQL.Add('SELECT Max([Orden]) AS Numero FROM Listados WHERE (((Listados.Clave)=''' + Clave + '''))');
  TablaSQLAux.Open;
  if TablaSQLAux.RecordCount = 0
    then Result := 0
  else Result := TablaSQLAux.FieldbyName('Numero').asInteger + 1;
  TablaSQLAux.Active := False;
  TablaSQLAux.Free;
end;


procedure TFormListados.ordenDBEditChange(Sender: TObject);
begin
  Orden:=TablaListados.FieldbyName('Orden').asInteger;
end;

procedure TFormListados.DBGridListadosKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then  Imprimir(True,False,'N');
end;

procedure TFormListados.DBNavigator2Click(Sender: TObject;
  Button: TNavigateBtn);
begin
 if Button = nbInsert
  then   descripcionDBEdit.SetFocus;
end;

procedure TFormListados.DestinoBtnClick(Sender: TObject);
begin
  if SaveDialog1.Execute then EditEmailFax.Text := SaveDialog1.FileName;
end;

procedure TFormListados.FiltraTabla;
begin
  if TablaListados.Active
    then TablaListados.Close;
  TablaListados.filter := 'Clave = ' + '''' + Quien + '''';
  TablaListados.filtered := true;
  if Quien = TODOS
    then TablaListados.filtered := False;
  TablaListados.Open;
  if TablaListados.RecordCount>0 then
    TablaListados.Locate('Orden', IraListado, []);
end;

procedure TFormListados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //  FreeAndNil(FormListados); ahora es showmodal .. se libera pero no se iguala a nil
end;

procedure TFormListados.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  paginas.Align            := alClient;
  ProgressBar1.Align       := alBottom;
  estadolabel.Align        := alBottom;
  paginas.ActivePageIndex  := 0;
  VecesLlamado             :=0;

  LeerImpresoraPDF;

  //DirectorioTrabajo := ExtractFilePath(Application.ExeName);  // de momento donde está el ejecutable

  ImpresorasListBox.Items := printer.Printers;

  FormListados.Width := 715; // con logo
  FormListados.Height := 440;

//  SaveDialog1.InitialDir := DirectorioTrabajo;
//  OpenDialog1.InitialDir := DirectorioTrabajo;

  rutaEdit.text := ''; cambiarEdit.text := '';
  porEdit.text := ''; ficheroEdit.text := '';
  EditPdf.text := '';
  EditEmailFax.text := '';

  ProgressBar1.Visible := False;
  estadolabel.Visible := False;
  estadolabel.Caption := '';
  LabelQuien.Caption := TODOS;

  FormatSettings.DecimalSeparator := SimboloDecimal;
  FormatSettings.ThousandSeparator := SimboloNoDecimal;
//  Sysutils.DecimalSeparator := ',';
//  Sysutils.ThousandSeparator := '.';

  Internet.Inicializado := False;
  Mascara := '';
  Editar1Click(nil);
  Quien := '';

  if TipoListado in [0..4] then
     RadioGroupTipoListado.ItemIndex:=TipoListado
  else
     RadioGroupTipoListado.ItemIndex:=0;


//  if not AsignaDSFRhecho then // solo ejecutamos una vez la asignacion o se duplican los datasets en el report
//    AsignaDSFR;

//  ImprimirBtn.Glyph   := FormAspecto.Imprimir32.Picture.Bitmap;
//  PantallaBtn.Glyph   := FormAspecto.Pantalla32.Picture.Bitmap;

  TablaListados.Open;

  ImpresorasListBox.Items:=printer.Printers;
  PonSources;

end;

procedure TFormListados.FormShow(Sender: TObject);
begin
  VerTodos1.Checked:=False;
  paginas.ActivePage:=Descripcion;
  PonSources;
  if EstoyEn='L' then
    Label26.Caption:='Impresora de Lonja'
  else
    Label26.Caption:='Impresora';

  EditarEmail.Visible:=RadioGroupTipoListado.ItemIndex=2;  LabelQuien.Caption := Quien;
  FiltraTabla;
  PonVariablesBien
end;

procedure TFormListados.Foto1Click(Sender: TObject);
begin
  //ImprimirFormulario(Self);
end;

procedure TFormListados.LeerImpresoraPDF;
begin
//  ImpresoraPDF := FicheroINI.ReadString('IMPRESION', 'ImpresoraPDF', '');
  Label29.caption := 'PDF: ' + ImpresoraPDF;
//  ImpresoraFAX := FicheroINI.ReadString('IMPRESION', 'ImpresoraFAX', '');
  Label30.caption := 'FAX: ' + ImpresoraFAX;
end;
procedure TFormListados.ImpresorasListBoxDblClick(Sender: TObject);
var Aux : String;
begin
  Aux:='\\';
  if Pos(Aux,ImpresorasListBox.Items[ImpresorasListBox.ItemIndex ])>0
    then Aux:=ImpresorasListBox.Items[ImpresorasListBox.ItemIndex ]
    else Aux:='\\'+DameNombrePC+'\'+ImpresorasListBox.Items[ImpresorasListBox.ItemIndex];
  TablaListados.Edit;
  if EstoyEn='L'
     then TablaListados.FieldByName('ImpresoraLonja').asstring:=Aux //Si estoy en la Lonja
     else TablaListados.FieldByName('Impresora').asstring:=Aux;//Si estoy en la Cofradía
  TablaListados.Post;
end;

procedure TFormListados.NoVerNingunoAntesdeImprimir1Click(Sender: TObject);
begin
  VerNoVer(False);
end;

procedure TFormListados.NuevoBtnClick(Sender: TObject);
begin
  frxReport2.DesignReport;
end;

//------------------------------------------------------------------------------

procedure TFormListados.AsignarImpresoraExportacinTextoPDFTXT1Click(
  Sender: TObject);
begin
   if ImpresorasListBox.ItemIndex>=0 then
   begin
      ImpresoraPDF:=ImpresorasListBox.Items.Strings[ImpresorasListBox.ItemIndex];
//      FicheroINI.WriteString('IMPRESION','ImpresoraPDF',ImpresoraPDF);
      Label29.caption:='PDF: '+ImpresoraPDF;
   end
   else
      Showmessage('Seleccione una Impresora.');
end;

procedure TFormListados.AsignarImpresoraFax1Click(Sender: TObject);
begin
   if ImpresorasListBox.ItemIndex>=0 then
   begin
      ImpresoraFAX:=ImpresorasListBox.Items.Strings[ImpresorasListBox.ItemIndex];
//      FicheroINI.WriteString('IMPRESION','ImpresoraFAX',ImpresoraFAX);
      Label30.caption:='FAX: '+ImpresoraFAX;
   end
   else
      Showmessage('Seleccione una Impresora.');
end;

procedure TFormListados.cambiaFicheroBtnClick(Sender: TObject);
begin
  CambiaNombre(True,True);
end;

procedure TFormListados.cambiaMascaraBtnClick(Sender: TObject);
begin
  CambiaNombre(True,False);
end;

procedure TFormListados.rutaBtnClick(Sender: TObject);
Var Dir: string;
begin
  Dir := 'C:\';
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
  rutaEdit.text := Dir;
end;

function TFormListados.CambiaNombre(Pregunta, CambiarFichero: Boolean): Boolean;
var dir, nam: string;
  Cambia: Boolean;
begin
  Result := false;
  dir := TablaListados.FieldbyName('Mascara').asString;
  Nam := ExtractfileName(dir);
  Dir := ExtractfileDir(dir);
  Nam := Dir + '\' + ficheroEdit.Text + nam;
//  if Pregunta then
//    if MensPregunta('¿Desea Cambiar?'+#13+TablaListados.FieldbyName('Mascara').asString+'  por'+#13+Nam) = False then
//      exit;
  Cambia := true;
  if CambiarFichero then
    if not RenameFile(TablaListados.FieldbyName('Mascara').asString, Nam) then
    begin
      Showmessage('Error al cambiar nombre'+#13+TablaListados.FieldbyName('Mascara').asString +'  por' + #13 + Nam);
      Cambia := False;
    end;
  if Cambia = false then exit;

  TablaListados.Edit;
  TablaListados.FieldbyName('Mascara').asString := Nam;
  TablaListados.Post;
  Result := True
end;

procedure TFormListados.cambiaRutaBtnClick(Sender: TObject);
begin
   cambiaPath(true);
end;

procedure TFormListados.cambiaTextoBtnClick(Sender: TObject);
begin
   cambiaPath(false);
end;
//------------------------------------------------------------------------------
procedure TFormListados.CambiaPath(EsPorDirectorio:Boolean);
var bien : Boolean;
    aux,Aux2  : String;
    Cambios : Integer;
begin
  Bien:=False;
  Cambios:=0;
  if EsPorDirectorio then
     if rutaEdit.text='' then
        MessageDlg('NO Hay Nada para Cambiar', mtWarning,[mbOk], 0)
     else Bien:=true
  else
     if cambiarEdit.text=''then
         MessageDlg('NO Hay Nada para Cambiar', mtWarning,[mbOk], 0)
     else Bien:=true;
  if not bien then exit;

  if CambiarA.ItemIndex=0 then
     TablaListados.Filtered:=False;
  TablaListados.Refresh;
  With TablaListados do
  Begin
    First;
    While Not Eof do
    begin
      aux:=FieldByName('Mascara').asString;
      if EsPorDirectorio then
         aux:=rutaEdit.text+'\'+extractFileName(Aux)
      else aux2:=CambiarSubCadena(aux,cambiarEdit.text,porEdit.text);
      if Aux<>Aux2 then
      begin
        Edit;
        FieldByName('Mascara').asString:=Aux2;
        Post;
        Cambios:=Cambios+1;
      end;
      Next;
    end;
  end;
  FiltraTabla;
  Aux:='    Proceso Concluido'+#13+'Se han realizado '+
       inttostr(Cambios)+' cambios.';
  MessageDlg(Aux,mtInformation,[mbOk], 0)
end;
//------------------------------------------------------------------------------



function TFormListados.CargaListado: Boolean;
begin
  if (ListadoFijo <> '') and (ListadoFijo <> '-9999') then
    TablaListados.Locate('Orden', ListadoFijo, []);
  Mascara := TablaListados.Fieldbyname('Mascara').asString;

  Result := True;

{
  if ExtractFileExt(Mascara) = '.frf'
    then
  begin
    try
      TraduceFR2toFR4(Mascara);
      if not lHayError then
      begin
        RenombraFichero(Mascara, StringReplace(Mascara, '\Listados', '\Listados' + PATH_FR_OLD, []));
        Mascara := StringReplace(Mascara, '.frf', '.fr3', []);
        TablaListados.Edit;
        TablaListados.Fieldbyname('FecConv').AsDateTime := DATE;
        TablaListados.Fieldbyname('Mascara').asString := Mascara;
        TablaListados.Post;
      end;
    except
      on E: EDataBaseError do
        MensError('Error(Abriendo Base de Datos)¡¡¡, ' + E.Message)
      else
        MensError('Error(No es posible abrir conexión ADO)¡¡¡');
      MensError('Error en conversión a FR4 ' + #13 + Mascara);
    end;
  end;
}

  if fileexists(Mascara) then
  begin
    if TablaSQLList.Active then
      TablaSQLList.Close;
    if (result) and (TablaListados.FieldByname('SQL').asString <> '') then
    begin
      try
        TablaSQLList.sql.clear;
        TablaSQLList.sql.add(TablaListados.FieldByname('SQL').asString);
        TablaSQLList.Open;
        Maestro1.DataSource := SourceSQL;
      except on e:exception do
        Showmessage('Error generando la SQL: ' + e.Message);
      end;
    end;

    frxReport1.LoadFromFile(Mascara)
  end
  else
    Result := False;

  if (not (result)) and (Mascara <> '') then
    Showmessage('No Exite el Fichero Mascara del Listado ' + #13#10 + Mascara);

end;

procedure TFormListados.VerNoVer(Ver:Boolean);
begin
  With TablaListados do begin
    first;
    while Not eof do begin
      edit;
      TablaListados.FieldbyName('VerAntes').asBoolean:=Ver;
      next;
    end;
    first;
  end;
end;

procedure TFormListados.VerTodos1Click(Sender: TObject);
begin
  if quien = '' then
    begin
      VerTodos1.Checked:=true;
      LabelQuien.Caption:=TODOS;
      exit;
    end;
  VerTodos1.Checked:=not(VerTodos1.Checked);
 // VerTodos1.checked:=FALSE;
  if VerTodos1.Checked
    then LabelQuien.Caption:=TODOS
    else LabelQuien.Caption:=Quien;
  FiltraTabla;
end;

procedure TFormListados.VerTodosAntesdeImprimir1Click(Sender: TObject);
begin
   VerNoVer(True);
end;

function TFormListados.ExisteImpresoraWin(Impresora:String):Integer;
begin
  if (Printer.Printers.Count = 0) then Result:=-1
  else result:=Printer.Printers.IndexOf(Impresora);
end;

procedure TFormListados.ImprimirConPregunta;
var FromPg,ToPg,ind:  Integer;
begin
  if not(CargaListado) then exit;
  ind := Printer.PrinterIndex;
  with PrintDialog1 do begin
    Copies   := strtoint(EditCopias.Text);
    COPIAS   := strtoint(EditCopias.Text);
    Collate  := True;   //COPIAS
    FromPage := 1;
    PaintAllowed := True;
    ToPage   := frxReport1.PagesCount;
    MaxPage  := frxReport1.PagesCount;
    if Execute then
    begin
      if Printer.PrinterIndex <> ind then
      begin
        frxReport1.PrintOptions.Printer := Printer.Printers[Printer.PrinterIndex];
        frxReport1.PrepareReport;
      end;
      FromPg := 1;
      ToPg   := frxReport1.PagesCount;
      if PrintDialog1.PrintRange = prPageNums
      then begin
            FromPg := PrintDialog1.FromPage;
            ToPg   := PrintDialog1.ToPage;
           end;
      frxReport1.PrepareReport;
    end; //if execute
  end; //del with
end;

procedure TFormListados.ImageAbajoClick(Sender: TObject);
var
  i: integer;
begin
  i:=StrtoInt(EditCopias.Text);
  if i> 1 then EditCopias.Text:=InttoStr(i-1)
end;

procedure TFormListados.ImageArribaClick(Sender: TObject);
begin
  EditCopias.Text:=InttoStr(StrtoInt(EditCopias.Text)+1);
end;

procedure TFormListados.Imprimir(directo, MuestraDirecto: Boolean; Destino: Char);
var Impresora, ImpresoraReport, ImpresoraReportTemp, ComoPrn, NombreMaquina: string;
  Indiceviejo: Integer; //Para la Impresora
begin
  if TablaListados.FieldByName('Etiquetas').AsString<>''
    then begin
            if Maestro1 <> Nil then Maestro1.First;
            if Maestro2 <> Nil then Maestro2.First;
            if Detalle1 <> Nil then Detalle1.First;
            if Detalle2 <> Nil then Detalle2.First;
            while not Maestro2.Eof do
            begin
                Etiquetas;
                Maestro1.Next;
                Maestro2.Next;
            end;
           exit;
         end;
  NombreMaquina   := DameNombrePC;
  ImpresoraReport := frxReport1.PrintOptions.Printer;
  IndiceViejo     := ExisteImpresoraWin(ImpresoraReport);
  if EstoyEn = 'L'
    then Impresora := TablaListados.FieldbyName('ImpresoraLonja').AsString //Si estoy en la Lonja
    else Impresora := TablaListados.FieldbyName('Impresora').AsString; //Si estoy en la Cofradía

  if Trim(Impresora) = '' then Impresora := TablaListados.FieldbyName('Impresora').AsString;
  if Trim(ComoPrn) = ''   then ComoPrn := 'D';
  ComoPrn := TablaListados.FieldbyName('ComoImpresora').asstring;

{
  if QueAplicacion = 'TERMINAL'
    then if Trim(IMPRESORATERMINAL) <> ''
          then begin
                  Impresora := IMPRESORATERMINAL;
                  ComoPrn := 'E';
               end
          else ComoPrn := 'D'; //Si Autec NO me pasa la Impresora, cojo la Impresora por defecto.(por Conil)

}

  if not (CargaListado) then
    exit; //localiza el listado.

//  BonitoFijo(Destino);

  COPIAS := strtoint(EditCopias.Text);
  if frxReport1.Tag <> 0 then Exit;

  case Destino of
    'P', 'E': begin //Generar PDF
        if Trim(EditPDF.Text) = '' then EditPDF.Text := 'c:\Datos.pdf'
        else ForceDirectories(extractfiledir(EditPdf.Text));
        ComoPrn := 'E'; //????
        frxReport1.PrepareReport;
        frxpdfexport1.Creator := application.Title;
        frxpdfexport1.FileName := EditPdf.Text;
        frxpdfexport1.ShowProgress := False;
        frxpdfexport1.ShowDialog := False;
        if Destino = 'E' then
        begin
          frxMailExport1.ExportFilter := frxPDFExport1;
          frxMailExport1.Address      := EditEmailFax.Text;
          frxMailExport1.FilterDesc   := 'PDF por E-Mail';

          if trim(Internet.EMailOrigen)='' then
             frxMailExport1.FromMail     := 'cofrawin@grupocie.com'
          else frxMailExport1.FromMail     := Internet.EMailOrigen;

          if trim(Internet.PuertoSMTP)='' then
             frxMailExport1.SmtpPort     := 587
          else frxMailExport1.SmtpPort     := StrToInt(Internet.PuertoSMTP);

          if trim(Internet.UsuarioSMTP)='' then
             frxMailExport1.Login        := 'cofrawin'
          else  frxMailExport1.Login        := Internet.UsuarioSMTP;

          if trim(Internet.ContrasenaSMTP)='' then
             frxMailExport1.Password     := chr(90)+ chr(79)+ chr(82)+ chr(82)+ chr(79)
          else frxMailExport1.Password     := Internet.ContrasenaSMTP;

          if trim(Internet.HostSMTP)='' then
             frxMailExport1.SmtpHost     := 'mail.grupocie.com'
          else frxMailExport1.SmtpHost     := Internet.HostSMTP;

          if trim(Internet.Asunto)='' then
             frxMailexport1.Subject      := 'Sistema Email GrupoCIE - Envío'
          else frxMailexport1.Subject      := Internet.Asunto;


          frxMailexport1.Lines.Clear;

          if trim(Internet.Cuerpo)='' then
             frxMailexport1.Lines.Add('esto es una prueba')
          else frxMailexport1.Lines.Add(Internet.Cuerpo);

          frxMailexport1.ShowExportDialog := False;
          frxMailexport1.ShowDialog := False;
          if EditarEmail.Checked then frxMailexport1.ShowProgress := True
          else frxMailexport1.ShowProgress := False;
          if EditarEmail.Checked then frxMailexport1.ShowDialog := True
          else frxMailexport1.ShowDialog := False;
          frxReport1.Export(frxMailexport1);
        end
        else
        begin
          frxReport1.Export(frxpdfexport1);
          if FileExists(EditPdf.Text) then
//            if MensPregunta('Fichero PDF creado correctamente en:'+#13#10+#13#10+EditPDF.Text+#13#10+#13#10+'¿Desea abrir el documento ahora?') then
              ShellExecute(FormListados.Handle,nil,PChar(EditPdf.Text),'','',SW_SHOWNORMAL);
        end;
      end;
    'F', 'N': begin //Si listado va por Fax y por impresora
      {
        if Destino = 'F' then
        begin
          ImpresoraReportTemp := ImpresoraReport;
          Impresora := ImpresoraFAX; //ImpresoraFAX se coge del Reg. de Windows
          ComoPrn := 'E';
        end;
      }
        //
        Impresora := UpperCase(Impresora);
        NombreMaquina := UpperCase(NombreMaquina);

        Impresora := CambiarSubCadena(Impresora, '\\' + NombreMaquina + '\', '&');
        Impresora := CambiarSubCadena(Impresora, NombreMaquina + '\', '&');
        Impresora := CambiarSubCadena(Impresora, NombreMaquina, '&');
        Impresora := QuitaCaracter(Impresora, '&');

        if ComoPrn = '' then ComoPrn := 'D'; // por defecto

        if not (directo)
          then begin
          case ComoPrn[1] of
            'P': begin //predefinido listado
                if (ExisteImpresoraWin(ImpresoraReport) = -1) then
                begin
//                  if QUEAPLICACION = 'COFRAWIN' then
                    showmessage('No existe la Impresora ' + ImpresoraReport);
                  end
                  else
                  begin //Activamos lo de cargar en ejecución.NOTA: Se pone False
                    frxReport1.PrintOptions.Printer := Printer.Printers[ExisteImpresoraWin(Impresora)];
                  end; //del if
              end;
            'E': begin //impresora elejida
                if (ExisteImpresoraWin(Impresora) = -1) then
                begin
//                  if QUEAPLICACION = 'COFRAWIN' then
                    Showmessage('No existe la Impresora ' + Impresora);
                  Exit;
                end;
                frxReport1.PrintOptions.Printer := Printer.Printers[ExisteImpresoraWin(Impresora)];
              end;
            'D': begin //Solo impresora defecto
                Printer.PrinterIndex := -1; //Elegimos la Impresora Predeterminada de Windows
                frxReport1.PrintOptions.Printer := Printer.Printers[Printer.PrinterIndex];
              end;
          end; //del case
          frxReport1.PrintOptions.PageNumbers := '';
          frxReport1.PrintOptions.Copies := Copias;
          frxReport1.PrintOptions.Collate := True;
          frxReport1.PrepareReport;
          frxReport1.PrintOptions.ShowDialog:=False;
          frxReport1.Print;
        end
        else ImprimirConPregunta;
        //
      end;
  end; //del Case
//  BonitoFijo('C');
end;

procedure TFormListados.Imprimir1Click(Sender: TObject);
begin
  Imprimir(True,False,'N');
end;

procedure TFormListados.Editar1Click(Sender: TObject);
begin
  Editar1.Checked          :=not(Editar1.Checked);
  Herramientas1.Enabled    :=Editar1.Checked;
  Registros1.Enabled       :=Editar1.Checked; Opciones.Enabled      :=Editar1.Checked;
  DBNavigator2.Visible     :=Editar1.Checked; Label2.Enabled        :=Editar1.Checked;
  descripcionDBEdit.Enabled:=Editar1.Checked; Label3.Enabled        :=Editar1.Checked;
  ordenDBEdit.Enabled      :=Editar1.Checked; Label1.Enabled        :=Editar1.Checked;
  mascaraDBEdit.Enabled    :=Editar1.Checked; VerAntes.Enabled      :=Editar1.Checked;
  DBGridlistados2.Enabled  :=Editar1.Checked; Label4.Enabled        :=Editar1.Checked;
  DBMemo1.Enabled          :=Editar1.Checked; AsignarFichero.Enabled:=Editar1.Checked;
  SalvarBtn.Enabled        :=Editar1.Checked; DisenarBtn.Enabled    :=Editar1.Checked;
  NuevoBtn.Enabled         :=Editar1.Checked; Memo1.Enabled         :=Editar1.Checked;
  if Editar1.Checked
    then Paginas.ActivePage :=Opciones
end;

procedure TFormListados.EditEmailFaxExit(Sender: TObject);
begin
  case RadioGroupTipoListado.itemindex of
      1: if EditEmailFax.text<>''
             then  LabelRutaPDF.Caption:= Trim(EditEmailFax.text);
      2: if EditEmailFax.text<>''
             then  Labelemail.Caption:= Trim(EditEmailFax.text);
      3: if EditEmailFax.text<>''
             then  LabelFax.Caption:= Trim(EditEmailFax.text);
  end;//del case
end;

procedure TFormListados.Etiquetas;
var
    impreso:TextFile;
    primero,ultimo,i,x,long1,long2,copias:integer;
    linea,sincorchetes,completa,source,campo,longitud, aux,Aux2:string;
begin
  Memo1.Text := TablaListados.FieldByName('etiquetas').AsString;
  copias     := TablaListados.fieldbyname('Copias').AsInteger;
//  copias:=Maestro1.getDataset.fieldbyname('Copias').AsInteger;
  if copias<=0 then copias:=1;

  for i:=0 to Memo1.Lines.Count-1 do
    begin
      linea := Memo1.Lines[i];

      if linea='^PQ1,0,1,Y^XZ'
        then Memo1.Lines[i]:='^PQ'+inttostr(copias)+',0,1,Y^XZ';

      linea   := Memo1.Lines[i];
      primero := pos('[',linea);
      ultimo  := pos(']',linea);
      if (primero<>0) and (ultimo<>0) and (primero<ultimo)
        then begin
              sincorchetes:= SubCadena(linea,primero+1,ultimo-1);
              completa    := sincorchetes;
              source      := Descomponer(sincorchetes,'.');
              source      := uppercase(source);
              campo       := Descomponer(sincorchetes,'.');
              campo       := QuitaCaracter(campo,'"');
              longitud    := Descomponer(sincorchetes,'.');
              if longitud='' then longitud:=IntToStr(length(sincorchetes));

              if source='MAESTRO1'
                then begin
                      if Maestro1.GetDataSet.RecordCount<>0
                        then aux:=Maestro1.GetDataSet.FieldByName(campo).AsString;
                     end;
              if source='MAESTRO2'
                then begin
                      if Maestro2.GetDataSet.RecordCount<>0
                        then aux:=Maestro2.GetDataSet.FieldByName(campo).AsString;
                     end;
              if source='DETALLE1'
                then begin
                      if Detalle1.GetDataSet.RecordCount<>0
                        then aux:=Detalle1.GetDataSet.FieldByName(campo).AsString;
                     end;
              if source='DETALLE2'
                then begin
                      if Detalle2.GetDataSet.RecordCount<>0
                        then aux:=Detalle2.GetDataSet.FieldByName(campo).AsString;
                     end;
              if source='DETALLE3'
                then begin
                      if Detalle3.GetDataSet.RecordCount<>0
                        then aux:=Detalle3.GetDataSet.FieldByName(campo).AsString;
                     end;

              long1:=length(aux);
              long2:=strtoint(longitud);
              if (long1<long2) then
                aux:=rellena(aux,' ',long2)
              else
                aux:=PrimerasLetras(aux,long1-1);
              Aux2 := Memo1.Lines[i];
              Memo1.Lines[i]:=CambiarSubCadena(Memo1.Lines[i],'['+completa+']',aux);
             end;
    end;
    Memo1.Lines.SaveToFile('C:\etiqueta.prn');
    winexec('print C:\etiqueta.prn lpt1',0);
    sleep(1000);
    DeleteFile('C:\etiqueta.prn');
end;

procedure TFormListados.PonSources;
begin
  // Igualamos los sources para que ambas versiones tengan datos
  if Maestro1.DataSource <> nil
    then maestro1L.Caption := Maestro1.DataSource.Name
  else maestro1L.Caption := '';
  if Maestro2.DataSource <> nil
    then maestro2L.Caption := Maestro2.DataSource.Name
  else maestro2L.Caption := '';
  if Detalle1.DataSource <> nil
    then detalle1L.Caption := Detalle1.DataSource.Name
  else detalle1L.Caption := '';
  if Detalle2.DataSource <> nil
    then detalle2L.Caption := Detalle2.DataSource.Name
  else detalle2L.Caption := '';
  if Detalle3.DataSource <> nil
    then detalle3L.Caption := Detalle3.DataSource.Name
  else detalle3L.Caption := '';
//  N1.Checked := True;
//  N1Click(nil);
end;

procedure TFormListados.RadioGroupTipoListadoClick(Sender: TObject);
begin
  if RadioGroupTipoListado.tag>99 then exit;
  TipoListado:=RadioGroupTipoListado.itemindex;
  PonVariablesBien
end;

//------------------------------------------------------------------------------

procedure TFormListados.RefrescarImpresoras1Click(Sender: TObject);
begin
  ImpresorasListBox.Items:=printer.Printers;
end;

procedure TFormListados.ImprimirBtnClick(Sender: TObject);
begin
  case RadioGroupTipoListado.ItemIndex of
    0: Imprimir(False, False, 'N');
    1: Imprimir(False, False, 'P');
    2: Imprimir(False, False, 'E');
    3: Imprimir(False, False, 'F');
  end;
end;
procedure TFormListados.PantallaBtnClick(Sender: TObject);
begin
  if CargaListado then
    frxReport1.ShowReport;
  PonSources;
end;
procedure TFormListados.Salir1Click(Sender: TObject);
begin
  if TablaListados.State in [dsInsert,dsEdit] then
  begin
    TablaListados.Cancel;
  end
  else
    Close;
end;

procedure TFormListados.SalirBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TFormListados.SalvarBtnClick(Sender: TObject);
begin
  if CargaListado
    then frxReport1.SaveToFile(Mascara);
end;
procedure TFormListados.TablaListadosBeforePost(DataSet: TDataSet);
begin
//  DataSet.FieldByName('CodigoEmpresa').AsInteger:= empresaActual;
  DataSet.FieldByName('CodigoEmpresa').AsInteger:= 1;
end;

procedure TFormListados.TablaListadosNewRecord(DataSet: TDataSet);
begin
  if QUIEN ='' then TablaListados.Cancel;
    TablaListados.FieldByName('Clave').asstring:=Quien;
end;

procedure TFormListados.DisenarBtnClick(Sender: TObject);
begin
  if CargaListado
    then frxReport1.DesignReport;
end;
procedure TFormListados.AsignarFicheroClick(Sender: TObject);
begin
  if not(OpenDialog1.execute) then exit;
  TablaListados.Edit;
  TablaListados.FieldByName('Mascara').asstring:=OpenDialog1.FileName;
  TablaListados.Post;
end;

//------------------------------------------------------------------------------
procedure TFormListados.PonVariablesBien;
begin
   Case TipoListado of
      0: begin
           EditEmailFax.Color:=clMenu;
           EditEmailFax.ReadOnly:=True;
           Label28.caption:='Ruta/Email/Fax';
           EditEmailFax.Text:='';
           DestinoBtn.Visible := False;
         end;
      1: begin
           EditEmailFax.Color:=clWindow;
           EditEmailFax.ReadOnly:=False;
           Label28.caption:='Ruta Fichero';
           if Trim(LabelRutaPDF.Caption) = ''
             then EditEmailFax.Text:='C:\CofraWin.pdf'
             else EditEmailFax.Text:=LabelRutaPDF.Caption;
           DestinoBtn.Visible := True;
         end;
      2: begin
           EditEmailFax.Color:=clWindow;
           EditEmailFax.ReadOnly:=False;
           Label28.caption:='Email Destino';
           EditEmailFax.Text:=LabelEMail.Caption;
           DestinoBtn.Visible := False;
         end;
      3: begin
           EditEmailFax.Color:=clWindow;
           EditEmailFax.ReadOnly:=False;
           Label28.caption:='Núm. Fax Destino';
           EditEmailFax.Text:=LabelFax.Caption;
           DestinoBtn.Visible := False;
         end;
   End;//del Case
  EditarEmail.Visible:=RadioGroupTipoListado.ItemIndex=2;
end;

procedure TFormListados.GenerarFichero;
var
   Fichero:String;
   FIniFile: TIniFile;
begin
  if Trim(RutaFicheroPDF)='' then RutaFicheroPDF:='C:\CofraWin.pdf';
  Case TipoListado of
    1://Fichero PDF
    begin
      if Trim(EditEmailFax.text)<>'' then
        begin
          if FileExists('c:\Windows\System\Pdfwritr.ini') then//Para W95/98/ME
          begin
            FIniFile:=nil;
            try
               FIniFile:= TIniFile.Create('c:\Windows\System\Pdfwritr.ini');
               FInifile.WriteString('Acrobat PDFWriter','PdfFileName', EditEmailFax.text);
               FInifile.WriteString('Acrobat PDFWriter','bExecViewer', '0');
            finally
               FIniFile.Free;
            end;
          end
          else//Para W2000/XP
          begin
             //FicheroINI.WriteString('Adobe\Acrobat PDFWriter','PdfFileName',EditEmailFax.text);
             //FicheroINI.CloseKey;
          end;
        end;
    end;
    2://Enviar Email
    begin
       if Trim(RutaFicheroPDF)='' then RutaFicheroPDF:='C:\CofraWin.pdf';
       Forcedirectories(extractfiledir(RutaFicheroPDF));
       if FileExists('c:\Windows\System\Pdfwritr.ini') then//Para W95/98/ME
       begin
         FIniFile:=nil;
         try
            FIniFile:= TIniFile.Create('c:\Windows\System\Pdfwritr.ini');
            FInifile.WriteString('Acrobat PDFWriter','PDFFileName', RutaFicheroPDF);
            FInifile.WriteString('Acrobat PDFWriter','bExecViewer', '0');
         finally
            FIniFile.Free;
         end;
       end
       else//Para W2000/XP
       begin
          //FicheroINI.WriteString('Adobe\Acrobat PDFWriter','PdfFileName',RutaFicheroPDF);
          //FicheroINI.CloseKey;
       end;
    end;
  end;
end;
//------------------------------------------------------------------------------

procedure TFormListados.EnviarMail(verAntes:Boolean);
var
   FicherosAdjuntos:TStringList;
begin
{
       FicherosAdjuntos:=TStringList.Create;
       if Trim(RutaFicheroPDF)<>'' then FicherosAdjuntos.Add(RutaFicheroPDF);
       LLamaEnviarEmail(Internet.EMailOrigen,EditEmailFax.Text,Internet.HostSMTP,
                                  Internet.PuertoSMTP,Internet.UsuarioSMTP,Internet.ContrasenaSMTP,
                                  Internet.Asunto,Internet.Cuerpo,FicherosAdjuntos,True,verAntes);
       FicherosAdjuntos.Free;
}
end;


//------------------------------------------------------------------------------
procedure TFormListados.ExportarListados1Click(Sender: TObject);
var Registro:TFicheroDat;
    NombreFicheroCie,DirectorioListadosCie,DirectorioListados,Aux : String;
    FicheroDat : File of TFicheroDat;
    NExportados,Longitud : Integer;
begin
//  if not MensPregunta('¿Desea Exportar los ficheros?') then exit;
  NExportados :=0;
  TablaListados.Filtered:=False;
//  DirectorioListadosCie:=DirectorioTrabajo+'ListadosCie';
  NombreFicheroCie     :=DirectorioListadosCie+'ListadosCie.dat';
  ForceDirectories(DirectorioListadosCie);
  AssignFile(FicheroDat,NombreFicheroCie);
  ReWrite(FicheroDat);
  ProgressBar1.Visible:=True;
  ProgressBar1.position:=0;
  ProgressBar1.Max:=TablaListados.RecordCount;

  while not TablaListados.eof do
    begin
      Registro.Clave          :=TablaListados.FieldbyName('Clave').asString;
      Registro.Descripcion    :=TablaListados.FieldbyName('Descripcion').asString;
      Registro.Mascara        :=TablaListados.FieldbyName('Mascara').asstring;
      Registro.Configurable   :=TablaListados.FieldbyName('Configurable').asBoolean;
      Registro.Formulario     :=TablaListados.FieldbyName('Formulario').asString;
      Registro.VerAntes       :=TablaListados.FieldbyName('VerAntes').asBoolean;
      Registro.PideLimites    :=TablaListados.FieldbyName('PideLimites').asBoolean;
      Registro.Orden          :=TablaListados.FieldbyName('Orden').asInteger;
      Registro.Impresora      :=TablaListados.FieldbyName('Impresora').asString;
      Registro.ImpresoraLonja :=TablaListados.FieldbyName('ImpresoraLonja').asString;
      Registro.ComoImpresora  :=TablaListados.FieldbyName('comoImpresora').asString;
      Registro.CopyCie        :=TablaListados.FieldbyName('CopyCie').asString;
      Registro.Version        :=VERSIONEXPORTAR;
      Registro.Registros      :=TablaListados.RecordCount;
      Aux                     :=TablaListados.FieldbyName('SQL').asString;
      Aux                     :=CambiarSubCadena(Aux,'#$D#$A#0',' ');
      Aux                     :=CambiarSubCadena(Aux,'#$D#$A#',' ');
      Aux                     :=CambiarSubCadena(Aux,'#$D#$A',' ');
      Registro.Sql            :=Aux;
      Registro.Sql2           :='';
      Registro.Sql3           :='';
      Longitud                :=length(Aux);
      if (Longitud >200) and (Longitud<=400) then
      begin
        Registro.Sql2           :=SubCadena(aux,201,Longitud);
      end;

      if (Longitud >400) and (Longitud<=600) then
      begin
         Registro.Sql2           :=SubCadena(aux,201,Longitud);
         Registro.Sql3           :=SubCadena(aux,401,Longitud);
      end;
      Write(FicheroDat,Registro);

      NombreFicheroCie:=DirectorioListadosCie+'\'+extractfilename(Registro.Mascara);
      NExportados:=NExportados+1;
      ProgressBar1.position:=ProgressBar1.position+1;
      estadolabel.Caption:='Copiando a ('+inttoStr(NExportados)+') '+NombreFicheroCie;
      Application.ProcessMessages;
      Aux:= Registro.Mascara;
      copyfile(PChar(Aux),PChar(NombreFicheroCie),False);
      TablaListados.Next;
    end;
    CloseFile(FicheroDat);
    estadolabel.Caption:='';
    TablaListados.Filtered:=True;
    ProgressBar1.position:=0;
    ProgressBar1.Visible:=False;;
end;


procedure TFormListados.ImportarListados(Todos:Char);
// antes ponia Todos:Boolean);    Lo cambio para que coja si recordcount=0
// U -> de este tipo de listado (anteriormente era false)
// T -> Todos los listados... (antes era True)
// 0 (cero)-> si no hay nada en ese tipo de listado
var Descripcion,QuienEra,Mensage : String;
    NListados,NListadosAnadidos,NOmitidos,frfCopiados,Version : Integer;
    Sal:Boolean;
    NombreFicheroCie,RutaGeneral,Aux,Unidad,Clave,ToAll : String;
    Registro:TFicheroDat;
    FicheroDat : File of TFicheroDat;
    //------------------------------------------------------------------------------
    procedure ImportarFichero(CopiaRegistro:Boolean);
    var AuxAux:String;
    begin
      if (Todos='U') and (trim(Registro.Clave)<> Quien)
        then exit;
      if (Todos='0') and (FileExists(NombreFicheroCie))
        then exit;

      AuxAux:=RutaGeneral+'\'+NombreFicheroCie;
//      NombreFicheroCie:=DirectorioTrabajo+'ListadosCIE\'+NombreFicheroCie;

      if CopiaRegistro
        then begin
               NListadosAnadidos:=NListadosAnadidos+1;
               TablaListados.Insert;
               TablaListados.FieldByName('Orden').asInteger          := DameNOrden(Clave);
               TablaListados.FieldByName('Mascara').asString         := AuxAux;
               TablaListados.FieldbyName('Clave').asString           := Registro.Clave;
               TablaListados.FieldbyName('Descripcion').asString     := Registro.Descripcion;
               TablaListados.FieldbyName('SQL').asString             := Registro.Sql+Registro.Sql2+Registro.Sql3;
               TablaListados.FieldbyName('Configurable').asBoolean   := Registro.Configurable;
               TablaListados.FieldbyName('Formulario').asString      := Registro.Formulario;
               TablaListados.FieldbyName('VerAntes').asBoolean       := Registro.VerAntes;
               TablaListados.FieldbyName('PideLimites').asBoolean    := Registro.PideLimites;
               TablaListados.FieldbyName('Impresora').asString       := Registro.Impresora;
               TablaListados.FieldbyName('ImpresoraLonja').asString  := Registro.ImpresoraLonja;
               TablaListados.FieldbyName('comoImpresora').asString   := Registro.ComoImpresora;
               TablaListados.FieldbyName('CopyCie').asString         := Registro.CopyCie;
               TablaListados.Post;
             end;
       if FileExists(NombreFicheroCie)
        then begin
               estadolabel.Caption:='Copiando '+NombreFicheroCie; Application.ProcessMessages;
               CopyFile(PChar(NombreFicheroCie),PChar(AuxAux),false);
               frfCopiados:=frfCopiados+1;
             end;
    end;
    //------------------------------------------------------------------------------
begin
//  NombreFicheroCie     :=DirectorioTrabajo+'ListadosCie\ListadosCie.dat';
//  RutaGeneral:=DirectorioTrabajo+'Listados';
  Unidad     :=RutaGeneral[1];

  if FileExists(NombreFicheroCie)=False
    then begin
           Showmessage('No existe Fichero de Importación de Listados.');
           exit;
         end;
  QuienEra :=LabelQuien.Caption; NListados:=0;     NListadosAnadidos:=0;
  frfCopiados:=0;                NOmitidos:=0;     ToAll:='';

  Mensage:='¿ Está seguro de Importar ';
  case todos of
    'T' : Mensage:=Mensage+'Todos los Listados ?';
    'U' : Mensage:=Mensage+'los Listados del Tipo "'+QuienEra+'" ?';
    '0' : Mensage:=Mensage+'los listados que no esten dados de alta';
  end;//del case

//  if not MensPregunta(Mensage) then Exit;

  Sal:=False;
  TablaListados.Filtered:=False;

  AssignFile(FicheroDat,NombreFicheroCie);
  Reset(FicheroDat);
  while (not(eof(FicheroDat))) and (Sal=False) do
    begin
      Read(FicheroDat,Registro);
      if NListados=0
        then begin
               ProgressBar1.Visible:=true; ProgressBar1.position:=0; ProgressBar1.Max:=Registro.Registros;
               estadolabel.Visible:=True; Application.ProcessMessages;
             end;

      Clave            := Registro.Clave;
      NombreFicheroCie := ExtractFileName(Registro.Mascara);
      NListados        :=NListados+1;
      Aux:=RutaGeneral+'\'+NombreFicheroCie;
      ProgressBar1.position:=ProgressBar1.position+1;
      estadolabel.Caption:=''; Application.ProcessMessages;
      if TablaListados.Locate('Clave;Mascara',Vararrayof([Clave,Aux]),[])
         then begin
                Aux:= TablaListados.Fieldbyname('CopyCie').asString;
                if Aux<>'M'
                  then begin
                         if ToAll='I' then Aux:='I'; //Importar
                         if ToAll='M' then Aux:='M'; //Mantener
                         if Aux='' then Aux:='P';
                       end;
                if Aux[1]='P'
                  then
                  case MessageDlg('¿desea Copiar Listado '+TablaListados.FieldbyName('Descripcion').asString+
                                  ' con orden '+TablaListados.Fieldbyname('orden').asString,
                                   mtConfirmation, [mbYes, mbYesToAll,mbNo,mbNoToAll,mbCancel], 0) of
                        mrYes   : Aux:='I';   //Importar
                        mrNo    : Aux:='M';   //Mantener
                        mrCancel: Sal:=true;  //Salir
                        mrYesToAll: ToAll:='I';
                        mrNoToAll : ToAll:='M';
                  end;//del case de la pregunta
                if Aux='I'
                  then ImportarFichero(False)  //Importar
                  else NOmitidos:=NOmitidos+1;  //Mantener
              end//del locate=true
         else ImportarFichero(True);  //Importar
       next;
     end;//del while
    Closefile(FicheroDat);
    ProgressBar1.position:=0;
    ProgressBar1.Visible:=False;
    estadolabel.Visible:=False;

    Label5.Caption    :='Tipo de Listado ';
    LabelQuien.Caption:= QuienEra;
    FiltraTabla;
    Showmessage('Se han copiado   '+InttoStr(frfCopiados)+' Listados (Mascaras).'+#13+
               'Se han añadido   '+InttoStr(NListadosAnadidos)+' Listados.'+#13+
               'Se han Procesado '+InttoStr(NListados)+' Listados de '+InttoStr(Registro.Registros)+#13+
               'Se han Omitido   '+InttoStr(NOmitidos-1)+' Listados.');
end;


procedure TFormListados.ImportarTiposdeListado1Click(Sender: TObject);
begin
  ImportarListados('U');
end;

procedure TFormListados.ImportarTodoslosListados1Click(Sender: TObject);
begin
  ImportarListados('T');
end;

procedure TFormListados.ImportarTodoslosListadossinohay1Click(Sender: TObject);
begin
  ImportarListados('O');
end;

procedure TFormListados.AsignaDSFR;
var
  i, j, k: integer;
  DM: TDataModule;
begin
  j := -1;
  FRDataSet := nil;
  for k := 0 to Application.ComponentCount - 1 do
  begin
  // Busco modulos de datos de todo el proyecto
    if TClass(Application.Components[k].ClassParent).ClassName = 'TDataModule' then
    begin
      DM := Application.Components[K] as TDataModule;
      if dm.Name = 'DMDatos' then // solo añadimos los datasources del DmPrincipal
      begin
        for i := 0 to DM.ComponentCount - 1 do
        begin
        // busco los datasource del modulo de datos para asignarselos a los Dataset de FR4
          if DM.Components[i].ClassName = 'TDataSource' then
          begin
            try
              Setlength(FRDataSet, length(FRDataSet) + 1);
              inc(j);
              FRDataSet[j] := TfrxDBDataset.Create(nil);
              with FRDataSet[j] do
              begin
                DataSet := TDataSource(DM.Components[i]).DataSet;
                Name := StringReplace(TDataSource(DM.Components[i]).DataSet.Name, '.', '', []);
                UserName := StringReplace(TDataSource(DM.Components[i]).DataSet.Name, '.', '', []);
                OpenDataSource := True;
              end;
            except
              Showmessage('Data Module :' + TDataModule(Application.Components[K]).Name + #13#10 +
                'Error en Datasource:' + TDataSource(DM.Components[i]).Name);
            end;
          end;
        end;
      end; // FIN del name = 'DMPrincipal'
    end;
  end;
  //AsignaDSFRhecho := True;
end;



end.

