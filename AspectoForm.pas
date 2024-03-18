unit AspectoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons,DBGrids, AdvMenus, AdvMenuStylers, AdvPanel,
  StdCtrls,AdvPageControl, Grids, BaseGrid, AdvGrid, DBAdvGrid, ImgList,
  ComCtrls, jpeg,FuncionesForm, AdvProgressBar,DBAdvNavigator;

type
  TFormAspecto = class(TForm)
    EstiloPanelDegradado: TAdvPanelStyler;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    EstiloPanelCabecera: TAdvPanelStyler;
    ColorBase: TLabel;
    ColorAgrupado: TLabel;
    AdvMenuStyler1: TAdvMenuStyler;
    ColorBase2: TLabel;
    ColorAgrupado2: TLabel;
    ColorDegradado: TLabel;
    ColorDegradado2: TLabel;
    EstiloPanelCollaps: TAdvPanelStyler;
    EstiloPanelCIE: TAdvPanelStyler;
    ColorCIE: TLabel;
    ImageListMenus: TImageList;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Imprimir: TImage;
    Imprimir1: TImage;
    Pantalla: TImage;
    Foto: TImage;
    Buscar: TImage;
    Gente: TImage;
    Parametros: TImage;
    ParametrosG: TImage;
    Salir2: TImage;
    FechaArriba: TImage;
    FechaDerecha: TImage;
    FechaIzquierda: TImage;
    FechaAbajo: TImage;
    eliminar: TImage;
    anadir: TImage;
    Arriba3: TImage;
    Abajo3: TImage;
    Izquierda: TImage;
    Procesar: TImage;
    Procesar2: TImage;
    Excel: TImage;
    Cancelar2: TImage;
    Escaner: TImage;
    Paint: TImage;
    Disenar: TImage;
    Guardar: TImage;
    Nuevos: TImage;
    Nuevo: TImage;
    Buscar1: TImage;
    Buscar4: TImage;
    Borrar: TImage;
    Carpeta: TImage;
    Cerrar: TImage;
    TabSheet3: TTabSheet;
    Ancla: TImage;
    Copiar: TImage;
    Logic: TImage;
    Email: TImage;
    Informacion: TImage;
    Pendiente: TImage;
    Error: TImage;
    Caution: TImage;
    Pregunta: TImage;
    SiaTodo: TImage;
    Image1Aux: TImage;
    Filtro: TImage;
    FiltroNo: TImage;
    CentroInformacion: TImage;
    Prohibido: TImage;
    Pagar: TImage;
    Sumatorio: TImage;
    PreguntaAmarillo: TImage;
    Salir: TImage;
    ColorBarraGridSelLect: TLabel;
    ColorBarraGridSelLect2: TLabel;
    Aceptar2: TImage;
    Derecha: TImage;
    Barco: TImage;
    Comprador: TImage;
    Concepto: TImage;
    Armador: TImage;
    Hielo: TImage;
    Lubricante: TImage;
    Camion: TImage;
    LubricantePregunta: TImage;
    Mensajes: TImage;
    DineroSaco: TImage;
    ExportarAutec: TImage;
    ImportarAutec: TImage;
    Autec: TImage;
    EstadisticaLinea1: TImage;
    EstadisticaCirculo: TImage;
    Tareas: TImage;
    DineroPreguntaC: TImage;
    Euro: TImage;
    Caja: TImage;
    Calculadora2: TImage;
    AlbaranBarco: TImage;
    AlbaranComprador: TImage;
    GastosBarco: TImage;
    GastosComprador: TImage;
    LiquidacionBarco: TImage;
    LiquidacionComprador: TImage;
    Subasta: TImage;
    CajasES: TImage;
    CajasPregunta: TImage;
    FacturaRoja: TImage;
    FacturaVerde: TImage;
    Documento: TImage;
    Cruzado: TImage;
    RecalcularTodo: TImage;
    EstadisticaLinea: TImage;
    Estadistica3D: TImage;
    ConceptoPregunta: TImage;
    CambioAutec: TImage;
    Prorrateo: TImage;
    Ordenar: TImage;
    Reloj: TImage;
    Archivo: TImage;
    ProcesarAmarillo: TImage;
    ProcesaRojo: TImage;
    ProcesarAzul: TImage;
    Procesarverde: TImage;
    Reintentar: TImage;
    DineroPreguntaB: TImage;
    NoLineas: TImage;
    SiLineas: TImage;
    AdelanteMas: TImage;
    Fijo: TImage;
    Formulario: TImage;
    Matricula: TImage;
    Semana: TImage;
    Hoy: TImage;
    MesUltimo: TImage;
    Reciclar: TImage;
    Last: TImage;
    Next: TImage;
    Prior: TImage;
    First: TImage;
    Carpetita: TImage;
    Rayo: TImage;
    CambiarStatus: TImage;
    CandadoG: TImage;
    CandadoAbiertoG: TImage;
    Agenda: TImage;
    Editar: TImage;
    Start: TImage;
    NPapel: TImage;
    Etiquetas1: TImage;
    Lista: TImage;
    Recibo: TImage;
    BuscaImprime: TImage;
    Stop: TImage;
    Image2: TImage;
    Image3: TImage;
    Copy: TImage;
    ServerDocumentos: TImage;
    CopiarEdit: TImage;
    ver: TImage;
    Limpiar: TImage;
    CajaPescado: TImage;
    CestoCompra: TImage;
    ColorCIETServer: TLabel;
    Todos: TImage;
    Procesa2Verde: TImage;
    ColorDegradadoParametros: TLabel;
    ColorDegradadoParametros2: TLabel;
    Cartera: TImage;
    ProcesarAma: TImage;
    Copiar2: TImage;
    Etiquetas: TImage;
    Ver2: TImage;
    PasoMas: TImage;
    Paso: TImage;
    PasoNew: TImage;
    ColorCIE2: TLabel;
    ColorBotones: TLabel;
    ColorLabels: TLabel;
    ColorCabGrid: TLabel;
    ColorDatGrid: TLabel;
    ColorCabPanel: TLabel;
    ColorFuenteCie: TLabel;
    ColorBotonesCie: TLabel;
    ColorCabecera: TLabel;
    ColorCabecera2: TLabel;
    Senalado: TImage;
    SenaladoHasta: TImage;
    BloqueoTemporal: TImage;
    BloqueoTodo: TImage;
    Contrasenya: TImage;
    Image1: TImage;
    pda: TImage;
    Pause: TImage;
    Iniciar: TImage;
    Refrescar: TImage;
    ColorGriddelphi: TLabel;
    Image4: TImage;
    Pez: TImage;
    MandoCIE: TImage;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    AdvPanel6: TAdvPanel;
    Label1: TLabel;
    GridLista: TDBAdvGrid;
    Paginas: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;

    Procedure ProgressBar_Inicia(Barra:TAdvProgressBar;Maximo:Integer);
    Procedure ProgressBar_Termina(Barra:TAdvProgressBar);
    Procedure ProgressBar_Suma(Barra:TAdvProgressBar);

    Procedure InicializaFormulario(
                Formulario:TForm;PanelPrincipal:TPanel;NavegadorPrincipal:TDBAdvNavigator;
                PanelDeLaImagen:TAdvPanel;
                ImagenFormulario:TImage;
                Paginas : TAdvpagecontrol;
                PanelLimites:TAdvPanel);

    procedure CreaFormAni(Formulario:Tform);
    procedure MuestraFormAni(Formulario:Tform);
    procedure CierraFormAni(Formulario:Tform);
    procedure PonZumbido (Formulario:Tform);
    procedure InicializaAspecto(VEstoyTServer:Boolean;VColorPanel,vColorLetraBtn,VEstiloPanel:Integer);
    procedure ImprimeFoto(Formulario: TForm);
    procedure PonCalendario(Calendario : TObject);
    procedure PonPanel(Panel:TPanel);
    procedure PonEstiloPanelCabecera(Panel:TAdvPanel);
    procedure PonEstiloPanelDegradado(Panel:TAdvPanel;Color:TColor);
    procedure PonEstiloPanelCIE(formulario:TForm;Panel:TAdvPanel;Centrar:boolean);
    Procedure CentrarAdvPanel(formulario:TForm; advpanl:TAdvPanel);
    procedure PonEstiloPanelCollaps(Panel:TAdvPanel);
    procedure PonBoton (Boton:TSpeedButton;Imagen:TImage;NumeroImagenes:Integer;
                           BorrarCaption:Boolean;Alineado:Char;PosicionImagen:Char;
                           Defecto:Boolean);
    procedure PonPageControl(Page:TAdvPageControl);
    procedure PonGrid(Grid : TDBGrid);
    procedure PonEstiloGridAdv(AdvGrid : TDBAdvGrid; Degradado,LineaEnteraSeleccionada,ActivaCelda:Boolean);
    procedure PonEstiloGridAdvStr(AdvGrid :TAdvStringGrid; Degradado,LineaEnteraSeleccionada,ActivaCelda:Boolean);
    procedure PonEstiloGridAdvLectura(AdvGrid : TDBAdvGrid);
    procedure FormCreate(Sender: TObject);
    procedure PonImagenPanel(Imagen:TImage;Panel:TAdvPanel;Picture:TPicture);
    private

    { Private declarations }
  public { Public declarations }
    ColorPanel,ColorLetraBtn,_EstiloPanel:Integer;
    EstiloTServer,EstamosEnPdas: Boolean;

  end;

