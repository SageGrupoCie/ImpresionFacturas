unit Funciones;

interface
uses
  Dialogs, windows, Controls, FileCtrl, Sysutils, ComObj, StdCtrls,
  Math, ShellAPI, ExtCtrls, PrinterS, Graphics, IdHTTP, DateUtils,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, idmessage, IdException, Forms, classes,
  Buttons, ADODB, DB, DBCtrls, {DBTables, }variants, Grids, BaseGrid, AdvGrid,
  DBAdvGrid,DBGrids,Registry,AdoConEd,Menus,Jpeg,AdvPanel,MMSYSTEM,Winsock,WinSpool,
  IdAttachmentFile;

type
   TNada = class // Clase falsa para asignar eventos de handlers en un onClick
       procedure PulsaClick(Sender: TObject) ;
   end;

const
  CONST_ERROR = '@#ERROR#@';
  B36        : PChar = ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');

  A0 = 'Cero';
  A1 = 'Uno'; A1A = 'Una'; B1 = 'Dieci';
  A2 = 'Dos'; A1b = 'Un'; B2 = 'Veinte'; B2b = 'Veinti';
  A3 = 'Tres'; B3 = 'Treinta';
  A4 = 'Cuatro'; B4 = 'Cuarenta'; C1 = 'Mil';
  A5 = 'Cinco'; A5b = 'Quinien'; B5 = 'Cincuenta'; C2 = 'Millón,';
  A6 = 'Seis'; B6 = 'Sesenta'; C3 = 'Millones,';
  A7 = 'Siete'; A7b = 'Sete'; B7 = 'Setenta';
  A8 = 'Ocho'; B8 = 'Ochenta';
  A9 = 'Nueve'; A9b = 'Nove'; B9 = 'Noventa'; P0 = ' ';
  A10 = 'Diez'; B10 = 'Cien'; P1 = 'y';
  A11 = 'Once'; P2 = 'con';
  A12 = 'Doce'; B = '';
  A13 = 'Trece'; U1 = 'Décima'; PLURALES = 's';
  A14 = 'Catorce'; U2 = 'Centésima'; MASCUL = 'to';
  A15 = 'Quince'; U3 = 'Milésima'; MASCULS = 'tos';
  FEMEN = 'ta';
  FEMENS = 'tas';

var
  Nada:TNada;

  Fvisible: smallint;
  EMPRESA, DIRECCION: string[100];
  TELEFONO, FAX, NOMBRE1, NOMBRE2, NOMBRE3, NOMBRE4, NOMBRE5, nombre6: string[20];
  FuerzaCopiasImprimir:Integer;
  QueAplicacion, EstoyEn, IMPRESORATERMINAL: string;
  EsSQLserver,EsFechaInglesa : Boolean;
  HablaOrdenador : Byte;//0 NO, 1 titulos, 2 Titulo y texto, 3 Texto


function obtenerNombrePC () : string;

Procedure SacaTexto(Texto:String);

procedure PrintImage(Image: TImage; ZoomPercent: Integer);
procedure DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
function CalculaDC(Banco, Cuenta: string):integer;
procedure IgualaLimites(Desde, Hasta: TEdit);
procedure MuestraFlat(Formulario: TForm; Valor: Boolean);
function MuestraMensaje(Texto, Titulo, Tipo, Botones: string; Defecto: Integer): Integer;
procedure Pita(Ruta:String);

{Maquina S.O.}
function DameNombrePC: string;
function ObtenerIPPublicaPCLocal(webIP, textoBuscar: string): string;
Function ObtenerIPLocal():String;
Function ResolucionPantalla(var Ancho,Alto: integer):string;
function EstamosEnGrupoCie: Boolean;
procedure CtrAltSup_Desconecta;
procedure CtrAltSup_Conecta;

{Bases de Datos}
Function NumeroRegistros(CampoCodigo,Tabla:String;TablaAux:TADOQuery):Integer;
function ExisteObjetoSQLSERVER(const Nombre,Tipo: string; TablaSQLAux: TAdoQuery): Boolean;
function DameCampos(Campos:array of string):string;
function DameValores(Campos,Valores:array of String):String;
function AbreTablaCon(NombreTabla:string;Campos:array of string;
                      Valores:array of string;TablaAux:TDataSet): String;
function ExisteRegistro(NombreTabla:string;Campos:array of string;
                        Valores:array of string;TablaAux:TDataSet;OtrosCampos:array of string): boolean;
function DameCadenaConexionADO(RutaFicheroMDB: string; Proveedor: Integer): string;
function filtro(comando, campo, texto, condicion: string; estexto: boolean): string;
function filtrono(comando, campo, texto, condicion: string): string;
function filtro2(comando, campo, texto, condicion: string; estexto: boolean): string;
function filtrono2(comando, campo, texto, condicion: string): string;
function HayBusqueda(cadena: string): boolean;
procedure RellenacomboImprimir(combo: Tcombobox);
function DimecomboImprimir(combo: Tcombobox): char;
function RegistraEMail(EmailDestino, Asunto,sMensaje:String;
                       slMensaje, slFicherosAdjuntos: TStrings;
                       TipoEnvio,error:String;TablaSQLAux: TADOQuery): string;
function RegistraEMail_2(EmailDestino, Asunto,sMensaje:String;
                       slMensaje, slFicherosAdjuntos: TStrings;
                       TipoEnvio,error:String;TablaSQLAux: TADOQuery): string;
                       
procedure CopiaCombo(var ComboOrigen, ComboDestino: TComboBox);
Procedure ActivaDesTabla(Tabla:TDataSet);
function DimeCombo(Combo: TComboBox; Como: Integer): string;
Function ExisteCampo(Campo:String;Tabla:TDataSet):Boolean;
Function ExisteCampoAdo(Campo:String;Tabla:TCustomADODataSet):Boolean;
Function ConstruyeInsertInto(Tabla:String;Campos,Valores,Tipos : array of string):String;
Function CambiarStringConexion(ADOConnection:TADOConnection;Programa,ConexionStr:String):Boolean;
procedure Conectar(ADOConnection:TADOConnection;Programa,ConexionStr:String);
Function CadenaSQLServer(SQL: string):String;
Function CadenaSQLServerFechas(SQL: string):String;
Function SepararSELECTSQL(QUERY : TADOQuery; var _SELECT, _FROM, _WHERE, _GROUP_BY, _HAVING, _ORDER_BY :string):Boolean;
Function MoverteEnTablaADO(Cual,tipodato:Char;dato,nombretabla,campo,filtro,codigoactual,claveprimaria:String;tabla:TAdoQuery):String;
{Fechas}
function PrimerDiaanyo:Tdate;
function UltimoDiaanyo:Tdate;
function DiaJuliano(Fecha: Tdatetime; Rellena: Boolean): string;
function AnyoyDiaJuliano(Fecha: Tdatetime): string;
function ANO(fecha: string): string;
function ANOCorto(fecha: string): string;
function Mes(fecha: string): string;
function Dia(fecha: string): string;
function Hora(Cadena: string): string;
function fechahoy(como: integer; fecha: string; Idioma: Char): string;
function fechaInglesa(Fecha: TDate): string;
function FechaInglesaDeUnStr(fechaencadena:string):string;
Function FechaInglesaEspanola(Fecha: string):String;
function FechaReves(Fecha: TDate): string;
function FechaReves2(Fecha: TDate): string;
function NumeroDiasdelMes(mes, ano: integer): integer;
function UltimoDiadelMes(mes, ano: integer): Tdate;
function PrimerDiadeSemana(fecha: Tdate): Tdate;
function UltimoDiadeSemana(fecha: Tdate): Tdate;
function PrimerDiadelMes(mes, ano: integer): Tdate;
function PrimerDiadelMesActual(fecha: TDate): Tdate;
function NumeroMes(mes: string): integer;
function MesNumero(num: integer): string;
function MesNumeroCor(num: integer): string;
function MesLarCor(mes: string; largo: boolean): string;
function AnoBisiesto(Fecha: TDate): Boolean;
function MismoMes(Fecha1, fecha2: TDate): Boolean;
procedure FechasPrefijadas(var FechaIni: Tdate; var FechaFin: Tdate; Como: Byte);
procedure RellanaFechasPrefijadas(Lista: TStrings);
function MesesEntreFechas(FechaINI, FechaFIN: TDateTime; Como: Integer): Integer;
function SemanasEntreFechas(FechaINI, FechaFIN: TDateTime; Como: Integer): Integer;
function ComponCuenta(Cta, Codigo: string; Longitud: Integer): string;
function IsDate(Date: variant): boolean;
function NumerodeSemana(Fecha: TDate): Integer;

//  function PrimerDiadelANO(fecha:TDate): Tdate;
//  function UltimoDiadelANO(fecha:TDate): Tdate;

//TablaAux
Procedure TablaAuxLimpia(TablaAux:TADOQuery;CondicionExtra,Usuario:String);
Procedure TablaAuxAbre(Tabla:TADOQuery;SentenciaEspecial,CondicionExtra,Usuario:String);
Procedure TablaAuxEjecutaUpdate(TablaAux:TADOQuery;Sentencia,Usuario:String);
Procedure TablaAuxEjecutaInsert(TablaAux:TADOQuery;Sentencia,Usuario:String);
procedure TablaAuxNewRecord(DataSet: TDataSet;Usuario:string);


{Ficheros}
procedure ComprimirZIP(Origen, Destino: string);
function CuentaLineasFichero(sFile: string): Integer;
function FileLength(sFile: string): Integer; //PARA FICHEROS DE TEXTO Y BINARIOS
function LongitudFichero(fichero: string): single; //SOLO PARA FICHEROS BINARIOS
function LongitudFichero2(fichero: string): Integer; //TAMAÑO SIN NECESIDAD DE ABRIR EL FICHERO
procedure ExtraeFile(var nombre: string; var dir: string);
procedure ExtraeNombre(var nombre: string; var extension: string);
function Junta(nombre, dir: string): string;
function ExisteFichero(FileName: string): Boolean;
function LimpiaRuta(Ruta: string): string;
function CreaDirectorio(Dir: string): Boolean;
function NombreUsuario: string;
procedure CopiarDirectorio(Origen, Desti: string);
procedure EliminarDirectorio(cPath: string); //Elimina Tambíén los SubDirectorios
procedure BuscarEnCombo(ComboBox:TComboBox;Codigo:String);
function EscribeFichero(Fichero, LineaReg: string): Boolean;
procedure RenombraFichero(NomOld,NomNew:String);// ¡¡ojo!! borra el fichero en caso de existir
function TamanoFichero(NombreFichero:String):LongInt;
Function ExtensionFichero(const Ruta:String):String;
{Números}
function SoloNumeroInt(Key: Char): char;
function NumerosSolo(cadena: string): string;
function PuntosNumero(cadena: string): string;
function SumameInteger(Suma: longint; que: string): longint;
function PtsaEcu(pts, cambio: real): real;
function EcuaPts(Ecu, cambio: real): real;
function MasPorCiento(base, tanto: real): real;
function MenosPorCiento(base, tanto: real): real;
function tantoPorCiento(base, tanto: real): real;
function MenosIva(base, tanto: real): real;
function MasIva(base, tanto: real): real;
function EsPar(numero: integer): boolean;
function NReal(Cadena: string; Defecto: Real): Real;
function NEntero(Cadena: string; Defecto: integer): Integer;
function IsNumber(S: string): Boolean;
function IsDouble(S: variant): Boolean;

function Maximo(A, B: Integer): Integer;
function Minimo(A, B: Integer): Integer;
function MaximoReal(A, B: Real): Real;
function MinimoReal(A, B: Real): Real;

procedure MaximoMinimo(var Max, Min: Integer);
procedure MinimoMaximo(var Min, Max: Integer);
procedure MaximoMinimoReal(var Min, Max: Real);
procedure MinimoMaximoReal(var Min, Max: Real);
function EnteroEntreValores(Numero, Minimo, Maximo: Integer): Boolean;
function Redondea(const X: Double; decimales: integer): Double;
function RedondeaMoneda(const X: Double): Double;
procedure Conmuta(var Primero, Segundo: Integer);
function Base3000(B3000: Real): Real;
function IntToBase(Valor: int64; Base: byte; Digitos: byte): string;
function BaseToint(Valor: String; Base: byte): int64;

// Números - Cadenas
function NumeroDividido(num: string; Masculino: Boolean): string;
function NumeroLetras(ElNumero, Unidad, SubUnidad: string;
  EsMasculino: boolean; Formato, NoDecimales: Integer; Idioma: Char): string;
function TraduceImporte(Cadena: string; Idioma: Char): string;
function MascaraReal(Numero: Real; Relleno, SimboloDecimal: ShortString;
  Enteros, Decimales: Byte; NegativoJunto: Char): string;
function TraduceBoolean(variable : Boolean):String;
function SimboloDecimal: Char;
function SimboloNoDecimal: Char;
function StrtoFloatSantos(ElNumero: string): Real;
function CtaContable(Cta, Mascara: string): string;
function damecodigo(cadena:string):string;

  //Cadenas
Function Entrecomilla(const cadena:String):String;
function DimeLimite(Edit : TEdit;const Defecto:String):String;
function Primero(cadena: string; Defecto: Char): string; // devuelve el primer caracter del string
function QuitaCaracter(cadena: string; car: char): string;
function QuitaPrimerasLetras(cadena: string; cantidad: Integer): string;
function rellena(cadena, car: string; LongCadena: integer): string; // añade tantos como se indique
function Recorta(cadena, car: string; LongCadena: integer): string; // lo deja como se indique
function rellenaIZQ(cadena, car: string; LongCadena: integer): string;
function RecortaIZQ(cadena, car: string; LongCadena: integer): string;
function CuentaCadenas(cadena, abuscar: string): integer;
function CuentaCar(cadena: string; car: char): integer;
function TieneFormato(cadena, formato: string): boolean;
function SubCadena(cadena: string; ini, fin: integer): string;
Function Componer(Campo1,Campo2:String):String;
function Descomponer(var cadena: string; separador: char): string;
function QuitarChar(cadena: string; Caracter: char): string;
function QuitarChars(cadena: string; Caracteres: array of char): string;
function CambiarChar(cadena: string; ACambiar, CambiarPor: char): string;
function CambiarSubCadena(Cadena, Origen, Destino: string): string;
function StrToPChar(cadena: string): PChar;
function Capital(cadena: string): string;
function HacerNumeroCuenta(cadena, Prefijo: string; Digitos: Integer): string;
function PrimerasLetras(Cadena: string; Cantidad: Integer): string;
function UltimasLetras(Cadena: string; Cantidad: Integer): string;
function QuitarSubCadena(SubCadena, Cadena: string): string;
function RepiteCadenaVacia(car: string; LongCadena: integer): string;
function TextoaMsDOS(Cadena: string): string;
function IntercalarBlancos(Cadena: string; Cuantos: Byte): string;
function DimeCadena(Cadena: string; Como: Integer): string;
function Formatea(sValor, sFormato, sRefCampo: string): string;
function NoNulo(Cadena,Defecto:String):String;
function SeparaCadena(Cadena: string; separador:char; indice: Integer): string;
function DeInaBetween(Cadena : String):String;
function DameRutaCadenaConexion(cadenaconexion:string):string;
{Códigos}
function DNI(cadena: string; avisar: boolean): string;
function DameClave(Cadena, Cadena2, Programa: string): string;
function DameClave2(Car: Char): Byte;
function LimpiaDNI(cadena: string): string;
function CodigoProvincia(Provincia: string): string;
function GeneraId(Base:integer;DigitosMaximo:Byte):String;
Function Descifrar(clave:string):string;
function encriptar(aStr: String; aKey: Integer): String;
function desencriptar(aStr: String; aKey: Integer): String;

function desencriptarCIE(aStr: String): String;
function encriptarCIE(aStr: String): String;
function EsNumero(S: variant): Boolean;

{Sistema}
procedure ejecutar(comando: string; como, DeDonde: integer);
function WinExecAndWait32(FileName:String; Visibility:integer):integer;
function NumeroDisco(DriveChar: Char): string;
procedure LiberarMemoria;
Procedure Habla(Texto:String);
function GetComputerNetName: string;
function CerrarSesion:Boolean;

function  ListaParametrosLee(const Grupo,Parametro,Defecto : String;Tabla:TAdoQuery):String;
Procedure ListaParametrosEscribe(const Grupo,Parametro,Valor : String;Tabla:TAdoQuery);
Procedure ListaParametrosEscribeNONormal(const Grupo,Parametro,Valor : String;Tabla:TAdoQuery);

procedure Traza(Texto: string);
{Libros}
function PuedeSerBarras(cadena: string): boolean;
function PuedeSerBarras13(cadena: string): boolean;
function GuionIsbn(cadena: string): string;
function BienISBN(cadena: string): boolean;
function BarrasISBN(cadena: string): string;
function BarrasCodigo(cadena: string): string;
function BienBarras(cadena: string): boolean;
function ISBNBarras(cadena: string): string;
function ISBNCodigo(cadena: string): string;

{Matemáticas}
function elevado(base, expo: real): real;
function MaxReal(a, b: real): real;
function MinReal(a, b: real): real;
procedure MaxMinReal(var a, b: real);
procedure MaxMinint(var a, b: integer);
function EstaEntre(valor, a, b: real): boolean;
function PtsEuros(Cantidad, ValorEuro: Real; Moneda: string): Real;

 {Internet}
procedure DesconectarInternet; //desconectar si estás con Módem
function FuncAvail(_dllname, _funcname: string; var _p: pointer): boolean; //para saber
function EstoyConectado: boolean; //si estoy conectado o NO
procedure ConectarInternet; //llama al Acceso Telefónico a Redes
procedure BorrarArchivosTemporalesInternet(FicherosAdjuntos: TStrings);
procedure PanelInfo(Mensaje: string; TiempoSg: integer);
//function ConectaSMTP(PuertoSMTP, HostSMTP, UsuarioSMTP, PassSMTP: string): TIdSMTP;
function EnviaEMail(ConexSMTP: TIDSMTP; EmailorigenAux, EmailDestinoAux, tituloAux, sMensaje: string;
                    slMensaje, slFicherosAdjuntos: TStringList): string;
function DesConectaSMTP(ConexSMTP: TIDSMTP): string;

// BASE DE DATOS
procedure CompactarMDB97(Ruta: string);
procedure RepararMDB97(Ruta: string);
function EjecutaSQL(Comando: string; TablaSQLAux: TAdoQuery): Boolean;
function EjecutaSQLADO_Access(Comando: string; TablaSQLAux: TADOQuery): Boolean;
function EjecutaSQLADO(Comando: string; TablaSQLAux: TADOQuery): Boolean;
function AbrirTabla(Tabla: Tdataset; SQL_o_Filtro: string): Integer;
procedure RellenaCombo(var Combo: TComboBox; TablaOri: TDataSet;
                       CampoCodigo, CampoNombre, TextoTodos,SituateEn: string);
procedure RellenaComboADO(var Combo: TComboBox; TablaOri: TADODataSet;
                          CampoCodigo, CampoNombre, TextoTodos: string);
function CreaDataSet: TdataSet;
procedure AbrirADODataset(Tabla: TAdoDataset; SQL: string);
procedure AbrirAdo(Tabla: TADOQuery; SQL: string);
procedure CerrarTablas(Pantalla: TForm);
procedure BloquearTablas(Pantalla: TForm);

procedure DesactivarCampos(Pantalla: TForm);
procedure RellenaComboPositivo(var Combo: TComboBox; TablaOri: TDataSet;
                              CampoCodigo, CampoNombre, TextoTodos: string);
procedure FiltraTabla(Tabla: TDataset; comando: string);
procedure FiltraNoTabla(tabla: TDataSet);
//function ExisteTabla(Tabla: TTable; direccion: string): boolean;
function CopiaRegistro(TablaOrigen, TablaDestino: TDataSet;
                     const CamposModificar, CamposValores, CamposNoCopiar: array of string;
                      anyado, OmitoError: Boolean): Boolean;
function CopiaRegistro2(TablaOrigen, TablaDestino: TDataSet;
const CamposModificar, CamposValores,CamposNoCopiar : array of string;
  anyado, OmitoError, actualizo: Boolean): Boolean;
function ResultadoDeSQL(TablaAux: TDataSet; StrSQL, CampoResultado, Defecto: string; QuieroRecordCount: Boolean): string;
procedure Editar(DataSet: TDataSet);
procedure EditarCancelar(DataSet: TDataSet);
procedure LeerFichero(Fich: string; Combo: TDBcomboBox; Lista: TlistBox);
procedure DBAdvGridCanSort(Sender: TObject; ACol: Integer;
                            var DoSort: Boolean; FieldNameSort:String);
//
procedure GrilBonito(Grid : TDBGrid;Cabeceras,Tamanos,Alineados:String;
                                Negrita:Boolean;CentradoCab:Integer);
procedure GrilBonitoAdv(Grid : TDBAdvGrid;Cabeceras,Tamanos,Alineados,TipoPies,Ediciones:String;
                              Negrita:Boolean;CentradoCab:Integer);
procedure GridBonitoAdv(Grid : TDBAdvGrid;Parametros:String);

procedure MenuSumaGrid(var DBGridADV: TDBAdvGrid);
Procedure AmpliaCombo(Combo:TComboBox;NuevoTamano:Integer;TamanoDoble:Boolean);
function BuscarReg(Tabla:TDataSet;CampoCodigo,CampoDescrip,Valor:String):Boolean;
// Impresora
procedure PaginaenBlanco;
function IsPrinter: Boolean;
function ExisteImpresora(NombreImpresora: string; DiNoEsta: Boolean): Boolean;
Procedure AbreCajon(const Lpt,Comando:String);
Function EstadoImpresora(const PrinterName:string):String;

// Formularios
function MostrarNoModal(AClass: TFormClass; Var Reference; mostrar, crear: boolean; Var EsNueva :boolean):integer;
Procedure CentrarObjeto(que:TForm);
Procedure CentrarAdvPanel(formulario:TForm; advpanl:TAdvPanel);
Procedure CentrarPanel(formulario:TForm; panl:TPanel);

//Graficos
function Reduce(NombreFichero: string; NombreDestino: string;
                TamanyoMax: Longint; MuestraResultado: boolean; Confirma: boolean): Integer;
//Speaker
procedure SetPort(address, Value: Word) ;
function GetPort(address: Word): Word;
procedure Sound(aFreq, aDelay: Integer) ;
procedure NoSound;

{arriba ya estan comentadas}

const Meses: array[1..12] of byte = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

implementation
uses FuncIdiom, SacaAvisosForm, ListadosForm, DatosModulo;
//var
//    EmailsEnviados: Integer;
//    _lActivaTraza_ : Boolean;
//-----------------------------------------------------------------------------

