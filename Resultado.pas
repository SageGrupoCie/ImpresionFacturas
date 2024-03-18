unit Resultado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvProgressBar, Grids, DBGrids, Buttons, ExtCtrls, AdvPanel,
  BaseGrid, AdvGrid, DBAdvGrid, frxDesgn, AdvMenus, AdvMenuStylers,
  frxClass, frxDBSet, frxExportPDF, Menus, StdCtrls,Printers, frxExportMail,
  gtPDFPrinter, {gtPDFCrypt, gtClasses, }gtCstPDFDoc, gtExPDFDoc,
  gtExProPDFDoc, gtPDFDoc, Mask, DBCtrls, gtPDFViewer,ShellAPI, ComCtrls,ADODB,
  AdvUtil, gtPDFClasses, frxExportBaseDialog, gtScrollingPanel, AdvObj;


  const WM_ENTER : Cardinal = 512;
        AUXALBPDF = '\Alb.pdf';
type
  TFormResultado = class(TForm)
    AdvPanel2: TAdvPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    AdvMainMenu1: TAdvMainMenu;
    Archivo1: TMenuItem;
    Salir1: TMenuItem;
    Herramientas1: TMenuItem;
    Disear1: TMenuItem;
    ModoPruebasslo1Fra1: TMenuItem;
    frxPDFExport1: TfrxPDFExport;
    frxReport1: TfrxReport;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    frxDesigner1: TfrxDesigner;
    frxMailExport1: TfrxMailExport;
    gtPDFPrinter1: TgtPDFPrinter;
    PDFDoc: TgtPDFDocument;
    N1: TMenuItem;
    LimpiarErrores1: TMenuItem;
    AlbaranesRoca: TfrxUserDataSet;
    SpeedButton4: TSpeedButton;
    PDFCopiaDOC: TgtPDFDocument;
    gtPDFPrinter2: TgtPDFPrinter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    AdvPanelOpciones: TAdvPanel;
    Label12: TLabel;
    Label13: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    AdvPanelOpcionesPrincipal: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox7: TCheckBox;
    AdvPanel1: TAdvPanel;
    AdvProgressBar1: TAdvProgressBar;
    DBAdvGrid1: TDBAdvGrid;
    DBEdit1: TDBEdit;
    Memo1: TMemo;
    gtPDFViewer1: TgtPDFViewer;
    AdvPanel3: TAdvPanel;
    GridLista: TDBAdvGrid;
    TabSheet2: TTabSheet;
    Memo2: TMemo;
    Memo3: TMemo;

    Function RutaFraCopia(Nombre:String):String;
    procedure LeePdf(Fichero:String);
    procedure ImprimirFra;
    function  NombreFichero:String;
    procedure AnadeError(Error:String;ErrorTexto : Char);
    procedure VerSiHayErrores;
    procedure EnviaEmailLogic(Const Fra,Albs:String);
    procedure EnviaEmail(Const Fra,Albs:String);
    Function  PonComandos(cadena:String):String;
    Function  CompruebaImprimirFra:Boolean;
    procedure RellenaRutasdeAlbaranes;
    procedure HojaenBlanco;
    procedure ImprimeCopiaFra(CIEEnvioFra:Char);

    procedure FormCreate(Sender: TObject);
    procedure Disear1Click(Sender: TObject);
    procedure ModoPruebasslo1Fra1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure LimpiarErrores1Click(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);

    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    tipoImpresion:integer;
    ImpresionSegunFichacliente:boolean;
  end;

var
  FormResultado: TFormResultado;
  CampoUsarEmail:String;
  Errores,NumeroAlbaranes : Integer;
  Adjuntos,Mensage        : TStrings;
  Previsualizar :Boolean;
  AlbaranesRutas :TStringList;
  AlbaranesNumero, AlbaranesNoEncontrados:Integer;
  Una_o_todas:Char;

implementation

{$R *.dfm}
uses DatosModulo,Funciones, SacaAvisosForm, AspectoForm, VisorPdf,
  IniFiles, DB, sendMail;
//------------------------------------------------------------------------------
procedure TFormResultado.SpeedButton1Click(Sender: TObject);
begin Close end;
//------------------------------------------------------------------------------
procedure TFormResultado.FormCreate(Sender: TObject);
begin
  gtPDFViewer1.Visible:=False;
  AlbaranesRutas :=TStringList.create;
  AlbaranesNumero:=0;
  Errores:=0;
  AdvPanel1.Align:=alClient;
  AdvPanel3.Align:=alClient;
  GridLista.Align:=alClient;

  Adjuntos:= TStringList.Create;
  Mensage := TStringList.Create;
  memo1.Text:='';
  CheckBox7.Checked := ModuloDatos.Plegadora;        //desde que he puesto lo de imprimir pdf por el acrobat, como que
  Label6.Caption:=InttoStr(ModuloDatos.Copia.Orden); //pierde los valores de modulodatos
end;
//------------------------------------------------------------------------------
procedure TFormResultado.Disear1Click(Sender: TObject);
var Impresora :String;
begin
   Impresora                  := UpperCase(ModuloDatos.Impresora);
   frxReport1.LoadFromFile(ModuloDatos.FicheroFRF);
           Case ModuloDatos.EligeImpresora of
             0 : begin //defecto
                   Printer.PrinterIndex := -1; //Elegimos la Impresora Predeterminada de Windows
                   frxReport1.PrintOptions.Printer := Printer.Printers[Printer.PrinterIndex];
                 end;
             1 : begin //seleccionada
                   if (ModuloDatos.ExisteImpresoraWin(Impresora) = -1)
                     then begin
                            ModuloDatos.MessageDlgCie('No existe la Impresora ' + Impresora, mtWarning, [mbCancel], 0);
                            Exit;
                          end;
                     frxReport1.PrintOptions.Printer := Printer.Printers[Modulodatos.ExisteImpresoraWin(Impresora)];
                 end;
           end;//del case

   frxReport1.DesignReport();
end;
//------------------------------------------------------------------------------
procedure TFormResultado.ModoPruebasslo1Fra1Click(Sender: TObject);
begin  ModoPruebasslo1Fra1.Checked:=not(ModoPruebasslo1Fra1.Checked) end;
//------------------------------------------------------------------------------
Function TFormResultado.CompruebaImprimirFra:Boolean;
var Aux:String;
begin
  Result:=False;
  Aux:= ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').asString+' '+
        ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString+' ( '+
        ModuloDatos.TablaFacturas.fieldbyname('FechaFactura').asString+' ) '+'  '+
        ModuloDatos.TablaFacturas.fieldbyname('Ruta').asString;
  if Fileexists(ModuloDatos.TablaFacturas.fieldbyname('Ruta').asString)=False
    then begin
           AnadeError('No se encuentra fichero de Fra '+Aux+' No se Imprime','E');
           Exit;
         end;
  if (AlbaranesNoEncontrados> ModuloDatos.MaxErrores)
    then begin
           AnadeError('No se encuentran ' +inttoStr(AlbaranesNoEncontrados)+'albaranes de la Fra '+Aux+' No se Imprime','E');
           Exit;
         end;
  Result:=True;
end;