var
  FormAspecto: TFormAspecto;
  mx,my:integer;
  hx,hy:integer;
  xmid,ymid:integer;
  i:integer;
  acanvas:Tcanvas;
  bmp:Tbitmap;

const
  n=100;

implementation

{$R *.dfm}


//------------------------------------------------------------------------------
procedure TFormAspecto.InicializaAspecto(VEstoyTServer:Boolean;VColorPanel,vColorLetraBtn,VEstiloPanel:Integer);
begin
  EstiloTServer:= VEstoyTServer;
  ColorPanel   :=VColorPanel;
  ColorLetraBtn:=vColorLetraBtn;
  _EstiloPanel  :=VEstiloPanel;
end;

//------------------------------------------------------------------------------
procedure TFormAspecto.ImprimeFoto(Formulario: TForm);
begin
   if FuncionesForm.MessageDlgCie('*¿Desea una copia en impresora de este formulario?*',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      if Formulario.Width >= 800
        then Formulario.PrintScale := poPrintToFit
        else Formulario.PrintScale := poProportional;
      Formulario.Print;
   end;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonPanel(Panel:TPanel);
begin
  if ColorPanel=0
    then Panel.Color := ColorBase.color
    else Panel.Color := ColorPanel;
  Panel.Font.Color:= ColorLetraBtn;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonEstiloPanelDegradado(Panel:TAdvPanel;Color:TColor);
begin
  Panel.Styler:=nil;
  if ColorPanel=0
    then Panel.Styler:=EstiloPanelDegradado
    else Panel.color:=ColorPanel;
  if Color<>0
    then Panel.Color:=Color;
//  Panel.Font.Name  := ColorLabels.Font.Name;// 'MS Sans Serif';
//  Panel.Font.Color := ColorLabels.Font.Color;
  Panel.Caption.Font := ColorCabPanel.Font;
  Panel.Font         := ColorLabels.Font;
  Panel.Caption.Color:= ColorCabecera.Color;
  Panel.Caption.ColorTo:= ColorCabecera2.Color;  
  if EstiloTServer
    then Panel.colorTo := Panel.color;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonEstiloPanelCIE(formulario:TForm;Panel:TAdvPanel;centrar:boolean);
begin
  Panel.Styler:=nil;
  if ColorPanel=0
    then begin
          Panel.Styler  := EstiloPanelCIE;
          Panel.colorTo := ColorCIE2.Color;
         end
    else Panel.color :=ColorPanel;
  Panel.Font.Name    := ColorFuenteCie.Font.Name;//'MS Sans Serif';
  Panel.BorderColor  := Panel.Caption.Color;
  if EstiloTServer
    then begin
           Panel.color   := ColorCIETServer.Color;
           Panel.colorTo := ColorCIETServer.Color;
         end;
  if centrar
    then begin
           Panel.left    := trunc((formulario.Width /2) - (Panel.width/2));
           Panel.top     := trunc((formulario.Height/2) - (Panel.height/2));
         end;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonEstiloPanelCabecera(Panel:TAdvPanel);
begin
  Panel.Styler:=nil;
  Panel.Styler:=EstiloPanelCabecera;
 // Panel.Font.Name  := ColorLabels.Font.Name;//MS Sans Serif';
 // Panel.Font.Color := ColorLabels.Font.Color;
//  Panel.Caption.Font := ColorCabPanel.Font;
//  Panel.Font         := ColorLabels.Font;
  if EstiloTServer
    then Panel.colorTo := Panel.color;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonImagenPanel(Imagen:TImage;Panel:TAdvPanel;Picture:TPicture);
begin
  Panel.Caption.Visible := False;
  Imagen.Align := alClient;
  Imagen.Picture := Picture;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonEstiloPanelCollaps(Panel:TAdvPanel);
begin
  Panel.Styler:=nil;
  Panel.Styler:=EstiloPanelCollaps;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonBoton (Boton:TSpeedButton;Imagen:TImage;NumeroImagenes:Integer;
                           BorrarCaption:Boolean;Alineado:Char;PosicionImagen:Char;
                           Defecto:Boolean);
begin
  if Imagen <> Nil then Boton.Glyph := Imagen.Picture.Bitmap;
  if BorrarCaption then Boton.Caption := '';
  if Defecto       then Boton.Font.Style := [fsBold];
  Case UpCase(Alineado) of
    'I','A': Boton.Margin  := 0;
    'C'    : Boton.Margin  :=-1;
  end;
  Boton.ParentFont:=False;
  Boton.NumGlyphs := NumeroImagenes;
  PosicionImagen:=UpCase(PosicionImagen);
  case PosicionImagen of
    'I': Boton.Layout := blGlyphLeft;
    'A': Boton.Layout := blGlyphTop;
    'D': Boton.Layout := blGlyphRight;
    'B': Boton.Layout := blGlyphBottom;
  end;
  //APARTIR DE AQUI TODO ES ESTILO VISUAL

  Boton.Flat   := True;
  Boton.Cursor := crHandPoint;
  Boton.Font.Color := ColorLetraBtn;
//  Boton.Font       := ColorBotones.Font;// 8;
  Boton.Font.Name  := ColorBotones.Font.Name;// 'MS Sans Serif';
  Boton.Font.Color := ColorBotones.Font.Color;
  Boton.Font.Size  := ColorBotones.Font.Size;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonGrid(Grid : TDBGrid);
//var i : Integer;
begin
  Grid.Color           := ColorGriddelphi.Color;// Colordegradado.color;
  Grid.TitleFont       := ColorCabGrid.Font;// ColorBotones.Font.Color;//clWhite;
  Grid.FixedColor      := colorDegradado.color;//clSkyBlue;
  Grid.Ctl3D           := False;
  Grid.Font.Color      := ColorDatGrid.Font.Color;
  //fijate en ponestilogridadv
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.FormCreate(Sender: TObject);
begin
  EstamosEnPdas:=False;
  ColorLetraBtn:=clBlue;
  EstiloPanelCabecera.Settings.Color          :=ColorAgrupado.COLOR;
  EstiloPanelCabecera.Settings.ColorTO        :=ColorAgrupado2.COLOR;  //clSkyBlue
  EstiloPanelCabecera.Settings.Caption.Color  :=ColorDegradado.Color;//ColorAgrupado.COLOR;//
  EstiloPanelCabecera.Settings.Caption.Colorto:=ColorDegradado.Color;  //ColorAgrupado.COLOR;//
  EstiloPanelCabecera.Settings.BorderColor    :=ColorCabecera.Color ;//clNavy; ColorDegradado.Color;
  EstiloPanelCabecera.Settings.BorderShadow   :=True;
  EstiloPanelCabecera.Settings.Caption.Font.Color:= ColorAgrupado.Font.Color;

  EstiloPanelDegradado.Settings.Color         :=ColorDegradado.COLOR;
  EstiloPanelDegradado.Settings.ColorTO       :=ColorDegradado2.COLOR;
  EstiloPanelDegradado.Settings.Caption.Color :=ColorDegradado.COLOR;
  EstiloPanelDegradado.Settings.Caption.ColorTO:=ColorDegradado2.COLOR;
  EstiloPanelDegradado.Settings.Font          :=ColorCabPanel.Font;

  EstiloPanelCIE.Settings.Color               :=ColorCIE.COLOR;
  EstiloPanelCie.Settings.ColorTO             :=ColorCIE2.COLOR;
  EstiloPanelCIE.Settings.Caption.Color       :=ColorCabecera.COLOR;
  EstiloPanelCie.Settings.Caption.ColorTO     :=ColorCabecera2.COLOR;
 // EstiloPanelCie.Settings.Font                :=ColorCabPanel.Font;

  EstiloPanelCollaps.Settings.Color           :=ColorAgrupado.COLOR;
  EstiloPanelCollaps.Settings.ColorTO         :=ColorAgrupado2.COLOR;  //clSkyBlue
  EstiloPanelCollaps.Settings.Caption.Color   :=ColorDegradado.Color;
  EstiloPanelCollaps.Settings.Caption.Colorto :=ColorDegradado.Color;
  EstiloPanelCollaps.Settings.BorderColor     :=ColorDegradado.Color;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonPageControl(Page:TAdvPageControl);
var i : Integer;
begin
 // Page.Font := ColorLabels.Font;
  Page.DefaultTextColor  := ColorLabels.Font.Color;
  Page.DefaultTabColor   :=ColorDegradado.Color;
  Page.TabBackGroundColor:=ColorDegradado2.Color;
  Page.DefaultTabColorto :=ColorDegradado2.Color;
  Page.ActiveColor       := ColorDegradado.Color;//$00D68759;//Azul case cNavy
  Page.ActiveColorto     := ColorDegradado.Color;//clNavy;
//  Page.ActiveFont.Color :=clWhite;
//  Page.TabBackGroundColor:=$00FBF0E6;//azul muy tenue
  For i:=0 to Page.PageCount-1 do
    begin
      page.Pages[i].Color  := ColorDegradado.Color;
      page.Pages[i].Colorto:= ColorDegradado2.Color;
    end;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonEstiloGridAdv(AdvGrid : TDBAdvGrid; Degradado,LineaEnteraSeleccionada,ActivaCelda:Boolean);
var i :Integer;
    ColorHeader,Color1,Color2:TColor;
begin
  Color1     :=Colordegradado.Color;
  Color2     :=Colordegradado2.Color;
  ColorHeader:=Color2;
  if EstiloTServer
    then begin
           Color1:=ColorCIETServer.Color;
           Color2:=ColorCIETServer.Color;
           ColorHeader:=clBlack;
         end;
  AdvGrid.Flat:=true;
  AdvGrid.ScrollType:=ssFlat;
  AdvGrid.background.ColorTo:=Color2;
  AdvGrid.Options:=AdvGrid.Options-[goRowSelect];
  if Degradado
    then  begin
            AdvGrid.background.Color  :=Color1;
            AdvGrid.background.ColorTo:=Color2;
          end
    else  begin
            AdvGrid.background.Color  :=Color2;
            AdvGrid.background.ColorTo:=Color2;
          end;

  if ActivaCelda
    then begin
           AdvGrid.ActiveCellColor  :=$0094E6FB;
           AdvGrid.ActiveCellColorTo:=$001595EE;
           AdvGrid.ActiveCellShow   :=True;
         end
    else begin
           AdvGrid.ActiveCellShow   :=False;   // ver color distinto arriba e izquierda
         end;

  AdvGrid.GridLineColor:=Color1;  //linea divisoria

  AdvGrid.SearchFooter.Color   :=Color1;      // SI TIENENBUSQUEDA, PONER EL COLOR
  AdvGrid.SearchFooter.ColorTo :=Color1;

  AdvGrid.SelectionColor:= Color1; // MEJOR SERIA AMARILLO
  AdvGrid.ActiveRowColor:= clInfoBk;//Colordegradado.Color;
  AdvGrid.SelectionColor:= clInfoBk;
  AdvGrid.ActiveRowShow:= LineaEnteraSeleccionada;

  if LineaEnteraSeleccionada
    then AdvGrid.Options:=AdvGrid.Options+[goRowSelect]
    else AdvGrid.Options:=AdvGrid.Options-[goRowSelect];

  AdvGrid.FixedColor:=Color1;
  for i:=0 to AdvGrid.Columns.Count-1 do
    begin
      AdvGrid.Columns[i].HeaderAlignment := taCenter;
      AdvGrid.Columns[i].HeaderFont.color:= ColorHeader;
      AdvGrid.Columns[i].HeaderFont.Style:=[fsBold]
    end;
end;
//------------------------------------------------------------------------------
procedure TFormAspecto.PonEstiloGridAdvStr(AdvGrid : TAdvStringGrid; Degradado,LineaEnteraSeleccionada,ActivaCelda:Boolean);
var i :Integer;
begin
  AdvGrid.Flat:=true;
  AdvGrid.ScrollType:=ssFlat;
  AdvGrid.background.ColorTo:=Colordegradado2.Color;
  AdvGrid.Options:=AdvGrid.Options-[goRowSelect];
  if Degradado
    then  begin
            AdvGrid.background.Color:=Colordegradado.Color;
            AdvGrid.background.ColorTo:=Colordegradado2.Color;
          end
    else  begin
            AdvGrid.background.Color  :=Colordegradado2.Color;
            AdvGrid.background.ColorTo:=Colordegradado2.Color;
          end;

  if ActivaCelda
    then begin
           AdvGrid.ActiveCellColor  :=$0094E6FB;
           AdvGrid.ActiveCellColorTo:=$001595EE;
           AdvGrid.ActiveCellShow   :=True;
         end
    else begin
           AdvGrid.ActiveCellShow   :=False;   // ver color distinto arriba e izquierda
         end;

  AdvGrid.GridLineColor:=Colordegradado.Color;  //linea divisoria

  AdvGrid.SearchFooter.Color :=Colordegradado.Color;      // SI TIENENBUSQUEDA, PONER EL COLOR
  AdvGrid.SearchFooter.ColorTo :=Colordegradado.Color;

  AdvGrid.SelectionColor:= Colordegradado.Color; // MEJOR SERIA AMARILLO
  AdvGrid.ActiveRowColor:= clInfoBk;//Colordegradado.Color;
  AdvGrid.SelectionColor:= clInfoBk;
  AdvGrid.ActiveRowShow:= LineaEnteraSeleccionada;

  if LineaEnteraSeleccionada
    then AdvGrid.Options:=AdvGrid.Options+[goRowSelect]
    else AdvGrid.Options:=AdvGrid.Options-[goRowSelect];

  AdvGrid.FixedColor:=Colordegradado.Color;
  for i:=0 to AdvGrid.ColCount-1 do
    begin
      AdvGrid.CellProperties[0,i].Alignment  := taCenter;
//      AdvGrid.Columns[i].HeaderFont.color:= Colordegradado2.Color;
      AdvGrid.CellProperties[0,i].FontColor := Colordegradado2.Color;
      AdvGrid.CellProperties[0,i].FontStyle  := [fsBold];
    end;
end;

procedure TFormAspecto.CreaFormAni(Formulario:TForm);
begin
  if EstiloTServer  then Exit; //Si estamos en Terminal Server nos salimos
  { creamos un canvas para dibujar en Windows Desktop }
  acanvas:=Tcanvas.create;
  acanvas.Handle:=getdc(0);

  { Asignamos el handle del desktop = 0 al canvas }
  bmp:=Tbitmap.Create;
  bmp.Height:=Formulario.height;
  bmp.Width:=Formulario.width;

  { calculamos el centro de la pantalla }
  mx:=screen.Width div 2;
  my:=screen.Height div 2;

  { calculamos el centro del form}
  hx:=Formulario.width div 2;
  hy:=Formulario.height div 2;

  { n indica el numero de cuadros(Zoom)
    se haran antes de mostrar el form completo}
  xmid:=hx div n;
  ymid:=hy div n;
end;
//----------------------------------------------------------------------------------------
procedure TFormAspecto.MuestraFormAni(Formulario:TForm);
var
  Handles: HWND;
  ScreenDC: HDC;
begin
  if EstiloTServer  then Exit; //Si estamos en Terminal Server nos salimos
  Handles := GetDesktopWindow ( );
  ScreenDC := GetDC ( Handles );

  { capturamos el sector de la pantalla destras de nuestro form
    para que al cerrar nuestra form no deje huella}
  BitBlt(bmp.Canvas.Handle,0,0,Formulario.width,Formulario.Height,ScreenDC,mx-hx,my-hy,SRCCOPY);

  ReleaseDC ( Handles, ScreenDC );

  { mostramos el form con el efecto }
{  acanvas.Brush.Bitmap:= Fondo.Picture.Bitmap; //Para poner una imagen (se repite)
  for i:=1 to n do
  begin
   acanvas.Rectangle(mx-i*xmid,my-i*ymid,mx+i*xmid,my+i*ymid);
   sleep(3);
  end;}
end;
//----------------------------------------------------------------------------------------
procedure TFormAspecto.CierraFormAni(Formulario:TForm);
begin
  if EstiloTServer  then Exit; //Si estamos en Terminal Server nos salimos
end;
//----------------------------------------------------------------------------------------
procedure TFormAspecto.PonEstiloGridAdvLectura(AdvGrid : TDBAdvGrid);
begin
    PonEstiloGridAdv(AdvGrid,True,True,False);
    AdvGrid.background.Display:=bdGradientHorz;
    AdvGrid.Options:=AdvGrid.Options+[goRowSelect];
    AdvGrid.FloatFormat:= '%12.2n';
    AdvGrid.BackGround.Color:= ColorDegradado.Color;
    AdvGrid.BackGround.ColorTo:= ColorDegradado2.Color;
    AdvGrid.SelectionColor:=ColorBarraGridSelLect.color;
    AdvGrid.SelectionColorTo:=ColorBarraGridSelLect2.color;
    AdvGrid.RefreshOnDelete:= False;
    AdvGrid.RefreshOnInsert:= False;
end;
//----------------------------------------------------------------------------------------
procedure TFormAspecto.PonCalendario(Calendario : TObject);
begin

end;
//----------------------------------------------------------------------------------------
procedure TFormAspecto.PonZumbido (Formulario:Tform);
var N, TL, TT : Integer;
begin
  TL := Formulario.Left;
  TT := Formulario.Top;
  for N:=1 to 50 do begin
     Formulario.Left:= (TL-10) + (Random(20));
     Formulario.Top := (TT-10) + (Random(20));
  end;
  Formulario.Left := TL;
  Formulario.Top := TT;
end;
//------------------------------------------------------------------------------
Procedure TFormAspecto.CentrarAdvPanel(formulario:TForm; advpanl:TAdvPanel);
begin
  advpanl.left       := trunc((formulario.Width /2) - (advpanl.width/2));
  advpanl.top        := trunc((formulario.Height/2) - (advpanl.height/2));
  advpanl.color      := ColorDegradadoParametros.color;
  advpanl.colorTo    := ColorDegradadoParametros2.color;
  advpanl.BorderWidth:= 1;
  advpanl.BorderColor:= advpanl.Caption.ColorTo;
  advpanl.Caption.CloseButton:=True;
end;



//------------------------------------------------------------------------------            
Procedure TFormAspecto.ProgressBar_Inicia(Barra:TAdvProgressBar;Maximo:Integer);
begin
  Barra.max:=Maximo;
  Barra.Visible:=True;
  Barra.Position:=0;
  Application.ProcessMessages;
end;

//------------------------------------------------------------------------------
Procedure TFormAspecto.ProgressBar_Termina(Barra:TAdvProgressBar);
begin
  Barra.Visible:=False;
  Barra.Position:=0;
  Application.ProcessMessages;
end;

//------------------------------------------------------------------------------
Procedure TFormAspecto.ProgressBar_Suma(Barra:TAdvProgressBar);
begin
  Barra.Position:=Barra.Position+1;
  Application.ProcessMessages;
end;

//------------------------------------------------------------------------------
Procedure TFormAspecto.InicializaFormulario(
           Formulario:TForm;PanelPrincipal:TPanel;NavegadorPrincipal:tDBAdvNavigator;
           PanelDeLaImagen:TAdvPanel;
           ImagenFormulario:TImage;
           Paginas : TAdvpagecontrol;
           PanelLimites:TAdvPanel);
begin
  FormAspecto.PonPanel(PanelPrincipal);
  Formulario.Color        :=FormAspecto.ColorBase.color;
  PanelPrincipal.Color    :=FormAspecto.ColorBase.color;
  if NavegadorPrincipal<>nil
    then NavegadorPrincipal.Color:=FormAspecto.ColorBase.color;
  if  PanelDeLaImagen<>NIL
    then begin
           PanelDeLaImagen.Color:= ColorDegradado.Color;
           PanelDeLaImagen.ColorTo:=PanelPrincipal.Color;
           PanelDeLaImagen.Caption.Visible:=False;
         end;
  if ImagenFormulario<>nil
    then begin
           Image1.Align  := alClient;
           PanelDeLaImagen.Color    := ColorDegradado.Color;
           PanelDeLaImagen.ColorTo  := ColorDegradado2.Color;
           PanelDeLaImagen.Caption.Visible:= False;
         end;
  if PanelLimites<>nil
    then begin
           PanelLimites.Caption.MinMaxButton:=true;
           PanelLimites.Caption.MinMaxButton:=true;
           PanelLimites.collaps:=True;//Panel limites pequeño
         end;
  if Paginas <> nil
    then FormAspecto.PonPageControl(Paginas);

end;


{ para copiar y pegar en los while not eof
    1º            FormAspecto.ProgressBar_Inicia(ProgressBar1, Tabla.RecordCount);

    por cada next FormAspecto.ProgressBar_Suma(ProgressBar1);

    último        FormAspecto.ProgressBar_Termina(ProgressBar1);
    }

end.