function BienBarras(cadena: string): boolean;
var par, impar, i, suma, len: integer;
begin
  result := false; len := length(cadena);
  if not ((len = 13) or (len = 8) or (len = 18)) then exit;
  par := 0; impar := 0; i := 1;
  if not TieneFormato(cadena, '##################') then exit; {hasta 18 Nºs #}
  if len <> 8 then
    repeat
      impar := impar + strtoint(cadena[i]);
      par := par + strtoint(cadena[i + 1]);
      i := i + 2;
    until i = 13
  else
    repeat
      par := impar + strtoint(cadena[i + 1]);
      impar := par + strtoint(cadena[i]);
      i := i + 2;
    until i = 8;
  suma := impar + par * 3 + strtoint(cadena[len]);
  if (suma mod 10) = 0 then result := true;
end;
//-----------------------------------------------------------------------------
function HayBusqueda(cadena: string): boolean;
begin if pos('*', cadena) > 0 then result := true else result := false; end;
//-----------------------------------------------------------------------------
function EsPar(numero: integer): boolean;
begin result := (numero mod 2) = 0; end;
//-----------------------------------------------------------------------------
procedure MaximoMinimo(var Max, Min: Integer);
var aux: integer;
begin
  if Min > Max then begin
    aux := min; min := max; Max := aux; end;
end;
//-----------------------------------------------------------------------------
procedure MaximoMinimoReal(var Min, Max: Real);
var aux: Real;
begin
  if Min > Max then begin
    aux := min; min := max; Max := aux; end;
end;
//-----------------------------------------------------------------------------
procedure MinimoMaximo(var Min, Max: Integer);
var aux: integer;
begin
  if Min > Max then begin
    aux := min; min := max; Max := aux; end;
end;
//-----------------------------------------------------------------------------
procedure MinimoMaximoReal(var Min, Max: Real);
var aux: Real;
begin
  if Min > Max then begin
    aux := min; min := max; Max := aux; end;
end;
//-----------------------------------------------------------------------------
function Maximo(A, B: Integer): Integer;
begin if a > b then Result := A else Result := B end;
//-----------------------------------------------------------------------------
function Minimo(A, B: Integer): Integer;
begin if a < b then Result := A else Result := B end;
//-----------------------------------------------------------------------------
function MaximoReal(A, B: Real): Real;
begin if a > b then Result := A else Result := B end;
//-----------------------------------------------------------------------------
function MinimoReal(A, B: Real): Real;
begin if a < b then Result := A else Result := B end;
//-----------------------------------------------------------------------------
procedure Conmuta(var Primero, Segundo: Integer);
var aux: integer;
begin
  aux := Primero; Primero := Segundo; Segundo := aux;
end;
//-----------------------------------------------------------------------------
function SubCadena(cadena: string; ini, fin: integer): string;
begin
  result := copy(cadena, ini, fin - ini + 1);
end;
//-----------------------------------------------------------------------------
function BienISBN(cadena: string): boolean;
var suma, i: integer;
begin
  result := false; cadena := Uppercase(cadena);
  if (CuentaCar(cadena, '-') = 3) and (length(cadena) = 13) then
    cadena := QuitaCaracter(cadena, '-');
  if (length(cadena) <> 10) or (not TieneFormato(cadena, '#########!')) then
    exit;
  if cadena[10] = 'X' then suma := 10
  else if cadena[10] in ['0'..'9'] then suma := strtoint(cadena[10])
  else exit;
  for i := 1 to 9 do suma := suma + ((11 - i) * strtoint(cadena[i]));
  result := (suma mod 11) = 0;
end;
//-----------------------------------------------------------------------------
function BarrasISBN(cadena: string): string;
var aux: string;
  suma, i: integer;
begin
  result := CONST_ERROR; suma := 0;
  if (not TieneFormato(cadena, '##############')) or
    (length(cadena) < 13) then exit;
  if subcadena(cadena, 1, 3) <> '978' then exit;
  aux := subcadena(cadena, 4, 12);
  for i := 1 to 9 do
    suma := suma + ((11 - i) * strtoint(aux[i]));

  suma := 11 - (suma mod 11);
  if suma = 11 then suma := 0;
  if suma = 10 then aux := aux + 'X'
  else aux := aux + inttostr(suma);
  aux := GuionIsbn(aux);
  result := aux;
end;
//-----------------------------------------------------------------------------
function BarrasCodigo(cadena: string): string;
var aux: string;
  suma, i: integer;
begin
  result := CONST_ERROR; suma := 0;
  if (not TieneFormato(cadena, '##############')) or
    (length(cadena) < 13) then exit;
  if subcadena(cadena, 1, 3) <> '978' then exit;
  aux := subcadena(cadena, 4, 12);
  for i := 1 to 9 do
    suma := suma + ((11 - i) * strtoint(aux[i]));
  suma := 11 - (suma mod 11);
  if suma = 11 then suma := 0;
  if suma = 10 then aux := aux + 'X'
  else aux := aux + inttostr(suma);
  result := aux;
end;
//-----------------------------------------------------------------------------
function ISBNBarras(cadena: string): string;
var par, impar, suma, i: integer;
  aux: string;
begin
  result := CONST_ERROR; suma := 0;
  if not BienISBN(cadena) then exit;
  cadena := QuitaCaracter(cadena, '-');
  aux := '978' + SubCadena(cadena, 1, 9);
  par := 0; impar := 0; i := 1;
  repeat
    impar := impar + strtoint(aux[i]);
    par := par + strtoint(aux[i + 1]);
    i := i + 2;
  until i = 13;
  suma := impar + par * 3;
  suma := 10 - (suma mod 10);
  result := aux + inttostr(suma);
end;
//-----------------------------------------------------------------------------
function ISBNCodigo(cadena: string): string;
begin
  result := CONST_ERROR;
  if not BienISBN(cadena) then exit;
  result := QuitaCaracter(cadena, '-');
end;
//-----------------------------------------------------------------------------
function GuionIsbn(cadena: string): string;
var aux: string;
  pais, edi: integer;
begin
  result := CONST_ERROR;
  if ((CuentaCar(cadena, '-') > 0) or (length(cadena) <> 10)) then exit;
  aux := SubCadena(cadena, 1, 9) + '-' + SubCadena(cadena, 10, 10);
  case cadena[1] of {Si es Americano o Inglés}
    '0': pais := 1;
    '9': pais := 3;
  else pais := 2
  end; {del case}
  if SubCadena(cadena, 3, 5) < '20' then edi := 2
  else if SubCadena(cadena, 3, 6) < '700' then edi := 3
  else if SubCadena(cadena, 3, 7) < '8500' then edi := 4
  else edi := 5;
  result := SubCadena(cadena, 1, pais) + '-' + SubCadena(cadena, pais + 1, pais + edi) + '-' +
    SubCadena(aux, pais + edi + 1, length(aux));
end;
//-----------------------------------------------------------------------------
function TieneFormato(cadena, formato: string): boolean;
var i: integer;
begin {#-->numero,   & --> alfabetico igual al que se le pasa
         @-->da igual  ! --> alfa-numerico}
  result := false;
  if length(formato) < length(cadena) then exit;
  result := true;
  for i := 1 to length(cadena) do begin
    case formato[i] of
      '#': if not (cadena[i] in ['0'..'9']) then result := false;
      '&': if not (cadena[i] in ['a'..'z', 'A'..'Z']) then result := false;
      '@': ;
      '!': if not (cadena[i] in ['a'..'z', 'A'..'Z', '0'..'9']) then result := false;
    else if cadena[i] <> formato[i] then result := false;
    end; {del case}
  end; {del for}
end;
//-----------------------------------------------------------------------------
function PuedeSerBarras(cadena: string): boolean;
var i: integer;
begin
  if length(cadena) < 8 then begin result := False; exit; end;
  result := true;
  for i := 1 to length(cadena) do
    if not (cadena[i] in ['0'..'9']) then result := false;
end;
//-----------------------------------------------------------------------------
function PuedeSerBarras13(cadena: string): boolean;
var i: integer;
begin
  result := false;
  if length(cadena) <> 13 then exit;
  result := true;
  for i := 1 to length(cadena) do
    if not (cadena[i] in ['0'..'9']) then result := false;
end;
//-----------------------------------------------------------------------------
function CuentaCadenas(cadena, abuscar: string): integer;
var aux, bus: string;
  contador, i, j: integer;
begin
  contador := 0;
  result := 0; if (abuscar = '') or (cadena = '') then exit;
  aux := cadena; bus := abuscar;
  if bus[1] = '$' then bus[1] := '@' else bus[1] := '$';
  repeat
    i := pos(abuscar, aux);
    if i > 0 then begin
      contador := contador + 1;
      for j := i to i + length(abuscar) do
        aux[j] := bus[j - i + 1]
    end;
  until i = 0;
  result := contador;
end;
//-----------------------------------------------------------------------------
function CuentaCar(cadena: string; car: char): integer;
var contador, i: integer;
begin
  contador := 0;
  result := 0; if (car = '') or (cadena = '') then exit;
  for i := 1 to length(cadena) do
    if cadena[i] = car then contador := contador + 1;
  result := contador;
end;
//-----------------------------------------------------------------------------
function Capital(cadena: string): string;
var cad: string;
begin
  result := '';
  if cadena = '' then exit;
  cad := UpperCase(cadena); cadena := LowerCase(cadena);
  result := cad[1] + copy(cadena, 2, length(cadena) - 1);
end;
//-----------------------------------------------------------------------------
function WinExecAndWait32(FileName:String; Visibility:integer):integer;
 var
   zAppName:array[0..512] of char;
   zCurDir:array[0..255] of char;
   WorkDir:String;
   StartupInfo:TStartupInfo;
   ProcessInfo:TProcessInformation;
   Resultado: DWord;
 begin
   StrPCopy(zAppName,FileName);
   GetDir(0,WorkDir);
   StrPCopy(zCurDir,WorkDir);
   FillChar(StartupInfo,Sizeof(StartupInfo),#0);
   StartupInfo.cb := Sizeof(StartupInfo);

   StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
   StartupInfo.wShowWindow := Visibility;
   if not CreateProcess(nil,
     zAppName,                      { pointer to command line string }
     nil,                           { pointer to process security attributes}
     nil,                           { pointer to thread security attributes}
     false,                         { handle inheritance flag }
     CREATE_NEW_CONSOLE or          { creation flags }
     NORMAL_PRIORITY_CLASS,
     nil,                           { pointer to new environment block }
     nil,                           { pointer to current directory name }
     StartupInfo,                   { pointer to STARTUPINFO }
     ProcessInfo) then Result := -1 { pointer to PROCESS_INF }

   else begin
     WaitforSingleObject(ProcessInfo.hProcess,INFINITE);
     GetExitCodeProcess(ProcessInfo.hProcess,Resultado);
     Result := Resultado;
   end;
 end;
//-----------------------------------------------------------------------------
procedure ejecutar(comando: string; como, DeDonde: integer);
// DeDonde = 0 -> viene Dado por el comando
// DeDonde = 1 -> Windows
// DeDonde = 2 -> windows\system
// DeDonde = 3 -> Aplicacion
// DeDonde = 4 -> windows\system32
var sistema: integer;
  DirWindows, DirWindowsSystem, DirAplicacion: Pchar;
  Comando2: array[0..255] of char;
  Aux :String;
begin
{ como
  SW_HIDE, SW_MAXIMIZE, SW_MINIMIZE, SW_RESTORE, SW_SHOW, SW_SHOWDEFAULT,
  SW_SHOWMAXIMIZED, SW_SHOWMINIMIZED, SW_SHOWMINNOACTIVE, SW_SHOWNA,
  SW_SHOWNOACTIVATE, SW_SHOWNORMAL
 }

  DirWindowsSystem := 'C:\Windows\System';
  DirWindows       := 'C:\Windows';
  Aux              := Extractfiledir( Application.ExeName);
 // GetSystemDirectory( DirWindowsSystem,200);
 // GetWindowsDirectory( DirWindows,200);
 // GetCurrentDirectory(200,DirAplicacion);
  case DeDonde of
    0: ;
    1: Comando := DirWindows + '\' + Comando;
    2: Comando := DirWindowsSystem + '\' + Comando;
    3: begin
         DirAplicacion :=   'C:\CofraWin';
         Comando       := DirAplicacion + '\' + Comando;
       end;
    4: Comando := DirWindows + '\System32\' + Comando;
  end;
  StrPCopy(comando2, comando); {pasa de string a pchar}
//  sistema := winexec(comando2, como); {que es != a strpas}
  case sistema of
    0: MessageDlg('¡ Falta de Memoria!, No se pudo ejecutar el comando ' +
        comando, mtwarning, [mbOk], 0);
    ERROR_BAD_FORMAT: MessageDlg(Comando + ' No es una aplicación de 32 bits valida',
        mtwarning, [mbOk], 0);
    ERROR_FILE_NOT_FOUND: MessageDlg('No se pudo encontrar ' + comando,
        mtwarning, [mbOk], 0);
    ERROR_PATH_NOT_FOUND: MessageDlg('No se pudo encontrar el Path : ' + comando,
        mtwarning, [mbOk], 0);
  end; {del case }
end;
//-----------------------------------------------------------------------------
function DNI(cadena: string; avisar: boolean): string;
var LETRADNI, CadenaValidar, LetraExtranjero: string;
  letra, letrabuena: char;
  B: REAL;
  tieneletra, Extranjero: boolean;
begin
  letra := 'a';
  cadena := QuitaCaracter(cadena, '.');
  cadena := QuitaCaracter(cadena, ' ');
  cadena := QuitaCaracter(cadena, '-');
  Extranjero := false;
  tieneletra := false;
  LetraExtranjero := '';
  if length(cadena) < 8 then {si la longitud es menor a 8, error}
  begin
    if avisar then
      messagedlg('El  D.N.I. ' + cadena + #13#13 + ' NO es correcto', mtWarning, [mbOK], 0);
    result := CONST_ERROR; exit;
  end;

  if cadena[1] in ['a'..'z', 'A'..'Z'] then
    if cadena[1] in ['X', 'x']
      then begin Extranjero := True; LetraExtranjero := uppercase(copy(cadena, 1, 1)) end
    else begin
      CadenaValidar := trim(copy(cadena, 2, 10));
      LetraExtranjero := Funciones.NumerosSolo(CadenaValidar);
      if CadenaValidar <> LetraExtranjero
        then messagedlg('El  C.I.F.  ' + cadena + '  puede contener carecteres extraños.',
          mtWarning, [mbOK], 0); Result := Cadena; exit; end;

  LETRADNI := 'TRWAGMYFPDXBNJZSQVHLCKE';

  if Extranjero
    then CadenaValidar := copy(cadena, 2, 10)
  else CadenaValidar := copy(cadena, 1, 10);

  if length(CadenaValidar) >= 9 then
  begin letra := CadenaValidar[9]; tieneletra := true; end;
  CadenaValidar := Funciones.NumerosSolo(CadenaValidar);
  B := strtofloat(CadenaValidar);
  b := b - (int(b / 23) * 23);
  letra := upcase(letra);
  letrabuena := LETRADNI[1 + trunc(b)];
// cadena:=PuntosNumero(CadenaValidar);
  cadena := CadenaValidar;
  if (tieneletra) then
    if (letra = letrabuena) then
    begin result := LetraExtranjero + cadena + letra; exit; end
    else
    begin
      if avisar then
        messagedlg('El  D.N.I.:  ' + LetraExtranjero + cadena + '-' + letra + #13' NO es correcto' + #13 +
          'La letra correcta es : ' + letrabuena, mtWarning, [mbOK], 0);
      result := cadena + letrabuena; exit;
    end {de no letra correcta}
  else
  begin
    if avisar then
      messagedlg('El D.N.I.  ' + LetraExtranjero + cadena + ' Le corresponde la letra  ' + letrabuena,
        mtinformation, [mbOK], 0);
    result := cadena + letrabuena; exit;
  end {de no letra correcta}

end;
//-----------------------------------------------------------------------------
function NumerosSolo(cadena: string): string;
var cad2: string;
  i: integer;
begin
  cad2 := ''; result := cad2;
  if Cadena = '' then exit;
  for i := 0 to length(cadena) do
    if cadena[i] in ['0'..'9'] then
      cad2 := cad2 + cadena[i];
  result := cad2;
end;
//-----------------------------------------------------------------------------
//  Ej  323232,34  -> 323.232,34
//------------------------------------------------------------------------------
function PuntosNumero(cadena: string): string;
var cad2: string;
  i, b: integer;
begin
  cad2 := cadena;
  cad2 := ''; b := 1;
  for i := length(cadena) downto 1 do
  begin
    b := b + 1; cad2 := cad2 + cadena[i];
    if (cadena[i] = ',') or (cadena[i] = '.') then b := 1;
    if (b = 4) and (i <> 1) then begin b := 1; cad2 := cad2 + '.'; end;
  end;
  cadena := '';
  for i := length(cad2) downto 1 do cadena := cadena + cad2[i];
  result := cadena;
end;
//-----------------------------------------------------------------------------
function SoloNumeroInt(Key: Char): char;
begin
  if key in [#1..#33, '0'..'9']
    then result := key else result := #0;
end;
//-----------------------------------------------------------------------------
function filtro(comando, campo, texto, condicion: string; estexto: boolean): string;
var aux: string;
begin
  if texto = '' then begin result := comando; exit; end;
  if comando <> '' then
    comando := comando + ' And (' + campo + ' ' + condicion + ' '
  else
    comando := comando + '( ' + campo + ' ' + condicion + ' ';
  if estexto then
    aux := '''' + texto + '''' + ')'
  else
    aux := texto + ')';
  result := comando + aux;
end;
//-----------------------------------------------------------------------------
function filtrono(comando, campo, texto, condicion: string): string;
begin
  if texto = '' then begin result := comando; exit; end;
  comando := comando + chr(13) + campo + ' ' + condicion + ' ' + texto;
  result := comando;
end; {de la funcion}
//-----------------------------------------------------------------------------
function filtrono2(comando, campo, texto, condicion: string): string;
begin
  result := comando + #13 + campo + ' ' + condicion + ' ' + texto;
end; {de la funcion}
//-----------------------------------------------------------------------------
function filtro2(comando, campo, texto, condicion: string; estexto: boolean): string;
var aux, palabra, sub, orr: string;
  i: integer;
begin
  aux := ''; i := 0;
  repeat
    i := i + 1; orr := ''; palabra := descomponer(texto, ';');
    if not ((palabra = '') and (i > 1)) then
    begin
      if i = 2 then aux := '( ' + aux;
      if i >= 2 then orr := ' Or ';
      sub := orr + '(' + campo + ' ' + condicion + ' ';
      if estexto then aux := aux + sub + '''' + palabra + '''' + ')'
      else aux := aux + sub + palabra + ')';
    end;
  until palabra = '';
  if i > 2 then aux := aux + ' )';
  if comando <> '' then comando := comando + ' And ';
  result := comando + aux;
end;
//-----------------------------------------------------------------------------
function IsDate(Date: variant): boolean;
var
  D: TdateTime;
begin
if varIsNull(Date) then Result:=false else
  Result:= TryStrToDate(Date,D);
end;
//-----------------------------------------------------------------------------
function Dia(Fecha: string): string;
begin
  if Fecha = '' then Fecha := datetostr(date);
  result := FormatDateTime('dd', StrToDate(Fecha));
end;
//-----------------------------------------------------------------------------
function Mes(Fecha: string): string;
begin
  if Fecha = '' then Fecha := datetostr(date);
  result := FormatDateTime('mm', StrToDate(Fecha));
end;
//-----------------------------------------------------------------------------
function ANO(fecha: string): string;
begin
  if Fecha = '' then Fecha := datetostr(date);
  result := FormatDateTime('YYYY', StrToDate(Fecha));
end;
//-----------------------------------------------------------------------------
function ANOCorto(fecha: string): string;
begin result := FormatDateTime('YY', StrToDate(Fecha)); end;
//-----------------------------------------------------------------------------
function FechaInglesa(Fecha: TDate): string;
begin result := FormatDateTime('mm/dd/YYYY', Fecha); end;
//-----------------------------------------------------------------------------
function FechaReves(Fecha: TDate): string;
begin result := FormatDateTime('YY/MM/DD', Fecha); end;
//-----------------------------------------------------------------------------
function FechaReves2(Fecha: TDate): string;
begin result := FormatDateTime('YYMMDD', Fecha); end;
//-----------------------------------------------------------------------------
function NumeroDiasdelMes(mes, ano: integer): integer;
begin // el NUMERO de dias que tiene el mes ...

  if (mes = 2) and (AnoBisiesto(EncodeDate(ano, mes, 1)))
    then result := 29
  else result := meses[mes];
end;
//-----------------------------------------------------------------------------
function PrimerDiadeSemana(fecha: Tdate): Tdate;
begin result := fecha - dayofweek(fecha) + 2; end;
//-----------------------------------------------------------------------------
function UltimoDiadeSemana(fecha: Tdate): Tdate;
begin result := PrimerDiadeSemana(fecha) + 6; end;
//-----------------------------------------------------------------------------
function UltimoDiadelMes(mes, ano: integer): Tdate;
begin
  if (mes = -1) then mes := strtoint(FormatDateTime('mm', Date()));
  if (ano = -1) then ano := strtoint(FormatDateTime('yyyy', Date()));
  if (mes = 2) and (AnoBisiesto(EncodeDate(ano, mes, 1)))
    then result := EncodeDate(ano, mes, 29)
  else result := EncodeDate(ano, mes, NumeroDiasdelMes(mes, ano));
end;
//-----------------------------------------------------------------------------
function PrimerDiadelMes(mes, ano: integer): Tdate;
begin
  if (mes = -1)
    then mes := strtoint(FormatDateTime('mm', Date()));
  if (ano = -1)
    then ano := strtoint(FormatDateTime('yyyy', Date()));
  result := EncodeDate(ano, mes, 1);
end;
//-----------------------------------------------------------------------------
function PrimerDiadelMesActual(fecha: TDate): Tdate;
var mess, anno: integer;
begin
  mess := strtoint(mes(datetostr(fecha)));
  anno := strtoint(ano(datetostr(fecha)));
  result := PrimerDiadelMes(mess, anno);
end;
//-----------------------------------------------------------------------------
function Hora(Cadena: string): string;
var sub: string;
begin
  if cadena = '' then cadena := Timetostr(Time);
  sub := SubCadena(cadena, 1, 5);
  if sub[length(sub)] = ':' then sub := SubCadena(cadena, 1, length(sub) - 1);
  result := sub
end;
//-----------------------------------------------------------------------------
function fechahoy(como: integer; fecha: string; Idioma: Char): string;
var dia, mes, diaint, mesint, anoint: string[14];
{1...................01/01/96
 2...................viernes, 01/01/96
 3...................viernes, 01 de Enero de 1996
 4...................01 de Enero de 1996
 5...................Dia semana
 6...................Dia del mes, 01
 7...................mes corto Ago, Sep, Nov...
 8...................mes largo Agosto, Septiembre...
 9...................año
 10..................ano corto
 11..................mes en numero

 100.................en letras quince de agosto de dosmi cienco}
begin
  if (fecha = 'hoy') or (fecha = '') then fecha := datetostr(date);
  diaint := formatdatetime('dd', strtodate(fecha));
  mesint := formatdatetime('mm', strtodate(fecha));
  anoint := formatdatetime('yyyy', strtodate(fecha));
 // idiomaI := strtoint(Idioma);
  case idioma of
    'C', 'V', '1', '2': begin
        case dayofweek(strtodate(fecha)) of
          2: dia := 'Dilluns'; 3: dia := 'Dimarts';
          4: dia := 'Dimecres'; 5: dia := 'Dijous';
          6: dia := 'Divendres'; 7: dia := 'Dissabte';
          1: dia := 'Dumenge';
        end; {del case de dia}

        case strtoint(mesint) of
          1: mes := 'Giner'; 2: mes := 'Febrer';
          3: mes := 'Març'; 4: mes := 'Abril';
          5: mes := 'Maig'; 6: mes := 'Juny';
          7: mes := 'juliol'; 8: mes := 'Agost';
          9: mes := 'Setembre'; 10: mes := 'Octubre';
          11: mes := 'Novembre'; 12: mes := 'Decembre';
        end; {del case del mes}
      end;
  else begin
      case dayofweek(strtodate(fecha)) of
        2: dia := 'Lunes'; 3: dia := 'Martes';
        4: dia := 'Miercoles'; 5: dia := 'Jueves';
        6: dia := 'Viernes'; 7: dia := 'Sábado';
        1: dia := 'Domingo';
      end; {del case de dia}

      case strtoint(mesint) of
        1: mes := 'Enero'; 2: mes := 'Febrero';
        3: mes := 'Marzo'; 4: mes := 'Abril';
        5: mes := 'Mayo'; 6: mes := 'Junio';
        7: mes := 'Julio'; 8: mes := 'Agosto';
        9: mes := 'Septiembre'; 10: mes := 'Octubre';
        11: mes := 'Noviembre'; 12: mes := 'Diciembre';
      end; {del case del mes}
    end; //del begin
  end; //Del case Idioma
  //mes := 'Giner';
  case como of
    1: result := datetostr(strtodate(fecha));
    2: result := dia + ', ' + datetostr(strtodate(fecha));
    3: result := dia + ', ' + diaint + ' de ' + mes + ' de ' + anoint;
    4: result := diaint + ' de ' + mes + ' de ' + anoint;
    5: result := dia;
    6: result := diaint;
    7: result := SubCadena(mes, 1, 3);
    8: result := mes;
    9: result := anoint;
    10: result := SubCadena(anoint, 3, 4);
    11: result := mesint;
    100: Result := Funciones.NumeroLetras(diaint, '', '', False, 0, 0, Idioma) + ' de ' + mes + ' de ' +
      Funciones.NumeroLetras(anoint, '', '', False, 0, 0, Idioma);
  end {del case}
end;
//-----------------------------------------------------------------------------
procedure ExtraeFile(var nombre: string; var dir: string);
begin
  dir := extractfiledir(nombre);
  nombre := extractfilename(nombre);
end;
//-----------------------------------------------------------------------------
procedure ExtraeNombre(var nombre: string; var extension: string);
var a: integer;
begin
  a := pos('.', nombre);
  if a > 0 then begin
    extension := SubCadena(nombre, a + 1, length(nombre));
    nombre := Subcadena(nombre, 1, a - 1);
  end
  else extension := '';
end;
//-----------------------------------------------------------------------------
function Junta(nombre, dir: string): string;
begin
  if dir[length(dir)] <> '\' then dir := dir + '\';
  result := dir + nombre;
end;
//-----------------------------------------------------------------------------
function Primero(cadena: string; Defecto: Char): string;
begin
  Cadena := Trim(Cadena);
  if cadena = ''
    then Result := Defecto
  else Result := Cadena[1];
end;
//-----------------------------------------------------------------------------
function QuitaCaracter(cadena: string; car: char): string;
var i: integer;
begin
  result := ''; if cadena = '' then exit;
  for i := 1 to length(cadena) do
    if cadena[i] <> car then result := result + cadena[i];
//  StringReplace(Cadena, car, '', [rfReplaceAll]); no funciona si car es ?
end;
//-----------------------------------------------------------------------------
function ExisteFichero(FileName: string): Boolean;
begin
//  {$I-}
//  AssignFile(F, FileName); FileMode := 0;{ Set file access to read only }
//  Reset(F);                CloseFile(F);
//  {$I+}
//  RESULT := (IOResult = 0) and (FileName <> '');
  result := Fileexists(FileName);
end;
//-----------------------------------------------------------------------------
function ExisteImpresora(NombreImpresora: string; DiNoEsta: Boolean): Boolean;
var Impresora: TextFile; Existe: Boolean;
begin
  Assignfile(Impresora, NombreImpresora);
{$I-}
  Rewrite(Impresora);
{$I+}
  if IOResult <> 0
    then Existe := False
    else Existe := true;
{$I-}
  close(impresora);
{$I+}
  if (DiNoEsta) and (not (Existe))
    then MessageDlg('NO se encontró la Impresora :' + NombreImpresora, mterror,
      [mbOk], 0);
 Result:=Existe;
end;
//-----------------------------------------------------------------------------
Function EstadoImpresora(const PrinterName:string):String;
Var
PrinterInfo: PPrinterInfo2;
PrinterHandle : THandle;
Stat : LongBool;
requiredSize : Cardinal;

Estado,Resultado:string;


Begin
Try
Stat := OpenPrinter( PChar(PrinterName), PrinterHandle, NIL ); //
//This works fine

If ( Stat )
Then
Begin
Try
GetMem( PrinterInfo, 1024 );
Stat := GetPrinter(PrinterHandle, 2, PrinterInfo, 1024,@requiredSize );
//Edit2.Text := 'Printer Name Is: ' + PrinterInfo^.pPrinterName;

Case PrinterInfo^.Status of
0 : Estado := 'OK';
PRINTER_STATUS_DOOR_OPEN : Estado := 'Puerta Abierta';
PRINTER_STATUS_POWER_SAVE : Estado := 'Power Save Mode';
PRINTER_STATUS_WARMING_UP : Estado := 'Warming Up';
PRINTER_STATUS_PAPER_OUT : Estado := 'No hay Papel';
End;
Finally
FreeMem( PrinterInfo, 1024 );
End;
End
Else
Begin
Estado := 'NA';
Estado := 'No se puede Abrir la Impresora: ' + PrinterName;
End;
Finally
ClosePrinter( PrinterHandle );
End;
result:=estado;
end;
//-----------------------------------------------------------------------------
function NumeroMes(mes: string): integer;
begin
  result := 0;
  if (mes = 'Enero') or (mes = 'Ene') then result := 1
  else if (mes = 'Febrero') or (mes = 'Feb') then result := 2
  else if (mes = 'Marzo') or (mes = 'Mar') then result := 3
  else if (mes = 'Abril') or (mes = 'Abr') then result := 4
  else if (mes = 'Mayo') or (mes = 'May') then result := 5
  else if (mes = 'Junio') or (mes = 'Jun') then result := 6
  else if (mes = 'Julio') or (mes = 'Jul') then result := 7
  else if (mes = 'Agosto') or (mes = 'Ago') then result := 8
  else if (mes = 'Septiembre') or (mes = 'Sep') then result := 9
  else if (mes = 'Octubre') or (mes = 'Oct') then result := 10
  else if (mes = 'Noviembre') or (mes = 'Nov') then result := 11
  else if (mes = 'Diciembre') or (mes = 'Dic') then result := 12
end;
//-----------------------------------------------------------------------------
function MesNumero(num: integer): string;
begin
  case num of
    1: result := 'Enero'; 2: result := 'Febrero'; 3: result := 'Marzo';
    4: result := 'Abril'; 5: result := 'Mayo'; 6: result := 'Junio';
    7: result := 'Julio'; 8: result := 'Agosto'; 9: result := 'Septiembre';
    10: result := 'Octubre'; 11: result := 'Noviembre'; 12: result := 'Diciembre';
  end;
end;
//-----------------------------------------------------------------------------
function MesNumeroCor(num: integer): string;
begin
  case num of
    1: result := 'Ene'; 2: result := 'Feb'; 3: result := 'Mar';
    4: result := 'Abr'; 5: result := 'May'; 6: result := 'Jun';
    7: result := 'Jul'; 8: result := 'Ago'; 9: result := 'Sep';
    10: result := 'Oct'; 11: result := 'Nov'; 12: result := 'Dic';
  end;
end;
//-----------------------------------------------------------------------------
function MesLarCor(mes: string; largo: boolean): string;
var i: integer;
begin
  if mes[1] in ['1'..'9'] then i := strtoint(mes)
  else i := NumeroMes(mes);
  if largo then result := MesNumero(i)
  else result := MesNumerocor(i);
end;
//-----------------------------------------------------------------------------
//function rellenaIZQ(cadena,car:string;LongCadenaMenosUno:integer):string;
function rellenaIZQ(cadena, car: string; LongCadena: integer): string;
//var  i:integer;
begin
  result := cadena;
  if length(cadena) >= LongCadena then exit;
  Result := StringOfChar(car[1], LongCadena - length(Cadena)) + Cadena;
{  result:=cadena;
  if length(cadena) >= LongCadenaMenosUno then exit;
  for i:=length(cadena)+1 to LongCadenaMenosUno do
    cadena:=car+cadena;

  result:=cadena;}
end;
//-----------------------------------------------------------------------------
function rellena(cadena, car: string; LongCadena: integer): string;
//var i: integer;
begin
  result := cadena;
  if length(cadena) >= LongCadena then exit;
  Result := Cadena + StringOfChar(car[1], LongCadena - length(Cadena));

{  result:=cadena;
  if length(cadena) >= LongCadena then exit;
  for i:=length(cadena)+1 to LongCadena do
    cadena:=cadena+car;
  if length(cadena) >= LongCadena then
  cadena:=SubCadena(Cadena,1,LongCadena);
  result:=cadena;}
end;
//-----------------------------------------------------------------------------
function Recorta(cadena, car: string; LongCadena: integer): string;
begin
  cadena := rellena(cadena, car, LongCadena);
  if length(cadena) >= LongCadena
    then
    Result := SubCadena(Cadena, 1, LongCadena)
  else Result := Cadena;
end;
//-----------------------------------------------------------------------------
function RecortaIZQ(cadena, car: string; LongCadena: integer): string;
begin
  cadena := rellenaIZQ(cadena, car, LongCadena);
  if length(cadena) >= LongCadena
    then
    Result := SubCadena(Cadena, length(Cadena) - LongCadena + 1, length(Cadena))
  else Result := Cadena;
end;
//-----------------------------------------------------------------------------
Function Componer(Campo1,Campo2:String):String;
begin
  Result:=Campo1+' - '+Campo2;
end;

function Descomponer(var cadena: string; separador: char): string;
var i: integer; // devuelve la primera cadena hasta el separado
begin // MODIFICA cadena y le quita la que ha devuelto
  result := '';
  i := pos(separador, cadena);
  if i > 0 then begin
    result := SubCadena(cadena, 1, i - 1);
    cadena := SubCadena(cadena, i + 1, length(cadena));
  end
  else begin result := cadena; cadena := ''; end;
end;
//-----------------------------------------------------------------------------
function QuitarChar(cadena: string; Caracter: char): string;
begin
{  result:='';}
  Result := StringReplace(Cadena, Caracter, '', [rfReplaceAll]);
{

  while Pos(Caracter, cadena) > 0 do
    cadena:=copy(cadena,1,Pos(Caracter, cadena)-1)+
            copy(cadena,Pos(Caracter, cadena)+1,length(cadena));
  Result:=cadena; }
end;
function QuitarChars(cadena: string; Caracteres: array of char): string;
var i:Integer;
begin
  Result:=cadena;
for i:=0 to Length(Caracteres) do
  Result := StringReplace(Result, Caracteres[i], '', [rfReplaceAll]);
end;
//-----------------------------------------------------------------------------
function CambiarChar(cadena: string; ACambiar, CambiarPor: char): string;
begin
  Result := StringReplace(Cadena, ACambiar, CambiarPor, [rfReplaceAll]);

{  while Pos(ACambiar, cadena) > 0 do
    cadena[Pos(ACambiar, cadena)] := CambiarPor;
  result:=cadena }
end;
//-----------------------------------------------------------------------------
function elevado(base, expo: real): real;
begin
  if base <= 0 then result := 0
  else if expo = 0 then result := 1
  else result := exp(expo * ln(base));
end;
//-----------------------------------------------------------------------------
function MaxReal(a, b: real): real;
begin if a > b then result := a else result := b end;
//-----------------------------------------------------------------------------
function MinReal(a, b: real): real;
begin if a < b then result := a else result := b end;
//-----------------------------------------------------------------------------
procedure MaxMinReal(var a, b: real);
var c: real;
begin if a < b then begin c := a; a := b; b := c; end; end;
//-----------------------------------------------------------------------------
procedure MaxMinInt(var a, b: integer);
var c: integer;
begin if a < b then begin c := a; a := b; b := c; end; end;
//-----------------------------------------------------------------------------
function EstaEntre(valor, a, b: real): boolean;
begin
  if (valor >= a) and (valor <= b)
    then result := TRUE
  else result := FALSE;
end;
//-----------------------------------------------------------------------------
function MasIva(base, tanto: real): real;
begin result := base * (1 + (tanto / 100)); end;
//-----------------------------------------------------------------------------
function MenosIva(base, tanto: real): real;
begin result := base / (1 + (tanto / 100)); end;
//-----------------------------------------------------------------------------
function MasPorCiento(base, tanto: real): real;
begin result := base / ((100 - tanto) / 100); end;
//-----------------------------------------------------------------------------
function MenosPorCiento(base, tanto: real): real;
begin result := base * ((100 - tanto) / 100); end;
//-----------------------------------------------------------------------------
function tantoPorCiento(base, tanto: real): real;
begin result := base * tanto / 100; end;
//-----------------------------------------------------------------------------
function SumameInteger(Suma: longint; que: string): longint;
begin result := suma; if que <> '' then result := suma + strtoint(que); end;
//-----------------------------------------------------------------------------
function PtsaEcu(pts, cambio: real): real;
begin result := pts / cambio end; {cambio--> 156pts -> 1Euro}
//-----------------------------------------------------------------------------
function EcuaPts(Ecu, cambio: real): real;
begin result := Ecu * cambio end; {cambio--> 156pts -> 1Euro}
//-----------------------------------------------------------------------------
function StrToPChar(cadena: string): PChar;
var a: pchar;
begin
  a := nil;
  StrPCopy(a, cadena);
  result := a;
end;
//-----------------------------------------------------------------------------
{*******************************************************************
  Esta función se le pasa como string un nmero de 3 cifres ( 123)
  y nos devuelve una cadena con el texto del número (Ciento Venti Tres).
  Tambien hay que decirle si lo queremos en Msculino, por el tema del 1
  , que puede ser Uno o Una .....}
function NumeroDividido(num: string; Masculino: Boolean): string;
var Unidad, Decena, Centena, Anterior, coletilla: string;
  Digitos, Digitoahora: Shortint;
begin
  if (num = '') or (num = '000') then begin result := ''; exit; end;
  NUM := '000' + NUM; Unidad := ''; Decena := ''; Centena := ''; Anterior := '';
  digitos := length(num); digitoAhora := 0; // Nº de digitos // empezamos por el ultimo
   //------------------------ UNIDADES ------------------------
  Unidad := num[digitos - digitoahora];
  Anterior := Unidad;
  case StrToInt(unidad) of
    1: if MASCULINO
      then Unidad := A1
      else Unidad := A1A;
    2: Unidad := A2;
    3: Unidad := A3; 4: Unidad := A4;
    5: Unidad := A5; 6: Unidad := A6;
    7: Unidad := A7; 8: Unidad := A8;
    9: Unidad := A9; 0: Unidad := '';
  end; // de case de UNIDADES

  if unidad = '' // es por que es cero y la decena es exacta
    then coletilla := ''
  else Coletilla := P0 + P1 + P0;

   //------------------------ DECENAS ------------------------
  digitoAhora := digitoAhora + 1;
  Decena := num[digitos - digitoahora];
  case StrToInt(Decena) of
    1: case StrToInt(anterior) of
        0: begin Unidad := ''; Decena := A10; end;
        1: begin Unidad := ''; Decena := A11; end;
        2: begin Unidad := ''; Decena := A12; end;
        3: begin Unidad := ''; Decena := A13; end;
        4: begin Unidad := ''; Decena := A14; end;
        5: begin Unidad := ''; Decena := A15; end;
      else Decena := B1;
      end; //   de los diez, once, doce ... deci..

    2: if StrToInt(anterior) = 0
      then Decena := P0 + B2
      else Decena := P0 + B2b;
    3: Decena := P0 + B3 + coletilla;
    4: Decena := P0 + B4 + coletilla; 5: Decena := P0 + B5 + coletilla;
    6: Decena := P0 + B6 + coletilla; 7: Decena := P0 + B7 + coletilla;
    8: Decena := P0 + B8 + coletilla; 9: Decena := P0 + B9 + coletilla;
    0: Decena := '';
  end; // de case de DECENAS
  if Decena = '' // es por que es cero y la decena es exacta
    then coletilla := P0 + P1 + P0
  else Coletilla := '';

   //------------------------ CENTENAS ------------------------
  digitoAhora := digitoAhora + 1;
  if Masculino
    then coletilla := MASCULS + P0
  else Coletilla := FEMENS + P0;
  Centena := num[digitos - digitoahora];
  case StrToInt(Centena) of
    1: if (Unidad = '') and (Decena = '')
      then Centena := B10 + P0
      else Centena := B10 + MASCUL + P0;
    2: Centena := A2 + b10 + coletilla; 3: Centena := A3 + b10 + coletilla;
    4: Centena := A4 + b10 + coletilla; 5: Centena := A5b + coletilla;
    6: Centena := A6 + b10 + coletilla; 7: Centena := A7b + b10 + coletilla;
    8: Centena := A8 + b10 + coletilla; 9: Centena := A9b + b10 + coletilla;
    0: Centena := '';
  end; // de case de CENTENAS

  RESULT := Centena + Decena + Unidad;
end;
//-----------------------------------------------------------------------------
{
  Esta función, recive una cadena que contiene un numero y la combierte en letras,
  Para completarla, se le pone las Medidas ( Pesetas, Metros,...), y los decimales
  el nombre ( centimos de euro, cm, mm ...´- Por defecto, sale DECIMA,
  CENTESIMA Y MILÉSIMAS -. También hay que decirle si la unidad es masculino por
  el tema del 1 ( Uno-Una). el formato que se quiere ( el mejor el 0 ) y
  si tiene decimales cual queremos que sea el Máximo ( NO más de tres 3 )
 }

function NumeroLetras(ElNumero, Unidad, SubUnidad: string;
  EsMasculino: boolean; Formato, NoDecimales: Integer; Idioma: Char): string;
// Idioma = E, o -> españo;   C V 1 2 -> Catalan o valenciano

var Cientos, Miles, Millo, Milesllones, Decimales, Resultado: string;
  ICientos, IMiles, IMillo, IMilesllones, IDecimales: integer;
  escero: real;
  Ultimo: integer;
  Plural, CentimoPlural, CentimoMasculino, EsNegativo: Boolean;
  ElNumeroAux, Numero, Decimal, coletilla: string;

 //  ............................ FORMATOS ......................
 //
 //    0 = Ciento ventitres
 //    1 = CIENTO VENTITRES
 //    2 = ciento ventitres
 //    3 = Ciento VentiTres
begin
  if (ElNumero = '') then begin result := A0; Exit; end;

  case Idioma of
    '1', '2': Idioma := 'V'; //catalan valenciano
    '0': Idioma := 'E'; //españo
  end; //del case

  ElNumero := CambiarChar(ElNumero, SimboloNODecimal, SimboloDecimal);
  if (strtofloat(ElNumero) < 0.0)
    then begin
    ElNumero := QuitarChar(ElNumero, '-');
    EsNegativo := True;
  end
  else EsNegativo := False;

  escero := strtofloat(ElNumero);
  if (escero = 0) then begin result := A0; exit; end;

  ElNumeroAux := ElNumero;
  ElNumero := CambiarChar(ElNumero, ',', '.'); // Cambiamos las comas por los PUNTOS
  numero := trim(Descomponer(ElNumero, '.')); // Sacamos el numero entero
  Decimal := trim(Descomponer(ElNumero, '.')); // Sacamos los decimales

  Numero := '00000000000' + Numero;
  ultimo := length(numero); Plural := false; CentimoPlural := false;

  // ------------------------ xxx.xxx.xxx.xxx , XXX ------------------------
  if (Decimal <> '') and (NoDecimales > 0) then // si realmente hay decimales
  begin
    CentimoMasculino := EsMasculino;
    if NoDecimales > 3 then NoDecimales := 3;
    if length(Decimal) >= NoDecimales
      then Decimal := copy(Decimal, 1, NoDecimales)
    else Decimal := rellena(Decimal, '0', NoDecimales - length(Decimal));

    if SubUnidad = '' // pasamos a poner las coletillas;
      then begin case NoDecimales of
        1: coletilla := U1; // si no ponemos unidades, que ponga Décimas
        2: coletilla := U2; // si no ponemos unidades, que ponga Centésimas
        3: coletilla := U3; // si no ponemos unidades, que ponga Milésimas
      end;
      EsMasculino := false; // Seguro que es femenino.
    end
    else coletilla := SubUnidad; // si ponemos que son centimos de euro, que l ponga
    Decimales := decimal;
    IDecimales := strtoint(Decimales);
    Decimales := numeroDividido(Decimales, CentimoMasculino);
    if IDecimales > 1 then CentimoPlural := true;

  end; // si decimal <> ''

  /// ------------------------ xxx.xxx.xxx.XXX ------------------------
  Cientos := Subcadena(numero, ultimo - 2, ultimo);
  ICientos := strtoint(Cientos);
  Cientos := numeroDividido(Cientos, EsMasculino);
  if ICientos <> 1 then Plural := true;

  /// ------------------------ xxx.xxx.XXX.xxx ------------------------
  Miles := Subcadena(numero, ultimo - 5, ultimo - 3);
  IMiles := strtoint(Miles);
  case IMiles of
    0: Miles := '';
    1: Miles := C1;
  else Miles := numeroDividido(Miles, EsMasculino) + P0 + C1;
  end;
  if Miles <> '' then Plural := true;

  /// ------------------------ xxx.XXX.xxx.xxx ------------------------
  Millo := Subcadena(numero, ultimo - 8, ultimo - 6);
  IMillo := strtoint(Millo);
  case IMillo of
    0: Millo := '';
    1: Millo := A1B + P0 + C2;
  else Millo := numeroDividido(Millo, EsMasculino) + P0 + C3;
  end;
  if Millo <> '' then Plural := true;

  /// ------------------------ XXX.xxx.xxx.xxx ------------------------
  Milesllones := Subcadena(numero, ultimo - 11, ultimo - 9);
  IMilesllones := strtoint(Milesllones);
  case IMilesllones of
    0: Milesllones := '';
    1: Milesllones := C1 + P0 + C3;
  else Milesllones := numeroDividido(Milesllones, EsMasculino) + P0 + C1;
  end;
  if (IMillo = 0) and (IMilesllones > 1) then Milesllones := Milesllones + P0 + C3;
  if Milesllones <> '' then Plural := true;

  /// ------------------------ XXX.XXX.XXX ------------------------
  if (plural) and (Unidad <> '')
    then resultado := Milesllones + P0 + Millo + P0 + Miles + P0 + Cientos + P0 + Unidad + PLURALES
  else resultado := Milesllones + P0 + Millo + P0 + Miles + P0 + Cientos + P0 + Unidad;

  if Decimales <> '' then
    if CentimoPlural
      then resultado := resultado + P0 + P2 + P0 + Decimales + P0 + coletilla + PLURALES
    else resultado := resultado + P0 + P2 + P0 + Decimales + P0 + coletilla;

  resultado := trim(resultado);
  if EsNegativo then resultado := 'MENOS ' + resultado;

  if (idioma <> 'E') and (idioma <> ' ')
    then resultado := TraduceImporte(resultado, Idioma);

  case formato of
    0: result := Capital(resultado); // 0 = Ciento ventitres                        // 0 = Ciento ventitres
    1: result := Uppercase(resultado); // 1 = CIENTO VENTITRES
    2: result := LowerCase(resultado); // 2 = ciento ventitres
    3: result := resultado; // 3 = Ciento VentiTres
  else result := Uppercase(resultado);
  end;
end;
//**************************************************************************
function NumeroDisco(DriveChar: Char): string;
var MaxFileNamelength, volFlags, sernum: DWord;
begin
  if GetVolumeInformation(PChar(DriveChar + ':\'), nil, 0, @SerNum, MaxFileNameLength, VolFlags, nil, 0)
    then begin
    Result := IntToHex(SerNum, 8);
    Insert('-', Result, 5);
  end else Result := '';
// LA LLAMADA A LA FUNCION PUEDE SER
// showmessage(NumeroDisco('C'));
end;
//-----------------------------------------------------------------------------
function NEntero(Cadena: string; Defecto: integer): Integer;
begin
  Result := defecto;
  cadena := Funciones.NumerosSolo(cadena);
  if cadena <> '' then result := Strtoint(cadena);
end;
//-----------------------------------------------------------------------------
function CambiarSubCadena(Cadena, Origen, Destino: string): string;
begin
  Result := StringReplace(Cadena, Origen, Destino, [rfReplaceAll]);
{var P, long: Integer;
begin
  Long := Length(Origen);
  P:=Pos(origen, Cadena);
  while p > 0 do begin
   aux:=SubCadena(cadena,0,P-2)+Destino+
        SubCadena(cadena,P+long,length(Cadena));
   Cadena:=Aux;
   P:=Pos(origen, Cadena);
  end;
  Result:=Cadena;}
end;
//-----------------------------------------------------------------------------
// ?????????
function HacerNumeroCuenta(cadena, Prefijo: string; Digitos: Integer): string;
var aux: string;
  a: Integer;
begin
  Aux := '';
  a := Digitos - Length(cadena);
  Prefijo := rellena(Prefijo, '0', a);
  Prefijo := Prefijo + cadena;
  Result := Prefijo
end;
//-----------------------------------------------------------------------------
function PtsEuros(Cantidad, ValorEuro: Real; Moneda: string): real;
begin
  Result := 0;
  if ValorEuro <> 0 then
    if Moneda = 'P'
      then Result := Cantidad / ValorEuro
    else Result := Cantidad * ValorEuro;
end;
//-----------------------------------------------------------------------------
function NombreUsuario: string;
var Netuser, Locname: array[0..255] of char;
  rc: Integer;
  len: Cardinal; //para delphi 4, en otro puede ser integer;
begin
  FillChar(NetUser, Sizeof(Netuser), #00);
  FillChar(Locname, Sizeof(Locname), #00);
  Len := Sizeof(Netuser) - 1;
  rc := WNetGetUser(Netuser, Locname, Len);
  if rc = 0
    then Result := StrPas(Locname)
  else Result := '';
end;
//-----------------------------------------------------------------------------
function LongitudFichero(fichero: string): single;
var f: TextFile;
  size: Longint;
begin
  AssignFile(f, fichero);
  Reset(f);
  Size := FileSize(f);
  CloseFile(f);
  Result := Size; //devueve el tamaño del fichero BINARIO
end;
//-----------------------------------------------------------------------------
Function ExtensionFichero(const Ruta:String):String;
var ruta2:String;
begin

  Ruta2:=trim(Extractfileext(ruta));
  ruta2:=quitacaracter(ruta2,'.');
  result:=Ruta2;
end;
//-----------------------------------------------------------------------------
function FileLength(sFile: string): Integer;
var SearchRec: TSearchRec;
begin
  Result := FindFirst(sFile, 0, SearchRec);
  if Result = 0 then Result := SearchRec.Size else Result := 0;
// FindClose(SearchRec);
end;
//-----------------------------------------------------------------------------
//Esta Función devuelve el número de líneas de un fichero
function CuentaLineasFichero(sFile: string): Integer;
var
  f: TextFile;
  i: integer;
  s: string;
begin
  i := 0;
  AssignFile(f, sFile);
  reset(f);
  while not (Eof(f)) do
  begin
    Readln(f, S);
    i := i + 1;
  end;
  CloseFile(f);
  result := i;
end;
//-----------------------------------------------------------------------------
function CreaDirectorio(Dir: string): Boolean;
begin Result := ForceDirectories(Dir); end;
//-----------------------------------------------------------------------------
function MascaraReal(Numero: Real; Relleno, SimboloDecimal: ShortString;
  Enteros, Decimales: Byte; NegativoJunto: CHAR): string;
// formatea un numero real con los decimales que le pasamos
// Numero -> el numero a formatera
// relleno -> como relleno el numero ejem 123-> 000123
// Simbolo decimal -> cual es el digito decimal que queremos
// enteros, decimales -> los digitos que queremos para esas cosas
// Negativo junto = 'S'-> 000-12.23    si 'N' -> -000123.23  'Q'->000123.23
var StrEntero, StrDecimal, Aux: string;
  Posicion, i: Integer;
  NumeroOriginalNegativo: Boolean;
begin
  NumeroOriginalNegativo := Numero < 0;
  Numero := abs(Numero);
  Numero := Funciones.Redondea(Numero, 2);
  if NumeroOriginalNegativo then
    Numero := Numero * (-1);

  if ord(NegativoJunto) > 90
    then NegativoJunto := chr(ord(NegativoJunto) - 32);
  if Relleno = '' then Relleno := '0';

  Aux := FloattoStr(Numero); Aux := funciones.CambiarChar(Aux, ',', '.');
  Posicion := pos('.', Aux);

  if posicion > 0
    then begin
    StrDecimal := Funciones.SubCadena(Aux, posicion + 1, posicion + decimales);
    StrEntero := Funciones.SubCadena(Aux, 1, posicion - 1);
  end
  else begin
    StrDecimal := '0';
    StrEntero := Aux;
  end;

  StrDecimal := Funciones.Recorta(StrDecimal, '0', decimales);
  if Decimales > 0
    then Aux := StrEntero + SimboloDecimal + StrDecimal
  else Aux := StrEntero;

  if enteros <> 100
    then begin
    Aux := Funciones.RecortaIZQ(Aux, Relleno, Decimales + Enteros + 1);

    if NumeroOriginalNegativo then begin
      Numero := Numero * (-1);
      case NegativoJunto of
        'S': while i <= Length(Aux) do begin
            if Aux[i] <> '0' then begin
              if i <> 1
                then Aux[i - 1] := '-'
              else Aux := '-' + Aux;
              i := Length(Aux);
            end;
            Inc(i);
          end;
        'N': Aux[1] := '-';
//        'Q': Aux := Funciones.CambiarChar(Aux, '-', PChar(Relleno[1]));
      end;
    end;
  end;
  Result := Aux
end;
//-----------------------------------------------------------------------------
function LongitudFichero2(fichero: string): Integer;
var SearchRec: TSearchRec;
begin
  Result := FindFirst(fichero, 0, SearchRec);
  if Result = 0 then Result := SearchRec.Size else Result := 0;
  FindClose(SearchRec);
end;
//-----------------------------------------------------------------------------
procedure DesconectarInternet; //desconectar si estás con Módem
begin
{var

  bufsize,
  numEntries,r : cardinal;
  x: Integer;
  entries: Array[1..10] of TRasConn;
  stat: TRasConnStatus;
  hRas: HRasConn;
  conexion:pRasConn;

 begin
   entries[1].dwSize := SizeOf(TRasConn);
   bufsize := SizeOf(TRasConn) * 10;
   FillChar(stat, Sizeof(TRasConnStatus), 0);
   stat.dwSize := Sizeof(TRasConnStatus);
   if RasEnumConnections(@entries[1], bufsize, numEntries) = 0 then
     begin
       if numEntries > 0 then
         with entries[1] do
         begin
           conexion:=Pointer(rasconn);
           hRas := Longint(conexion);
           if RasHangUp(hRas) <> 0 then
             ShowMessage('Fallo al ejecutar RasHangUp');
         end

         else
           ShowMessage('No hay ninguna conexion que colgar...');
     end;}
end;
//-----------------------------------------------------------------------------
function FuncAvail(_dllname, _funcname: string; var _p: pointer): boolean;
   {
   Devuelve true si la funcion _funcname esta disponible en la DLL _dllname.
   Si es asi, almacena en _p la direccion de la función.
   }
var _lib: tHandle;
begin
  Result := false;
  if LoadLibrary(PChar(_dllname)) = 0 then exit;
  _lib := GetModuleHandle(PChar(_dllname));
  if _lib <> 0 then
  begin
    _p := GetProcAddress(_lib, PChar(_funcname));
    if _p <> nil then Result := true;
  end;
end;
//-----------------------------------------------------------------------------
function EstoyConectado: boolean;
var InetIsOffline: function(dwFlags: DWORD): BOOL; stdcall;
begin
   { Ojo: 'InetIsOffline' debe de estar escrito con estas mayusculas y
   minusculas.}
  if FuncAvail('URL.DLL', 'InetIsOffline', @InetIsOffline) = true then
    if InetIsOffLine(0) = true
      then Result := FALSE
    else result := TRUE;
end;
//-----------------------------------------------------------------------------
procedure ConectarInternet;
begin
  ejecutar('c:\windows\rundll rnaui.dll,RnaDial ctv', SW_Normal, 0);
end;
//-----------------------------------------------------------------------------
function SimboloDecimal: Char;
begin
  if FloatToStr(0.1) = '0,1' then Result := ',' else Result := '.';
end;
//-----------------------------------------------------------------------------
function SimboloNoDecimal: Char;
begin
  if FloatToStr(0.1) = '0,1' then Result := '.' else Result := ',';
end;
//-----------------------------------------------------------------------------
function StrtoFloatSantos(ElNumero: string): Real;
//combierte un Str a Float pasando , teniendo cuidado del punto decimal
begin
  ElNumero := CambiarChar(trim(ElNumero), SimboloNODecimal, SimboloDecimal);

  if ElNumero = '' then ElNumero := '0';
  Result := StrtoFloat(ElNumero);
end;
//-----------------------------------------------------------------------------
function PrimerasLetras(Cadena: string; Cantidad: Integer): string;
begin
  Result := Subcadena(Cadena, 0, Cantidad);
end;
//-----------------------------------------------------------------------------
function UltimasLetras(Cadena: string; Cantidad: Integer): string;
begin
  Result := Subcadena(Cadena, Length(Cadena) - Cantidad + 1, Length(Cadena));
end;
//-----------------------------------------------------------------------------
procedure CopiarDirectorio(Origen, Desti: string);
var
  Files: integer;
  FOrigen, FDesti: string;
  ok, Informar: boolean;
  Search: TSearchRec;
begin
  Informar := True;
  Files := FindFirst(Origen + '\*.*', faAnyFile, Search);
  while Files = 0 do
  begin
    if Search.Attr <> faDirectory
      then begin
      FOrigen := Origen + '\' + Search.Name;
      FDesti := Desti + '\' + Search.Name;
      if FileExists(FOrigen)
        then begin
        ok := CopyFile(PChar(FOrigen), PChar(FDesti), false);
        if (ok = False) and (Informar)
          then Informar := MessageDlg('No se pudo copiar el fichero: ' + Search.Name, mtWarning,
            [mbOk, mbYesToAll], 0) <> mrYesToAll;

      end;
    end
    else begin
      if (Search.Name <> '.') and (Search.Name <> '..')
        then begin
        ok := CreateDir(Desti + '\' + Search.Name);
        if not ok
          then //ShowMessage('No se pudo crear el directorio: '+ Search.Name)
        else CopiarDirectorio(Origen + '\' + Search.Name, Desti + '\' + Search.Name);
      end;
    end;
    Files := FindNext(Search);
  end;
  FindClose(Search);
end;
//-----------------------------------------------------------------------------
procedure EliminarDirectorio(cPath: string); //Elimina Tambíén los SubDirectorios
var
  search: TSearchRec;
  nFiles: integer;
begin
  nFiles := FindFirst(cPath + '\*.*', faAnyFile, search);
  while nFiles = 0 do
  begin
    if Search.Attr = faDirectory then
    begin
      if (Search.Name <> '.') and (Search.Name <> '..') then
      begin
        EliminarDirectorio(cPath + '\' + Search.Name);
        RMDir(cPath + '\' + Search.Name);
      end;
    end
    else
      SysUtils.DeleteFile(cPath + '\' + Search.Name);
    nFiles := FindNext(Search);
  end;
  FindClose(Search);
  RMDir(cPath);
end;
//-----------------------------------------------------------------------------
function CtaContable(Cta, Mascara: string): string;
//Mascara debe ser ABDCEFGHIJKL.... o 430DEFG
var i: Integer;
  CtaFinal: string;

begin
  Mascara := Uppercase(Mascara);
  CtaFinal := ''; Cta := Funciones.UltimasLetras('00000000000000' + Cta, length(Mascara)); //+'                         ';
  for i := 1 to Length(Mascara) do
    case Mascara[i] of
      'A'..'Z': CtaFinal := CtaFinal + Cta[Ord(Mascara[i]) - 64];
      '0'..'9': CtaFinal := CtaFinal + Mascara[i];
    end; //del Case
  Result := CtaFinal
end;
//-----------------------------------------------------------------------------
{ es erronea pora los negativos
function Redondea(const X: Double; decimales: integer): Double;
var
  Aux: double;
  Negativo: Boolean;
begin
  Negativo := False;
  if (X < 0) then Negativo := True
  else if (X > 0) then Negativo := False;

  case Decimales of
    1: begin
        if Negativo then Aux := ((X * -1) + 0.05) else
          Aux := X + 0.05;
        Aux := trunc(Aux * 10);
        Aux := Aux / 10;
      end;
    2: begin
        if Negativo then Aux := ((X * -1) + 0.005) else
          Aux := X + 0.005000000001;
        Aux := Aux * 100;
        Aux := trunc(Aux);
        Aux := Aux / 100;
      end;
    3: begin
        if Negativo then Aux := ((X * -1) + 0.0005) else
          Aux := X + 0.0005;
        Aux := trunc(Aux * 1000);
        Aux := Aux / 1000;
      end;
    4: begin
        if Negativo then Aux := ((X * -1) + 0.00005) else
          Aux := X + 0.00005;
        Aux := trunc(Aux * 10000);
        Aux := Aux / 10000;
      end;
    0: begin
        Aux := X;
        Aux := trunc(Aux + 0.5);
      end;
  end; // del case

  if Negativo then Aux := Aux * (-1);

  Result := Aux;
end;             }

function Redondea(Const X: Double;decimales:integer): Double;
var
  Aux: double;
  Negativo: Boolean;
Begin
  Negativo:= False;
  if (X<0)
    then begin
            Negativo:= True;
            Aux     := ABS(X)
         end
    else begin
            if (X>0) then Negativo:= False;
            Aux     := X;
         end;

  Case Decimales of
    1 : begin
         Aux:= Aux+0.05;
         Aux:= trunc(Aux*10);
         Aux:= Aux/10;
        end;
    2 : begin
         Aux:= Aux+0.005000000001;
         Aux:= Aux*100;
         Aux:= trunc(Aux);
         Aux:= Aux/100;
        end;
    3 : begin
         Aux:= Aux+0.0005;
         Aux:= trunc(Aux*1000);
         Aux:= Aux/1000;
        end;
    4 : begin
         Aux:= Aux+0.00005;
         Aux:= trunc(Aux*10000);
         Aux:= Aux/10000;
        end;
    0 : begin
         //Aux:=X;
         Aux:=trunc(Aux+0.5);
        end;
  end;// del case

  if Negativo then Aux:= Aux*(-1);

  Result:=Aux;

end;
//-----------------------------------------------------------------------------
function DiaJuliano(Fecha: Tdatetime; Rellena: Boolean): string;
var Dias: Real;
  UnoEnero: Tdatetime;
  Aux: string[10];
begin
  UnoEnero := StrtoDate('01/01/' + FormatDateTime('yyyy', Fecha));
  Dias := Fecha - UnoEnero + 1;
  if Rellena
    then begin
    Aux := '000' + floatTostr(int(dias));
    Aux := copy(aux, length(aux) - 2, 3);
    result := Aux;
  end
  else Result := IntTostr(trunc(Dias));
end;
//-----------------------------------------------------------------------------
function AnyoyDiaJuliano(Fecha: Tdatetime): string;
begin
  Result := FormatDateTime('yyyy', Fecha)+DiaJuliano(Fecha,true);
end;
//-----------------------------------------------------------------------------
function NReal(Cadena: string; Defecto: Real): Real;
begin
  Result := defecto;
  if cadena <> '' then result := strtofloat(cadena);
end;
//-----------------------------------------------------------------------------
function DameClave2(Car: Char): Byte;
var aux, i: Integer; // le damos por ejempol A que es ascii 65, y lo suma hasta que de < 10
  Str: string; // es decir, la suma da 11 y la suma de esto da 2
begin
  Aux := 0; Str := inttoStr(ord(car));
  for i := 1 to length(Str) do Aux := Aux + Strtoint(Str[i]);
  if aux > 9 then Result := DameClave2(chr(Aux)) else Result := Aux;
end;
//-----------------------------------------------------------------------------
function DameClave(Cadena, Cadena2, Programa: string): string; //Cadena=Nombre;Cadena2=cif
var aux, Resultado: string; //le pasamos dos cadena, y nos construye una clave en funcion de las dos
  i, K, Max: Integer;
begin
  Cadena := upperCase(Cadena); Cadena2 := upperCase(Cadena2);
  Aux := ''; Resultado := ''; Cadena := Cadena + Cadena2;
  Cadena := Funciones.QuitaCaracter(Cadena, ' ');
  if cadena = '' then exit;
  max := length(Cadena);
  for i := Max downto 0 do Aux := Aux + Cadena[i];
  Aux := Aux + '3h?l5j1hjzx?l5ax#0h?l5ka#@klaww?l5';

  resultado := Funciones.SubCadena(Aux, 5, 9); resultado := resultado + Funciones.SubCadena(Aux, 15, 18);
  resultado := resultado + Funciones.SubCadena(Aux, 1, 6); resultado := resultado + Funciones.SubCadena(Aux, 19, 25);
  resultado := resultado + Funciones.SubCadena(Aux, 15, 18); resultado := resultado + Funciones.SubCadena(Aux, 9, 16);
  Aux := resultado;

  max := length(Aux); k := 0;
  for i := 2 to Max do
  begin
    if k = 0 then Resultado := Resultado + Aux[i] else k := k - 1;
    if aux[i] in ['0'..'9'] then
      case Strtoint(aux[i]) of
        1, 6, 7, 9: k := 2;
        2, 4, 5, 8: k := 1;
      end; //Case
  end; //del for

  Aux := resultado; max := length(Aux);
  for i := 1 to Max do
    case Aux[i] of
      '0'..'9': Resultado := Resultado + chr(ord(Aux[i]) + 2);
      'I'..'Z': Resultado := Resultado + chr(ord(Aux[i]) + 5);
      'A'..'H': Resultado := Resultado + chr(ord(Aux[i]) + 3);
    else Resultado := Resultado + chr(ord(Aux[i]) + 1);
    end; //del case
  if length(Resultado) < 15 then Resultado := Resultado + 'KDFQAVZSUOSQK';
  Aux := Resultado; Resultado := '';

  Resultado := Resultado + InttoStr(DameClave2(Aux[6])); Resultado := Resultado + InttoStr(DameClave2(Aux[11]));
  Resultado := Resultado + InttoStr(DameClave2(Aux[19])); Resultado := Resultado + InttoStr(DameClave2(Aux[10]));
  Resultado := Resultado + InttoStr(DameClave2(Aux[18])); Resultado := Resultado + InttoStr(DameClave2(Aux[16]));
  Resultado := Resultado + InttoStr(DameClave2(Aux[17])); Resultado := Resultado + InttoStr(DameClave2(Aux[20]));
  Resultado := Resultado + InttoStr(DameClave2(Aux[22])); Resultado := Resultado + InttoStr(DameClave2(Aux[22]));
  Resultado := Resultado + InttoStr(DameClave2(Aux[8])); Resultado := Resultado + InttoStr(DameClave2(Aux[13]));
  Resultado := Resultado + InttoStr(DameClave2(Aux[21])); Resultado := Resultado + InttoStr(DameClave2(Aux[14]));
  Resultado := Resultado + InttoStr(DameClave2(Aux[8]));
  if Programa = 'SSocial'
    then begin Resultado[1] := '5'; Resultado[9] := '5'; end;
  result := Resultado;
end;
//-----------------------------------------------------------------------------
procedure LiberarMemoria;
begin
   //Liberar Memoria Virtual
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
end;

function QuitarSubCadena(SubCadena, Cadena: string): string;
//var
{   indice:integer;}
begin
  Result := StringReplace(Cadena, Subcadena, '', []);

{   indice:=Pos(SubCadena,Cadena);
   if indice>0 then
   begin
      delete (cadena, indice, length(Subcadena));
   end;
   Result:=Cadena;}
end;
//-------------------------------------------------------------
function IsPrinter: Boolean;
const
  PrnStInt: Byte = $17;
  StRq: Byte = $02;
  PrnNum: Word = 0; { 0 para LPT1, 1 para LPT2, etc. }
var
  nResult: byte;
begin (* IsPrinter*)
  asm
  mov ah,StRq;
  mov dx,PrnNum;
  Int $17;
  mov nResult,ah;
  end;
  IsPrinter := (nResult and $80) = $80;
end;
//-------------------------------------------------------------
function RepiteCadenaVacia(car: string; LongCadena: integer): string; //
var a: string;
begin
  Result := ''; if LongCadena = 0 then exit;
  a := car;
  result := rellena(a, car, LongCadena);
end;
//-------------------------------------------------------------
function Base3000(B3000: Real): Real;
var B1, B2: Real;
begin
  B1 := B3000;
  B2 := Int(B1 / 3000 + 0.49);
  B1 := B2 * 3000;
  Result := B1;
end;
//-------------------------------------------------------------
function AnoBisiesto(Fecha: TDate): Boolean;
var Ano: Integer;
  Fechakk: TDateTime;
begin
  Ano := StrToInt(FormatDateTime('yyyy', Fecha));
  if TryEncodeDate(Ano, 2, 29, Fechakk)
    then Result := True
  else Result := False;
end;
//-----------------------------------------------------------------------------
function LimpiaDNI(cadena: string): string;
var Aux: string;
  i: Integer;
begin
  Aux := '';
  for i := 1 to Length(Cadena) do
    if Cadena[i] in ['0'..'9', 'A'..'Z', 'a'..'z']
      then Aux := Aux + Cadena[i];
  result := Aux;
end;
//-----------------------------------------------------------------------------
function TextoaMsDOS(Cadena: string): string;
//Aqui hay unos cuantos
begin
  Cadena := Funciones.CambiarChar(Cadena, 'ñ', '¤');
  Cadena := Funciones.CambiarChar(Cadena, 'Ñ', '¥');
  Cadena := Funciones.CambiarChar(Cadena, 'º', '§');
  Cadena := Funciones.CambiarChar(Cadena, 'ª', '¦');

  Cadena := Funciones.CambiarChar(Cadena, 'Á', 'µ');
  Cadena := Funciones.CambiarChar(Cadena, 'É', '');
  Cadena := Funciones.CambiarChar(Cadena, 'Í', 'Ö');
  Cadena := Funciones.CambiarChar(Cadena, 'Ó', 'à');
  Cadena := Funciones.CambiarChar(Cadena, 'Ú', 'é');

  Cadena := Funciones.CambiarChar(Cadena, 'á', 'a');
  Cadena := Funciones.CambiarChar(Cadena, 'é', '‚');
  Cadena := Funciones.CambiarChar(Cadena, 'í', '¡');
  Cadena := Funciones.CambiarChar(Cadena, 'ó', '¢');
  Cadena := Funciones.CambiarChar(Cadena, 'ú', '£');

  result := Cadena;
end;
//-----------------------------------------------------------------------------
function IntercalarBlancos(Cadena: string; Cuantos: Byte): string;
var aux, Aux2: string;
  i: Integer;
begin
  Aux := ''; Aux2 := primerasLetras('                             ', Cuantos);
  for i := 1 to length(Cadena) do
    Aux := Aux + Cadena[i] + Aux2;
  result := Aux;
end;
//------------------------------------------------------------------------------
function DimeCombo(Combo: TComboBox; Como: Integer): string;
// 1-> Codigo
// 2-> Descripción
var Aux, Aux2: string;
begin
  aux := Combo.Text;
  aux2 := Funciones.Descomponer(aux, '-');
  if Como = 1
    then Result := trim(Aux2)
  else Result := trim(Aux)
end;
//------------------------------------------------------------------------------
function LimpiaRuta(Ruta: string): string;
var Aux: string;
begin
  Aux := Ruta;
  Aux := Funciones.QuitaCaracter(Aux, '?');
  Aux := Funciones.QuitaCaracter(Aux, '/');
  Aux := Funciones.QuitaCaracter(Aux, '*');
  result := Aux;
end;
//------------------------------------------------------------------------------
function DameNombrePC: string;
var
  pcComputer: PChar;
  dwCSize: DWORD;
begin
  dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
  GetMem(pcComputer, dwCSize);
  try
    if Windows.GetComputerName(pcComputer, dwCSize) then
      Result := pcComputer;
  finally
    FreeMem(pcComputer);
  end;
end;
//------------------------------------------------------------------------------
// copia los valores de los campos que se llamen igual de dos tablas
// No Copiar es por si queremos que un campo no se copie
// modificar es si un campo queremos modificarlo
// anyado es si añadimos un nuevo registro o modificamos el destino
procedure BorrarArchivosTemporalesInternet(FicherosAdjuntos: TStrings);
var Fichero: string;
  i: Integer;
//Elimina los archivos temporales de Internet
begin
  i := 0;

  while i < FicherosAdjuntos.Count do
  begin
    Fichero := FicherosAdjuntos.Strings[i];
    if (ExisteFichero(Fichero)) and (ExtractFileExt(Fichero) <> '.pdf')
      then deletefile(Fichero);
    inc(i);
  end;
end;
//------------------------------------------------------------------------------
function DimeCadena(Cadena: string; Como: Integer): string;
// 1-> Codigo
// 2-> Descripción
var Aux, Aux2: string;
begin
  aux := Cadena;
  aux2 := Funciones.Descomponer(aux, '-');
  if Como = 1
    then Result := trim(Aux2)
    else Result := trim(Aux)
end;
//------------------------------------------------------------------------------
function SeparaCadena(Cadena: string; separador:char; indice: Integer): string;
// 1-> Codigo
// 2-> Descripción
var Aux, Aux2: string;
begin
  aux := Cadena;
  aux2 := Funciones.Descomponer(aux, separador);
  if indice = 1
    then Result := trim(Aux2)
    else Result := trim(Aux)
end;
//------------------------------------------------------------------------------
function NumerodeSemana(Fecha: TDate): Integer;
var FechaIni: TDate;
  Numero: Integer;

  function PrimerDiaSemana(Fecha: TDate): TDate;
  var dia: Integer;
  begin
    dia := DayofWeek(Fecha);
    if Dia = 1
      then fecha := Fecha - 6
    else if Dia > 2
      then fecha := Fecha - dia + 2;
    Result := Fecha;
  end;

begin
  FechaIni := PrimerDiaSemana(Strtodate('01/01/' + FormatDateTime('yyyy', Fecha)));
  Numero := Trunc((Fecha - FechaIni) / 7) + 1;
  if Numero = 53 then Numero := 1;
  Result := Numero;
end;
//------------------------------------------------------------------------------
function FechadeSemana(semana, ano: Integer): TDate;
var FechaIni: TDate;

  function PrimerDiaSemana(Fecha: TDate): TDate;
  var dia: Integer;
  begin
    dia := DayofWeek(Fecha);
    if Dia = 1
      then fecha := Fecha - 6
    else if Dia > 2
      then fecha := Fecha - dia + 2;
    Result := Fecha;
  end;

begin
  FechaIni := PrimerDiaSemana(Strtodate('01/01/' + inttoStr(ano)));
  Result := FechaIni + (7 * Semana);
end;
//------------------------------------------------------------------------------
function EnteroEntreValores(Numero, Minimo, Maximo: Integer): Boolean;
begin
  if (Numero >= Minimo) and (Numero <= Maximo)
    then result := true
  else Result := False;
end;
//------------------------------------------------------------------------------
function DameCadenaConexionADO(RutaFicheroMDB: string; Proveedor: Integer): string;
var
  Cadena: string;
// 1 -> Microsoft Jet 4.0 OLE DB Provider
begin
  if Trim(RutaFicheroMDB) = '' then exit;
  case Proveedor of
    1: Cadena := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + RutaFicheroMDB + ';Persist Security Info=False';
  else MessageDlg('Error, Proveedor de acceso a Datos NO indicado', mtError, [mbOk], 0);
  end; //del case
  Result := Cadena;
end;
//------------------------------------------------------------------------------
procedure CopiaCombo(var ComboOrigen, ComboDestino: TComboBox);
var Lista: TStrings;
begin
  try
    Lista := TStrings.Create;
    Lista := ComboOrigen.Items;
    ComboDestino.items := Lista;
  except
    Lista.Free;
  end;
end;
//------------------------------------------------------------------------------
function MismoMes(Fecha1, fecha2: TDate): Boolean;
begin
  result := Formatdatetime('mm/yyyy', Fecha1) = Formatdatetime('mm/yyyy', Fecha2);
end;
//------------------------------------------------------------------------------
function MuestraMensaje(Texto, Titulo, Tipo, Botones: string; Defecto: Integer): Integer;
//Resultados
// smbOK	A button with the caption ‘OK’
// smbCancel	A button with the caption ‘Cancel’
// smbYes	A button with the caption ‘Yes’
// smbNo	A button with the caption ‘No’
// smbAbort	A button with the caption ‘Abort’
// smbRetry	A button with the caption ‘Retry’
// smbIgnore	A button with the caption ‘Ignore’
var Opciones: Integer;
begin
  Tipo := UpperCase(Tipo);
  Botones := UpperCase(Botones);
  if Titulo = '' then
    case Tipo[1] of
      'A': Titulo := '¡ATENCIÓN!';
      'I': Titulo := 'INFORMACIÓN';
      'E': Titulo := '¡ERROR!';
      'P': Titulo := 'PREGUNTA';
    end;

  if (Botones = '') then Opciones := 0 else //Aceptar
    if (Botones = 'SN') then Opciones := 4 else //SiNo
      if (Botones = 'AC') then Opciones := 1 else //AceptarCancelar
        if (Botones = 'SNC') then Opciones := 3 else //SiNoCancelar
          if (Botones = 'RC') then Opciones := 5 else //ReintentarCancelar
            if (Botones = 'ARO') then Opciones := 2; //AbortarReintentarOmitir

  case Tipo[1] of
    'A': Opciones := Opciones + 48; //Atencion
    'I': Opciones := Opciones + 64; //Informacion
    'E': Opciones := Opciones + 16; //Error
    'P': Opciones := Opciones + 32; //Pregunta
  end;

  case Defecto of
    1: Opciones := Opciones; //Por defecto deja el primero
    2: Opciones := Opciones + 256; //Boton2
    3: Opciones := Opciones + 512; //Boton3
    4: Opciones := Opciones + 1024; //Boton4
  end;

  Result := Application.MessageBox(PChar(Texto), PChar(Titulo), Opciones);
end;

procedure MuestraFlat(Formulario: TForm; Valor: Boolean);
var i: Integer;
begin
  for i := 0 to Formulario.ComponentCount - 1 do
    if Formulario.Components[i] is TSpeedButton
      then TSpeedButton(Formulario.Components[i]).Flat := Valor;
end;

procedure ComprimirZIP(Origen, Destino: string);
begin
//  WinExec(PChar('WinZip -min -a -ex -hs "' + Destino + '" "' + Origen), SW_SHOWNORMAL);
end;

procedure IgualaLimites(Desde, Hasta: TEdit);
begin Hasta.Text := Desde.Text; end;

function CodigoProvincia(Provincia: string): string;
var Aux: string;
begin
  Provincia := LowerCase(trim(Provincia));
  Provincia := funciones.CambiarChar(Provincia, 'á', 'a');
  Provincia := funciones.CambiarChar(Provincia, 'é', 'e');
  Provincia := funciones.CambiarChar(Provincia, 'í', 'i');
  Provincia := funciones.CambiarChar(Provincia, 'ó', 'o');
  Provincia := funciones.CambiarChar(Provincia, 'ú', 'u');
  Aux := funciones.PrimerasLetras(Provincia + '    ', 3);
  Result := '00';
  if (Aux = 'alav') then result := '01';
  if (Aux = 'alba') then result := '02';
  if (Aux = 'alic') then result := '03';
  if (Aux = 'alme') then result := '04';
  if (Aux = 'astu') or (Aux = 'ovi') then result := '33';
  if (Aux = 'avil') then result := '05';
  if (Aux = 'bada') then result := '06';
  if (Aux = 'barc') then result := '08';
  if (Aux = 'burg') then result := '09';
  if (Aux = 'cace') then result := '10';
  if (Aux = 'cadi') then result := '11';
  if (Aux = 'cant') or (Aux = 'sant') then result := '30';
  if (Aux = 'cast') then result := '12';
  if (Aux = 'ceut') then result := '51';
  if (Aux = 'ciud') or (Aux = 'rea') then result := '13';
  if (Aux = 'cord') then result := '14';
  if (Aux = 'coru ') or (Aux = 'la c') or (Aux = 'a co') then result := '15';
  if (Aux = 'cuen') then result := '16';
  if (Aux = 'giro') or (Aux = 'gero') then result := '17';
  if (Aux = 'gran') then result := '18';
  if (Aux = 'guad') then result := '19';
  if (Aux = 'guip') then result := '20';
  if (Aux = 'huel') then result := '21';
  if (Aux = 'hues') then result := '22';
  if (Aux = 'ille') or (Aux = 'isla') or (Aux = 'bale') or (Aux = 'ibiz') or (Aux = 'form')
    or (Aux = 'mall') or (Aux = 'meno') then result := '07';
  if (Aux = 'jaen') then result := '23';
  if (Aux = 'leon') then result := '24';
  if (Aux = 'llei') or (Aux = 'leri') then result := '25';
  if (Aux = 'lugo') then result := '27';
  if (Aux = 'madr') then result := '28';
  if (Aux = 'mala') then result := '29';
  if (Aux = 'meli') then result := '52';
  if (Aux = 'murc') then result := '30';
  if (Aux = 'nava') then result := '31';
  if (Aux = 'oure') or (Aux = 'oren') then result := '32';
  if (Aux = 'pale') then result := '34';
  if (Aux = 'palm') then result := '35';
  if (Aux = 'pont') then result := '36';
  if (Aux = 'rioj') or (Aux = 'logr') then result := '26';
  if (Aux = 'sala') then result := '37';
  if (Aux = 'scte') or (Aux = 'tene') then result := '38';
  if (Aux = 'sego') then result := '40';
  if (Aux = 'sevi') then result := '41';
  if (Aux = 'sori') then result := '42';
  if (Aux = 'tarr') then result := '43';
  if (Aux = 'teru') then result := '44';
  if (Aux = 'tole') then result := '45';
  if (Aux = 'vale') then result := '46';
  if (Aux = 'vall') then result := '47';
  if (Aux = 'vizc') then result := '48';
  if (Aux = 'zamo') then result := '49';
  if (Aux = 'zara') then result := '50';
end;

procedure RellanaFechasPrefijadas(Lista: TStrings);
begin
  Lista.Clear;
  Lista.Add('Año anterior');
  Lista.Add('Año anterior 1º Trimestre');
  Lista.Add('Año anterior 2º Trimestre');
  Lista.Add('Año anterior 3º Trimestre');
  Lista.Add('Año anterior 4º Trimestre');
  Lista.Add('Año actual');
  Lista.Add('Año Actual 1º Trimestre');
  Lista.Add('Año Actual 2º Trimestre');
  Lista.Add('Año Actual 3º Trimestre');
  Lista.Add('Año Actual 4º Trimestre');
  Lista.Add('Semana Actual');
  Lista.Add('Semana Anterior');
  Lista.Add('Quincena Actual');
  Lista.Add('Quincena Anterior');
end;
//------------------------------------------------------------------------------
function PrimerDiaanyo:Tdate;
begin  
  result := strtodate('01/01/'+formatdatetime('yyyy',date()));
end;
//------------------------------------------------------------------------------
function UltimoDiaanyo:Tdate;
begin
  result := strtodate('31/12/'+formatdatetime('yyyy',date()));
end;
//------------------------------------------------------------------------------
procedure FechasPrefijadas(var FechaIni: Tdate; var FechaFin: Tdate; Como: Byte);
{como
0 -> Año anterior
1 -> Año anterior 1º Triemestre
2 -> Año anterior 2º Triemestre
3 -> Año anterior 3º Triemestre
4 -> Año anterior 4º Triemestre
5 -> Año actual
6 -> Año Actual 1º Triemestre
7 -> Año Actual 2º Triemestre
8 -> Año Actual 3º Triemestre
9 -> Año Actual 4º Triemestre
10-> Semana Actual
11-> Semana Anterior
12-> Quincena  Actual
13-> Quincena  Anterior
}
var Mes, ano, anoanterior: string[5];
  FechaI, FechaF: string[15];
  Hoy: TDatetime;
begin
{  Ano:=formatdatetime('yyyy',FechaIni);
  Mes:=formatdatetime('mm',FechaIni);
  AnoAnterior:=formatdatetime('yyyy',FechaIni-365);}
  Hoy := Date();
  Ano := formatdatetime('yyyy', Hoy);
  Mes := formatdatetime('mm', Hoy);
  AnoAnterior := formatdatetime('yyyy', Hoy - 365);

  case Como of
    0: begin FechaI := '01/01/' + AnoAnterior; FechaF := '31/12/' + AnoAnterior; end;
    1: begin FechaI := '01/01/' + AnoAnterior; FechaF := '31/03/' + AnoAnterior; end;
    2: begin FechaI := '01/04/' + AnoAnterior; FechaF := '30/06/' + AnoAnterior; end;
    3: begin FechaI := '01/07/' + AnoAnterior; FechaF := '30/09/' + AnoAnterior; end;
    4: begin FechaI := '01/10/' + AnoAnterior; FechaF := '31/12/' + AnoAnterior; end;

    5: begin FechaI := '01/01/' + Ano; FechaF := '31/12/' + Ano; end;
    6: begin FechaI := '01/01/' + Ano; FechaF := '31/03/' + Ano; end;
    7: begin FechaI := '01/04/' + Ano; FechaF := '30/06/' + Ano; end;
    8: begin FechaI := '01/07/' + Ano; FechaF := '30/09/' + Ano; end;
    9: begin FechaI := '01/10/' + Ano; FechaF := '31/12/' + Ano; end;
    10: begin //semana actual
        Hoy := Hoy - dayofweek(Hoy) + 2;
        FechaI := FormatDatetime('dd/mm/yyyy', Hoy);
        FechaF := FormatDatetime('dd/mm/yyyy', Hoy + 6);
      end;
    11: begin //semana anterior
        Hoy := Hoy - 7 - dayofweek(Hoy) + 2;
        FechaI := FormatDatetime('dd/mm/yyyy', Hoy);
        FechaF := FormatDatetime('dd/mm/yyyy', Hoy + 6);
      end;
    12: begin //Quincena actual
        if Strtoint(FormatDatetime('dd', Hoy)) <= 15
          then begin
          FechaI := '01/' + FormatDatetime('mm/yyyy', Hoy);
          FechaF := '15/' + FormatDatetime('mm/yyyy', Hoy);
        end
        else begin
          FechaI := '16/' + FormatDatetime('mm/yyyy', Hoy);
          FechaF := FormatDatetime('dd/mm/yyyy',
            UltimoDiadelMes(Strtoint(mes), Strtoint(ano)));
        end;
      end;
    13: begin //Quincena Anterior
        if Strtoint(FormatDatetime('dd', Hoy)) > 15
          then begin
          FechaI := '01/' + FormatDatetime('mm/yyyy', Hoy);
          FechaF := '15/' + FormatDatetime('mm/yyyy', Hoy);
        end
        else begin
          if Strtoint(mes) = 1
            then begin mes := '12'; ano := IntToStr(Strtoint(Ano) - 1); end;
          FechaI := '16/' + mes + '/' + ano;
          FechaF := FormatDatetime('dd/mm/yyyy',
            UltimoDiadelMes(Strtoint(mes), Strtoint(ano)));
        end;
      end;

  end; //del case

  FechaIni := Strtodate(FechaI);
  FechaFin := Strtodate(FechaF);
end;
//--------------------------------------------------------------------------------------------
// Formatea: Funcion que aplica a un string una mascara devolviendonos otro string formateado con dicha mascara.
//--------------------------------------------------------------------------------------------
// Parametros: sValor-> String a formatear; sFormato -> Mascara de salida ;sRefCampo-> es un idicador
// para que en caso de error nos muestre cual fue la referencia del campo que ha fallado (campo de un fichero,
// variable, etc)
// Devuelve un string con el formato pedido.
// Mascaras de salida (las letras pueden ser mayusculas o minúsculas:
//   'S10'    ->  ej '      hola'
//   '-S10'   ->  ej 'hola      '
//   'N10'    ->  ej '    100000'
//   '+N10'   ->  ej '   +100000' sale siempre signo
//   '-N10'   ->  ej '   -100000' no sale signo si es positivo
//   'N10.2'  ->  ej '   1000.22'
//   'N10,2'  ->  ej '   1000,22'
//   '+N10.2' ->  ej '  +1000.22' sale siempre signo
//   '-N10,2' ->  ej '  -1000,22' no sale signo si es positivo
//   'C10'    ->  ej '0000100000'
//   '+C10'   ->  ej '+000100000' sale siempre signo(*)
//   '-C10'   ->  ej '-000100000' no sale signo si es positivo (*)
//   'E10'    ->  ej '  1.000'
//   'D10'    ->  ej '  1.000,00'
//   'M10'    ->  ej '  1,000.00€'
//   'fdd/mm/yy' -> la mascara esta formada por la letra 'f' y cualquier valor de fecha/hora en inglés
//   'fhh/mm/ss'
// (*) estas mascaras no están ajustadas del todo y actualmente dan problemas
//--------------------------------------------------------------------------------------------------
Function Formatea(sValor,sFormato,sRefCampo:String):String;
//--------------------------
function FormatExcep(sF,sV,sRefCampo:String):String;
begin
      try
      Result:=Format(sF,[sV]);
      except
         MessageDlg('Error generacion de formato'+#13
                   +'Mascara:'+'%'+sF+'u'+#13
                   +'Valor: '+sV+#13
                   +'Campo:'+sRefCampo , mtWarning, [mbOK], 0);
         Result:='';
         end;
end;
//--------------------------
Function Formateador(sValor,sPre,sFormato,sTipo,sSigDecim,sPrefijo,sQuitar,sRefCampo:String):String;
var
Entera,Decimal,FormOrigi:String;
begin
   FormOrigi:=sFormato;
   sFormato:=StringReplace(sFormato,sQuitar,'',[]);
   if sSigDecim='' then
   begin
      try
      Result:=Format('%'+sPre+Trim(sFormato)+sTipo,[StrToInt(sValor)]);
      if sPrefijo<>'' then result:=sPrefijo+copy(Result,2,length(Result));
      except
         MessageDlg('Error generacion de formato'+#13
                   +'Mascara:'+FormOrigi+#13
                   +'Mascara real:'+'%'+sPre+Trim(sFormato)+sTipo+#13
                   +'Valor: '+sValor+#13
                   +'Campo:'+sRefCampo , mtWarning, [mbOK], 0);
         end;
      end
    else
      begin
         Entera:=Copy(sFormato,1,pos(sSigDecim,sFormato)-1);
         Decimal:=Copy(sFormato,pos(sSigDecim,sFormato)+1,Length(sFormato));
         sValor:=FloatToStr(Redondea(StrToFloat(sValor),StrToInt(Decimal)));
         try
         Result:=Format(sPrefijo+'%'+sPre+Trim(Entera)+sTipo,[Trunc(StrToFloat(sValor))])
         +sSigDecim
         +Format('%-'+Trim(Decimal)+'s',[copy(StringReplace(FloatToStr(Abs(Frac(StrToFloat(sValor)))),'0,','',[])+'000000',1,StrToInt(Decimal))]);
//         +Format('%-'+Trim(Decimal)+'u',[StrToInt(StringReplace(Copy(FloatToStr(Frac(StrToFloat(sValor))),1,9),'0,','',[]))]);
         except
         MessageDlg('Error generacion de formato'+#13
                   +'Mascara:'+FormOrigi+#13
                   +'Mascara real 1:'+sPrefijo+'%'+sPre+Trim(Entera)+sTipo+#13
//                   +'Mascara real 2:'+'%'+sPre+Trim(Decimal)+sTipo+ #13
                  +'Mascara real 2:'+'%-'+Trim(Decimal)+'u'+ #13
                   +'Valor1: '+FloatToStr(Trunc(StrToFloat(sValor)))+#13
//                   +'Valor2: '+StringReplace(copy(FloatToStr(Frac(StrToFloat(sValor))),1,9),'0,','0',[])+#13
                   +'Valor2: '+'%-'+Trim(Decimal)+'s'+#13
                   +'Campo:'+sRefCampo , mtWarning, [mbOK], 0);
         end;
      end;
end;
//--------------------------principal de formatea
var
iValor:integer;
sDecimal:String;
begin
//   Result:='s/v';
   sValor:=Funciones.CambiarChar(sValor,Funciones.SimboloNoDecimal,Funciones.SimboloDecimal);
   Result:=sValor;
   sFormato:=UpperCase(sFormato);
// Area de Strings

   if copy(sFormato,1,1)='L' then // Limpia espacios y caracteres raros
      begin
         Result:=LimpiaDNI(sValor);
         exit;
      end;
//'S10'->'%-10s'
   if copy(sFormato,1,1)='S' then
      begin
         sFormato:=StringReplace(sFormato,'S','',[]);
         Result:=Format('%-'+Trim(sFormato)+'s',[sValor]);
         exit;
      end;

// Area de Fechas
   if copy(sFormato,1,1)='F' then
      begin
         sFormato:=StringReplace(sFormato,'F','',[]);
         Result:=FormatDateTime(sFormato,StrToDateTime(sValor));
         exit;
      end;

// Area de Números
   sDecimal:='';
   if Pos('.',sFormato)>0 then sDecimal:='.';
   if Pos(',',sFormato)>0 then sDecimal:=',';
//-----------------

//'N+10'->'%10u'      ej '   100000+'
   if copy(sFormato,1,2)='N+' then
      begin
         iValor:=StrToInt(sValor);
         if iValor<0 then
            Result:=Formateador(sValor,'',sFormato,'d',sDecimal,'','N+',sRefCampo)
          else  Result:=Formateador(sValor,'',sFormato,'d',sDecimal,'+','N+',sRefCampo);
          if Pos('+',Result)>0 then Result:=StringReplace(Result,'+','',[])+'+';
          if Pos('-',Result)>0 then Result:=StringReplace(Result,'-','',[])+'-';
         exit;
      end;
//'N-10'->'%10u'      ej '   100000-'
   if copy(sFormato,1,2)='N-' then
      begin
         Result:=Formateador(sValor,'',sFormato,'d',sDecimal,'','N-',sRefCampo);
          if Pos('-',Result)>0 then Result:=StringReplace(Result,'-','',[])+'-';
         exit;
      end;

//-------------------
//'N10'->'%10u'      ej '    100000'
   if copy(sFormato,1,1)='N' then
      begin
         Result:=Formateador(sValor,'',sFormato,'u',sDecimal,'','N',sRefCampo);
         exit;
      end;
//'+N10'->'%10u'      ej '   +100000'
   if copy(sFormato,1,2)='+N' then
      begin
         iValor:=StrToInt(sValor);
         if iValor<0 then
            Result:=Formateador(sValor,'',sFormato,'d',sDecimal,'','+N',sRefCampo)
          else  Result:=Formateador(sValor,'',sFormato,'d',sDecimal,'+','+N',sRefCampo);
         exit;
      end;
//'-N10'->'%10u'      ej '   -100000'
   if copy(sFormato,1,2)='-N' then
      begin
         Result:=Formateador(sValor,'',sFormato,'d',sDecimal,'','-N',sRefCampo);
         exit;
      end;
//'C+10'->'%.10d'    ej '000100000+'
   if copy(sFormato,1,2)='C+' then
      begin
         iValor:=StrToInt(sValor);
         if iValor<0 then
            Result:=Formateador(sValor,'.',sFormato,'d',sDecimal,'','C+',sRefCampo)
          else  Result:=Formateador(sValor,'.',sFormato,'d',sDecimal,'+','C+',sRefCampo);
          if Pos('+',Result)>0 then Result:=StringReplace(Result,'+','',[])+'+';
          if Pos('-',Result)>0 then Result:=StringReplace(Result,'-','',[])+'-';
         exit;
      end;

//'C-10'->'%.10d'    ej '000100000-' no sale signo si es positivo
   if copy(sFormato,1,2)='C-' then
      begin
         Result:=Formateador(sValor,'.',sFormato,'d',sDecimal,'','C-',sRefCampo);
          if Pos('-',Result)>0 then Result:=StringReplace(Result,'-','',[])+'-';
         exit;
      end;

//'C10'->'%.10u'     ej '0000100000'
   if copy(sFormato,1,1)='C' then
      begin
         Result:=Formateador(sValor,'.',sFormato,'u',sDecimal,'','C',sRefCampo);
         exit;
      end;
//'+C10'->'%.10d'    ej '+000100000'
   if copy(sFormato,1,2)='+C' then
      begin
         iValor:=StrToInt(sValor);
         if iValor<0 then
            Result:=Formateador(sValor,'.',sFormato,'d',sDecimal,'','+C',sRefCampo)
          else  Result:=Formateador(sValor,'.',sFormato,'d',sDecimal,'+','+C',sRefCampo);
         exit;
      end;

//'-C10'->'%.10d'    ej '-000100000' no sale signo si es positivo
   if copy(sFormato,1,2)='-C' then
      begin
         Result:=Formateador(sValor,'.',sFormato,'d',sDecimal,'','-C',sRefCampo);
         exit;
      end;

//'E10'->'%10.n'    ej '  1.000'
   if copy(sFormato,1,1)='E' then
      begin
//         Result:=Formateador(sValor,'',sFormato,'n',sDecimal,'','E',sRefCampo);
         sFormato:=StringReplace(sFormato,'E','',[]);
         Result:=Format('%.'+Trim(sFormato)+'2n',[StrToFloat(sValor)]);
         Result:=Copy(Result,1,Pos(',',Result)-1);
         exit;
      end;
//'D10'->'%10.2n'    ej '  1.000,00'
   if copy(sFormato,1,1)='D' then
      begin
         sFormato:=StringReplace(sFormato,'D','',[]);
         Result:=Format('%.'+Trim(sFormato)+'2n',[StrToFloat(sValor)]);
         exit;
      end;
//'M10'->'%10.2m'    ej '  1,000.00€'
   if copy(sFormato,1,1)='M' then
      begin
         sFormato:=StringReplace(sFormato,'M','',[]);
         Result:=Format('%.'+Trim(sFormato)+'2m',[StrToFloat(sValor)]);
         exit;
      end;
//'.' 1000,00 -> 1000.00    Obliga punto
   if copy(sFormato,1,2)='O.' then
      begin
         Result:=StringReplace(sValor,',','.',[]);
         exit;
      end;
//'.'  1000.00 -> 1000,00   Obliga coma
   if copy(sFormato,1,2)='O,' then
      begin
         Result:=StringReplace(sValor,'.',',',[]);
         exit;
      end;

end;

procedure Traza(Texto: string);
var
  t: Longint;
  f: file of Byte;
  Fichero: TextFile;
  Linea, Testigo, Marcador, Dif, Entero, Decimal, NomPantalla: string;
  Buffer: array[0..46] of Char;
  Leidos: Integer;
  HoraOld, HoraNew: TDateTime;
  Pantalla: HWND;
  Buffer2: array[0..20] of char;
begin
  HoraNew := Now;
  Testigo := '   ';
  Marcador := ' ';
  Entero := '*****';
  Decimal := '***';

  Pantalla := GetActiveWindow;

  GetClassName(Pantalla, Buffer2, 20); // Nos da en nombre de la clase
//GetWindowText(Pantalla,NomPantalla,30); // Nos da el literal de la cabecera del form
  NomPantalla := string(Buffer2);
  if Trim(NomPantalla) = '' then NomPantalla := '<Área de create>';

//IconData : TNotifyIconData;


//   with IconData do
//      begin
//         cbSize := sizeof(IconData);
//         Wnd := Application.Handle;
//         uID := 100;
//         uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
//         uCallbackMessage := 5000;//WM_USER + 1;
//         hIcon := Application.Icon.Handle;
//         StrPCopy(szTip, Application.Title);
//      end;
//   Shell_NotifyIcon(NIM_ADD, @IconData);


  if FileExists('c:\traza.txt') then
  begin
    AssignFile(F, 'c:\traza.txt');
{$I-}
    Reset(F);
{$I+}
    T := FileSize(F);
    try
      Seek(F, T - 47);
      BlockRead(F, Buffer, Sizeof(Buffer) - 1, Leidos);
//       MessageDlg('*'+String(Buffer)+'*', mtWarning, [mbOK], 0);
      Linea := string(Buffer);
      HoraOld := EncodeDateTime(StrToInt(Copy(Linea, 7, 4)), StrToInt(Copy(Linea, 4, 2)), StrToInt(Copy(Linea, 1, 2))
        , StrToInt(Copy(Linea, 15, 2)), StrToInt(Copy(Linea, 18, 2)), StrToInt(Copy(Linea, 21, 2)), StrToInt(Copy(Linea, 24, 3)));
    except
      HoraOld := HoraNew;
    end;

    CloseFile(F);

    AssignFile(Fichero, 'c:\traza.txt');
{$I-}
    Append(Fichero);
{$I+}
    Dif := FloatToStr(SecondSpan(HoraNew, HoraOld));
    Dif := StringReplace(Dif, '.', ',', []);
    Entero := Copy(Dif, 1, Pos(',', Dif) - 1);
    Entero := StringOfChar(' ', 5 - length(Entero)) + Entero;
    if length(Entero) > 5 then
    begin

    end
    else
    begin
      Decimal := Copy(Dif, Pos(',', Dif) + 1, 3);
      Decimal := StringOfChar(' ', 3 - length(Decimal)) + Decimal;
    end;
   //
  end
  else
  begin
    AssignFile(Fichero, 'c:\traza.txt');
{$I-}
    Rewrite(Fichero);
{$I+}
  end;
  Dif := Entero + ',' + Decimal;
  Linea := FormatDateTime('dd/mm/yyyy    hh:nn:ss:zzz', HoraNew);

  WriteLn(Fichero, Texto + StringOfChar(' ', 40 - length(Texto)) + '[' + NomPantalla + StringOfChar(' ', 20 - length(NomPantalla)) + ']  ' + Linea + '  ' + Testigo + '  ' + '[' + Dif + ']' + Marcador);
  CloseFile(Fichero);
//   if IconData.Wnd <> 0
//      then Shell_NotifyIcon(NIM_DELETE, @IconData);

end;

procedure PrintImage(Image: TImage; ZoomPercent: Integer);
  // if ZoomPercent=100, Image will be printed across the whole page
var
  relHeight, relWidth: integer;
begin
  Screen.Cursor := crHourglass;
  Printer.BeginDoc;
  with Image.Picture.Bitmap do
  begin
    if ((Width / Height) > (Printer.PageWidth / Printer.PageHeight)) then
    begin
      // Stretch Bitmap to width of PrinterPage
      relWidth := Printer.PageWidth;
      relHeight := MulDiv(Height, Printer.PageWidth, Width);
    end
    else
    begin
      // Stretch Bitmap to height of PrinterPage
      relWidth := MulDiv(Width, Printer.PageHeight, Height);
      relHeight := Printer.PageHeight;
    end;
    relWidth := Round(relWidth * ZoomPercent / 100);
    relHeight := Round(relHeight * ZoomPercent / 100);
    DrawImage(Printer.Canvas, Rect(0, 0, relWidth, relHeight), Image.Picture.Bitmap);
  end;
  Printer.EndDoc;
  Screen.cursor := crDefault;
end;

procedure DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
var
  Header, Bits: Pointer;
  HeaderSize: DWORD;
  BitsSize: DWORD;
begin
  GetDIBSizes(ABitmap.Handle, HeaderSize, BitsSize);
  Header := AllocMem(HeaderSize);
  Bits := AllocMem(BitsSize);
  try
    GetDIB(ABitmap.Handle, ABitmap.Palette, Header^, Bits^);
    StretchDIBits(Canvas.Handle, DestRect.Left, DestRect.Top,
      DestRect.Right, DestRect.Bottom,
      0, 0, ABitmap.Width, ABitmap.Height, Bits, TBitmapInfo(Header^),
      DIB_RGB_COLORS, SRCCOPY);
  finally
    FreeMem(Header, HeaderSize);
    FreeMem(Bits, BitsSize);
  end;
end;

//------------------------------------------------------------------------------
Function ObtenerIPLocal():String;
type
  pu_long = ^u_long;
var
  varTWSAData : TWSAData;
  varPHostEnt : PHostEnt;
  varTInAddr : TInAddr;
  namebuf : Array[0..255] of char;
begin
//  If WSAStartup($101,varTWSAData) <> 0 Then
//  Result := 'No. IP Address'
//  Else Begin
//    gethostname(namebuf,sizeof(namebuf));
//    varPHostEnt := gethostbyname(namebuf);
//    varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
//    Result := inet_ntoa(varTInAddr);
//  End;
//  WSACleanup;
end;


//------------------------------------------------------------------------------
//Obtener IP pública pc local
function ObtenerIPPublicaPCLocal(webIP, textoBuscar: string): string;
var
  obtenerHTTP: TidHTTP;
  web: TStringList;
  i, posCar: integer;
  lineaActual, lineaCor, ip: string;
begin
  if webIP = ''
    then webIP := 'http://www.ajpdsoft.com/ip.php';
  if textoBuscar = ''
    then textoBuscar := 'Su IP: ';

  web := TStringList.Create;
  obtenerHTTP := TidHTTP.Create(nil);
  try
    web.Text := obtenerHTTP.Get(webIP);
  finally
    obtenerHTTP.Free;
  end;
  for i := 0 to web.Count do
  begin
    lineaActual := web.Strings[i];
    if Pos(textoBuscar, lineaActual) <> 0 then
    begin
      lineaCor := copy(lineaActual, Pos(textoBuscar, lineaActual)
        + length(textoBuscar), length(lineaActual));
      posCar := 1;
      ip := '';
      while (lineaCor[posCar] in ['0'..'9']) or (lineaCor[posCar] = '.') do
      begin
        ip := ip + lineaCor[posCar];
        posCar := posCar + 1;
      end;
      Break;
    end;
  end;
  ObtenerIPPublicaPCLocal := ip;
end;
//-----------------------------------------------------------------------
function SemanasEntreFechas(FechaINI, FechaFIN: TDateTime; Como: Integer): Integer;
//para semanas completas
//para saber ciantas semans hay esta la funcion WeeksBetween(const ANow, AThen: TDateTime): Integer;
var semaIni,SemaFin,Resultado:Integer;
begin
  semaIni := WeekOf(FechaINI);
  SemaFin := WeekOf(FechaFIN);
  if YearOf(FechaINI)=YearOf(FechaFIN)
    then Resultado:= SemaFin-SemaIni
    else begin
           resultado:=SemaFin;
           resultado:=resultado +(WeeksInYear(FechaINI)-semaIni);
           FechaINI:=FechaINI+365;//incremento un año
           FechaFin:=FechaFin-365;//incremento un año
           while FechaINI<FechaFin do
             begin
                semaIni:=WeeksInYear(FechaINI);
                resultado:=resultado + semaIni;
                FechaINI:=FechaINI+365
             end;
         end;
  result:=resultado;
end;
//-----------------------------------------------------------------------
function MesesEntreFechas(FechaINI, FechaFIN: TDateTime; Como: Integer): Integer;
// Como
//  0 -> Devuelve los meses
//  1 -> Devuelve los dias TOTALES
//  2 -> Dias que le quedan del mes (ampliamos el tipo 0 )
var DiasINI, DiasFIN, MesINI, MesFIN, AnoINI, AnoFIN,
  i, Aux, Aux2, Aux3, MesesTotales, DiasTotales: Integer;
  FechaInclusive: Boolean;
  AnoRes, MesRes: integer; // ana 20/07/06
begin
  FechaInclusive := False; //Si es verdadero entre hoy y hoy hay un dia
  if FechaINI > FechaFIN
    then begin
    Result := 0;
    Exit;
  end;

  MesesTotales := 0;
  DiasTotales := 0;
  DiasINI := StrToInt(FormatDateTime('dd', FechaINI));
  DiasFIN := StrToInt(FormatDateTime('dd', FechaFIN));
  MesINI := StrToInt(FormatDateTime('mm', FechaINI));
  MesFIN := StrToInt(FormatDateTime('mm', FechaFIN));
  AnoINI := StrToInt(FormatDateTime('yyyy', FechaINI));
  AnoFIN := StrToInt(FormatDateTime('yyyy', FechaFIN));

  if AnoINI < AnoFIN //Controlo si son de distinto años
    then Aux := 12 * (AnoFIN - AnoINI)
  else Aux := 0;
  Aux2 := 0;
  Aux3 := 0;

  case Como of
    0: begin //MESES
         { for i := (MesINI + 1) to (MesFIN-1+Aux) do begin
            if i-Aux = 13 then Aux2 := Aux + 12; //Controlo si cambia de año
            Inc(MesesTotales);
          end;
          if (DiasINI <= DiasFIN) and (MesINI <> MesFIN) then Inc(MesesTotales);
          Result := MesesTotales;
          }

          // ana   20/07/06
        AnoRes := AnoFin - AnoIni;
        MesRes := MesFin - MesIni;
        if MesRes < 1
          then begin
          MesRes := MesRes + 12;
          AnoRes := AnoRes - 1;
        end;
        if DiasFin + 1 < DiasIni then MesRes := MesRes - 1; // esto se utilizará si queremos tener en cuenta también los dias para el cálculo
        MesRes := MesRes + (AnoRes * 12);
        Result := MesRes;

      end;

    1: begin //DIAS
        if (MesINI <> MesFIN) or (AnoINI <> AnoFIN) then begin
          DiasTotales := NumeroDiasdelMes(MesINI, AnoINI) - DiasINI; //Cuento el resto de dias que le quedan al mes
          for i := (MesINI + 1) to (MesFIN - 1 + Aux) do begin
            if i - Aux2 = 13 then begin //Controlo si cambia de año
              Aux2 := Aux2 + 12;
              Aux3 := Aux3 + 1;
            end;
            DiasTotales := DiasTotales + NumeroDiasdelMes(i - Aux2, AnoINI + Aux3);
          end;
          DiasTotales := DiasTotales + DiasFIN;
          if AnoINI < AnoFIN then begin
            if (MesINI <= 2) then if IsLeapYear(AnoINI) then Inc(DiasTotales);
            if (MesFIN >= 2) then if IsLeapYear(AnoFIN) then Inc(DiasTotales);
          end else
            if (MesINI <= 2) and (MesFIN >= 2)
              then if IsLeapYear(AnoFIN) then Inc(DiasTotales);
        end else begin
          DiasTotales := DiasFIN - DiasINI;
        end;
        if FechaInclusive then Inc(DiasTotales); //Fecha fin inclusive
        Result := DiasTotales;
      end;
    2: begin //RESTO DIAS
        if (MesINI = MesFIN) then begin
          if (DiasINI < DiasFIN)
            then DiasTotales := DiasFIN - DiasINI;
        end else begin
          if (DiasINI > DiasFIN)
            then DiasTotales := NumeroDiasdelMes(MesFIN, AnoFIN) - DiasINI + DiasFIN
          else DiasTotales := DiasFIN - DiasINI;
        end;
        if FechaInclusive then Inc(DiasTotales); //Fecha fin inclusive
        Result := DiasTotales;
      end;
  end; //del case
end;
//------------------------------------------------------------------------------
function ComponCuenta(Cta, Codigo: string; Longitud: Integer): string;
var i, k: Integer;
begin
  Cta := Cta + '000000000000000';
  Cta := PrimerasLetras(Cta, Longitud - 1);
  k := length(cta) - length(codigo) + 1;
  for i := 1 to length(Codigo) do
  begin Cta[k] := Codigo[i]; inc(k); end;
  Result := Cta;
end;
//------------------------------------------------------------------------------
function TraduceImporte(Cadena: string; Idioma: Char): string;
begin
  case Idioma of
    'C', 'V': begin //Català - Valencià

        Cadena := CambiarSubCadena(Cadena, 'DieciSeis', 'Setze');
        Cadena := CambiarSubCadena(Cadena, 'DieciSiete', 'Disset');
        Cadena := CambiarSubCadena(Cadena, 'DieciOcho', 'Divuit');
        Cadena := CambiarSubCadena(Cadena, 'DieciNueve', 'Denou');

        Cadena := CambiarSubCadena(Cadena, 'Cero', 'Zero');
        Cadena := CambiarSubCadena(Cadena, 'Uno', 'Un');
        Cadena := CambiarSubCadena(Cadena, 'Cuatro', 'Quatre');
        Cadena := CambiarSubCadena(Cadena, 'Cinco', 'Cinc');
        Cadena := CambiarSubCadena(Cadena, 'Seis', 'Sis');
        Cadena := CambiarSubCadena(Cadena, 'Siete', 'Set');
        Cadena := CambiarSubCadena(Cadena, 'Ocho', 'vuit');
        Cadena := CambiarSubCadena(Cadena, 'Nueve', 'Nou');
        Cadena := CambiarSubCadena(Cadena, 'Diez', 'Deu');
        Cadena := CambiarSubCadena(Cadena, 'Once', 'Onze');
        Cadena := CambiarSubCadena(Cadena, 'Doce', 'Dotze');
        Cadena := CambiarSubCadena(Cadena, 'Trece', 'Tretze');
        Cadena := CambiarSubCadena(Cadena, 'Catorce', 'Catorze');
        Cadena := CambiarSubCadena(Cadena, 'Quince', 'Quinze');
        Cadena := CambiarSubCadena(Cadena, 'Veinte', 'Vint');
        Cadena := CambiarSubCadena(Cadena, 'Veinti', 'Vint-i-');
        Cadena := CambiarSubCadena(Cadena, 'Treinta', 'Trenta');
        Cadena := CambiarSubCadena(Cadena, 'Cuarenta', 'Quaranta');
        Cadena := CambiarSubCadena(Cadena, 'Cincuenta', 'Cinquanta');
        Cadena := CambiarSubCadena(Cadena, 'Sesenta', 'Seixanta');
        Cadena := CambiarSubCadena(Cadena, 'Setenta', 'Setanta');
        Cadena := CambiarSubCadena(Cadena, 'Ochenta', 'Vuitanta');
        Cadena := CambiarSubCadena(Cadena, 'Noventa', 'Noranta');

        Cadena := CambiarSubCadena(Cadena, 'Cien', 'Cen');
        Cadena := CambiarSubCadena(Cadena, 'Quinientos', 'Cinc cents');
        Cadena := CambiarSubCadena(Cadena, 'SeteCentos', 'Set cents');
        Cadena := CambiarSubCadena(Cadena, 'NoveCentos', 'Nou cents');

        Cadena := CambiarSubCadena(Cadena, 'Millón', 'Milió');
        Cadena := CambiarSubCadena(Cadena, 'Millones', 'Milions');

        Cadena := CambiarSubCadena(Cadena, 'y', '');
        Cadena := CambiarSubCadena(Cadena, 'con', 'amb');
        Cadena := CambiarSubCadena(Cadena, 'tos', 'ts');
        Cadena := CambiarSubCadena(Cadena, 'to', 't');
        Cadena := CambiarSubCadena(Cadena, 'tas', 'ts');
        Cadena := CambiarSubCadena(Cadena, 'mos', 'ms');

      end;
  end; //del case
  Result := Cadena;
end;

procedure RellenacomboImprimir(combo: Tcombobox);
begin
  Combo.Items.clear;
  Combo.Items.Add('No Imprimir');
  Combo.Items.Add('Sí, según ficha');
  Combo.Items.Add('Sí, sólo papel');
  Combo.Items.Add('Sí, sólo fax');
  Combo.Items.Add('Sí, sólo pdf');
  Combo.Items.Add('Sí, sólo e-mail');
end;

function DimecomboImprimir(combo: Tcombobox): char;
begin
  Result := '-';
  case Combo.itemindex of
    1: Result := 'X';
    2: Result := 'N';
    3: Result := 'F';
    4: Result := 'P';
    5: Result := 'E';
  end; //del case
end;
//------------------------------------------------------------------------------
function RegistraEMail(EmailDestino, Asunto,sMensaje:String;
                       slMensaje, slFicherosAdjuntos: TStrings;
                       TipoEnvio,error:String;TablaSQLAux: TADOQuery): string;

                       //TipoEnvio [E]nviado, [2]reenviado, e[R]ror
var StrSQL,FicherosAdjuntos,Mensaje,Fecha,Hora: String;
    i:Integer;
    STRaux:string;
begin
  if TablaSQLAux=NIl
    then exit;
  Fecha:=fechainglesa(Date());
  fecha:='#'+Fecha+'#';

  hora := formatdatetime('hh:nn:ss',time());
  if EmailDestino=''     then EmailDestino:='Vacio';
  FicherosAdjuntos:='';  Mensaje:=sMensaje;         i := 0;
  if (slFicherosAdjuntos <> nil) and (slFicherosAdjuntos.Count > 0)
    then for i:=0 to slFicherosAdjuntos.Count-1 do
           FicherosAdjuntos:=FicherosAdjuntos+';'+slFicherosAdjuntos.Strings[i];
  if (slMensaje <> nil) and (slMensaje.Count > 0)
    then for i:=0 to slMensaje.Count-1 do
           Mensaje:=Mensaje+';'+slMensaje.Strings[i];



  StrSQL:=Funciones.ConstruyeInsertInto('CieEnvios',
      ['DireccionDestino','Asunto','Cuerpo','Adjuntos','fecha','hora','Enviado','Error'],
      [EmailDestino,Asunto,Mensaje,FicherosAdjuntos,Fecha,Hora,TipoEnvio,Error],
      ['C','C','C','C','C','C','C','C']);




{  StrSQL:='INSERT INTO emails ( DireccionDestino, Asunto, Cuerpo, Adjuntos, fecha, hora, Enviado, Error ) '+
          'SELECT "'+EmailDestino+'" AS Destino, "'+Asunto+'" AS Asunto_, '+
                 '"'+Mensaje+'" AS Cuerpo_, "'+FicherosAdjuntos+'" AS Aduntos_, '+
                 Fecha +'AS Fecha_, "'+Hora+'" AS Hora_, "'+TipoEnvio+'" AS Enviado_, "'+Error+'" AS error_;';}
  EjecutaSQLADO(StrSQL,TablaSQLAux);
end;
function RegistraEMail_2(EmailDestino, Asunto,sMensaje:String;
                       slMensaje, slFicherosAdjuntos: TStrings;
                       TipoEnvio,error:String;TablaSQLAux: TADOQuery): string;

                       //TipoEnvio [E]nviado, [2]reenviado, e[R]ror
var StrSQL,FicherosAdjuntos,Mensaje,Fecha,Hora: String;
    i:Integer;
    STRaux:string;
    CodigoCliente,Cuerpo,RutaFactura:String;
    Usuario:integer;
begin
  EsSQLserver:=true;

  if TablaSQLAux=NIl
    then exit;

  try
    if ModuloDatos.TrabajoConCadenas then
      CodigoCliente:=ModuloDatos.TablaFacturas.fieldbyname('CieClienteCadena').AsString
    else
      CodigoCliente:=ModuloDatos.TablaFacturas.fieldbyname('CodigoCliente').AsString;
  Except
     CodigoCliente:='';
  end;
  try
     Cuerpo:='Factura: '+ModuloDatos.TablaFacturas.fieldbyname('EjercicioFactura').AsString+'/'+ModuloDatos.TablaFacturas.fieldbyname('SerieFactura').AsString+
        '/'+ModuloDatos.TablaFacturas.fieldbyname('NumeroFactura').AsString;
  Except
     Cuerpo:='';
  end;

  Usuario:=StrToInt(funciones.NumerosSolo(ModuloDatos.UsuarioLogic));



  //Fecha:=fechainglesa(Date());


  Fecha:=FormatDateTime('dd/mm/yyyy',date());


  //fecha:='#'+Fecha+'#';

  hora := formatdatetime('hh:nn:ss',time());
  if EmailDestino=''     then EmailDestino:='Vacio';
  FicherosAdjuntos:='';  Mensaje:=sMensaje;         i := 0;
  if (slFicherosAdjuntos <> nil) and (slFicherosAdjuntos.Count > 0)
    then for i:=0 to slFicherosAdjuntos.Count-1 do
           FicherosAdjuntos:=FicherosAdjuntos+';'+slFicherosAdjuntos.Strings[i];
  if (slMensaje <> nil) and (slMensaje.Count > 0)
    then for i:=0 to slMensaje.Count-1 do
           Mensaje:=Mensaje+';'+slMensaje.Strings[i];

  RutaFactura:=ModuloDatos.TablaFacturas.fieldbyname('ruta').AsString;

  StrSQL:=Funciones.ConstruyeInsertInto('CieEnvios',
      ['codigoEmpresa','Email1','Asunto','fechaEnvio','ErrorEnvio','CodigoCliente','Usuario','Cuerpo','Adjunto1'],
      [Empresa,EmailDestino,Asunto,fecha,TipoEnvio,CodigoCliente,IntToStr(Usuario),Cuerpo,RutaFactura],
      ['N','C','C','C','F','C','C','C','C']);

  EjecutaSQLADO(StrSQL,TablaSQLAux);
end;

//------------------------------------------------------------------------------
function EscribeFichero(Fichero, LineaReg: string): Boolean;
var
  F: TextFile;
begin
  AssignFile(F, Fichero);
  if FileExists(Fichero) then {$I-}Append(F){$I+}
  else {$I-}Rewrite(F); {$I+}
  WriteLn(F, LineaReg);
  CloseFile(F);
end;
procedure RenombraFichero(NomOld,NomNew:String);// ¡¡ojo!! borra el fichero en caso de existir
begin
        if not RenameFile(NomOld,NomNew) then
        begin
          DeleteFile(NomNew);
          RenameFile(NomOld,NomNew);
        end;
end;

procedure PanelInfo(Mensaje: string; TiempoSg: integer);
  procedure BotonClick(Sender: TObject);
  begin
    TPanel(Sender).Visible := false;
    Sender.Free;
  end;
var
  w, h: integer;
  PBuff: PChar;
  Pantalla: HWND;
  Buffer: array[0..20] of char;
  Padre: TwinControl;
  NomPadre: string;
  Componente: TComponent;
begin
  Pantalla := GetActiveWindow;
  GetClassName(Pantalla, Buffer, 20);
  NomPadre := Trim(string(Buffer));
  Padre := Application.FindComponent(copy(NomPadre, 2, length(NomPadre))) as TWinControl;
  if TiempoSg = 0 then
  begin
    w := 300;
    h := 300;
  end
  else
  begin
    w := 200;
    h := trunc((length(mensaje) / 30) * 17); //+- 30 caracteres entran en un witdh de 200
  end;

  with TPanel.Create(Padre) do
  begin
    name := 'PanelInfo';
    Parent := Padre;
    Left := Padre.Left + 10;
    Top := Padre.Top + 10;
    caption := '';
    Width := w;
    Height := h;
    Alignment := taCenter;
    BevelInner := bvRaised;
    Visible := True;
    setfocus;
  end;
  Componente := Padre.FindComponent('PanelInfo') as Tcomponent;
  Application.ProcessMessages;
  if TiempoSg <> 0 then
  begin
    with TLabel.Create(Componente) do
    begin
      name := 'MensajeInfo';
      Align := alClient;
      Parent := Componente as TWinCOntrol;
      Autosize := true;
      Width := 200;
      Height := 200;
      Caption := Mensaje;
      Alignment := taCenter;
      Transparent := False;
      BringToFront;
      Visible := True;
      WordWrap := True;
    end;
    Application.ProcessMessages;
    Sleep(TiempoSg * 1000);
  end
  else
  begin
    with TMemo.Create(Componente) do
    begin
      name := 'MensajeInfoMemo';
      Parent := Componente as TWinCOntrol;
      Left := 2;
      Top := 2;
      Width := w - 2;
      Height := h - 40;
      Lines.Add(Mensaje);
      Visible := True;
    end;
    with TLabel.Create(Componente) do
    begin
      name := 'Pulse';
      Align := alBottom;
      Parent := Componente as TWinCOntrol;
      Autosize := true;
      Caption := 'Pulse la barra espaciadora para continuar';
      Alignment := taCenter;
      Transparent := False;
      BringToFront;
      Visible := True;
      WordWrap := True;
    end;
    Application.ProcessMessages;
    while HiByte(getKeyState(VK_SPACE)) = 0 do
    begin
      Application.ProcessMessages;
    end;
    TPanel(COmponente).Visible := false;
    Application.ProcessMessages;
  end;
  TPanel(COmponente).free;
  Application.ProcessMessages;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
// ConectaSMTP, EnviaEMail,DesConectaSMTP son tres funciones pensadas para el envio de multiples
// correos (direcciones distintas)
// Los parametros son obvios, devuleve un string vacio si ha ido todo bien o en caso
// contrario la descripción del error.
// Los tres graban en un fichero plano los errores (ErrEMail.txt)
//
//____________________________________________________________________________________

{
function ConectaSMTP(PuertoSMTP, HostSMTP, UsuarioSMTP, PassSMTP: string): TIdSMTP;
var
  i: Integer;
  sError: string;
  servidorSmtp: TIdSMTP;

begin
  sError := '';
  result := TIdSMTP.Create(nil);

  with Result do
  begin
    Port := StrToInt(PuertoSMTP);
    Host := HostSMTP;
    if Trim(UsuarioSMTP) <> '' then UserNAME := UsuarioSMTP;
    if Trim(PassSMTP) <> '' then Password := PassSMTP;
// 10/04/2018
//    if ((Trim(UsuarioSMTP) <> '') and (Trim(PassSMTP) <> '')) then
//      AuthenticationType := AtLogin;
    AuthType := atDefault; //atNone;
    try
      Connect();
    except
//      on E: EIdSocketError do
//        sError := 'Host desconocido o incorrecto. Error(' + IntToStr(E.LastError) + ')';
      on E: Exception do
        sError := ' Error(' + E.Message + ')';
    else
      begin
        sError := 'Fallo en la conexion SMTP (error no perteneciente al protocolo).';
        raise; //para que muestre el error.
      end;
    end;
  end;
  if not (sError = '') then
  begin
    EscribeFichero('ErrEMail.txt', 'Email dest:'
      + '  PuertoSMTP:' + PuertoSMTP + '  UsuarioSMTP:'
      + UsuarioSMTP + '  Con:' + PassSMTP + ' Desc. Error:' + sError);
    Result := nil;
  end;
end;
}
//________________________________________________________________________________________
// EnviarEMail:
// sMensaje se diferencia de slMensaje en que este último permite por parte del usuario
// formatear en lineas el mensaje (saber donde terminan y donde acaban,Lineas en blanco, tabulaciones...)
// mientras que en sMensaje sale al monton.
//_______________________________________________________________________________

function EnviaEMail(ConexSMTP: TIDSMTP; EmailorigenAux, EmailDestinoAux, tituloAux, sMensaje: string;
                    slMensaje, slFicherosAdjuntos: TStringList): string;
var
  i: Integer;
  sError: string;
  mensajeCorreo: TIdMessage;

begin
  sError := '';
  mensajeCorreo := TIdMessage.Create(nil);
  with mensajeCorreo do
  begin
    Subject := TituloAux;
//    Body.Text := 'Cuerpo del correo';
    if slMensaje.Count > 0 then
      Body.AddStrings(slMensaje)
    else Body.Add(sMensaje);

    From.Address := EmailorigenAux;
    ReplyTo.EMailAddresses := EmailorigenAux;
    Recipients.EMailAddresses := EmailDestinoAux;
    ReceiptRecipient.Text := '';
    Priority := TidMessagePriority(mpHighest);
    if (slFicherosAdjuntos <> nil) and (slFicherosAdjuntos.Count > 0) then
    begin
      i := 0;
      while i < slFicherosAdjuntos.Count do
      begin
        if FileExists(slFicherosAdjuntos.Strings[i]) then
          TIdAttachmentFile.Create(mensajeCorreo.MessageParts, slFicherosAdjuntos.Strings[i]);
//          TIdAttachment.Create(MessageParts, slFicherosAdjuntos.Strings[i]);
        inc(i);
      end;
    end;
  end;
  try
    ConexSMTP.Send(mensajeCorreo);
  except
    on E: EFOpenError do
      sError := 'Fichero Adjunto desconocido o erróneo. Error(' + E.Message + ')';
//    on E: EIdSocketError do
//      sError := 'Host desconocido o incorrecto. Error(' + IntToStr(E.LastError) + ')';
    on E: Exception do
      sError := ' Error(' + E.Message + ')';
  else
    begin
      sError := 'Fallo en el envio de email (error no perteneciente al protocolo).';
      raise; //para que muestre el error.
    end;
  end;

  mensajeCorreo.Free;
  if not (sError = '') then
    EscribeFichero('ErrEMail.txt', 'Email dest:'
      + EmailDestinoAux + '  PuertoSMTP:'
      + ' Desc. Error:' + sError);
  Result := sError;
end;
//______________________________________________________________________________

function DesConectaSMTP(ConexSMTP: TIDSMTP): string;
var
  sError: string;
begin
  sError := '';
  try
    ConexSMTP.Disconnect;
  except
    sError := 'Fallo desconexion (error no perteneciente al protocolo).';
    raise; //para que muestre el error.
  end;

  ConexSMTP.Free;
  if not (sError = '') then
    EscribeFichero('ErrEMail.txt', 'Desc. Error:' + sError);
  Result := sError;
end;

procedure CompactarMDB97(Ruta: string);
var dao: OleVariant;
begin
  try
    try
      dao := CreateOleObject('Dao.DBEngine.35');
      dao.CompactDatabase(Ruta, 'nuevo' + Ruta);
      deletefile(ruta);
      RenameFile('Nuevo' + Ruta, Ruta);
    except MessageDlg('ERROR Compactando: + Ruta', mtWarning, [mbOk], 0); end;
  finally
    MessageDlg('ERROR Compactando: + Ruta', mtWarning, [mbOk], 0); end;
end;
//-----------------------------------------------------------------------------
procedure RepararMDB97(Ruta: string);
var dao: OleVariant;
begin
  try
    dao := CreateOleObject('Dao.DBEngine.35');
    dao.RepairDatabase(Ruta);
  except
    MessageDlg('ERROR Reparando: + Ruta', mtWarning, [mbOk], 0);
  end;
end;
//-----------------------------------------------------------------------------
function ExisteObjetoSQLSERVER(const Nombre,Tipo: string; TablaSQLAux: TADOQuery): Boolean;
//tipo V -> Vista
//     T -> Tabla
begin
  if Tipo<>''
    then Result:=ExisteRegistro( 'sysobjects',['name','xtype'],[QuotedStr(Nombre),QuotedStr(Tipo)],TablaSQLAux,[])
    else Result:=ExisteRegistro( 'sysobjects',['name'],[QuotedStr(Nombre)],TablaSQLAux,[])
 // SELECT name, xtype FROM sysobjects WHERE (name = N'empresa') AND (xtype = 'v')
end;
//-----------------------------------------------------------------------------
function EjecutaSQL(Comando: string; TablaSQLAux: TAdoQuery): Boolean;
var aux: string;
  contador: Integer;
  salir: Boolean;
begin
   // SE HACE UN BUCLE POR SI SE BLOQUEA LA SENTENCIA                                      /
   // (Ej. si estoy importando líneas de Autec y hago un Alb. de Barco a la vez)           /

  if EsSQLserver
        then Comando:=CadenaSQLServer(Comando);


  Result := false; contador := 0; Salir := False;
  while ((contador < 50) and not (salir)) do
  begin
    contador := contador + 1; salir := True;
    with TablaSQLAux do begin
      if TablaSQLAux.Active then TablaSQLAux.Close;
      SQL.clear;
      SQL.Add(Comando);
      try
        //open; //-> Cuando haces un Insert (Que no devuelve datos), el Open NO funciona.
        //Prepare; //Optimiza la ejecución de la Sentencia
        ExecSQL;
        result := true;
      except
//        on E: EDbEngineError do begin
//          aux := Format('%s: %s.', [E.ClassName, E.Message]);
//          Salir := False;
//          MessageDlg('EjecutaSQL ' + aux, mtError, [mbOk], 0);
//                 //Result:=false;
//          raise;
//        end;
        on E: EDataBaseError do begin
               // NO QUITAR, OJO----> DARIA PROBLEMAS (SANTOS, NO SABRIA HACER EL MANEJADOR hANDLE)
          Salir := False;
        end;
      end; //FIN DEL TRY
    end; //FIN DEL WITH
  end; //fin del bucle que repite el número de Intentos
  if contador = 50 then begin Result := False; end; //hubo 50 intentos sin éxito
end;
//------------------------------------------------------------------------------
function EjecutaSQLADO_Access(Comando: string; TablaSQLAux: TADOQuery): Boolean;
var Antiguo:Boolean;
begin
 Antiguo    := EsSQLserver;
 EsSQLserver:= False;
 result     := EjecutaSQLADO(Comando,TablaSQLAux);
 EsSQLserver:= Antiguo;
end;
//------------------------------------------------------------------------------
function EjecutaSQLADO(Comando: string; TablaSQLAux: TADOQuery): Boolean;
var aux: string;
  contador: Integer;
  salir: Boolean;
begin
   // SE HACE UN BUCLE POR SI SE BLOQUEA LA SENTENCIA                                      /
   // (Ej. si estoy importando líneas de Autec y hago un Alb. de Barco a la vez)           /
  if EsSQLserver
        then Comando:=CadenaSQLServer(Comando);

  Result := false; contador := 0; Salir := False;
  while ((contador < 50) and not (salir)) do
  begin
    contador := contador + 1; salir := True;
    with TablaSQLAux do begin
      if TablaSQLAux.Active then TablaSQLAux.Close;
      SQL.clear;
      SQL.Add(Comando);
      try
        //open; //-> Cuando haces un Insert (Que no devuelve datos), el Open NO funciona.
//        Prepare;//Optimiza la ejecución de la Sentencia
        ExecSQL;
        result := true;
      except
//        on E: EDbEngineError do begin
//          aux := Format('%s: %s.', [E.ClassName, E.Message]);
//          Salir := False;
//          MessageDlg('EjecutaSQL ' + aux, mtError, [mbOk], 0);
//                 //Result:=false;
//          raise;
//        end;
        on E: EDataBaseError do begin
               // NO QUITAR, OJO----> DARIA PROBLEMAS (SANTOS, NO SABRIA HACER EL MANEJADOR hANDLE)
          Salir := False;
        end;
      end; //FIN DEL TRY
    end; //FIN DEL WITH
  end; //fin del bucle que repite el número de Intentos
  if contador = 50 then begin Result := False; end; //hubo 50 intentos sin éxito
end;
//------------------------------------------------------------------------------
function AbrirTabla(Tabla: Tdataset; SQL_o_Filtro: string): Integer;
var nombre: string;
  Cancela: Boolean;
  Boton: Integer;
begin
  Result := 0;
  Cancela := false;
  while not cancela do
  try
    Cancela := True; Nombre := Tabla.Name;
    if Tabla.Active then Tabla.close;
    if trim(SQL_o_Filtro) <> '' then
      if Tabla is TAdoQuery then
      begin
        (Tabla as TAdoQuery).SQL.Clear;
        (Tabla as TAdoQuery).Sql.add(SQL_o_Filtro);
      end
      else
      begin
//        (Tabla as TTable).Filter := SQL_o_Filtro;
//        (Tabla as TTable).Filtered := True;
      end;
    Tabla.open
  except on X: exception do
    begin
      Boton := MessageDlg('NO se pudo abrir ' + nombre + ' :' + #13 + #13 + X.message,
        mtError, [mbRetry, mbCancel, mbNo], 1);
      case Boton of
        mrCancel: Cancela := true;
        mrAbort: ;
//        mrNo: SacaTexto(SQL_o_Filtro);
      else Cancela := False;
      end; //del case
    end;
  end; //del try
end;
//------------------------------------------------------------------------------
procedure RellenaCombo(var Combo: TComboBox; TablaOri: TDataSet;
            CampoCodigo, CampoNombre, TextoTodos,SituateEn: string);
var Tabla: TDataSet;
    i,indice:Integer;
begin
  indice:=0; i:=-1;
  Combo.Items.Clear;
  if TextoTodos <> ''
    then begin
           Combo.Items.add(TextoTodos);
           inc(i);
         end;
  Tabla := TablaOri;

  Tabla.DisableControls;
  try
    Tabla.First;
    while not (Tabla.eof) do
    begin
      inc(i);
      if (CampoCodigo <> '') and (CampoNombre <> '')
        then Combo.Items.add(trim(Tabla.fieldbyName(CampoCodigo).asstring) + ' - ' +
          Tabla.fieldbyName(CampoNombre).asstring);
      if (CampoCodigo = '') and (CampoNombre <> '')
        then Combo.Items.add(trim(Tabla.fieldbyName(CampoNombre).asstring));
      if (CampoCodigo <> '') and (CampoNombre = '')
        then Combo.Items.add(trim(Tabla.fieldbyName(CampoCodigo).asstring));

      if (CampoCodigo <> '') and (SituateEn <> '') and
         (Tabla.fieldbyName(CampoCodigo).asstring= SituateEn)
          then Indice:=i;

      Tabla.Next;
    end; //del while
  finally
    Tabla.EnableControls;
  end; //del try
  Combo.ItemIndex := Indice;
end;
//------------------------------------------------------------------------------
function CreaDataSet: TdataSet;
begin
//  Result := TQuery.Create(nil);
end;
//------------------------------------------------------------------------------
procedure AbrirAdo(Tabla: TADOQuery; SQL: string);
var nombre: string;
  Cancela: Boolean;
  Boton: Integer;
begin
  Cancela := false;
  while not cancela do
  try
    Cancela := True; Nombre := Tabla.Name;
    Tabla.close;
    if Trim(SQL) <> '' then
    begin
      if EsSQLserver
        then SQL:=CadenaSQLServer(SQL);
      Tabla.SQL.Clear;
      Tabla.SQL.Add(SQL);
    end;
    Tabla.open;
  except on X: exception do begin
      Boton := MessageDlg('NO se pudo abrir ' + nombre + ' :' + #13 + #13 + X.message, mtError,
        [mbRetry, mbCancel], 1);
      if Boton = mrCancel
        then Cancela := true
      else if Boton = mrAbort
        then Application.Terminate
      else Cancela := False;
    end;
  end;
end;

procedure CerrarTablas(Pantalla: TForm);
var
   x: smallint;
begin
For x := 0 To Pantalla.ComponentCount - 1 Do
  If Pantalla.Components[x] Is TDataset
  Then begin
    (Pantalla.Components[x] as TDataset).Cancel;
    (Pantalla.Components[x] as TDataset).Active := False;
  end;
end;

procedure BloquearTablas(Pantalla: TForm);
var
   x: smallint;
   activa :boolean;
   _SELECT, _FROM, _WHERE, _GROUP_BY, _HAVING, _ORDER_BY :string;
begin
For x := 0 To Pantalla.ComponentCount - 1 Do
  If Pantalla.Components[x] Is TCustomADODataSet
  Then begin
    activa := (Pantalla.Components[x] as TCustomADODataSet).Active;
    if activa
        then (Pantalla.Components[x] as TCustomADODataSet).Active := False;

    (Pantalla.Components[x] as TCustomADODataSet).LockType := ltReadOnly;

    if activa
        then if (Pantalla.Components[x] is TADOQuery)
           then begin
           if SepararSELECTSQL((Pantalla.Components[x] as TADOQuery), _SELECT, _FROM, _WHERE, _GROUP_BY, _HAVING, _ORDER_BY)
            then AbrirAdo((Pantalla.Components[x] as TADOQuery), _SELECT + _FROM + _WHERE + _GROUP_BY + _HAVING + _ORDER_BY +';');
           end
        else
           (Pantalla.Components[x] as TCustomADODataSet).Active := activa;
  end;
end;

procedure DesactivarCampos(Pantalla: TForm);
var
   x: smallint;
begin
  For x := 0 To Pantalla.ComponentCount - 1 Do
  begin
    If (Pantalla.Components[x] Is TDBLookupComboBox)
      then (Pantalla.Components[x] as TDBLookupComboBox).Enabled := False;
    If (Pantalla.Components[x] Is TDBEdit)
      then (Pantalla.Components[x] as TDBEdit).Enabled := False;
    If (Pantalla.Components[x] Is TDBRadioGroup)
      then (Pantalla.Components[x] as TDBRadioGroup).Enabled := False;
    If (Pantalla.Components[x] Is TDBMemo)
      then (Pantalla.Components[x] as TDBMemo).Enabled := False;
  end;
end;
//------------------------------------------------------------------------------
Function FechaInglesaEspanola(Fecha: string):String;
var Dia,Mes,Ano:String[4];
    i,Separadores:byte;
begin
  Separadores:=0;
  Dia := '';    Mes := '';       Ano := '';
  for i:=1 to length(Fecha) do
    begin
      if Fecha[i] in ['0'..'9']
        then case separadores of
               0 : Mes:=Mes+Fecha[i];
               1 : Dia:=Dia+Fecha[i];
               2 : Ano:=Ano+Fecha[i];
             end//del case
        else inc(separadores)
    end;
  Result:= Dia +'/'+ Mes+'/'+Ano;
end;
//------------------------------------------------------------------------------
Function CadenaSQLServerUPDATEJOIN(SQL: string):String;
var FromStr,TablaStr,WhereStr,SetStr:String;
    SetInt,WhereInt,i:Integer;
begin
  SetInt  := pos('SET',SQL);
  WhereInt:= pos('WHERE',SQL);
  FromStr:=trim(Funciones.SubCadena(SQL, 7, SetInt-1));
  i:=1;
  while FromStr[i]<>' ' do
    inc(i); //SI SABREMOS EL NOMBRE DE LA TABLA A AACTUALIZAR

  TablaStr:=Funciones.SubCadena(FromStr,1,i-1);
  TablaStr:=trim(Funciones.CambiarSubCadena(TablaStr,'(',' '));
  if WhereInt=0
    then begin
            WhereStr:='';
            SetStr  :=trim(funciones.SubCadena(SQL,SetInt,Length(SQL)-1));
         end
    else begin
            WhereStr:=Trim(funciones.SubCadena(SQL,WhereInt,Length(SQL)-1));
            SetStr  :=Trim(funciones.SubCadena(SQL,SetInt,WhereInt-1));
         end;

  FromStr:='UPDATE '+' '+TablaStr +' '+ SetStr +' FROM '+ FromStr +' '+ WhereStr;
  Result:= FromStr;
end;
//------------------------------------------------------------------------------
Function CadenaSQLServerFechas(SQL: string):String;
var ini,fin:Integer;
    Aux,Cambiaremos:String;
procedure ayuda;
begin
  result:=SQL;
  ini :=pos('#',SQL);
  if ini=0
    then exit;
  Aux:=Funciones.SubCadena(SQL,Ini+1,ini+11);

  fin :=pos('#',Aux);
  if fin=0
    then exit;

  Aux:=funciones.SubCadena(aux,1,fin-1);
  Cambiaremos:='#'+Aux+'#';
//  if EsFechaInglesa=false
  //  then Aux:=FechaInglesaEspanola(Aux);
  Aux:=FechaInglesaEspanola(Aux);
  aux:=''''+aux+'''';
  SQL:=Funciones.CambiarSubCadena(SQL,Cambiaremos,aux)
end;//de ayuda
begin
  SQL:=Funciones.CambiarSubCadena(SQL,'"#"','$$@@$$');
  while pos('#',SQL)>0 do
     ayuda;
  SQL:=Funciones.CambiarSubCadena(SQL,'$$@@$$','''#''');
  result:=SQL;
end;
//------------------------------------------------------------------------------
Function CadenaSQLServerTrim(SQL: string):String;
var i,i2:Integer;
    Resultado:string;
procedure ayudame;
begin
  i:=Pos(' TRIM(',Resultado);
  i2:=i;
  while Resultado[i2]<>')' do
    inc(i2);
  Resultado:=Funciones.SubCadena(Resultado,1,I-1) +
             '@@@'+
             Funciones.SubCadena(Resultado,I+5,I2) +
             ')'+
             Funciones.SubCadena(Resultado,I2+1,length(Resultado));
end;
begin
  Resultado:=SQL;
  while pos(' TRIM(',Resultado)>0 do
     Ayudame;
  Result:=Funciones.CambiarSubCadena(Resultado,'@@@',' RTRIM( LTRIM');
end;
//------------------------------------------------------------------------------
Function CadenaSQLServerDELETE(SQL: string):String;
var i:Integer;
begin
  i:= POS(' FROM',SQL);
  Result:='DELETE '+Funciones.SubCadena(SQL,i,length(sql));
end;
//------------------------------------------------------------------------------
Function CadenaSQLServerInCorchete(SQL: string):String;
var i,j,Final:Integer;
  HayMas:Boolean;
begin
  Result:=SQL;
               i:= Pos('IN [',SQL);   // un espacio
  if i=0  then i:= Pos('IN  [',SQL);  // dos espacios
  if i=0  then i:= Pos('IN   [',SQL); // tres espacios
  if i=0 then exit;
  j:=i;
  Final:=length(SQL);

  repeat    // Vamos a Buscar [
    if SQL[j] ='['
      then begin
             SQL[j]:='(';
             i:=j
           end
      else inc(j);
  until (j>=Final) or (j=i);

  if i=j //hemos encontrado [, vamos a buscar ]
   then repeat
          if SQL[j] =']'
            then begin
                   SQL[j]:=')';
                   i:=j
                 end
            else inc(j);
        until (j>=Final) or (j=i);

  HayMas:=False;
  i:= Pos('IN [',SQL);                if i>0  then HayMas:=true; // un espacio
  if i=0  then i:= Pos('IN  [',SQL);  if i>0  then HayMas:=true; // dos espacios
  if i=0  then i:= Pos('IN   [',SQL); if i>0  then HayMas:=true; // tres espacios

  if HayMas
    then SQL:= CadenaSQLServerInCorchete(SQL);

  Result:=SQL;
end;
//------------------------------------------------------------------------------
Function AyudaCadenaSQLServerIIF(SQL: string):String;
var i,Inicioif,FinalIf,Longitud,Parentesis:Integer;
  Antes,Despues,iif : String;
begin  //falta refinarla
  Result:=SQL;
  i:= pos('IIF',SQL);
  if i=0 then exit;
  InicioIf :=i;
  Longitud := length(SQL);
  while (SQL[i]<>'(') and (i<Longitud) do
     inc(i); //encontramos el inicio del iif
  if i<Longitud then SQL[i]:=' '; //quito el parentesis del iif
  Parentesis:=1;
  repeat
     inc(i);
     if SQL[i]='('  then Parentesis := Parentesis+1;
     if SQL[i]=')'  then Parentesis := Parentesis-1;
  until (Parentesis = 0) or (i=Longitud);
  if (Parentesis = 0) or (i<Longitud)
    then  begin
            SQL[i]:=' '; //quito el parentesis del iif
            FinalIf:=i+1;
          end;
  Antes   := funciones.PrimerasLetras(SQL,InicioIf-2);
  Despues := Funciones.SubCadena(SQL,FinalIf,Longitud);
  iif     := Funciones.SubCadena(SQL,InicioIf+4,FinalIf);

  iif     := ' CASE WHEN  '+IIF+' END ';
  Parentesis:=0; //parentesis son las comas ahora
  SQL:='';
  for i:=1 to length(iif) do
      if (iif[i]=',')
        then if (parentesis=0)
             then begin      // primera coma -> then
                    parentesis:=1;
                    SQL :=  SQL+' THEN ';
                  end
             else   SQL :=  SQL+' ELSE ' //segunda coma -> else
        else SQL := SQL +iif[i];
  SQL := Antes + SQL + Despues;
  Result:=SQL;
end;
//------------------------------------------------------------------------------
Function CadenaSQLServerIIF(SQL: string):String;
begin
 Result:=SQL;
 while pos('IIF',SQL)>0 do
   SQL:=AyudaCadenaSQLServerIIF(SQL);
 Result:=SQL;
end;
//------------------------------------------------------------------------------
Function CadenaSQLServer(SQL: string):String;
begin
  SQL:=UpperCase(SQL);
  SQL:=Funciones.CambiarSubCadena(SQL,'(LTRIM','( LTRIM'); // Por si le pasamos ya una en SQL server con un trim sin espacio por delante
  SQL:=Funciones.CambiarSubCadena(SQL,'(RTRIM','( RTRIM'); // Por si le pasamos ya una en SQL server con un trim sin espacio por delante
  SQL:=Funciones.CambiarSubCadena(SQL,'(TRIM', '( TRIM'); // Por si le pasamos con un trim sin espacio por delante

  if (pos('IIF',SQL)>0)
    then SQL:=CadenaSQLServerIIF(SQL);  // LOS IIF -> Case

  if (pos('UPDATE',SQL)>0) and (pos('JOIN',SQL)>0) and (pos('FROM',SQL)=0)
    then SQL:=CadenaSQLServerUPDATEJOIN(SQL);  // LOS UPDATES SON DISTINTOS QUE ESN ACCES

  if Pos('DELETE',SQL)>0
    then SQL:=CadenaSQLServerDELETE(SQL);

  if (Pos('IN [',SQL)>0) or (Pos('IN  [',SQL)>0) or (Pos('IN   [',SQL)>0)
    then SQL:=CadenaSQLServerInCorchete(SQL);


  SQL:=CadenaSQLServerFechas(SQL);                   // Las fechas no son #, son ' y no en formato ingles
  if Pos('TRIM',SQL)>0
    then SQL:=CadenaSQLServerTrim(SQL);    //  is null -> isnull con 2 argumentos

  SQL:=Funciones.CambiarSubCadena(SQL,'"','''');     // los literales
  SQL:=Funciones.CambiarSubCadena(SQL,'LAST','MAX'); // los literales
  SQL:=Funciones.CambiarSubCadena(SQL,'FIRST','MIN');// los literales
  SQL:=Funciones.CambiarSubCadena(SQL,'INT(','(');   // Los int de los sumatorios
  SQL:=Funciones.CambiarSubCadena(SQL,'TRUE','1');   // los booleanos
  SQL:=Funciones.CambiarSubCadena(SQL,'FALSE','0');
  SQL:=Funciones.CambiarSubCadena(SQL,'FALSO','0');
  SQL:=Funciones.CambiarSubCadena(SQL,'VERDADERO','1');
  SQL:=Funciones.CambiarSubCadena(SQL,'NOW','GetDate()');

  Result:=SQL;
end;
//------------------------------------------------------------------------------
procedure AbrirADODataset(Tabla: TAdoDataset; SQL: string);
var nombre: string;
  Cancela: Boolean;
  Boton: Integer;
begin
  Cancela := false;
  while not cancela do
  try
    Cancela := True; Nombre := Tabla.Name;
    Tabla.close;
    if Trim(SQL) <> '' then
    begin
      if EsSQLserver
        then SQL:=CadenaSQLServer(SQL);
      Tabla.Commandtext := SQL;
    end;
    Tabla.open
  except on X: exception do begin
      Boton := MessageDlg('NO se pudo abrir ' + nombre + ' :' + #13 + #13 + X.message, mtError,
        [mbRetry, mbCancel], 1);
      if Boton = mrCancel
        then Cancela := true
      else if Boton = mrAbort
        then Application.Terminate
      else Cancela := False;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure RellenaComboPositivo(var Combo: TComboBox; TablaOri: TDataSet;
  CampoCodigo, CampoNombre, TextoTodos: string);
var Tabla: TDataSet;
  Negativo: Boolean;
begin
  Negativo := True;
  Combo.Items.Clear;
  if TextoTodos <> '@'
    then Combo.Items.add(TextoTodos);
  Tabla := TablaOri;
  Tabla.DisableControls;
  try
    Tabla.First;
    while not (Tabla.eof) and Negativo do //Nos situamos en el primer registro Positivo
    begin
      if Tabla.fieldbyName(CampoCodigo).asInteger < 0
        then Tabla.Next
      else Negativo := False;
    end;

    while not (Tabla.eof) do begin
      Combo.Items.add(Tabla.fieldbyName(CampoCodigo).asstring + ' - ' +
        Tabla.fieldbyName(CampoNombre).asstring);
      Tabla.Next;
    end;
  finally
    Tabla.EnableControls;
  end; //del try
  Combo.ItemIndex := 0;
end;
//------------------------------------------------------------------------------
procedure FiltraTabla(Tabla: TDataset; comando: string);
begin Tabla.filtered := false; Tabla.filter := comando; Tabla.filtered := true; end;
//------------------------------------------------------------------------------
procedure FiltraNoTabla(tabla: TDataSet);
begin tabla.filtered := false; end;
//------------------------------------------------------------------------------
{
function ExisteTabla(Tabla: TTable; direccion: string): boolean;
begin
  result := false;
  if FileExists(direccion + '\' + Tabla.Tablename)
    then result := true
  else MessageDlg('NO Existe la tabla ' + Tabla.Tablename, mtError, [mbOk], 0);
end;
}
//------------------------------------------------------------------------------
function CopiaRegistro(TablaOrigen, TablaDestino: TDataSet;
const CamposModificar, CamposValores,CamposNoCopiar : array of string;
  anyado, OmitoError: Boolean): Boolean;
begin
  // 2/12/2007 (Javier) Creo copiaregistro2 para controlar el POST por los problemas con ADO
  result := CopiaRegistro2(TablaOrigen, TablaDestino, CamposModificar, CamposValores, CamposNoCopiar, anyado, OmitoError, true);
end;

function CopiaRegistro2(TablaOrigen, TablaDestino: TDataSet;
                        const CamposModificar, CamposValores,CamposNoCopiar : array of string;
                          anyado, OmitoError, actualizo: Boolean): Boolean;
var i, numero, Donde, coincide,NoCopiar: Integer;
  CamposOrigen, CamposDestino: TStringList; //, CamposParaNoCopiar
  aux, Valor: string;
begin
  Result := True;           NoCopiar:=0;
  if Length(CamposModificar) <> Length(CamposValores)
    then MessageDlg('Campos  modificar y valores no coinciden.', mtError, [mbOk], 0);
  try

    CamposOrigen := TStringList.Create; // Creo La lista que contiene los Campos
    CamposDestino:= TStringList.Create; // Creo La lista que contiene los Campos

    {CamposParaNoCopiar := TStringList.Create;

        for i := 0 to High(CamposNoCopiar) do
      CamposParaNoCopiar.Add(CamposNoCopiar[i]);}

    TablaOrigen.GetFieldNames(CamposOrigen);
    TablaDestino.GetFieldNames(CamposDestino);
    CamposOrigen.Sort;
    CamposDestino.Sort;
    Numero       := TablaOrigen.FieldCount; // Nº de Campos de la base de Datos
    //quito de origen, los campos a no copiar
    for i := 0 to High(CamposNoCopiar) do //nuevo santos 16/01/07
      begin
        if CamposOrigen.Find(CamposNoCopiar[i],donde)
          then begin CamposOrigen.Delete(donde); inc(NoCopiar); end;
      end;
    CamposOrigen.Sort;
    Numero       := TablaOrigen.FieldCount-NoCopiar; // Nº de Campos de la base de Datos
    if (numero <= 0) then begin showmessage('La Tabla ' + TablaOrigen.Name + ' No tiene Campos'); exit; end; // Si hay campos lo leo los contenidos como

    i:=0;     coincide := 0;
    while (i<=numero - 1) and (coincide = 0) do
      begin
        if CamposDestino.Find(CamposOrigen[i], donde)
           then inc(Coincide);
        inc(i);
      end;

{    for i := 0 to numero - 1 do
      if CamposDestino.Find(CamposOrigen[i], donde) then inc(Coincide);}

    if (coincide <= 0) then begin showmessage('La Tabla ' + TablaOrigen.Name + ' No coincide en nada con ' + TablaDestino.Name); exit; end; // Si hay campos lo leo los contenidos como

    if anyado //segun sea añadir o no Insertamos o Editamos
      then if TablaDestino.RecordCount <> 0
               then TablaDestino.insert
               else TablaDestino.append
      else if TablaDestino.State <> dsInsert
               then TablaDestino.edit;
    for i := 0 to numero - 1 do //recorro todos los campos y si lo encuentro copio ese campo
      if (CamposDestino.Find(CamposOrigen[i], donde)) //and
        //(CamposParaNoCopiar.Find(CamposOrigen[i], donde) = False)
        then begin
               aux := CamposOrigen[i];
               Valor := TablaOrigen.FieldByName(aux).asstring;
               if Valor <> ''
                  then begin
                         if (Valor <> 'True') and (Valor <> 'False') and (Valor <> 'Verdadero') and (Valor <> 'Falso')
                           then TablaDestino.FieldByName(aux).AsString := Valor
                           else if (Valor = 'True') or (Valor = 'Verdadero')
                                  then TablaDestino.FieldByName(aux).AsBoolean := True
                                  else TablaDestino.FieldByName(aux).AsBoolean := False;
                       end;
            end;
      // recorro los campos a modificar y pongo los valores que deben tener
    for i := low(CamposModificar) to High(CamposModificar) do
    begin
      if (CamposValores[i] <> 'True') and (CamposValores[i] <> 'False') and (CamposValores[i] <> 'Verdadero') and (CamposValores[i] <> 'Falso')
        then
        TablaDestino.FieldByName(CamposModificar[i]).AsString := CamposValores[i]
      else
        if (Valor = 'True') or (Valor = 'Verdadero')
          then TablaDestino.FieldByName(CamposModificar[i]).AsBoolean := True
          else TablaDestino.FieldByName(CamposModificar[i]).AsBoolean := False;
    end;

    if actualizo
    then TablaDestino.Post;

  except on X: exception do begin
      if OmitoError = False
        then MessageDlg('ERROR :' + #13 + #13 + X.message, mtError, [mbOk], 0);
      Result := False;
    end;
  end;
  CamposOrigen.free;
  CamposDestino.free;
end;
//------------------------------------------------------------------------------
function ResultadoDeSQL(TablaAux: TDataSet; StrSQL, CampoResultado, Defecto: string; QuieroRecordCount: Boolean): string;
begin
  Result := Defecto;
//  if TablaAux is TQuery then
//    AbrirTabla (TablaAux, StrSQL)
//  else
    AbrirAdo( TADOQuery(TablaAux), StrSQL);
  if QuieroRecordCount then
  begin
    Result := InttoStr(TablaAux.RecordCount);
    exit;
  end;
  if TablaAux.RecordCount = 0 then exit;
  result := TablaAux.fieldbyname(CampoResultado).asString;
  tablaAux.Close;
end;
//------------------------------------------------------------------------------
procedure Editar(DataSet: TDataSet);
begin
  if DataSet.Active = False
    then DataSet.Active := true;
  if not ((DataSet.State = dsInsert) or
    (DataSet.State = dsEdit))
    then DataSet.edit;
end;
//------------------------------------------------------------------------------
procedure EditarCancelar(DataSet: TDataSet);
begin
  if (DataSet.state = dsInsert) or
    (DataSet.state = dsEdit)
    then DataSet.cancel
end;
//------------------------------------------------------------------------------
procedure LeerFichero(Fich: string; Combo: TDBcomboBox; Lista: TlistBox);
//fich es el fichero a leer
//combo es si copiamos lo que leemos en un combo, entonces Lista = nil
//lista es si copiamos lo que leemos en un combo, entonces Combo = nil
var Fichero: TextFile;
  Linea: string;
begin
  if fich = '' then exit;

  AssignFile(Fichero, Fich);
  if ExisteFichero(Fich) then
{$I-}Reset(Fichero){$I+} //abrir el fichero para leerlo
  else begin
    ReWrite(Fichero);
{$I-}Reset(Fichero); {$I+}
  end;

  while not Eof(Fichero) do
  begin
    Readln(Fichero, Linea);
    if lista = nil then
      Combo.Items.Add(Linea)
    else Lista.Items.Add(Linea);
  end;

  CloseFile(Fichero);
end;
//------------------------------------------------------------------------------
procedure RellenaComboADO(var Combo: TComboBox; TablaOri: TADODataSet;
  CampoCodigo, CampoNombre, TextoTodos: string);
var Tabla: TDataSet;
begin
  Combo.Items.Clear;
  if TextoTodos <> '@' then
    Combo.Items.add(TextoTodos);
  Tabla := TablaOri;
  Tabla.First;
  while not (Tabla.eof) do begin
    Combo.Items.add(Tabla.fieldbyName(CampoCodigo).asstring + ' - ' +
      Tabla.fieldbyName(CampoNombre).asstring);
    Tabla.Next;
  end;
  Combo.ItemIndex := 0;
end;
//------------------------------------------------------------------------------
function IsNumber(S: string): Boolean;
var Number, Code: Integer;
begin
  if varIsNull(s) then Result := false else
  begin
    Val(S, Number, Code);
    Result := (Code = 0);
  end;
end;
//------------------------------------------------------------------------------
function IsDouble(S: variant): Boolean;
var
Number:Double;
   Code: Integer;
begin
   if varIsNull(s) then Result:=false else
   begin
     Val(S, Number, Code);
     Result := (Code = 0);
   end;
end;
//------------------------------------------------------------------------------
procedure DBAdvGridCanSort(Sender: TObject; ACol: Integer;
  var DoSort: Boolean; FieldNameSort:String);
var
  SQL: string;
  slListaCampos: TStringList;
  ADOSQL: TADOQuery;
//  BDESQL: TQuery;
  lHayADO: Boolean;
  GridPrin:TDBAdvGrid;
  //----------------------------------------------------
  function DescomponeOrderBy(SentenciaSQLIn: string): TStringList;
  var
    Aux, Aux2: string;
    i: integer;
  begin
    Result := TstringList.Create;
    SentenciaSQLIn := StringReplace(UpperCase(SentenciaSQLIn), 'SELECT', '', []);
    SentenciaSQLIn := StringReplace(UpperCase(SentenciaSQLIn), ' FROM ', '|', []);
    SentenciaSQLIn := Descomponer(SentenciaSQLIn, '|');
    i := 0;
    while SentenciaSQLIn <> '' do
    begin
      AUx := Descomponer(SentenciaSQLIn, ',');
      inc(i);
      if pos(' AS ', UpperCase(Aux)) > 0 then
      begin
        Aux := StringReplace(UpperCase(Aux), ' AS ', '|', []);
        Aux2 := Trim(Descomponer(Aux, '|'));
        Aux := StringReplace(UpperCase(Aux), '[', '', []);
        Aux := StringReplace(UpperCase(Aux), ']', '', []);
      end
      else
      begin
        Aux2 := Aux; //en Aux2 tenemos el campo entero
        Descomponer(Aux, '.'); // ahora solo queda en 'Aux' el campo indice
        if trim(Aux) = '' then Aux := Aux2;
      end;
      Result.Values[Trim(Aux)] := Trim(Aux2);
    end;
  end;
  //----------------------------------------------------
  function ObtenCampoReal(CampoCabecera: string): string;
  begin
    result := slListaCampos.values[Uppercase(CampoCabecera)];
    if Trim(Result)='' then Result:=CampoCabecera;
  end;
  //----------------------------------------------------
begin
  DoSort := False;
  GridPrin:=TDBAdvGrid(Sender);
  if TDataSource(GridPrin.DataSource).Dataset.ClassName = 'TADOQuery' then
    begin
      ADOSQL := TADOQuery(TDataSource(GridPrin.DataSource).Dataset);
      lHayADO := True;
    end
  else
    begin
//      BDESQL := TQuery(TDataSource(GridPrin.DataSource).Dataset);
      lHayADO := False;
    end;

    if lHayADO then SQL := ADOSQL.SQL.Text;
//    else SQL := BDESQL.SQL.Text;

    if pos('ORDER BY', UpperCase(SQL)) > 0 then
      SQL := copy(SQL, 1, pos('ORDER BY', UpperCase(SQL)) - 1);

    if GridPrin.SortSettings.Direction = sdAscending then
      GridPrin.SortSettings.Direction := sdDescending
    else
      GridPrin.SortSettings.Direction := sdAscending;

    if lHayADO then slListaCampos := DescomponeOrderBy(ADOSQL.SQL.Text);
//    else slListaCampos := DescomponeOrderBy(BDESQL.SQL.Text);

    SQL := SQL + ' ORDER BY ' + ObtenCampoReal(FieldNameSort);
    if GridPrin.SortSettings.Direction = sdDescending then
      SQL := SQL + ' DESC';
    if lHayADO then
    begin
      ADOSQL.SQL.Text := SQL;
      ADOSQL.Active := true;
    end
    else
    begin
//      BDESQL.SQL.Text := SQL;
//      BDESQL.Active := true;
    end;
    GridPrin.SortSettings.Column := ACol;
end;
//------------------------------------------------------------------------------
procedure GrilBonito(Grid : TDBGrid;Cabeceras,Tamanos,Alineados:String;
                                Negrita:Boolean;CentradoCab:Integer);
var i,Columnas :Integer;
    Cabecera,Tamano,Alineado : String;
//Centrado --->  = 0 Centrado; = 1 Izquierda; 2=Derecha;
//Necesito que esté separado por ;, las cabecera y los Tamaños
begin
  i:=0;  Columnas:=Grid.Columns.Count;
  Cabecera := Funciones.Descomponer(CabeceraS,';');
  Tamano   := Trim(Funciones.Descomponer(TamanoS,';'));
  Alineado := Trim(Funciones.Descomponer(AlineadoS,';'));
  if Alineado = '' then Alineado:='C';
  Alineado := UpperCase(Alineado);
  while (length(cabecera) > 1) and (i<Columnas) do begin
     Grid.Columns[i].Title.Caption:=Cabecera;
     if Negrita
       then Grid.Columns[i].Title.Font.Style:=[fsBold]
       else Grid.Columns[i].Title.Font.Style:=[];
     Case CentradoCab of
       0 : Grid.Columns[i].Title.Alignment := taCenter;
       1 : Grid.Columns[i].Title.Alignment := taLeftJustify;
       2 : Grid.Columns[i].Title.Alignment := taRightJustify;
     end;
     Case Alineado[1] of
       'C' : Grid.Columns[i].Alignment := taCenter;
       'I' : Grid.Columns[i].Alignment := taLeftJustify;
       'D' : Grid.Columns[i].Alignment := taRightJustify;
     end;

     Grid.Columns[i].Width :=StrToInt(trim(Tamano));
     Cabecera := Funciones.Descomponer(CabeceraS,';');
     Tamano   := Funciones.Descomponer(TamanoS,';');
     i:=i+1;
  end;
end;
//------------------------------------------------------------------------------
procedure GrilBonitoAdv(Grid : TDBAdvGrid;Cabeceras,Tamanos,Alineados,TipoPies,Ediciones:String;
                                Negrita:Boolean;CentradoCab:Integer);
var i,Columnas :Integer;
    Cabecera,Tamano,Alineado,TipoPie,Edicion : String;
//Centrado --->  = 0 Centrado; = 1 Izquierda; 2=Derecha;
//Necesito que esté separado por ;, las cabecera y los Tamaños
//TipoPies (T) totaliza, (M) Media, (I) Minimo, (A) máximo, (C) cuenta....
// Edicion poner masacara: ej :%10.2n -> 100.000,02
begin
  i:=1;  Columnas:=Grid.Columns.Count;
  Cabecera := Descomponer(CabeceraS,';');
  Tamano   := Trim(Descomponer(TamanoS,';'));
  Alineado := Uppercase(Trim(Descomponer(AlineadoS,';')));
  if Alineado = '' then Alineado:='C';
  TipoPie   := Uppercase(Trim(Descomponer(TipoPies,';')));
  if TipoPie='' then TipoPie:=' ';
  Edicion := Trim(Descomponer(Ediciones,';'));

  Alineado := UpperCase(Alineado);
  while (length(cabecera) > 1) and (i<Columnas) do begin
     Grid.Columns[i].Header:=Cabecera;
     if Negrita
       then Grid.Columns[i].HeaderFont.Style:=[fsBold]
       else Grid.Columns[i].HeaderFont.Style:=[];
     Case CentradoCab of
       0 : Grid.Columns[i].HeaderAlignment := taCenter;
       1 : Grid.Columns[i].HeaderAlignment := taLeftJustify;
       2 : Grid.Columns[i].HeaderAlignment := taRightJustify;
     end;
     Case Alineado[1] of
       'C' : Grid.Columns[i].Alignment := taCenter;
       'I' : Grid.Columns[i].Alignment := taLeftJustify;
       'D' : Grid.Columns[i].Alignment := taRightJustify;
     end;

     Case TipoPie[1] of
       'T' :Grid.FloatingFooter.ColumnCalc[i] := acSUM;
       'M' :Grid.FloatingFooter.ColumnCalc[i] := acAVG;
       'C' :Grid.FloatingFooter.ColumnCalc[i] := acCOUNT;
       'I' :Grid.FloatingFooter.ColumnCalc[i] := acMIN;
       'A' :Grid.FloatingFooter.ColumnCalc[i] := acMAX;
       'S' :Grid.FloatingFooter.ColumnCalc[i] := acSPREAD;
       'U' :Grid.FloatingFooter.ColumnCalc[i] := acCUSTOM;
     else Grid.FloatingFooter.ColumnCalc[i] := acNone;
     end;
     Grid.Columns[i].EditMask:=Edicion;
     Grid.Columns[i].Width :=StrToInt(trim(Tamano));
     Cabecera := Funciones.Descomponer(CabeceraS,';');
     Tamano   := Funciones.Descomponer(TamanoS,';');
     Alineado := Uppercase(Trim(Descomponer(AlineadoS,';')));
     if Alineado = '' then Alineado:='C';
     TipoPie   := Uppercase(Trim(Descomponer(TipoPies,';')));
     if TipoPie='' then TipoPie:=' ';
     Edicion := Trim(Descomponer(Ediciones,';'));

     i:=i+1;
  end;
end;
//------------------------------------------------------------------------------
procedure GridBonitoAdv(Grid : TDBAdvGrid;Parametros:String);
var i,Columnas :Integer;
    Cabecera,Tamano,Alineado,TipoPie,Edicion,Negrita,CentradoCab : String;
//    ['Cabecera,Tamaño,Alineado,Tipo de pie,Edición,Alineado','.. ..']
//Centrado --->  = 0 Centrado; = 1 Izquierda; 2=Derecha;
//Necesito que esté separado por ;, las cabecera y los Tamaños
//TipoPies (T) totaliza, (M) Media, (I) Minimo, (A) máximo, (C) cuenta....
// Edicion poner masacara: ej :%10.2n -> 100.000,02
begin
For I:=1 to CuentaCar(Parametros,';') do
begin
  Columnas    := Grid.Columns.Count;
  Cabecera    := Traduce(Descomponer(Parametros,','));
  Tamano      := Trim(Descomponer(Parametros,','));
  CentradoCab := Uppercase(Trim(Descomponer(Parametros,',')));
  Alineado    := Uppercase(Trim(Descomponer(Parametros,',')));
  TipoPie     := Uppercase(Trim(Descomponer(Parametros,',')));
  Negrita     := Uppercase(Trim(Descomponer(Parametros,',')));
  Edicion     := Trim(Descomponer(Parametros,';'));

  if Alineado = '' then Alineado:='C';
  if TipoPie='' then TipoPie:=' ';
  Alineado := UpperCase(Alineado);

     Grid.Columns[i].Header:=Cabecera;
     Grid.Columns[i].Width:=StrToInt(Tamano);
     if UpperCase(Negrita)='N'
       then Grid.Columns[i].HeaderFont.Style:=[fsBold]
       else Grid.Columns[i].HeaderFont.Style:=[];

     Case CentradoCab[1] of
       '0' : Grid.Columns[i].HeaderAlignment := taCenter;
       '1' : Grid.Columns[i].HeaderAlignment := taLeftJustify;
       '2' : Grid.Columns[i].HeaderAlignment := taRightJustify;
     end;

     Case Alineado[1] of
       'C' : Grid.Columns[i].Alignment := taCenter;
       'I' : Grid.Columns[i].Alignment := taLeftJustify;
       'D' : Grid.Columns[i].Alignment := taRightJustify;
     end;

     Case TipoPie[1] of
       'T' :Grid.FloatingFooter.ColumnCalc[i] := acSUM;
       'M' :Grid.FloatingFooter.ColumnCalc[i] := acAVG;
       'C' :Grid.FloatingFooter.ColumnCalc[i] := acCOUNT;
       'I' :Grid.FloatingFooter.ColumnCalc[i] := acMIN;
       'A' :Grid.FloatingFooter.ColumnCalc[i] := acMAX;
       'S' :Grid.FloatingFooter.ColumnCalc[i] := acSPREAD;
       'U' :Grid.FloatingFooter.ColumnCalc[i] := acCUSTOM;
     else Grid.FloatingFooter.ColumnCalc[i] := acNone;
     end;
     Grid.Columns[i].EditMask:=Edicion;
     Grid.Columns[i].Width :=StrToInt(trim(Tamano));
  end;
end;

//------------------------------------------------------------------------------
Function ExisteCampo(Campo:String;Tabla:TDataSet):Boolean;
//Comprueba si existe el campo en la Base de
var
   Existe:Boolean;
   i:Integer;
   CamposOrigen : TStringList;//TStrings;
begin
  CamposOrigen   := TStringList.Create;  // Creo La lista que contiene los Campos
  Tabla.GetFieldNames(CamposOrigen);
  campo:=Uppercase(Campo);
  if Tabla.active=False then Tabla.active:=True;
  Existe:=False;
  for i:=0 to Tabla.FieldCount-1 do
     if Uppercase(Tabla.FieldList[i].FullName)=campo then Existe:=true;
  Result:=Existe;
  Tabla.active:=False;
end;
//------------------------------------------------------------------------------
Function ExisteCampoAdo(Campo:String;Tabla:TCustomADODataSet):Boolean;
//Comprueba si existe el campo en la Base de
var
   Existe:Boolean;
   i:Integer;
   CamposOrigen : TStringList;//TStrings;
begin
  CamposOrigen   := TStringList.Create;  // Creo La lista que contiene los Campos
  Tabla.GetFieldNames(CamposOrigen);
  campo:=Uppercase(Campo);
  if Tabla.active=False then Tabla.active:=True;
  Existe:=False;
  for i:=0 to Tabla.FieldCount-1 do
     if Uppercase(Tabla.FieldList[i].FullName)=campo then Existe:=true;
  Result:=Existe;
  Tabla.active:=False;
end;
//------------------------------------------------------------------------------
Function ConstruyeInsertInto(Tabla:String;Campos,Valores,Tipos : array of string):String;
var StrSQL,StrCampos,StrValores,aux : String;
    i,B :Integer;
    TipoDato:Char;
    C,V,T : Integer;
// [C]adena    [N]úmero   [F]echa [H]ora [B]oolean [E]xpresión como now() [I]D Autogenerada      
begin
  Result:='';     StrCampos:='';      StrValores:='';
  C :=Length(Campos);
  V :=Length(Valores);
  T :=Length(Tipos);
  if (C <> V) or (V=0) or (C<>T)
    then begin
           StrValores:='Párametros incorrectos'+#13+
                       'Campos  : '+InttoStr(C)+#13+
                       'Valores : '+InttoStr(V)+#13+
                       'Tipos   : '+InttoStr(T);
           MessageDlg(StrValores, mtError, [mbOk], 0);
           exit;
         end;

  B:= High(Campos);
  for i := low(Campos) to B do
     begin
     if trim(Campos[i])<>''
       then begin
              StrCampos:=StrCampos+Campos[i];
              if i<B
                 then StrCampos:=StrCampos+',';
              TipoDato:=Upcase(funciones.primero(Tipos[i],' ')[1]);
              case tipodato of
                'C': StrValores:=StrValores+QuotedStr(Valores[i]);
                'N': begin
                       Aux:=Funciones.CambiarChar( Valores[i],',','.');
                       if Aux='' then aux:='0'; //wpor si pasamos nulos
                       StrValores:=StrValores+Aux
                     end;
                'F': if EsSQLserver
                       then StrValores:=StrValores+entrecomilla(Valores[i])
                       else StrValores:=StrValores+'#'+Valores[i]+'#';  //si es SQLServer Serie QuotedStr
                'H': StrValores:=StrValores+''''+Valores[i]+'''';  //Si es HORA
                'B','E': StrValores:=StrValores+Valores[i];//boolean
                'I':StrValores:=StrValores+QuotedStr(GeneraID(36,11));
                else StrValores:=StrValores+Valores[i];
              end;
//              Aux:= Funciones.CambiarChar( Valores[i],',','.');
  //            StrValores:=StrValores+Aux;
             if i<B
               then StrValores:=StrValores+',';
        end;
     end;

  StrCampos:='('+StrCampos+') ';
  StrValores:=''+StrValores+' ';
  StrSQL:='INSERT INTO '+Tabla+' '+StrCampos+' '+
          'SELECT '+StrValores+' ;';
  Result:=StrSQL;
end;
//------------------------------------------------------------------------------
function GeneraId(Base:integer;DigitosMaximo:Byte):String;
var Valor:String;
begin
 sleep(1);
 Valor:=formatdatetime('yyyymmddhhnnsszzz',Now())+rellenaIZQ( IntToStr(Random(99)),'0',2);
 Result:=Valor;
 if Base = 10 then exit;
 Result:=Inttobase(Strtoint64(valor),base,DigitosMaximo);
end;
//------------------------------------------------------------------------------
function NoNulo(Cadena,Defecto:String):String;
begin
 if Cadena=''
   then Result:=Defecto
   else Result:=Cadena;
end;
//------------------------------------------------------------------------------
function IntToBase(Valor: int64; Base: byte; Digitos: byte): string;
   begin
     result := '';
     repeat
       result := B36[Valor MOD BASE]+result;
       Valor := Valor DIV Base;
     until (Valor DIV Base = 0);
     result := B36[Valor MOD BASE]+result;
     while length(Result) < Digitos do Result := '0' + Result;
   end;
//------------------------------------------------------------------------------
function BaseToint(Valor: String; Base: byte): int64;
   var
     i: byte;
   begin
     result := 0;
     for i := 1 to length(Valor) do begin
       if (pos(Valor[i], B36)-1) < Base then
         result := result * Base + (pos(Valor[i], B36)-1)
       else begin
         result := 0;
         break;
       end;
     end;
   end;
//------------------------------------------------------------------------------
Function CambiarStringConexion(ADOConnection:TADOConnection;Programa,ConexionStr:String):Boolean;
var Reg : TRegIniFile;
begin
  Result:=False;
  if ADOConnection.Connected
    then ADOConnection.Connected:=False;
  EditConnectionString(ADOConnection);
  if ADOConnection.ConnectionString > ''
    then begin
           ADOConnection.Connected:=True;
           Reg        :=TRegIniFile.Create(Programa);
           Reg.writeString(ConexionStr,'ConexionADO',ADOConnection.ConnectionString);
           Reg.Free;
           Result:=true;
         end;
end;
//------------------------------------------------------------------------------
procedure Conectar(ADOConnection:TADOConnection;Programa,ConexionStr:String);
var Reg : TRegIniFile;
    Conexion:String;
begin
  if ADOConnection.Connected
    then ADOConnection.Connected:=False;
  Reg        :=TRegIniFile.Create(Programa);
  Conexion   :=trim(Reg.ReadString(ConexionStr,'ConexionADO',''));
  if Conexion =''
    then CambiarStringConexion(ADOConnection,Programa,ConexionStr)
    else begin
           ADOConnection.ConnectionString:=Conexion;
           try
             ADOConnection.Connected:=true;
           except
             MessageDlg('Error en la conexión, Pulse Ok para Configurar', mtWarning,
                 [mbOk], 0);

             CambiarStringConexion (ADOConnection,Programa,ConexionStr)
           end;
         end;
end;
//------------------------------------------------------------------------------
Function Descifrar(clave:string):string;
var long,i,j,LongVector:integer;
    vector,clave2:string;
begin
   clave2:='';         long:=Length(clave);
   vector:='cofrawin'; longvector:=8;

   i:=1;               j:=1;
   While i<=long do
   begin
      if j=longvector then j:=1;
      clave2:=clave2+vector[j]+clave[i]+IntToStr(long-i); //pondré un nº aleatorio,
      j:=j+1;                                             //pero no recuerdo el procedimiento
      i:=i+1;
   end;
   clave:=clave2;
   Result:=Clave;
end;

//------------------------------------------------------------------------------
procedure BuscarEnCombo(ComboBox:TComboBox;Codigo:String);
var Contador,i:integer;
    User:string;
begin
   i:=0;
   Contador := ComboBox.Items.Count;
   While i <= Contador do
     begin
       ComboBox.ItemIndex:=i;
       User := ComboBox.Items.Strings[i];
       User := Funciones.DimeCadena(User,1);// NumerosSolo(User);
       if User = Codigo
         then begin ComboBox.ItemIndex:=i; Exit; end;
       i:=i+1;
     end;
end;
//------------------------------------------------------------------------------
function DameCampos(Campos:array of string):string;

    var Sentencia : string;
        i : integer;
        Primero : boolean;
    begin
      Sentencia := '';
      Primero := true;
      for i:= Low(Campos) to High(Campos) do
        begin
          if Primero
            then  Sentencia := Sentencia + Campos[i]
            else  Sentencia := Sentencia + ','+Campos[i];
          Primero := false;
        end;
      result := Sentencia;
    end;
//------------------------------------------------------------------------------
function DameValores(Campos,Valores:array of String):String;
var Sentencia : string;
        i : integer;
        Primero : boolean;
    begin
      Sentencia := '';
      Primero := true;
      for i:= Low(Campos) to High(Campos) do
        begin
        if Primero
          then Sentencia := Sentencia + '('+Campos[i]+'='+Valores[i]+') '
          else Sentencia := Sentencia + ' AND ('+Campos[i]+'='+Valores[i]+') ';
        Primero := false;
        end;
      result :=sentencia;
    end;
//------------------------------------------------------------------------------
function ExisteRegistro(NombreTabla:string;Campos:array of string;
                        Valores:array of string;TablaAux:TDataSet;OtrosCampos:array of string): boolean;
var StrSQL,CadenaCampos,OtrosCampos2 : string;
begin
  result := false;
  CadenaCampos := DameCampos(Campos);
  OtrosCampos2 := DameCampos(OtrosCampos);
  if OtrosCampos2<>'' then OtrosCampos2:=','+OtrosCampos2;

  StrSQL := 'SELECT ' + CadenaCampos + OtrosCampos2;
  StrSQL := StrSQL +' FROM '+NombreTabla;
  StrSQL := StrSQL +' WHERE '+DameValores(Campos,Valores);
//  if TablaAux is TQuery
//    then AbrirTabla (TablaAux, StrSQL)
//    else
    AbrirAdo( TADOQuery(TablaAux), StrSQL);
  if TablaAux.RecordCount >0
    then  result := true;
end;
//------------------------------------------------------------------------------
function AbreTablaCon(NombreTabla:string;Campos:array of string;
                        Valores:array of string;TablaAux:TDataSet): String;
//Pasamos la tabla y los campos para el where y el debe componer la select y abrir la tabla
var StrSQL,CadenaCampos : string;
begin
  result := '';
  CadenaCampos := DameCampos(Campos);
  StrSQL := 'SELECT '+CadenaCampos;
  StrSQL := StrSQL +' FROM '+NombreTabla;
  StrSQL := StrSQL +' WHERE '+DameValores(Campos,Valores);
//  if (TablaAux<>NIL)
//   then if (TablaAux is TQuery)
//              then AbrirTabla (TablaAux, StrSQL)
//              else
  AbrirAdo( TADOQuery(TablaAux), StrSQL);
  Result := StrSQL;
end;
//------------------------------------------------------------------------------
function RedondeaMoneda(const X: Double): Double;
begin Result := Funciones.Redondea(x,2); end;
//------------------------------------------------------------------------------
Procedure ActivaDesTabla(Tabla:TDataSet);
begin
  if Tabla.Active
    then Tabla.Active:=False;
  Tabla.Active:=True;
end;
//------------------------------------------------------------------------------
function DimeLimite(Edit : TEdit;const Defecto:String):String;
begin
  if trim(Edit.Text)=''
    then Result:=Defecto
    else Result:=trim(Edit.Text);
end;
//------------------------------------------------------------------------------
procedure TNada.PulsaClick(Sender: TObject);
  var
    i:Integer;
    GridAux:TDBAdvGrid;
  Pantalla: HWND;
  Buffer: array[0..60] of char;
  sAnfitrion:string;
  FormAnfitrion:TForm;
  begin
    TMenuItem(Sender).Checked:=not(TMenuItem(Sender).Checked);
// Obtencion del Anfitrion
    Pantalla := GetActiveWindow;
    GetClassName(Pantalla, Buffer, 60);
    sAnfitrion := Trim(string(Buffer));
    sAnfitrion := copy(sAnfitrion, 2, length(sAnfitrion) - 1);
    FormAnfitrion:=Application.FindComponent(sAnfitrion) as TForm;
//
    GridAux:=TDBAdvGrid(FormAnfitrion.FindComponent(StringReplace(TPopupMenu(TMenuItem(Sender).GetParentMenu).Name,'_menu','',[])));
    for I:=0 to TPopupMenu(TMenuItem(Sender).GetParentMenu).Items.Count-1 do
    if TPopupMenu(TMenuItem(Sender).GetParentMenu).Items.Items[I].Checked
    then GridAux.FloatingFooter.ColumnCalc[TPopupMenu(TMenuItem(Sender).GetParentMenu).Items.Items[I].tag] := acSUM
    else GridAux.FloatingFooter.ColumnCalc[TPopupMenu(TMenuItem(Sender).GetParentMenu).Items.Items[I].tag] := acNONE;
  end;
//------------------------------------------------------------------------------
procedure MenuSumaGrid(var DBGridADV: TDBAdvGrid);
var
  Menu: TPopupMenu;
  Opcion: array of TMenuItem;
  I, j: Integer;
  sAnfitrion:string;
  FormAnfitrion:TForm;
begin
  j := -1;
  DBGridADV.Enabled := False;
  DBGridADV.FloatingFooter.Visible:=True;
  sAnfitrion:=TComponent(DBGridADV.Owner).Name;
  FormAnfitrion:=Application.FindComponent(sAnfitrion) as TForm;
  Menu := TPopupMenu(FormAnfitrion.FindComponent(DBGridADV.Name+'_menu'));
  if Menu<>nil then Menu.Destroy;
  //
  Menu := TPopupMenu.Create(FormAnfitrion);
  with Menu do
  begin

    Name := DBGridADV.Name+'_menu';
    for i := 0 to DBGridADV.ColCount - 1 do
    begin

      if Trim(DBGridADV.Columns.Items[i].FieldName)<>'' then
      if (DBGridADV.Columns.Items[i].Field.DataType = ftInteger)
      or (DBGridADV.Columns.Items[i].Field.DataType = ftCurrency)
      or (DBGridADV.Columns.Items[i].Field.DataType = ftSmallint)
      or (DBGridADV.Columns.Items[i].Field.DataType = ftLargeint)
      or (DBGridADV.Columns.Items[i].Field.DataType = ftFloat) then
      begin
        inc(j);
        setlength(Opcion, length(Opcion) + 1);
        Opcion[j] := TMenuItem.Create(Menu);
          if Trim(DBGridADV.Columns.Items[i].Header)=''
          then Opcion[j].Caption := DBGridADV.Columns.Items[i].FieldName
          else Opcion[j].Caption := DBGridADV.Columns.Items[i].Header;
        Opcion[j].Name := QuitarChars(Opcion[j].Caption,['º','ª','.','/','-','%','á','é','í','ó','ú',' ']);
        Opcion[j].OnClick:=Nada.PulsaClick;
        Opcion[j].Tag:=i;
        Menu.Items.Add(Opcion[j]);
      end;
    end;
  end;
  DBGridADV.PopupMenu := TPopUpMenu(FormAnfitrion.FindComponent(DBGridADV.Name+'_menu'));
  DBGridADV.Enabled := True;
end;
//------------------------------------------------------------------------------
Function BuscarReg(Tabla:TDataSet;CampoCodigo,CampoDescrip,Valor:String):Boolean;
begin
    case Valor[1] of
    '0'..'9' : Result:=Tabla.Locate(CampoCodigo,Valor,[loPartialKey]);
    else       Result:=Tabla.Locate(CampoDescrip,Valor,[loPartialKey]);
    end;//del case
end;
//------------------------------------------------------------------------------
procedure PaginaenBlanco;
var Impresora:TextFile;
begin
  with printer do
    begin
      assignPrn(Impresora);
      Rewrite(Impresora);
      closeFile(Impresora);
  end;//with
end;
//------------------------------------------------------------------------------
Procedure Habla(Texto:String);
var Bill: OLEVariant;
begin
  Bill := CreateOLEObject('SAPI.SpVoice');
  Bill.Speak(Texto, 0);
end;
//------------------------------------------------------------------------------
Procedure AbreCajon(const Lpt,Comando:String);
var Impresora: TextFile;
begin
  assignPrn(Impresora);
  rewrite(Impresora);
  Writeln(Impresora, Comando);
  closeFile(Impresora)
end;
//------------------------------------------------------------------------------
Function NumeroRegistros(CampoCodigo,Tabla:String;TablaAux:TADOQuery):Integer;
var  StrSql:String;
begin
  Result:=0;
  StrSql:='SELECT Count('+CampoCodigo+') AS Hay '+
          'FROM '+Tabla;
  try
    AbrirAdo(TablaAux,StrSql);
    Result:=TablaAux.fieldByName('Hay').asInteger;
  finally
  end;
end;
//------------------------------------------------------------------------------
function SepararSELECTSQL(QUERY : TADOQuery; var _SELECT, _FROM, _WHERE,
                                 _GROUP_BY, _HAVING, _ORDER_BY :string):Boolean;
var
  _s,_f,_w,_g,_h,_o, n : smallint;
  cad : string;
begin
  cad       := '';
  _SELECT   := '';
  _FROM     := '';
  _WHERE    := '';
  _GROUP_BY := '';
  _HAVING   := '';
  _ORDER_BY := '';

  for  n := 0 to QUERY.SQL.Count -1 do
    cad := cad + QUERY.SQL[n] + ' ';

  _s := pos('SELECT',UpperCase(cad));
  _f := pos('FROM',UpperCase(cad));
  _w := pos('WHERE',UpperCase(cad));
  _g := pos('GROUP BY',UpperCase(cad));
  _h := pos('HAVING',UpperCase(cad));
  _o := pos('ORDER BY',UpperCase(cad));

  cad := QuitarChar(cad,';');

  if ((_s = 0) or (_f = 0) or (_s > _f))                    // si no existe SELECT o FROM nos vamos
  then begin
    ShowMessage('Error en SepararSELECTSQL:' + chr(13) + cad);
    Result := False;
    Exit;
  end;
  if (_w <> 0) and (_h <> 0) and (_h < _w)                // si el orden no es correcto nos vamos
  then begin
    ShowMessage('Error en SepararSELECTSQL:' + chr(13) + cad);
    Result := False;
    Exit;
  end;
  if (_w <> 0) and (_o <> 0) and (_o < _w)                // si el orden no es correcto nos vamos
  then begin
    ShowMessage('Error en SepararSELECTSQL:' + chr(13) + cad);
    Result := False;
    Exit;
  end;

  n := 0;

  // Asignamos SELECT
  _SELECT := copy(cad,1, _f - 1);

  // Asignamos FROM
  if (n = 0) and (_w <> 0) then n := _w;
  if (n = 0) and (_g <> 0) then n := _g;
  if (n = 0) and (_h <> 0) then n := _h;
  if (n = 0) and (_o <> 0) then n := _o;
  if (n = 0) then n := length(cad) + 1;
  n := n - _f;
  _FROM   := copy(cad, _f, n);
  n := 0;

  // Asignamos WHERE
  if _w <> 0
  then begin
    if (n = 0) and (_g <> 0) then n := _g;
    if (n = 0) and (_h <> 0) then n := _h;
    if (n = 0) and (_o <> 0) then n := _o;
    if (n = 0) then n := length(cad) + 1;
    n := n - _w;
    _WHERE := copy(cad, _w, n);
    n := 0;
  end;

  // Asignamos GROUP BY
  if _g <> 0
  then begin
    if (n = 0) and (_h <> 0) then n := _h;
    if (n = 0) and (_o <> 0) then n := _o;
    if (n = 0) then n := length(cad) + 1;
    n := n - _g;
    _GROUP_BY := copy(cad, _g, n);
    n := 0;
  end;

  // Asignamos HAVING
  if _h <> 0
  then begin
    if (n = 0) and (_o <> 0) then n := _o;
    if (n = 0) then n := length(cad) + 1;
    n := n - _h;
    _HAVING := copy(cad, _h, n);
    n := 0;
  end;

  // Asignamos ORDER BY
  if _o <> 0
  then begin
    n := length(cad) - _o + 1;
    _ORDER_BY := copy(cad,_o,n);
  end;
 Result := True;
end;
//------------------------------------------------------------------------------
function MostrarNoModal(AClass: TFormClass; Var Reference; mostrar, crear: boolean; Var EsNueva :boolean):integer;
var
I: Integer;
begin
{ Esta función Crea y/o Muestra una ventana NoModal, le pasamos la Clase y una variable para que nos devuelva si es nueva,
  Result no va a devolver la posicion que ocupa en el array Screen.Forms[I]
  AClass    :  La clase de ventana que queremos crear
  Reference :  El puntero de la ventana
  mostrar   :  Si queremos mostrarla
  crear     :  Si queremos crearla
  EsNueva   :  Nos devuelve si la acabamos de crear
  Result    :  Nos devuelve el indice para usarlo con Screen.Forms[I]

*** Ejemplos de uso 1 (si no existe la creamos y ademas la mostramos, pero no queremos hacer nada mas)
  Funciones.MostrarNoModal(TFormUsuarios,True,EsNuevoForm);

*** Ejemplos de uso 2 (si no existe la creamos pero no la mostramos porque queremos modificar propiedades antes de mostrarla la primera vez)

  i := Funciones.MostrarNoModal(TFormCajasEs,false,EsNueva);
  if EsNueva
  then begin
    (Screen.Forms[I] as TFormCajasEs).Caption := 'eeeehhhhh!!!!';
    (Screen.Forms[I] as TFormCajasEs).Show;
  end;
}
  result := 0;
  for I := Screen.FormCount - 1 downto 0 do
  if Screen.Forms[I] is AClass then
  begin
    if mostrar
       then Screen.Forms[I].Show;
    EsNueva := False;
    result := I;
    Exit;
  end;

  if crear
  then begin
    Application.CreateForm(AClass, Reference);
    EsNueva := True;

    for I := Screen.FormCount - 1 downto 0 do
       if Screen.Forms[I] is AClass
       then result := I;
    if mostrar
       then Screen.Forms[result].Show;
  end;
end;
//------------------------------------------------------------------------------
Function ResolucionPantalla(var Ancho,Alto: integer):string;
begin
  Ancho := GetSystemMetrics(SM_CXSCREEN);
  Alto := GetSystemMetrics(SM_CYSCREEN);
  Result := inttostr(Ancho) + 'X' + inttostr(Alto);
end;
//------------------------------------------------------------------------------
function damecodigo(cadena:string):string;
var i:integer;
begin
  result := '';
  for i := 1 to length(cadena) do
  begin
    if not (cadena[i] in ['0'..'9']) then exit;
    result := result + cadena[i];
  end;
end;
//------------------------------------------------------------------------------
function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;
//------------------------------------------------------------------------------
function EstamosEnGrupoCie: Boolean;
var Maquina :string;
begin
  Maquina := Lowercase(DameNombrePC);
  Result := (Maquina = 'portatilsantos') or
            (Maquina = 'paco-corcoles') or
            (Maquina = 'equipocorcoles') or            
            (Maquina = 'portatilramiro');
end;
//------------------------------------------------------------------------------
//encriptar datos    Ejemplo txtTextoEncriptado.Text := encriptar(txtTextoEncriptar.Text, 10);
function encriptar(aStr: String; aKey: Integer): String;
begin
   Result:='';
   RandSeed:=aKey;
   for aKey:=1 to Length(aStr) do
       Result:=Result+Chr(Byte(aStr[aKey]) xor random(256));
end;
//------------------------------------------------------------------------------
//desencriptar datos    ejemplo txtTextoDesencriptado.Text := encriptar(txtTextoEncriptado.Text, 10);
function desencriptar(aStr: String; aKey: Integer): String;
begin
   Result:='';
   RandSeed:=aKey;
   for aKey:=1 to Length(aStr) do
       Result:=Result+Chr(Byte(aStr[aKey]) xor random(256));
end;
//------------------------------------------------------------------------------
function DeInaBetween(Cadena : String):String;
var i,k:Integer;
begin
  Result:=Cadena;
  Cadena:=UpperCase(Cadena);
  i:=Pos(' IN ',cadena);
  k:=Pos('..',cadena);
  if (i=0) or (k=0)then exit;
  Cadena := Funciones.CambiarSubCadena(Cadena,' IN (',' Between ');
  Cadena := Funciones.CambiarSubCadena(Cadena,' IN(',' Between ');
  Cadena := Funciones.CambiarSubCadena(Cadena,'..',' and ');
  while Cadena[k]<>')' do
    inc(k);
 Cadena[k]:=' ';
 Result:=Cadena;
end;
//------------------------------------------------------------------------------
Procedure CentrarObjeto(que:TForm);
begin
  Que.Left:= trunc((Screen.Width/2) -(que.Width/2));
  Que.Top := trunc((Screen.Height/2)-(que.Height/2));
end;
//------------------------------------------------------------------------------
Procedure CentrarAdvPanel(formulario:TForm; advpanl:TAdvPanel);
begin
   advpanl.left := trunc((formulario.Width/2) - (advpanl.width/2));
   advpanl.top :=  trunc((formulario.Height/2) - (advpanl.height/2));
end;
//------------------------------------------------------------------------------
Procedure CentrarPanel(formulario:TForm; panl:TPanel);
begin
   panl.left := trunc((formulario.Width/2) - (panl.width/2));
   panl.top :=  trunc((formulario.Height/2) - (panl.height/2));
end;
//------------------------------------------------------------------------------
Procedure AmpliaCombo(Combo:TComboBox;NuevoTamano:Integer;TamanoDoble:Boolean);
//TamanoDoble manda sobre nuevo tamano
// si NuevoTamano= 0  y TamanoDoble=False, recupera el tamaño original
begin
  if (Combo.Tag>0) and (NuevoTamano=0) and (TamanoDoble=False)
    then begin
           Combo.Width:=Combo.Tag;
           Combo.Tag  := 0;
           exit;
         end;
  Combo.Tag :=Combo.Width;
  if (TamanoDoble)
    then begin
           Combo.Width:=Combo.Width*2;
           exit;
         end;
  Combo.Width:=NuevoTamano;
end;
//------------------------------------------------------------------------------
function TamanoFichero(NombreFichero:String):LongInt;
var   f: file of Byte;
begin
  Result:=0;
   if FileExists(NombreFichero) then
      begin
        AssignFile(f, NombreFichero);
        reset(f);
        Result := Filesize(f);
        closefile(f);
      end;
end;
//------------------------------------------------------------------------------
function Reduce(NombreFichero: string; NombreDestino: string;
                TamanyoMax: Longint; MuestraResultado: boolean; Confirma: boolean): Integer;
// result =0 no ha hecho nada, 1 todo bien   2 con errores
var
  bmp: TBitmap;
  jpg: TJpegImage;
  scale: Double;
  Tamanyo:LongInt;
begin
   Result:=0;
   Tamanyo:= TamanoFichero(NombreFichero);
   if Tamanyo=0        then exit;
   if NombreDestino='' then NombreDestino:=NombreFichero;

   if (Tamanyo > TamanyoMax)
     then begin
           if (Confirma) and
              (MessageDlg('EL TAMAÑO ES DE '+inttostr(tamanyo)+', ¿DESEA REDUCIR?',
                        mtConfirmation, [mbYes, mbNo], 0) <> mrYes)
              then Exit;

   jpg := TJpegImage.Create;
   Result:=2;
   try // Cargar la imagen
     jpg.Loadfromfile(NombreFichero);
     if jpg.Height > jpg.Width
       then scale := 2200 / jpg.Height
       else scale := 2200 / jpg.Width;
     bmp := TBitmap.Create;
     try //Crear el thumbnail
       bmp.Width := Round(jpg.Width * scale);
       bmp.Height := Round(jpg.Height * scale);
       bmp.Canvas.StretchDraw(bmp.Canvas.Cliprect, jpg);
       // Convertirlo y guardarlo en disco.
       jpg.Assign(bmp);
       jpg.SaveToFile(NombreDestino);
       if MuestraResultado
         then showmessage('La imagen '+Nombrefichero+' ha sido reducida y nombrada como '+NombreDestino);
       finally
           bmp.free;
           Result:=1;
       end;

    finally
      Result:=1;
      jpg.free;
   end;
  end;
end;
//------------------------------------------------------------------------------
function ListaParametrosLee(const Grupo,Parametro,Defecto : String;Tabla:TAdoQuery):String;
var StrSQL:String;
begin
  Result:=Defecto;
  StrSQL:='Select * from ListaParametros '+
          'Where (Grupo = "'+Grupo+'") and '+
                '(Clave = "'+Parametro+'")';
  AbrirAdo(Tabla,StrSQL);
  if Tabla.RecordCount=1
    then Result := Tabla.fieldbyname('Valor').asString;
end;
//------------------------------------------------------------------------------
Procedure ListaParametrosEscribe(const Grupo,Parametro,Valor : String;Tabla:TAdoQuery);
var StrSQL:String;
begin
  if Funciones.ExisteRegistro( 'ListaParametros',['Grupo','Clave'],['"'+Grupo+'"','"'+Parametro+'"'],tabla,[])
    then StrSQL:='UPDATE ListaParametros SET Valor = "'+Valor+'" '+
                 'Where (Grupo = "'+Grupo+'") and '+
                       '(Clave = "'+Parametro+'")'
    else StrSQL:=Funciones.ConstruyeInsertInto('ListaParametros',
                     ['Grupo','Clave','Valor'],
                     [grupo,parametro,Valor],
                     ['C','C','C']);
  Funciones.EjecutaSQLAdo(StrSQL,Tabla)
end;
//------------------------------------------------------------------------------
{por ejemplo, cuando guardamos un stringconnection, peta, por el tema de comillas...
  lo hacemos a la antigua usanza }
Procedure ListaParametrosEscribeNONormal(const Grupo,Parametro,Valor : String;Tabla:TAdoQuery);
var StrSQL:String;
begin
  StrSQL:='SELECT * from ListaParametros  '+
          'Where (Grupo = "'+Grupo+'") and '+
          '(Clave = "'+Parametro+'")';
  Funciones.AbrirAdo(Tabla,StrSQL);
  if Tabla.RecordCount=0
    then begin
           Tabla.Insert;
           Tabla.FieldByName('Grupo').asString:=Grupo;
           Tabla.FieldByName('Clave').asString:=Parametro;
         end
    else Tabla.Edit;
  Tabla.FieldByName('Valor').asString:=Valor;
  Tabla.Post;
end;
//------------------------------------------------------------------------------
function QuitaPrimerasLetras(cadena: string; cantidad: Integer): string;
begin
  result:= UltimasLetras(Cadena,length(cadena)-Cantidad);
end;
//------------------------------------------------------------------------------
function TraduceBoolean(variable : Boolean):String;
begin
  if variable
    then Result:='1'
    else Result:='0';
end;
//------------------------------------------------------------------------------
Procedure TablaAuxLimpia(TablaAux:TADOQuery;CondicionExtra,Usuario:String);
var STRSQL:String;
begin
  STRSQL:='DELETE  * FROM TablaAux '+
          'WHERE (Maquina="'+DameNombrePC+'") AND '+
                '(Usuario="'+Usuario+'") '+
                CondicionExtra;
  EjecutaSQLAdo(STRSQL,TablaAux);
end;
//------------------------------------------------------------------------------
Procedure TablaAuxAbre(Tabla:TADOQuery;SentenciaEspecial,CondicionExtra,Usuario:String);
var STRSQL:String;
begin
  SentenciaEspecial:=Funciones.QuitaCaracter(SentenciaEspecial,';');
  if SentenciaEspecial<>''
    then begin
           if Pos('WHERE ',SentenciaEspecial)>0
              then begin
                      STRSQL:=Funciones.CambiarSubCadena(SentenciaEspecial,'WHERE (',
                               'WHERE @@(Maquina="'+DameNombrePC+'") AND '+
                                       '(Usuario="'+Usuario+'") ');
                      STRSQL:=Funciones.CambiarSubCadena(SentenciaEspecial,'WHERE @@(','WHERE (');
                   end
              else STRSQL:= SentenciaEspecial+' '+
                            'WHERE (Maquina="'+DameNombrePC+'") AND '+
                                  '(Usuario="'+Usuario+'") ';
           STRSQL:=STRSQL+ CondicionExtra;
         end
    else STRSQL:='Select * FROM TablaAux '+
                 'WHERE (Maquina="'+DameNombrePC+'") AND '+
                       '(Usuario="'+Usuario+'") '+
                       CondicionExtra;
  Funciones.AbrirAdo(Tabla,STRSQL);
end;
//------------------------------------------------------------------------------
Procedure TablaAuxEjecutaUpdate(TablaAux:TADOQuery;Sentencia,Usuario:String);
var STRSQL:String;
begin
  if Sentencia=''
    then exit;
  sentencia:=Funciones.QuitaCaracter(sentencia,';');
  STRSQL:= Sentencia+ ' and '+
         '(Maquina="'+DameNombrePC+'") AND '+
         '(Usuario="'+Usuario+'") ';

  EjecutaSQLAdo(Sentencia,TablaAux);
end;
//------------------------------------------------------------------------------
Procedure TablaAuxEjecutaInsert(TablaAux:TADOQuery;Sentencia,Usuario:String);
var aux:String;
    i:Integer;
begin
  if Sentencia=''
    then exit;
  sentencia:=Funciones.QuitaCaracter(sentencia,';');
  i:=pos(')',sentencia);//el final del insert
  sentencia[i]:='@';
  Aux:= ',Maquina,Usuario )';
  sentencia:= funciones.CambiarSubCadena(sentencia,'@',Aux);//añado los campos de la maquina y usuario
  Aux:=',"'+DameNombrePC+'" as Maquina, "'+
            Usuario+'" as Usuario FROM  ';
  sentencia:= funciones.CambiarSubCadena(sentencia,' from ',' FROM ');
  sentencia:= funciones.CambiarSubCadena(sentencia,' From ',' FROM ');
  sentencia:= funciones.CambiarSubCadena(sentencia,' FROM ',Aux);
  if pos('FROM',sentencia)=0
    then begin
            sentencia:=sentencia+Aux;
            sentencia:=Funciones.QuitarSubCadena('FROM',sentencia);
         end;
  EjecutaSQLAdo(Sentencia,TablaAux);
end;
//------------------------------------------------------------------------------
procedure TablaAuxNewRecord(DataSet: TDataSet;Usuario:string);
begin
  DataSet.FieldByName('Maquina').asString:= DameNombrePC;
  DataSet.FieldByName('Usuario').asString:= Usuario;
end;
//------------------------------------------------------------------------------
procedure Pita(Ruta:String);
begin
  if ruta=''
    then Beep
    else PlaySound(pChar(Ruta), 0, 0);

end;
//------------------------------------------------------------------------------
function DameRutaCadenaConexion(cadenaconexion:string):string;
var
  conexion, conexionaux:string;
  salir:boolean;
begin
  salir:=false;
  conexion:=cadenaconexion;
  conexionaux:=Funciones.Descomponer(conexion,';');
  while (conexion<>'') and (salir=false) do
  begin
    if Funciones.PrimerasLetras(conexionaux,11)='Data Source='
      then begin
            conexionaux:=Funciones.QuitaPrimerasLetras(conexionaux,12);
            salir:=true;
           end
      else conexionaux:=Funciones.Descomponer(conexion,';');
  end;
  result:=conexionaux;
end;
//------------------------------------------------------------------------------
function FechaInglesaDeUnStr(fechaencadena:string):string;
begin result:=Funciones.fechaInglesa(StrToDate(fechaencadena)); end;
//------------------------------------------------------------------------------

//***********************FUNCIONES DE SONIDO SPEAKER****************************
procedure SetPort(address, Value: Word) ;
var
   bValue: Byte;
begin
   bValue := trunc(Value and 255) ;
   asm
     mov dx, address
     mov al, bValue
     out dx, al
   end;
end;
//------------------------------------------------------------------------------
function GetPort(address: Word): Word;
var
   bValue: Byte;
begin
   asm
     mov dx, address
     in al, dx
     mov bValue, al
   end;
   GetPort := bValue;
end;
//------------------------------------------------------------------------------
procedure Sound(aFreq, aDelay: Integer) ;
   //------------------------------
   procedure DoSound(Freq: Word) ;
   var
     B: Byte;
   begin
     if Freq > 18 then
     begin
       Freq := Word(1193181 div Longint(Freq)) ;
       B := Byte(GetPort($61)) ;

       if (B and 3) = 0 then
       begin
         SetPort($61, Word(B or 3)) ;
         SetPort($43, $B6) ;
       end;

       SetPort($42, Freq) ;
       SetPort($42, Freq shr 8) ;
     end;
   end;
   //-------------------------------
   procedure Delay(MSecs: Integer) ;
   var
     FirstTickCount: LongInt;
   begin
     FirstTickCount := GetTickCount;
     repeat
       Sleep(1) ;
       //or use Application.ProcessMessages instead of Sleep
     until ((GetTickCount - FirstTickCount) >= Longint(MSecs)) ;
   end;
   //---------------------------------
begin
   if Win32Platform = VER_PLATFORM_WIN32_NT then
   begin
     Windows.Beep(aFreq, aDelay) ;
   end
   else
   begin
     DoSound(aFreq) ;
     Delay(aDelay) ;
   end;
end;
//------------------------------------------------------------------------------
procedure NoSound;
var
   Value: Word;
begin
   if not (Win32Platform = VER_PLATFORM_WIN32_NT) then
   begin
     Value := GetPort($61) and $FC;
     SetPort($61, Value) ;
   end;
end;
//------------------------------------------------------------------------------
Function MoverteEnTablaADO(Cual,tipodato:Char;dato,nombretabla,campo,filtro,codigoactual,claveprimaria:String;tabla:TAdoQuery):String;
var StrSql,StrWhere,StrFiltro,comillas:String;
//CUAL: L -> Last F -> First N -> Next P -> Prior     CUAL=VACIO -> se mueve al registro exacto
//TIPODATO: C -> cadena N -> Numerico
//DATO: dato pasado
//NOMBRETABLA: Nombre que se le ha dado físicamente en el gestor de base de datos
//CAMPO: Campo a ordenar
//FILTRO: Si existieran filtros provenientes del formulario que llama a esta función
//TABLA: Pasar el TADOQUERY correspondiente, el registro se abrirá en la tabla correspondiente

//NOTA: Hay problemas si hay 2 nombres idénticos. Ejemplo:
//   barco0: andres
//   barco1: pepa
//   barco2: pepa
//   barco3: zunia

//Si estoy en el barco1 y hacemos "select top 1 * where nombreB > 'barco1'" NO iría al barco 2, por este motivo
// se debe hacer "select top 1 * where NombreB >= 'barco1' and claveprimaria > claveprimariaactual"
//Esto sólo sucede para el caso que se pasen cadenas, con enteros no hay problema.



begin
  if tipodato = 'C' then dato := QuotedStr(dato);  //le pone comillas a la cadena

  if tabla.Tag=100// estamos inicializando, el formulario, no debe de entrar aquí
    then exit;   //hasta el ultim momento o cuando cambiemos alguno de los valores del los limites

  if (dato='') and (Cual in ['N','P'])
    then Cual:='L';

  StrFiltro:='';              
  if filtro<>''
    then begin
           //StrFiltro:=Trim(Edit1.Text);
           if StrFiltro<>''
             then StrFiltro:=' (codigobarco = '+Funciones.DimeCadena(StrFiltro,1)+')';
         end;
  Case Cual of
    'L' : StrWhere:='@ Order by '+campo+' DESC'; // LAST
    'F' : StrWhere:='@ Order by '+campo;     //FIRST
    'N' : StrWhere:='WHERE ('+claveprimaria+'<>'+codigoactual+') and ('+campo+' >='+comillas+dato+comillas+') @@ Order by '+ campo;//NEXT
    'P' : StrWhere:='WHERE ('+claveprimaria+'<>'+codigoactual+') and ('+campo+' <='+comillas+dato+comillas+') @@ Order by '+campo+' DESC';//PRIOR
    else  StrWhere:='WHERE ('+campo+' ='+comillas+dato+comillas+') @@';//Exacto
  end;
  if StrFiltro=''
    then StrWhere:=Funciones.QuitarChar(StrWhere,'@')
    else begin
           StrWhere:=Funciones.CambiarSubCadena(StrWhere,'@@',' AND '+StrFiltro);   // YA TENIAN EL WHERE
           StrWhere:=Funciones.CambiarSubCadena(StrWhere,'@' ,' WHERE '+StrFiltro) // NO TENI WHERE
         end;

  StrSql:='Select Top 1 * from '+nombretabla+' '+ StrWhere;
  Funciones.AbrirAdo(tabla,StrSql);
  if (tabla.RecordCount=0) and (cual in ['N','P'])
    then MoverteEnTablaADO(' ',tipodato,dato,nombretabla,campo,filtro,codigoactual,claveprimaria,tabla);

  Result := StrSQL;
end;
//------------------------------------------------------------------------------
Function Entrecomilla(const cadena:String):String;
begin
  result:=QuotedStr(Cadena);
end;
//------------------------------------------------------------------------------
procedure CtrAltSup_Desconecta;
var dummy : integer;
begin           {Desconectar el Ctrl-Alt-Del:}
  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 1, @dummy, 0);
end;
//------------------------------------------------------------------------------
procedure CtrAltSup_Conecta;
var dummy : integer;
begin           {Volver a conectarlo:}
  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 0, @dummy, 0);
end;
//------------------------------------------------------------------------------
function CerrarSesion:Boolean;
//CIERRA LA SESIÓN TANTO DE TERMINAL SERVER COMO CUALQUIER VERSIÓN DE WINDOWS
  var
    TokenPriv: TTokenPrivileges;
    H: DWord;
    HToken: THandle;
  begin
    if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
     OpenProcessToken(GetCurrentProcess,
      TOKEN_ADJUST_PRIVILEGES,HToken);
     LookUpPrivilegeValue(NIL, 'SeShutdownPrivilege',
      TokenPriv.Privileges[0].Luid);
     TokenPriv.PrivilegeCount := 1;
     TokenPriv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
     H := 0;
     AdjustTokenPrivileges(HToken, FALSE,
     TokenPriv, 0, PTokenPrivileges(NIL)^, H);
     CloseHandle(HToken);
   end;
    Result := ExitWindowsEx(EWX_LOGOFF, 0);
    //nota: si fuera ExitWindowsEx(EWX_POWEROFF, 0);, se apagaría el equipo
end;
//------------------------------------------------------------------------------
function CalculaDC(Banco, Cuenta: string):integer;
// ejemplo Label1.Caption:=IntToStr(CalculaDC('00851755','0000321764'));
   const
     Pesos: array[0..9] of integer=(6,3,7,9,10,5,8,4,2,1);
   var
     n      : byte;
     iTemp  : integer;
   begin
     iTemp:=0;
     for n := 0 to 7 do
        iTemp := iTemp + StrToInt(Copy(Banco, 8 - n, 1)) * Pesos[n];
     Result:=11 - iTemp Mod 11;
     if (Result > 9) then Result:=1-Result mod 10;
     iTemp:=0;
     For n := 0 to 9 do
        iTemp := iTemp + StrToInt(Copy(Cuenta, 10 - n, 1)) * Pesos[n];
     iTemp:=11 - iTemp mod 11;
     if (iTemp > 9) then iTemp:=1-iTemp mod 10;
     Result:=Result*10+iTemp;
   end;

procedure SacaTexto(Texto:String);
begin
  Application.CreateForm(TFormSacaAvisos, FormSacaAvisos);
  FormSacaAvisos.Memo1.text:=Texto;
  FormSacaAvisos.Showmodal;
  FormSacaAvisos.free;
end;
//
function obtenerNombrePC () : string;
var
  nombre: String;
  DatosSocket: WSAData;
begin
//  WSAStartup($0101, DatosSocket);
//  SetLength(nombre, MAX_PATH);
//  gethostname(PChar(Nombre), MAX_PATH);
//  SetLength(nombre, StrLen(PChar(nombre)));
//  result := upperCASE(nombre);
  result := '';
end;

function encriptarCIE(aStr: String): String;
var
  i:integer;
  aux: string;
begin
  Result:='';
  aux := '';
  for i := 1 to length(aStr) do
  begin
    case aStr[i] of
      'a': aux := '9!'; 'b': aux := '8!'; 'c': aux := '7!';
      'd': aux := '6!'; 'e': aux := '5!'; 'f': aux := '4!';
      'g': aux := '3!'; 'h': aux := '2!'; 'i': aux := '1!';
      'j': aux := '9@'; 'k': aux := '8@'; 'l': aux := '7@';
      'm': aux := '6@'; 'n': aux := '5@'; 'o': aux := '4@';
      'p': aux := '3@'; 'q': aux := '2@'; 'r': aux := '1@';
      's': aux := '9#'; 't': aux := '8#'; 'u': aux := '7#';
      'v': aux := '6#'; 'w': aux := '5#'; 'x': aux := '4#';
      'y': aux := '3#'; 'z': aux := '2#';
      'A': aux := '9¡'; 'B': aux := '8¡'; 'C': aux := '7¡';
      'D': aux := '6¡'; 'E': aux := '5¡'; 'F': aux := '4¡';
      'G': aux := '3¡'; 'H': aux := '2¡'; 'I': aux := '1¡';
      'J': aux := '9"'; 'K': aux := '8"'; 'L': aux := '7"';
      'M': aux := '6"'; 'N': aux := '5"'; 'O': aux := '4"';
      'P': aux := '3"'; 'Q': aux := '2"'; 'R': aux := '1"';
      'S': aux := '9·'; 'T': aux := '8·'; 'U': aux := '7·';
      'V': aux := '6·'; 'W': aux := '5·'; 'X': aux := '4·';
      'Y': aux := '3·'; 'Z': aux := '2·';
      '=': aux := '&';
      ';': aux := '+';
      '.': aux := 'º';
      else
        aux := aStr[i];
    end;
    result := result + aux;
  end;
end;

function desencriptarCIE(aStr: String): String;
var
  i:integer;
  aux: string;
begin
  Result:='';
  aux := '';
  for i := 1 to length(aStr) do
  begin
    aux := aStr[i];
    case aStr[i] of
      '9' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'a';
              if (aStr[i+1] = '@') then aux := 'j';
              if (aStr[i+1] = '#') then aux := 's';
              if (aStr[i+1] = '¡') then aux := 'A';
              if (aStr[i+1] = '"') then aux := 'J';
              if (aStr[i+1] = '·') then aux := 'S';
            end;
      '8' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'b';
              if (aStr[i+1] = '@') then aux := 'k';
              if (aStr[i+1] = '#') then aux := 't';
              if (aStr[i+1] = '¡') then aux := 'B';
              if (aStr[i+1] = '"') then aux := 'K';
              if (aStr[i+1] = '·') then aux := 'T';
            end;
      '7' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'c';
              if (aStr[i+1] = '@') then aux := 'l';
              if (aStr[i+1] = '#') then aux := 'u';
              if (aStr[i+1] = '¡') then aux := 'C';
              if (aStr[i+1] = '"') then aux := 'L';
              if (aStr[i+1] = '·') then aux := 'U';
            end;
      '6' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'd';
              if (aStr[i+1] = '@') then aux := 'm';
              if (aStr[i+1] = '#') then aux := 'v';
              if (aStr[i+1] = '¡') then aux := 'D';
              if (aStr[i+1] = '"') then aux := 'M';
              if (aStr[i+1] = '·') then aux := 'V';
            end;
      '5' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'e';
              if (aStr[i+1] = '@') then aux := 'n';
              if (aStr[i+1] = '#') then aux := 'w';
              if (aStr[i+1] = '¡') then aux := 'E';
              if (aStr[i+1] = '"') then aux := 'N';
              if (aStr[i+1] = '·') then aux := 'W';
            end;
      '4' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'f';
              if (aStr[i+1] = '@') then aux := 'o';
              if (aStr[i+1] = '#') then aux := 'x';
              if (aStr[i+1] = '¡') then aux := 'F';
              if (aStr[i+1] = '"') then aux := 'O';
              if (aStr[i+1] = '·') then aux := 'X';
            end;
      '3' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'g';
              if (aStr[i+1] = '@') then aux := 'p';
              if (aStr[i+1] = '#') then aux := 'y';
              if (aStr[i+1] = '¡') then aux := 'G';
              if (aStr[i+1] = '"') then aux := 'P';
              if (aStr[i+1] = '·') then aux := 'Y';
            end;
      '2' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'h';
              if (aStr[i+1] = '@') then aux := 'q';
              if (aStr[i+1] = '#') then aux := 'z';
              if (aStr[i+1] = '¡') then aux := 'H';
              if (aStr[i+1] = '"') then aux := 'Q';
              if (aStr[i+1] = '·') then aux := 'Z';
            end;
      '1' : if (i < length(aStr)) and (not EsNumero(aStr[i+1])) then
            begin
              if (aStr[i+1] = '!') then aux := 'i';
              if (aStr[i+1] = '@') then aux := 'r';
              if (aStr[i+1] = '¡') then aux := 'I';
              if (aStr[i+1] = '"') then aux := 'R';
            end;
      'º' : aux := '.';
      '&' : aux := '=';
      '+' : aux := ';';
      else // del case
      begin
        if (aux = '!') or (aux = '¡') or (aux = '@') or (aux = '#')
        or (aux = '"') or (aux = '·') then
          aux := '';
      end;
    end;
    result := result + aux;
  end;
end;
function EsNumero(S: variant): Boolean;
var
  Number, Code: Integer;
begin
  if varIsNull(s) then
    Result:=false
  else
  begin
    Val(S, Number, Code);
    Result := (Code = 0);
  end;
end;

end.