//------------------------------------------------------------------------------
procedure TFormResultado.LeePdf(Fichero:String);
begin
  if trim(ModuloDatos.ProgramaReaderPdf) <>''
    then Funciones.ejecutar(trim(ModuloDatos.ProgramaReaderPdf)+' '+Fichero,0,0)// SW_SHOWNORMAL 'C:\Archivos de programa\Adobe\Acrobat 7.0\Reader\AcroRd32.exe '+Aux, 0, 0);
    else begin
           frmPDFViewerDemo.AbrirFichero(Fichero);
           frmPDFViewerDemo.ShowModal;
        end;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.ImprimirFra;
var
  NombrePdf,Impresora,Aux     : String;
  CIEEnvioFra,CIEEnvioFraReal : Char;
  error, juntarAlbaranFactura : boolean;
  i:integer;
//----------------
Procedure ImprimeAuxFra;
begin
  if moduloDatos.PapelPreImpresoFacturas then
  begin
    if not Previsualizar then
      if  ModuloDatos.TablaFacturas.fieldbyname('TipoEnvio').asString='E' then
        exit;
  end;

  //SI ES POR EMAIL SE SALE, S�LO IMPRIMIR PAPEL
  //showmessage('entra a imprimeAuxFra');

  if ((CheckBox1.Checked) and     //Impresora
      (CIEEnvioFra in ['P','A'])) or  //Papel o Ambas
     (Previsualizar)
    then
    else exit;

  aux:=ModuloDatos.TablaFacturas.fieldbyname('Ruta').asString;
  //Showmessage(aux);
  if Fileexists(Aux)=False
    then exit;
  if Previsualizar
    then LeePdf(Aux)
    else begin
           if ModuloDatos.EligeImpresoraFra = 0
              then
              else gtPDFPrinter1.SelectPrinterByIndex(Modulodatos.ExisteImpresoraWin(ModuloDatos.ImpresoraFra));
              //gtPDFPrinter1.SelectPrinterByName(Impresora);


           PDFDoc.LoadFromFile(Aux);
           //gtPDFPrinter1.ShowSetupDialog:=true;

           //blanco/negro o color
           case ModuloDatos.ColorFactura of
              0:gtPDFPrinter1.AdvancedPrinterSettings.Color:=cmMonochrome;
              1:gtPDFPrinter1.AdvancedPrinterSettings.Color:=cmColor;
           end;

           //N� de bandeja
           Try
              if ModuloDatos.BandejaFactura>0 then//0 es noSelecci�n de bandeja
                 gtPDFPrinter1.AdvancedPrinterSettings.BinIndex:=ModuloDatos.BandejaFactura;
           Except
              Showmessage('Error eligiendo Bandeja (Factura), revise la configuraci�n, el proceso continuar�.');
           end;
           //gtPDFPrinter1.PrintDoc ;   // cambiar tipo de impresion
           ShellExecute(0, 'open', PChar(ModuloDatos.RutaImpresionExe), PChar('"' +aux + '" "' + ModuloDatos.ImpresoraFra + '"' ),  nil, SW_SHOW);
         end;
end;
Procedure ImprimeAuxAlbPdf;
var Aux,Impresora,NombreTemp,Comando,Parametros:String;
begin
  if ModuloDatos.EligeImpresora = 0
    then Impresora := ''
    else Impresora := ModuloDatos.Impresora;

  PDFDoc.MergeDocs(AlbaranesRutas);
  NombreTemp := AlbaranesRutas.Strings[0];
  NombreTemp := ExtractFileDir(Aux);
  NombreTemp := ModuloDatos.RutaTemporal+'\kk.Pdf';
  PDFDoc.SaveToFile(NombreTemp);
  Comando := ModuloDatos.ProgramaReaderPdf+'\AcroRd32.exe ';
  if Previsualizar
     then begin
            Parametros := NombreTemp;
            LeePdf(NombreTemp);
          end
     else begin
            if (Checkbox1.Checked) and
               (CIEEnvioFra in ['P','A'])
               then Parametros := '/t '+NombreTemp+' '+Impresora
               else Comando:='';
          end;
  //Comando := Comando+Parametros;
  if Comando<>''
    then //ShellExecute(0, 'open', PChar(Comando), PChar(Parametros), nil, SW_SHOW);
    begin
      //Aux := Comando+Parametros;
      //funciones.ejecutar( Aux,SW_MINIMIZE,0);
     // funciones.ejecutar( Comando,SW_HIDE,0);
     ShellExecute(0, 'open', PChar(ModuloDatos.RutaImpresionExe), PChar('"' + NombreTemp + '" "' + Impresora + '"' ),  nil, SW_SHOW);
    end;
end;
//----------------
Procedure ImprimeAuxAlbJpg;
begin

  if ((Checkbox1.Checked=False) and (CIEEnvioFra ='P')) or
     ((Checkbox2.Checked=False) and (CIEEnvioFra ='M'))
     then exit;


  AlbaranesRoca.RangeEnd     := reCount;

  AlbaranesRoca.RangeEndCount:= AlbaranesRutas.Count;

  //Showmessage('AlbaranesRutas.count:'+IntToStr(AlbaranesRutas.Count));

  frxpdfexport1.Creator      := application.Title;
  frxpdfexport1.FileName     := NombrePdf;
  //Showmessage(NombrePdf);
  frxpdfexport1.ShowProgress := true;
  //frxpdfexport1.FileName     := AUXALBPDF;
 // frxpdfexport1.Compressed   := False;
 // frxpdfexport1.PrintOptimized := False;
//  frxpdfexport1.SlaveExport  :=False;
  frxpdfexport1.ShowDialog   := false;
  frxReport1.PrintOptions.ShowDialog:=false;


  Case ModuloDatos.EligeImpresora of
     0 : begin //defecto
           Printer.PrinterIndex := -1; //Elegimos la Impresora Predeterminada de Windows
           frxReport1.PrintOptions.Printer := Printer.Printers[Printer.PrinterIndex];
         end;
     1 : begin //seleccionada
           if (ModuloDatos.ExisteImpresoraWin(Impresora) = -1)
             then begin
                    ModuloDatos.MessageDlgCie('No existe la Impresora ' + Impresora, mtWarning, [mbCancel], 0);
                    Exit;
                  end;
             frxReport1.PrintOptions.Printer := Printer.Printers[Modulodatos.ExisteImpresoraWin(Impresora)];
         end;
  end;//del case

  if AlbaranesRutas.Count>0
     then //frxReport1.PrepareReport
     else exit;

  case CIEEnvioFra of
    'P': begin //if (CheckBox1.Checked) and (AlbaranesRutas.Count>0)     then begin
            if ModuloDatos.FastReporDirecto
               then if previsualizar
                         then frxReport1.ShowReport()
                         else ShellExecute(0, 'open', PChar(ModuloDatos.RutaImpresionExe), PChar('"' + NombrePdf + '" "' + Impresora + '"' ),  nil, SW_SHOW);
         end;
    'A': begin
          if ModuloDatos.FastReporDirecto then
             if previsualizar then frxReport1.ShowReport()
             else
             begin
                if moduloDatos.PapelPreImpresoFacturas then
                begin
                   if ((CheckBox1.checked) and (ModuloDatos.TablaFacturas.fieldbyname('TipoEnvio').asString='P')) then
                       ShellExecute(0, 'open', PChar(ModuloDatos.RutaImpresionExe), PChar('"' + NombrePdf + '" "' + Impresora + '"' ),  nil, SW_SHOW);
                end
                else
                begin
                   if (CheckBox1.checked) then
                       ShellExecute(0, 'open', PChar(ModuloDatos.RutaImpresionExe), PChar('"' + NombrePdf + '" "' + Impresora + '"' ),  nil, SW_SHOW);
                end;

                frxReport1.Export(frxPDFExport1);
             end;
         end;
    'E': if previsualizar
          then frxReport1.ShowReport()
          else frxReport1.Export(frxPDFExport1);//frxReport1.Print;   //CAMBIAR AQUI A SHELLEXECUTE
     'G':begin
          frxpdfexport1.FileName     := ModuloDatos.RutaTemporal+AUXALBPDF;
          if previsualizar
            then frxReport1.ShowReport()
            else frxReport1.Export(frxPDFExport1);//frxReport1.Print;
         end;
   end;//del case
end;
//----------------
Procedure EnviaEMail(MailPlegadora:Char);
var
  FicherosAdjuntos: TStrings;
  ficheros: TStringList;
  Aux,Factura,Cuerpo,asunto,Error, facfinal:String;
  QueryAux:TAdoQuery;
  j: integer;
  Email : TEmail;
begin
if moduloDatos.PapelPreImpresoFacturas then
begin
  if not Previsualizar then
     if ModuloDatos.TablaFacturas.fieldbyname('TipoEnvio').asString='P' then exit;
  //SI ES PAPEL SE SALE
end;


  memo2.Lines.Add(DateToStr(date())+' Generando env�o por email...');

  FicherosAdjuntos:=TStringList.Create;
  ficheros:=TStringList.Create;
  asunto := ModuloDatos.SMTPAsunto;
  Cuerpo:=ModuloDatos.SMTPCuerpo1+#13+#10+
          ModuloDatos.SMTPCuerpo2+#13+#10+
          ModuloDatos.SMTPCuerpo3+#13+#10;
  if ModuloDatos.TrabajoConCadenas then
    Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('CieClienteCadena').asString)
  else
    Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('Codigocliente').asString);
  Cuerpo:=funciones.CambiarSubCadena(Cuerpo,'@',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('EjercicioFactura').asString);
  Cuerpo:=funciones.CambiarSubCadena(Cuerpo,'#',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString);
  Cuerpo:=funciones.CambiarSubCadena(Cuerpo,'%',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').asString);
  Cuerpo:=funciones.CambiarSubCadena(Cuerpo,'$',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('FechaFactura').asString);
  Cuerpo:=funciones.CambiarSubCadena(Cuerpo,'&',Aux);
  if pos('?',Cuerpo)>0 then
  begin
    Aux:='';
    ModuloDatos.TablaAlbaranes.First;
    while not(ModuloDatos.TablaAlbaranes.Eof) do
    begin
      Aux:=Aux+#13+#10+
                    ModuloDatos.TablaAlbaranes.FieldByName('FechaAlbaran').asString+'  '+
                    ModuloDatos.TablaAlbaranes.FieldByName('SerieAlbaran').asString+'  '+
                    ModuloDatos.TablaAlbaranes.FieldByName('NumeroAlbaran').asString;

      ModuloDatos.TablaAlbaranes.Next;
    end;//del while
    Cuerpo:=funciones.CambiarSubCadena(Cuerpo,'?',Aux);
  end;

  // JAU - 21/05/2018 - Cambio los comodines en el ASUNTO
  if ModuloDatos.TrabajoConCadenas then
    Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('CieClienteCadena').asString)
  else
    Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('Codigocliente').asString);
  asunto:=funciones.CambiarSubCadena(asunto,'@',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('EjercicioFactura').asString);
  asunto:=funciones.CambiarSubCadena(asunto,'#',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString);
  asunto:=funciones.CambiarSubCadena(asunto,'%',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').asString);
  asunto:=funciones.CambiarSubCadena(asunto,'$',Aux);
  Aux:=trim(ModuloDatos.TablaFacturas.fieldbyname('FechaFactura').asString);
  asunto:=funciones.CambiarSubCadena(asunto,'&',Aux);
  if pos('?',asunto)>0 then
  begin
    Aux:='';
    ModuloDatos.TablaAlbaranes.First;
    while not(ModuloDatos.TablaAlbaranes.Eof) do
    begin
      Aux:=Aux+#13+#10+
                ModuloDatos.TablaAlbaranes.FieldByName('FechaAlbaran').asString+'  '+
                ModuloDatos.TablaAlbaranes.FieldByName('SerieAlbaran').asString+'  '+
                ModuloDatos.TablaAlbaranes.FieldByName('NumeroAlbaran').asString;
      ModuloDatos.TablaAlbaranes.Next;
    end;//del while
    asunto:=funciones.CambiarSubCadena(asunto,'?',Aux);
  end;
  // FIN JAU - 21/05/2018 - Cambio los comodines en el ASUNTO

  Factura:=ModuloDatos.TablaFacturas.fieldbyname('Ruta').asString;

  if CheckBox5.Checked then      //Factura
  begin
    memo2.Lines.Add(DateToStr(date())+' Adjuntando factura...:'+factura);
    if FileExists(Factura) then
      FicherosAdjuntos.Add(Factura);
  end
  else
     memo2.Lines.Add(DateToStr(date())+' NO se adjunta factura...:'+factura);

  if CheckBox3.Checked then     //CopiaFactura
  begin
    if FileExists(Factura) then
      FicherosAdjuntos.Add(RutaFraCopia(Factura));
  end;


  if trim(ModuloDatos.TablaFacturas.fieldbyname(CampoUsarEmail).asString)='' then
  begin
     //showmessage('Cliente '+ModuloDatos.TablaFacturas.fieldbyname('RazonSocial').asString+' sin e-mail informado, el proceso continuar�.');
     //rellenamos el error en la tabla cieEnvios
     QueryAux:=TAdoquery.create(nil);
     QueryAux.ConnectionString:=Modulodatos.Logic.ConnectionString;
     funciones.RegistraEMail_2('�Email NO informado!', asunto,Cuerpo,
                          nil, FicherosAdjuntos,
                          'R','',QueryAux);

     exit;
  end;


  case MailPlegadora of
    'M':begin
          if ImpresionSegunFichaCliente then
          begin
             if ModuloDatos.TablaFacturas.fieldbyname('CieAdjuntarAlbaranes').Asinteger=-1 then
                CheckBox6.Checked:=true
             else
                CheckBox6.Checked:=false;
          end;

          if CheckBox6.Checked then     //Albaranes
          begin
            if FileExists(NombrePdf) then
              FicherosAdjuntos.Add(NombrePdf);
          end;


          // JAU - 21/05/2018 - Juntar en un pdf la factura y el albar�n. Se indica en la ficha del cliente
          juntarAlbaranFactura := (ModuloDatos.TablaFacturas.fieldbyname('CieUnionPdfFrasAlb').AsInteger <> 0);
          if juntarAlbaranFactura then
          begin
            ficheros.Clear;
            for j := 0 to FicherosAdjuntos.Count-1 do
            begin
              if FileExists(FicherosAdjuntos[j]) then
                ficheros.Add(FicherosAdjuntos[j]);
            end;
            FicherosAdjuntos.Clear;

            if ficheros.Count > 0 then
            begin
              ForceDirectories('C:\Grupocie\');
              Facfinal := 'C:\Grupocie\prueba.pdf';
              factura := ficheros[0];
              if ficheros.Count > 2 then
              begin
                ShellExecute(0, 'open', PChar(ModuloDatos.RutaUnificarExe), PChar(factura + ' ' + ficheros[1] + ' ' + Facfinal),  nil, SW_SHOW);
                ShellExecute(0, 'open', PChar(ModuloDatos.RutaUnificarExe), PChar(Facfinal + ' ' + ficheros[2] + ' ' + Facfinal),  nil, SW_SHOW);
              end
              else
              begin
                ShellExecute(0, 'open', PChar(ModuloDatos.RutaUnificarExe), PChar(ficheros[0] + ' ' + ficheros[1] + ' ' + Facfinal),  nil, SW_SHOW);
              end;



              if FileExists(Facfinal) then
              begin
                ficheros.Clear;
                ficheros.Add(FacFinal)
              end;

            end;
          end;
          {
          if Una_o_todas='U'
            then Error:=ModuloDatos.PantallaEnviarEmail(
                           ModuloDatos.SMTPEmailYo,//EmailOrigen,
                           ModuloDatos.TablaFacturas.fieldbyname(CampoUsarEmail).asString,//EmailDestino,
                           ModuloDatos.SMTPHost,//HostSMTP,
                           ModuloDatos.SMTPPuerto,//PuertoSMTP,
                           ModuloDatos.SMTPUsuario,//UsuarioSMTP,
                           ModuloDatos.SMTPPass,//PassSMTP,
                           asunto,//Titulo,
                           Cuerpo,//Cuerpo: string;
                           nil,FicherosAdjuntos,//DetalleCuerpo,FicherosAdjuntos: TStrings;
                           False,False)// BorrarFicherosAlEnviar, Fijo: Boolean);
            else Error:=ModuloDatos.EnviarEmail( ModuloDatos.SMTPEmailYo,ModuloDatos.TablaFacturas.fieldbyname(CampoUsarEmail).asString,
                                        asunto,ModuloDatos.SMTPPuerto,ModuloDatos.SMTPHost,ModuloDatos.SMTPUsuario,
                                  ModuloDatos.SMTPPass,Cuerpo,Nil, FicherosAdjuntos,3,ModuloDatos.TablaAux2,True);   }



          Email := TEmail.Create;

          with Email do
          begin
            Server     := ModuloDatos.SMTPHost;
            Port       := ModuloDatos.SMTPPuerto;
            UserName   := ModuloDatos.SMTPUsuario;
            Password   := ModuloDatos.SMTPPass;
            Reciepient := ModuloDatos.SMTPEmailYo;
            UseTLS     := True;

            SentTo     := ModuloDatos.TablaFacturas.fieldbyname(CampoUsarEmail).asString;
            Subject    := asunto;
            Body.Add(Memo1.Lines.Text);

            {
            for j := 0 to ficheros.Count-1 do
            begin
              if FileExists(ficheros[j]) then
              begin
                if j=0 then
                  Attachment := ficheros[j]
                else
                  Attachment := Attachment + ';' + ficheros[j];
              end;
            end;}
            if FicherosAdjuntos.Count > 0 then
            begin
              for j := 0 to FicherosAdjuntos.Count-1 do
              begin
                if FileExists(FicherosAdjuntos[j]) then
                  ficheros.Add(FicherosAdjuntos[j]);
              end;
            end;


            Attachment.Assign(ficheros);
            ficheros.Clear;


            //Attachment := FicherosAdjuntos;
          end;
          try
            if not Email.SendEmail then
              begin
                  ShowMessage('Error al enviar la factura');
              end;

          except

          end;
        end;
    'G':begin
            if ImpresionSegunFichaCliente then
            begin
               if ModuloDatos.TablaFacturas.fieldbyname('CieAdjuntarAlbaranes').Asinteger=-1 then
                  CheckBox6.Checked:=true
               else
                  CheckBox6.Checked:=false;

            end;

            if CheckBox6.Checked      //Albaranes
              then FicherosAdjuntos.add(ModuloDatos.RutaTemporal+AUXALBPDF);


            PDFDoc.MergeDocs(FicherosAdjuntos);
            Factura:= ModuloDatos.RutaTemporal+'\'+ExtractFileName(Factura);
            PDFDoc.SaveToFile(Factura);
            Aux:='"'+extractfiledir(application.ExeName)+'\gsprint.exe "';
            Aux:=Aux+' "'+Factura+'"';
            Funciones.Ejecutar(Aux,0, 0);
        end;
  end;//del case
  if (Error<>'') and (MailPlegadora='M')
    then begin
           AnadeError('Error Envio EMail. '+ModuloDatos.TablaFacturas.fieldbyname('RazonSocial').asString +' '+
                                            ModuloDatos.TablaFacturas.fieldbyname(CampoUsarEmail).asString+Error,'E');
           memo2.Lines.Add(DateToStr(date())+' Error enviando email...');
         end;
end;
//------- PRINCIPAL------
begin
  if (not ImpresionSegunFichacliente) and (CheckBox3.checked=False) and
     (CheckBox5.checked=False) and
     (CheckBox6.checked=False)
     then exit;
  //por defecto si no tiene  NADA que sea Papel
  CIEEnvioFra                := Funciones.primero(ModuloDatos.TablaFacturas.fieldbyname('CIEEnvioFra').asString,'P')[1];
  memo2.Lines.Add(DateToStr(date())+'Tipo Impresion cliente: '+ModuloDatos.TablaFacturas.fieldbyname('CIEEnvioFra').AsString+' Factura: '+ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').AsString);

  AlbaranesNoEncontrados     := 0;

//********************
  if ModuloDatos.TablaFacturas.fieldbyname('CieAdjuntarAlbaranes').Asinteger<>0 then
     RellenaRutasdeAlbaranes
  else
     AlbaranesRutas.Add('en blanco');
//********************
  Impresora                  := UpperCase(ModuloDatos.Impresora);
  NombrePdf                  := NombreFichero;

  if (CompruebaImprimirFra=False) or
     (AlbaranesRutas.Count=0)
    then CIEEnvioFra := 'N'; // para que se salga sin imprimir, ya que el documento Fra no existe

  if CIEEnvioFra = 'N'
     then exit;              // si es Nada, que se salga

  CIEEnvioFraReal:=CIEEnvioFra;
  if (ModuloDatos.Plegadora)
    then CIEEnvioFra:='G'; //PLEGADORA

  if ImpresionSegunFichaCliente then
  begin
     if ModuloDatos.TablaFacturas.fieldbyname('tipoEnvio').AsString<>'E' then
     begin
        memo2.Lines.Add(DateToStr(date())+' Imprimiendo factura...');
        CheckBox5.Checked:=true
     end
     else
     begin
        memo2.Lines.Add(DateToStr(date())+' La factura NO se imprimir� (s�lo email)');
        CheckBox5.Checked:=true;///?????????????????AQU� la �ltima vez pon�a false y no iba bien en bertomeu, lo cambio para loli CIE 04/07/2013 C�RCOLES
     end;
  end;


  if (CheckBox5.Checked)       //quiere imprimir las Fras
    then ImprimeAuxFra;

  if (Checkbox3.Checked) and  (StrToint(Label6.Caption)=1)
    then ImprimeCopiaFra(CIEEnvioFra);   //quiere la copia despues de la fra original


  if ImpresionSegunFichaCliente then
  begin
     if ModuloDatos.TablaFacturas.fieldbyname('CieAdjuntarAlbaranes').Asinteger=-1 then
     begin
        memo2.Lines.Add(DateToStr(date())+' Adjunta albaranes (Si)');
        CheckBox6.Checked:=true
     end
     else
     begin
        memo2.Lines.Add(DateToStr(date())+' Adjunta albaranes (No)');
        CheckBox6.Checked:=false;
     end;

  end;

  if //((Checkbox1.Checked) or
     (CheckBox6.Checked) and//SI MARCADO IMPRIMIR ALBARANES
     (CIEEnvioFra in ['P','A','G','E'])
    then if ModuloDatos.JpgPdf='P'
            then ImprimeAuxAlbPdf
            else ImprimeAuxAlbJpg;

  if ImpresionSegunFichaCliente then
  begin
     if ModuloDatos.TablaFacturas.fieldbyname('tipoEnvio').AsString<>'E' then
     begin
        memo2.Lines.Add(DateToStr(date())+' Imprimiendo copia factura...');
        CheckBox3.Checked:=true
     end
     else
     begin
        memo2.Lines.Add(DateToStr(date())+' La factura NO se imprimir� copia factura(s�lo email)');
        CheckBox3.Checked:=false;
     end;

  end;


  if (Checkbox3.Checked) and (ModuloDatos.Copia.Orden=2)
    then ImprimeCopiaFra(CIEEnvioFra); //quiere la copia despues de los albaranes

  if (ImpresionSegunFichacliente) then
  begin
     if ((moduloDatos.PapelPreImpresoFacturas) and (ModuloDatos.TablaFacturas.fieldbyname('TipoEnvio').asString='E'))
     or (ModuloDatos.TablaFacturas.fieldbyname('CIEEnvioFra').asString='E') then
        CheckBox2.Checked:=true
     else
        CheckBox2.Checked:=false;

  end;

  if (CheckBox2.Checked) and (Previsualizar =False) and
     //(ModuloDatos.TablaFacturas.fieldbyname(CampoUsarEmail).asString<>'') and
     (CIEEnvioFraReal in ['E','A']) //E-mail o ambos
     then EnviaEMail('M');

  if  CheckBox7.Checked
    then EnviaEMail('G'); //PLEGADORA

  if (Checkbox1.Checked) and (CheckBox4.Checked)
    then HojaenBlanco;
end;
//------------------------------------------------------------------------------
function TFormResultado.NombreFichero:String;
var Aux:String;
begin
  Aux:='Albs_de_Fra_'+
        ModuloDatos.TablaFacturas.fieldbyname('EjercicioFactura').asString+
        ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').asString+
        ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString;
 Aux:=ModuloDatos.RutaTemporal+'\'+Aux+'.pdf';
 Result:=Aux;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.SpeedButton3Click(Sender: TObject);
begin
 Una_o_todas:='U';
 Previsualizar :=False;
 AnadeError('Imprimir 1 Factura '+FormatDatetime('  hh:nn:ss',time),'A');
 ImprimirFra;
 VerSiHayErrores;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.FormShow(Sender: TObject);
begin
  case TipoImpresion of
    0 :
       begin
          AdvPanelOpciones.Visible:=false;
          checkbox1.Checked:=true;
          checkbox5.Checked:=true;
          checkbox6.Checked:=true;
       end;
    1 :
       begin
          AdvPanelOpciones.Visible:=false;
          checkbox1.Checked:=true;
          checkbox2.Checked:=true;
       end;
    2:
       begin
          AdvPanelOpciones.Visible:=true;
       end;
    3:
       begin
          AdvPanelOpciones.Visible:=true;
       end;

  end;

  case ModuloDatos.UsoEmail of
    0 : CampoUsarEmail:='Email1';
    1 : CampoUsarEmail:='Email2';
    else CampoUsarEmail:='Email1';
  end;
  frxReport1.LoadFromFile(ModuloDatos.FicheroFRF);
  AdvProgressBar1.Position:=0;
  AdvProgressBar1.Max:= ModuloDatos.TablaFacturas.RecordCount;
  AdvPanel1.Caption.Text:='<P align="center">Facturas : '+InttoStr(ModuloDatos.TablaFacturas.RecordCount)+'</P>';

  funciones.ActivaDesTabla(Modulodatos.TablaEmail);

//  Label1.Caption :='Hacer Copia Fra ';
  if ModuloDatos.Copia.Orden =0
    then begin
           Checkbox3.Checked:=False;
           Checkbox3.Enabled:=False;
         end
    else begin
           Checkbox3.Checked:=true;
           Checkbox3.Enabled:=true;

{
           if ModuloDatos.Copia.Orden=1
             then Begin//Label1.Caption := Label1.Caption+'Despu�s de la Fra'
                    Label1.Top   :=Label13.Top;
                    Label4.Top   :=Label2.Top;
                    CheckBox3.Top:=CheckBox2.Top;
                    CheckBox6.Top:=CheckBox4.Top;
                  end
             else begin//Label1.Caption := Label1.Caption+'Despu�s de los Albs';
                    Label1.Top   :=Label2.Top;
                    Label4.Top   :=Label13.Top;
                    CheckBox3.Top:=CheckBox4.Top;
                    CheckBox6.Top:=CheckBox2.Top;

                  end;
}
         end;

  FormResultado.AdvPanelOpciones.Visible:=not ImpresionSegunFichaCliente;
  FormResultado.AdvPanelOpcionesPrincipal.Visible:=not ImpresionSegunFichaCliente;


end;
//------------------------------------------------------------------------------
procedure TFormResultado.SpeedButton2Click(Sender: TObject);
begin
  Una_o_todas:='T';
  Previsualizar :=False;
  if (ModuloDatos.TablaFacturas.RecordCount > 1) and
     (ModuloDatos.MessageDlgCIE('Est� seguro de Imprimir Todas las Facturas', mtConfirmation,
          [mbYes, mbNo], 0) <> mrYes)
     then exit;

  if ModoPruebasslo1Fra1.Checked
     then begin
            AnadeError('Imprimir todas las Factura Modo Prueba'+FormatDatetime('  hh:nn:ss',time),'A');
            ImprimirFra;
            VerSiHayErrores;
            exit;
          end
     else AnadeError('Imprimir todas las Factura '+FormatDatetime('  hh:nn:ss',time),'A');

  AdvProgressBar1.Position:=0;
  AdvProgressBar1.Max:= ModuloDatos.TablaFacturas.RecordCount;

  AdvProgressBar1.Visible:=True;
  ModuloDatos.TablaFacturas.First;
  memo2.Lines.Clear;
  while not ModuloDatos.TablaFacturas.eof do
     begin
       memo2.Lines.Add(DateToStr(date())+'Imprimiendo cliente: '+ModuloDatos.TablaFacturas.fieldbyname('RazonSocial').AsString+' Factura: '+ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').AsString+' Tipo Env�o: '+ModuloDatos.TablaFacturas.fieldbyname('TipoEnvio').AsString);
       ImprimirFra;
       AdvProgressBar1.Position:=AdvProgressBar1.Position+1;
       ModuloDatos.TablaFacturas.Next;
     end;
   AdvProgressBar1.Visible:=False;
   VerSiHayErrores;
end;
//------------------------------------------------------------------------------

procedure TFormResultado.AnadeError(Error:String;ErrorTexto : Char);
begin
  if ErrorTexto in ['E','e']
    then Errores:=Errores+1;
  FormSacaAvisos.Memo1.text :=FormSacaAvisos.memo1.Text+#13+#10+Error;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.LimpiarErrores1Click(Sender: TObject);
begin
  FormSacaAvisos.Memo1.Clear;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.VerSiHayErrores;
begin
  if Errores>0
    then FormSacaAvisos.ShowModal;
  Errores:=0;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.DBEdit1Change(Sender: TObject);
var StrSQL:String;
begin
  if ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString='' then exit;
  StrSQL:='SELECT  EjercicioAlbaran , SerieAlbaran,  NumeroAlbaran , FechaAlbaran '+
          'FROM    CieImpresionAlbaranes '+
          'WHERE   (EjercicioFactura = '+ModuloDatos.TablaFacturas.fieldbyname('EjercicioFactura').asString+') and '+
                  '(CodigoEmpresa = '+ModuloDatos.TablaFacturas.fieldbyname('CodigoEmpresa').asString+') and '+
                  '(SerieFactura = '+QuotedStr(ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').asString)+' ) and '+
                  '(NumeroFactura = '+ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString+' ) ';

  if ModuloDatos.TablaAlbaranes.Active
   then ModuloDatos.TablaAlbaranes.Active:=False;
  ModuloDatos.TablaAlbaranes.SQL.Clear;
  ModuloDatos.TablaAlbaranes.SQL.Add(StrSQL);
  ModuloDatos.TablaAlbaranes.Active:=true;

  AdvPanel3.Caption.Text:='<P align="center">Albaranes de la factura seleccionada : '+InttoStr(ModuloDatos.TablaAlbaranes.RecordCount)+'</P>'
end;
//------------------------------------------------------------------------------
Function TFormResultado.PonComandos(cadena:String):String;
begin
  if ModuloDatos.TrabajoConCadenas then
    Cadena := funciones.CambiarSubCadena(Cadena,'@',trim(ModuloDatos.TablaFacturas.fieldbyname('CieClienteCadena').asString))
  else
    Cadena := funciones.CambiarSubCadena(Cadena,'@',trim(ModuloDatos.TablaFacturas.fieldbyname('CodigoCliente').asString));
  Cadena := funciones.CambiarSubCadena(Cadena,'#',trim(ModuloDatos.TablaFacturas.fieldbyname('EjercicioFactura').asString));
  Cadena := funciones.CambiarSubCadena(Cadena,'%',trim(ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString));
  Cadena := funciones.CambiarSubCadena(Cadena,'$',trim(ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').asString));
  Cadena := funciones.CambiarSubCadena(Cadena,'&',trim(ModuloDatos.TablaFacturas.fieldbyname('FechaFactura').asString));
  Result:=Cadena;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.EnviaEmail(Const Fra,Albs:String);
var Aux,Asunto,Cuerpo,Email,CopiaFra : String;
begin
  CopiaFra:=RutaFraCopia(Fra);
  if ModuloDatos.UsoEmail=0
    then Email := ModuloDatos.TablaFacturas.fieldbyname('Email1').asString
    else Email := ModuloDatos.TablaFacturas.fieldbyname('Email2').asString;

  if ModoPruebasslo1Fra1.Checked
    then Email:=ModuloDatos.SMTPEmailYo;


  Adjuntos.Clear;
  Mensage.Clear;

  Asunto := PonComandos(ModuloDatos.SMTPAsunto);
  Cuerpo := PonComandos(ModuloDatos.SMTPCuerpo1)+#13+#10+
            PonComandos(ModuloDatos.SMTPCuerpo2)+#13+#10+
            PonComandos(ModuloDatos.SMTPCuerpo3);
  Mensage.Add(PonComandos(ModuloDatos.SMTPCuerpo1));
  Mensage.Add(PonComandos(ModuloDatos.SMTPCuerpo2));
  Mensage.Add(PonComandos(ModuloDatos.SMTPCuerpo3));

  if Fileexists(Fra)  then Adjuntos.Add(Fra);
  if Fileexists(Albs) then Adjuntos.Add(Albs);
  if CheckBox3.Checked and Fileexists(CopiaFra) then Adjuntos.Add(CopiaFra);

  Aux:=ModuloDatos.EnviarEmail( ModuloDatos.SMTPEmailYo,Email,Asunto,
                              ModuloDatos.SMTPPuerto,ModuloDatos.SMTPHost,
                              ModuloDatos.SMTPUsuario,ModuloDatos.SMTPPass,
                              Asunto,Mensage,Adjuntos,0,ModuloDatos.TablaAux2,true);
  if Aux<>''
    then AnadeError('No se envio E-Mail : '+EMail+'  '+Aux,'E');

  ModuloDatos.TablaEmail.Insert;
  if ModuloDatos.TrabajoConCadenas then
    ModuloDatos.TablaEmail.FieldByName('CodigoCliente').asString :=
       ModuloDatos.TablaFacturas.fieldbyname('CieClienteCadena').asString
  else
    ModuloDatos.TablaEmail.FieldByName('CodigoCliente').asString :=
       ModuloDatos.TablaFacturas.fieldbyname('CodigoCliente').asString;
  ModuloDatos.TablaEmail.FieldByName('IdDelegacion').asString :=
     ModuloDatos.TablaFacturas.fieldbyname('IdDelegacion').asString;
  ModuloDatos.TablaEmail.FieldByName('CodigoEmpresa').asString :=
     ModuloDatos.TablaFacturas.fieldbyname('CodigoEmpresa').asString;
  ModuloDatos.TablaEmail.FieldByName('RazonSocial').asString :=
     ModuloDatos.TablaFacturas.fieldbyname('RazonSocial').asString;
  ModuloDatos.TablaEmail.FieldByName('Email1').asString    := Email;
  ModuloDatos.TablaEmail.FieldByName('Asunto').asString    := Asunto;
  ModuloDatos.TablaEmail.FieldByName('Cuerpo').asString    := Cuerpo;
  ModuloDatos.TablaEmail.FieldByName('Adjunto1').asString  := Fra;
  ModuloDatos.TablaEmail.FieldByName('Adjunto2').asString  := Albs;
  ModuloDatos.TablaEmail.FieldByName('Intentos').asinteger := 1;
  ModuloDatos.TablaEmail.FieldByName('Fecha').asDatetime   := now();
  ModuloDatos.TablaEmail.FieldByName('FechaEnvio').asDatetime := now();
  ModuloDatos.TablaEmail.FieldByName('Usuario').asString      := funciones.DimeCadena(ModuloDatos.UsuarioLogic,1);
  ModuloDatos.TablaEmail.FieldByName('Maquina').asString      := Funciones.DameNombrePC;
  if Aux<>''
    then ModuloDatos.TablaEmail.FieldByName('enviado').asInteger      := 0

    else ModuloDatos.TablaEmail.FieldByName('enviado').asInteger      := -1;
  ModuloDatos.TablaEmail.Post;
end;

//------------------------------------------------------------------------------
procedure TFormResultado.RellenaRutasdeAlbaranes;
var Aux,Nombre,Nombre2,ContStr,FraAux:String;
    Cont,Hay,Error:Integer;
    StrCliente,StrEjercicio,StrNumero,StrSerie, Ruta   :String;
//-------------------------
function anade(Nombre:String):Boolean;
begin
  Result := True;
  if Fileexists(Nombre)
    then begin
          AlbaranesRutas.Add(Nombre);
          if (ModuloDatos.JpgPdf ='J') and
             (ModuloDatos.TablaAlbaranes.RecordCount>=ModuloDatos.RedudirJPG) and
             (Funciones.Reduce(Nombre,'',500000,False,False)=2)
            then AnadeError('Error al reducir tama�o al fichero '+Nombre,'E');
         end
    else Result:= False
end;
//-------------------------
Procedure RevisaRuta(Nombre:string);
begin
  Error :=0;
  Cont  :=0;
  Hay   :=0;
  FraAux:=ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').asString+' - '+
          ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').asString;

  if (moduloDatos.ContadorHojas) and  (Anade(Nombre)=False)
    then begin
          inc(Error);//intentamos a�adir el mismo sin pagina
         { AnadeError('No se encuentra "'+Nombre+'" de Alb. '+
                   ModuloDatos.TablaAlbaranes.fieldbyname('SerieAlbaran').asString+' '+
                   ModuloDatos.TablaAlbaranes.fieldbyname('NumeroAlbaran').asString+' ( '+
                   ModuloDatos.TablaAlbaranes.fieldbyname('FechaAlbaran').asString+' ) de Fra '+Aux,'E');}
         end;
  while Error<10 do
    begin
      Nombre2:='_'+InttoStr(Cont);
      if ModuloDatos.JpgPdf='P'
        then begin
               Nombre2:=Funciones.CambiarSubCadena(Nombre,'.pdf', Nombre2);
               Nombre2:=Nombre2+'.pdf';
             end
        else begin
               Nombre2:=Funciones.CambiarSubCadena(Nombre,'.jpg', Nombre2);
               Nombre2:=Nombre2+'.jpg';
             end;
      if Anade(Nombre2)
        then inc(Hay)
        else inc(Error);//intentamos a�adir el mismo sin pagina
      Inc(Cont);
    end;

  if ((Hay=0) and (ModuloDatos.TablaFacturas.fieldbyname('CieAdjuntarAlbaranes').Asinteger=-1)) then
  begin
           AnadeError('No se encuentran ficheros de Alb. '+
                   ModuloDatos.TablaAlbaranes.fieldbyname('SerieAlbaran').asString+' '+
                   ModuloDatos.TablaAlbaranes.fieldbyname('NumeroAlbaran').asString+' ( '+
                   ModuloDatos.TablaAlbaranes.fieldbyname('FechaAlbaran').asString+' ) de Fra '+
                   FraAux+'  '+Nombre,'E');
           AlbaranesNoEncontrados :=AlbaranesNoEncontrados+1;
  end;

end;
//-------------------------
begin
  AlbaranesRutas.Clear;
  AlbaranesNumero:=0;
  ModuloDatos.TablaAlbaranes.DisableControls;
  ModuloDatos.TablaAlbaranes.First;
  while not(ModuloDatos.TablaAlbaranes.Eof) do
    begin
      if ModuloDatos.TrabajoConCadenas then
        StrCliente    := '0000000000000000'+trim(ModuloDatos.TablaFacturas.FieldByName('CieClienteCadena').asString)
      else
        StrCliente    := '0000000000000000'+trim(ModuloDatos.TablaFacturas.FieldByName('CodigoCliente').asString);
      StrCliente    := Funciones.UltimasLetras(StrCliente,ModuloDatos.LongitudCliente); //15 defecto
      StrEjercicio  := ModuloDatos.TablaAlbaranes.FieldByName('EjercicioAlbaran').asString;
      StrNumero     := '000000000000'+ModuloDatos.TablaAlbaranes.FieldByName('NumeroAlbaran').asString;
      StrNumero     := Funciones.UltimasLetras(StrNumero,ModuloDatos.LongitudNumeroCliente); //10 defecto
      StrSerie      := '000000000000'+trim(ModuloDatos.TablaAlbaranes.FieldByName('SerieAlbaran').asString);
      StrSerie      := Funciones.UltimasLetras(StrSerie,ModuloDatos.LongitudSerieCliente);  //10 por defecto
      Ruta   := ModuloDatos.RutaAlbaranes;
      Ruta   :=funciones.CambiarSubCadena(Ruta,'@',StrCliente); //CodigoCliente
      Ruta   :=funciones.CambiarSubCadena(Ruta,'*',Empresa);   //E,presa
      Ruta   :=funciones.CambiarSubCadena(Ruta,'#',StrEjercicio); //Ejercicio
      Ruta   :=funciones.CambiarSubCadena(Ruta,'%',StrNumero);
      Ruta   :=funciones.CambiarSubCadena(Ruta,'$',StrSerie);
      RevisaRuta(Ruta);
      ModuloDatos.TablaAlbaranes.Next;
    end;
  ModuloDatos.TablaAlbaranes.EnableControls;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.frxReport1GetValue(const VarName: String;  var Value: Variant);
begin
  if (CompareText(VarName, 'Ruta') = 0)
    then begin
           Value := AlbaranesRutas.Strings[AlbaranesRoca.RecNo];
         end;
end;
//------------------------------------------------------------------------------
Function TFormResultado.RutaFraCopia(Nombre:String):String;
var aux : string;
begin
  Aux := Funciones.CambiarSubCadena(Nombre,'.Pdf','Copia.Pdf');
  Aux := ExtractfileName(Aux);
  Result:= ModuloDatos.RutaTemporal+'\'+Aux;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.ImprimeCopiaFra(CIEEnvioFra:Char);
var Agua: TgtTextWatermarkTemplate;
    Aux :String;
begin
if moduloDatos.PapelPreImpresoFacturas then
begin
  if not Previsualizar then
     if ModuloDatos.TablaFacturas.fieldbyname('TipoEnvio').asString='E' then exit;
  //s�lo papel, para email no tiene sentido
end;
  
  if (CheckBox1.Checked=False ) And (CheckBox2.Checked=False )
    then  exit;
  if (CheckBox3.Checked=False )
    then  exit;

  Aux       := ModuloDatos.TablaFacturas.fieldbyname('Ruta').asString;
  PDFCopiaDoc.LoadFromFile(Aux);
  Aux       := FormResultado.RutaFraCopia(Aux);
  Agua := TgtTextWatermarkTemplate.Create;
  Agua.Text       := ModuloDatos.Copia.Texto;
  Agua.Angle      := ModuloDatos.Copia.Angulo;
  Agua.Font.Name  := ModuloDatos.Copia.FontName;
  Agua.Font.Color := ModuloDatos.Copia.Color;
  Agua.Font.Size  := ModuloDatos.Copia.FontSize;
  Agua.RenderMode := rmStroke;
  Agua.HorizPos   := hpCenter;
  Agua.VertPos    := vpMiddle;
  Agua.Overlay    := False;
  PDFCopiaDoc.InsertWatermark(Agua);


  if (CIEEnvioFra in ['E','A','G']) or (CheckBox2.Checked)//guarda el fichero si quiere copia
    then PDFCopiaDoc.SaveToFile(Aux);

  if (CheckBox1.Checked=False ) or (not(CIEEnvioFra  in ['P','A']))
    then exit;

  if Previsualizar
     then begin
            PDFCopiaDoc.SaveToFile(Aux);
            LeePdf(Aux);
          end
     else begin
              if ModuloDatos.EligeImpresoraCopiaFra = 0 then//por defecto
              begin
                 ;//no hace nada
              end
              else
              begin
                 if ModuloDatos.ImpresoraCopiaFra='' then ModuloDatos.ImpresoraCopiaFra:=ModuloDatos.ImpresoraFra;
                 gtPDFPrinter2.SelectPrinterByIndex(Modulodatos.ExisteImpresoraWin(ModuloDatos.ImpresoraCopiaFra));  //gtPDFPrinter1.SelectPrinterByName(Impresora);
              end;

           //blanco/negro o color
           case ModuloDatos.ColorCopiaFactura of
              0:gtPDFPrinter2.AdvancedPrinterSettings.Color:=cmMonochrome;
              1:gtPDFPrinter2.AdvancedPrinterSettings.Color:=cmColor;
           end;

           //N� de bandeja
           Try
              if ModuloDatos.BandejaCopiaFactura>0 then
                 gtPDFPrinter2.AdvancedPrinterSettings.BinIndex:=ModuloDatos.BandejaCopiaFactura;
           Except
              Showmessage('Error eligiendo Bandeja (Copia Factura), revise la configuraci�n, el proceso continuar�.');
           end;


            gtPDFPrinter2.PrintDoc ;     //cambiar tipo de impresion
          end;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.HojaenBlanco;
var Impreso:TextFile;
begin
//c�rcoles: 23/01/2013: lo comento de momento 
{  with printer do
  begin
    assignPrn(Impreso);
    rewrite(Impreso);
    Writeln(Impreso,'');
    closeFile(Impreso)
  end;//with
}
end;
//------------------------------------------------------------------------------
procedure TFormResultado.SpeedButton4Click(Sender: TObject);
begin
  Una_o_todas:='U';
  Previsualizar :=True;
  AnadeError('Previsualizar 1 Factura '+FormatDatetime('  hh:nn:ss',time),'A');
  ImprimirFra;
  VerSiHayErrores;
  Previsualizar :=false;
end;
//------------------------------------------------------------------------------
procedure TFormResultado.Label2Click(Sender: TObject);
begin
  CheckBox4.Checked:=not(CheckBox4.Checked);
end;
//------------------------------------------------------------------------------
procedure TFormResultado.Label13Click(Sender: TObject);
begin
  CheckBox2.Checked:=not(CheckBox2.Checked);
end;
//------------------------------------------------------------------------------
procedure TFormResultado.Label12Click(Sender: TObject);
begin
  CheckBox1.Checked:=not(CheckBox1.Checked);
end;
//------------------------------------------------------------------------------
procedure TFormResultado.Label3Click(Sender: TObject);
begin
  CheckBox5.Checked:=not(CheckBox5.Checked);
end;
//------------------------------------------------------------------------------
procedure TFormResultado.Label4Click(Sender: TObject);
begin
  CheckBox6.Checked:=not(CheckBox6.Checked);
end;
//------------------------------------------------------------------------------
procedure TFormResultado.Label1Click(Sender: TObject);
begin
  CheckBox3.Checked:=not(CheckBox3.Checked);
end;
//------------------------------------------------------------------------------
procedure TFormResultado.EnviaEmailLogic(Const Fra,Albs:String);
begin
  ModuloDatos.TablaEmail.Insert;
  ModuloDatos.TablaEmail.FieldByName('SysUserFrom').AsString   := Funciones.DimeCadena(ModuloDatos.UsuarioLogic,1);
  ModuloDatos.TablaEmail.FieldByName('SysTypeAdvice').AsInteger:= ModuloDatos.PrioridadEnvios;
  ModuloDatos.TablaEmail.FieldByName('SysFolder').AsString    :='4';
  ModuloDatos.TablaEmail.FieldByName('Sysdate').AsString      :=FormatDatetime('dd/mm/yyyy',Date());
  ModuloDatos.TablaEmail.FieldByName('SysTime').Asfloat       :=time();
  ModuloDatos.TablaEmail.FieldByName('SysdateRead').AsString  :='0:00:00';
  ModuloDatos.TablaEmail.FieldByName('SysUsertolist').AsString:=ModuloDatos.SMTPEmailYo;//'Santos@grupocie.com';
  ModuloDatos.TablaEmail.FieldByName('SysSubject').AsString   :=ModuloDatos.SMTPAsunto;
  ModuloDatos.TablaEmail.FieldByName('SysMessage').AsString   :=
                                                        ModuloDatos.SMTPCuerpo1+
                                                        ModuloDatos.SMTPCuerpo2+
                                                        ModuloDatos.SMTPCuerpo3;
  ModuloDatos.TablaEmail.FieldByName('SysFileAdvice').AsString:= Fra; //0D7A7562-AF3D-4C60-AF2E-5D8A81C5DF70
 // ModuloDatos.TablaEmail.FieldByName('SysTitleFile').AsString:=Fra;
  ModuloDatos.TablaEmail.FieldByName('SysFileAdvice2').AsString:=Albs;
 // ModuloDatos.TablaEmail.FieldByName('SysTitleFile2').AsString:=Albs;
  if CheckBox3.Checked
    then ModuloDatos.TablaEmail.FieldByName('SysFileAdvice3').AsString:= RutaFraCopia(Fra);
  ModuloDatos.TablaEmail.Post;
end;

//------------------------------------------------------------------------------

//----------------
{Procedure ImprimeAuxAlbPdf;
var Aux:String; a:Integer;
    kk:Boolean;
    SetDuplexPrintingMode: TgtDuplexPrintingMode;
    elHandle: tHandle;
begin
  kk:=gtPDFPrinter1.PrinterCapabilities.Duplex;
  a :=Modulodatos.ExisteImpresoraWin(ModuloDatos.Impresora);
  if ModuloDatos.EligeImpresora = 0
    then
    else gtPDFPrinter1.SelectPrinterByIndex(a);  //gtPDFPrinter1.SelectPrinterByName(Impresora);

  PDFDoc.MergeDocs(AlbaranesRutas);
  if Previsualizar
     then begin
            Aux:= AlbaranesRutas.Strings[0];
            Aux:= ExtractFileDir(Aux);
            Aux:=ModuloDatos.RutaTemporal+'\kk.Pdf';
            PDFDoc.SaveToFile(Aux);
            LeePdf(Aux);
          end
     else begin
            SetDuplexPrintingMode :=dpmVertical;
            kk:=gtPDFPrinter1.PrinterCapabilities.Duplex;
            gtPDFPrinter1.AdvancedPrinterSettings.DuplexPrintingMode := dpmHorizontal;// SetDuplexPrintingMode;  //dpmHorizontal - dpmNone
            gtPDFPrinter1.AdvancedPrinterSettings. DuplexPrintingMode := SetDuplexPrintingMode;  //dpmHorizontal - dpmNone

              if (Checkbox1.Checked) and
                 (CIEEnvioFra in ['P','A'])
                 then begin
                        gtPDFPrinter1.Execute;
                        gtPDFPrinter1.PrintDoc;
                      end;
          end;
end;}


end.