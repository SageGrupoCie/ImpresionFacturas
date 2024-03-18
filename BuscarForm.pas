unit BuscarForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, {DBTables, }Buttons, ExtCtrls, ADODB,AdoConEd,
  BaseGrid, AdvGrid, DBAdvGrid, Menus, AdvMenus, ColCombo, AdvCombo,
  AdvEdit, AdvPanel, AdvUtil, AdvObj;

type
  TFormBuscar = class(TForm)
    Panel1: TPanel;
    DataSource1: TDataSource;
    TablaBusquedaAdo: TADOQuery;
    BitBtn2: TSpeedButton;
    BitBtn1: TSpeedButton;
    BitBtn3: TSpeedButton;
    BitBtn4: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Panel2: TPanel;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Label1: TLabel;
    QuiereOrdenDescendente: TCheckBox;
    TextoBuscar: TAdvEdit;
    Label4: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TextoBuscar2: TAdvEdit;
    Panel4: TPanel;
    DBAdvGrid2: TDBAdvGrid;
    TablaBusqueda: TADOQuery;
    Function BuscarSQLBDE(StrSqlquiere,NombreDeLaTabla,CadenaABuscar,
                       CampoDeLaBusqueda,CampoDelOrden,CampoDelCodigo,NombreBaseDatos:String;
                       MostrarSiempre,EnsenyaTextoBusqueda,OrdenDescendente,EsSoloTexto:Boolean;
                       Tabla:TDataSet;QuierePrecondicion:String):String;
    Function BuscarSQLADO(StrSqlquiere,NombreDeLaTabla,CadenaABuscar,
                       CampoDeLaBusqueda,CampoDelOrden,CampoDelCodigo:String;NombreBaseDatos:TADOConnection;
                       MostrarSiempre,EnsenyaTextoBusqueda,OrdenDescendente,EsSoloTexto:Boolean;
                       Tabla:TCustomADODataSet;QuierePrecondicion:String):String;

    procedure RellenaCamposOrdenBDE;
    procedure RellenaCamposOrdenAdo;
    procedure GrilBonito;
    procedure AbrirQuery(Tabla:TAdoQuery;SQL:string);
    Procedure Inicializar;
    procedure BitBtn3Click(Sender: TObject);
    procedure TextoBuscarChange(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SalirSeleccionando(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure QuiereOrdenDescendenteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TextoBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Click(Sender: TObject);
    procedure ComboBox3Click(Sender: TObject);
    procedure Grid1DblClick(Sender: TObject);
    procedure Foto2Click(Sender: TObject);
    procedure Salir2Click(Sender: TObject);
    procedure TextoBuscar2KeyPress(Sender: TObject; var Key: Char);
    procedure DBAdvGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure TextoBuscar2Change(Sender: TObject);
  private
    { Private declarations }
//    procedure MostrarPDA;

  public
    StrSql,StrSqlQuiereCliente,NombreTabla,CampoCodigo,CampoOrden,
    CampoBusqueda ,Resultado,Precondicion: String;
    mostrar,EnsenyaTexto,EsTexto,DiNoEsta : Boolean;

    { Public declarations }
  end;

var
  FormBuscar: TFormBuscar;
  SoyAdo,Escalado:Boolean;
  TamanyoX,TamanyoY :Integer;
implementation

uses funciones, FuncionesForm, AspectoForm;

{$R *.DFM}
//------------------------------------------------------------------------------
procedure TFormBuscar.RellenaCamposOrdenBDE;
var j : Integer;
begin
   ComboBox2.Items.Clear;
   for j := 0 to TablaBusqueda.FieldCount - 1 do
      ComboBox2.Items.Add(TablaBusqueda.Fields[j].FieldName);
   ComboBox2.ItemIndex:=0;
   ComboBox3.Items:=ComboBox2.Items;
   ComboBox3.ItemIndex:=0;
   ComboBox2.tag:=1;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.RellenaCamposOrdenAdo;
var j : Integer;
begin
   ComboBox2.Items.Clear;
   for j := 0 to TablaBusquedaAdo.FieldCount - 1 do
      ComboBox2.Items.Add(TablaBusquedaAdo.Fields[j].FieldName);
   ComboBox2.ItemIndex:=0;
   ComboBox3.Items:=ComboBox2.Items;
   ComboBox3.ItemIndex:=0;
   ComboBox2.tag:=1;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.GrilBonito;
//var i,Columnas :Integer;
begin
{  i:=0;  Columnas:=Grid1.Columns.Count;
  while (i<Columnas) do begin
     Grid1.Columns[i].Title.Font.Style:=[];
     Grid1.Columns[i].Title.Alignment := taCenter;

    if Grid1.Columns[i].Width >200
      then Grid1.Columns[i].Width:=160;
     i:=i+1;
  end;}
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.AbrirQuery(Tabla:TAdoQuery;SQL:string);
var nombre : string;
    Cancela :Boolean;
    Boton : Integer;
begin
  Cancela:=false;
  while not cancela do
  try
    Cancela:=True;   Nombre:=Tabla.Name;
    Tabla.close;     Tabla.SQL.Clear; Tabla.Sql.add(SQL); Tabla.open
    except on X:exception do begin
      Boton:=MessageDlgCIE('NO se pudo abrir '+nombre+' :'+#13+#13+X.message, mtError,
         [mbRetry, mbCancel], 1);
      if Boton = mrCancel
        then Cancela:=true
        else if Boton = mrAbort
           then Application.Terminate
           else Cancela:=False;
     end;
  end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.BitBtn3Click(Sender: TObject);
var BuscarPor,OrdenarPor,Cadena,Where:String;
    espe:Boolean;
    Registros:Integer;
    Comodin_:Char;
begin
  if TextoBuscar.tag=1 then exit;
  Timer1.Enabled:=False;
  Registros:=0;
  if SoyAdo=False
    then Comodin_:='*'
    else Comodin_:='%';

  if NombreTabla='' then
    begin
        MessageDlg('No sabemos en que Tabla Buscar', mtWarning,
      [mbOk], 0);
        Exit;
    end;
  Cadena:=TextoBuscar.Text;
  if Cadena='' then cadena:=Comodin_;
  Cadena:=Funciones.CambiarChar(cadena,'.',Comodin_);
  if (length(Cadena)>1) and (Cadena[1]=Comodin_)
    then espe:=true
    else Espe:=False;
  Cadena:=Funciones.QuitaCaracter(cadena,Comodin_);
  if Cadena='' then Espe:=true;

  if Espe then Cadena:=Comodin_+Cadena;
  Buscarpor :=CampoBusqueda;
  OrdenarPor:=CampoOrden;

  if StrSqlQuiereCliente<>''
    then StrSql:=StrSqlQuiereCliente
    else StrSql:='select '+NombreTabla+'.* from '+NombreTabla;

  if ComboBox2.text<>'' then Buscarpor :=ComboBox2.text;
  if ComboBox3.text<>'' then OrdenarPor:=ComboBox3.text;

  if SoyAdo
    then Cadena:=Funciones.CambiarChar(cadena,'*',Comodin_);
  Where:='';
  if (Buscarpor<> '') and (trim(TextoBuscar.TEXT) <> '')
    then begin
          if EsTexto
               then Where:=' WHERE ('+NombreTabla+'.'+
                            Buscarpor+' LIKE "'+Cadena+Comodin_+'") '
               else Where:=' WHERE ('+NombreTabla+'.'+
                            Buscarpor+' = '+Cadena+') ';
         end;
  if Precondicion<>''
    then Where:=Where+' AND '+Precondicion;

  StrSql:=StrSql+Where;

  if OrdenarPor<> ''
    then begin
           StrSql:=StrSql+' ORDER BY '+ OrdenarPor;
           if QuiereOrdenDescendente.Checked
               then StrSql:=StrSql+' Desc';
         end;
  try
    if SoyAdo=False
       then begin
              AbrirQuery(TablaBusqueda,StrSql);
              Registros:=TablaBusqueda.RecordCount;
            end
       else begin
              StrSQL:=FUNCIONES.CambiarSubCadena(StrSQL,'"','''');
              Funciones.AbrirAdo(TablaBusquedaAdo,StrSQL);
              Registros:=TablaBusquedaAdo.RecordCount;
            end;
  except
    StrSql:=Funciones.QuitaCaracter(StrSql,'"');
    if SoyAdo=False
       then begin
              AbrirQuery(TablaBusqueda,StrSql);
              Registros:=TablaBusqueda.RecordCount;
            end
       else begin
              Funciones.AbrirAdo(TablaBusquedaAdo,StrSQL);
              Registros:=TablaBusquedaAdo.RecordCount;
            end;
  end;
  if (Soyado=False) and  (Registros=1) and (mostrar = False)
    then  begin
              BitBtn2.Tag:=1;
              SalirSeleccionando(NIL);
              Exit;
          end;
  if (Soyado=True) and  (Registros=1) and (mostrar = False)
    then  begin
              BitBtn2.Tag:=1;
              SalirSeleccionando(NIL);
              Exit;
          end;

  if (Soyado=False) and  (Registros=0) and (mostrar = False)
    then  begin

              if DiNoEsta=True
                then begin
                      Beep;
                      MessageDlgCIE('No se encuentran registros con el texto "'+
                                   TextoBuscar.Text+'" al buscar en la tabla '+NombreTabla,
                                   mtError,[mbOk], 0);
                      end;                                   
              BitBtn1Click(NIL);
              BitBtn1.Tag:=1;
              Exit;
          end;
  if (Soyado=True) and  (Registros=0) and (mostrar = False)
    then  begin
              if DiNoEsta=True
                then begin
                       Beep;
                       MessageDlgCIE('No se encuentran registros con el texto "'+
                                   TextoBuscar.Text+'" al buscar en la tabla '+NombreTabla,
                                   mtError,[mbOk], 0);
                     end;
              BitBtn1Click(NIL);
              BitBtn1.Tag:=1;
              Exit;
          end;

 // if FormBuscar.Visible=False then FormBuscar.Showmodal;
  if (Soyado=True) and (ComboBox2.tag=0)
    then RellenaCamposOrdenADO
    else RellenaCamposOrdenBDE;
  ComboBox2.text:=Buscarpor;
  ComboBox3.text:=OrdenarPor;
  GrilBonito;
  FormBuscar.Caption := 'Buscar en la Tabla : '+NombreTabla+'.    '+
                        'Registros encontrados '+inttoStr(Registros);
  if ((Registros>1) or (mostrar ) ) and (FormBuscar.Visible=False)
    then FormBuscar.Showmodal;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.TextoBuscarChange(Sender: TObject);
begin
  Timer1.Enabled:=false;
  Timer1.Enabled:=True;//BitBtn3Click(NIL);BitBtn3Click(NIL);
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.ComboBox3Change(Sender: TObject);
begin
  BitBtn3Click(nil);
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.ComboBox2Change(Sender: TObject);
begin
  BitBtn3Click(nil);
end;
//------------------------------------------------------------------------------
Procedure TFormBuscar.Inicializar;
begin
  DBAdvGrid2.Align:= alclient;
  EnsenyaTexto    := False;
  BitBtn4.Top     := BitBtn1.Top;
  BitBtn4.Left    := Label2.Left;

  with FormAspecto do
    begin
     PonBoton(BitBtn2,Aceptar2,2,False,'C','I',False);
     PonBoton(BitBtn1,Cancelar2,2,False,'C','I',False);
     PonBoton(SpeedButton2,Aceptar2,2,True,'C','I',False);
     PonBoton(SpeedButton1,Cancelar2,2,True,'C','I',False);
     PonBoton(BitBtn4,Nil,1,False,'C','I',False);
    end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.FormCreate(Sender: TObject);
begin
  TamanyoX:= FormBuscar.Width;
  TamanyoY:= FormBuscar.Height;
  Escalado:= False;
  Panel4.Align:=alclient;
  Inicializar;
  Panel3.Visible:=False;
  DiNoEsta:=true;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.SalirSeleccionando(Sender: TObject);
begin
   Resultado:='';
   if (SoyAdo=False) and (CampoCodigo<>'') and (TablaBusqueda.RecordCount>0)
     then Resultado:= TablaBusqueda.FieldbyName(CampoCodigo).asString;
   if (SoyAdo) and (CampoCodigo<>'') and (TablaBusquedaAdo.RecordCount>0)
     then Resultado:= TablaBusquedaADO.FieldbyName(CampoCodigo).asString;
   ModalResult := mrOK;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.BitBtn1Click(Sender: TObject);
begin
  Resultado:='';
  ModalResult := mrCancel;
end;
//------------------------------------------------------------------------------
Function TFormBuscar.BuscarSQLBDE(StrSqlquiere,NombreDeLaTabla,CadenaaBuscar,
                       CampoDeLaBusqueda,CampoDelOrden,CampoDelCodigo,NombreBaseDatos:String;
                       MostrarSiempre,EnsenyaTextoBusqueda,OrdenDescendente,EsSoloTexto:Boolean;
                       Tabla:TDataSet;QuierePrecondicion:String):String;
//StrSqlquiere     = si queremos una sql determinada, es aconsejable--> + velocidad
//NombreTabla      = nombre de la tabla para construir el from
//Cadena           = Cadena a Buscar
//CampoBusqueda    = Campo por el que vamos a buscar
//CampoOrden       = si hay que mostrar, podremos poner orden
//Mostrar          = Si es false y sólo hay 1 registro que se salga
//QuierePrecondicion= si queremos una precondicion;
begin
  Label5.Caption:='*';
  Result:='';
  SoyAdo:=False;
  DataSource1.dataSet:=TablaBusqueda;
  if TablaBusqueda.Active then TablaBusqueda.Close;
//  TablaBusqueda.DatabaseName := NombreBaseDatos;
  StrSqlQuiereCliente:=StrSqlquiere;
  NombreTabla:=NombreDeLaTabla;
  TextoBuscar.tag:=1;
  TextoBuscar.TEXT:=CadenaaBuscar;
  CampoBusqueda:=CampoDeLaBusqueda;
  Precondicion:=QuierePrecondicion;
  CampoOrden:=CampoDelOrden;
  CampoCodigo:=CampoDelCodigo;
  Mostrar:=MostrarSiempre;
  EsTexto:=EsSoloTexto;
  QuiereOrdenDescendente.Checked:=OrdenDescendente;
  EnsenyaTexto:=EnsenyaTextoBusqueda;
 // FormBuscar.Showmodal;
  //-----------------
  BitBtn1.Tag:=0;
  BitBtn2.Tag:=0;
  BitBtn4.Visible:=not(EnsenyaTexto);
  Panel2.Visible:=not(BitBtn4.Visible);

  ComboBox2.text:=CampoBusqueda;
  ComboBox3.text:=CampoOrden;
  Resultado:='';
  TextoBuscar.tag:=0;
  EsTexto:=EsSoloTexto;
  Mostrar:=MostrarSiempre;
  BitBtn3Click(nil);
  //------------------------
  if (Resultado <> '')
    then if Tabla<>nil
              then if Tabla.Locate(CampoCodigo,Resultado,[])
                      then Result:=Tabla.fieldbyname(Campocodigo).asString
                      else Result:=''
              else Result:=Tabla.fieldbyname(Campocodigo).asString;
  close;
end;
//------------------------------------------------------------------------------
Function TFormBuscar.BuscarSQLADO(StrSqlquiere,NombreDeLaTabla,CadenaaBuscar,
                       CampoDeLaBusqueda,CampoDelOrden,CampoDelCodigo:String;NombreBaseDatos:TADOConnection;
                       MostrarSiempre,EnsenyaTextoBusqueda,OrdenDescendente,EsSoloTexto:Boolean;
                       Tabla:TCustomADODataSet;QuierePrecondicion:String):String;
//StrSqlquiere     = si queremos una sql determinada, es aconsejable--> + velocidad
//NombreTabla      = nombre de la tabla para construir el from
//Cadena           = Cadena a Buscar
//CampoBusqueda    = Campo por el que vamos a buscar
//CampoOrden       = si hay que mostrar, podremos poner orden
//Mostrar          = Si es false y sólo hay 1 registro que se salga
//QuierePrecondicion= si queremos una precondicion;
begin
  Label5.Caption:='%';
  Result:='';
  SoyAdo:=True;
  DataSource1.dataSet:=TablaBusquedaAdo;
  if TablaBusquedaAdo.Active then TablaBusquedaAdo.Close;
  TablaBusquedaAdo.Connection:=NombreBaseDatos;
  StrSqlQuiereCliente:=StrSqlquiere;
  NombreTabla:=NombreDeLaTabla;
  TextoBuscar.tag:=1;
  TextoBuscar.TEXT:=CadenaaBuscar;
  CampoBusqueda:=CampoDeLaBusqueda;
  Precondicion:=QuierePrecondicion;
  CampoOrden:=CampoDelOrden;
  CampoCodigo:=CampoDelCodigo;
  Mostrar:=MostrarSiempre;
  EsTexto:=EsSoloTexto;
  QuiereOrdenDescendente.Checked:=OrdenDescendente;
  EnsenyaTexto:=EnsenyaTextoBusqueda;
 // FormBuscar.Showmodal;
  //-----------------
  BitBtn1.Tag:=0;                                                
  BitBtn2.Tag:=0;
  BitBtn4.Visible:=not(EnsenyaTexto);
  Panel2.Visible:=not(BitBtn4.Visible);

  ComboBox2.text:=CampoBusqueda;
  ComboBox3.text:=CampoOrden;
  Resultado:='';
  TextoBuscar.tag:=0;
  EsTexto:=EsSoloTexto;
  Mostrar:=MostrarSiempre;
  BitBtn3Click(nil);
  //------------------------
  if (Resultado <> '')
    then if Tabla<>nil
              then if Tabla.Locate(CampoCodigo,Resultado,[])
                      then Result:=Tabla.fieldbyname(Campocodigo).asString
                      else Result:=Resultado
              else Result:=Resultado;//Tabla.fieldbyname(Campocodigo).asString;
  close;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.BitBtn4Click(Sender: TObject);
begin
  BitBtn4.Visible:=False;
  Panel2.Visible:=not(BitBtn4.Visible);
  TextoBuscar.SetFocus;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.FormPaint(Sender: TObject);
begin
  if BitBtn1.Tag= 1
    then BitBtn1Click(nil);
  if BitBtn2.Tag= 1
    then SalirSeleccionando(nil)
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.QuiereOrdenDescendenteClick(Sender: TObject);
begin   Mostrar:=True; TextoBuscarChange(NIL); end;
//------------------------------------------------------------------------------
procedure TFormBuscar.FormShow(Sender: TObject);
begin
  FormAspecto.PonPanel(Panel1);
  panel1.Color       :=FormAspecto.ColorBase2.color;
  FormBuscar.Color   :=FormAspecto.ColorBase.color;
  panel3.Color       :=FormAspecto.ColorBase2.color;
  if FormAspecto.EstiloTServer
    then begin
           FormBuscar.Color  :=FormAspecto.ColorCIETServer.Color;
           Panel1.Color      :=FormAspecto.ColorCIETServer.Color;
           Panel3.color :=panel1.color;
         end;
  Panel2.color :=panel3.color;
  FormAspecto.PonEstiloGridAdv(DBAdvGrid2,true,true,False);
  if FormAspecto.EstamosEnPDAs
   then begin
          FormBuscar.WindowState:= wsMaximized;
          Panel3.Visible    := True;//Botones PDA
          Panel1.Visible    := False;//Botonoes Standar
          TextoBuscar2.Text := '';
          TamanyoX          := FormBuscar.Width;
          TamanyoY          := FormBuscar.Height;
          if (Escalado=False) and
             (FuncionesForm.AdaptarResolucion(FormBuscar,10,10,TamanyoX+160,TamanyoY))
              then Escalado:=True;
          TextoBuscar2.SetFocus;
        end
   else begin
          FormBuscar.WindowState:= wsNormal;
          Panel3.Visible    := False;//Botones PDA
          Panel1.Visible    := True;//Botonoes Standar
          Panel4.Align      :=alclient;
          DBAdvGrid2.SetFocus;
          Escalado          := False;
          ComboBox2.tag     := 0;
          TamanyoX          := trunc(screen.Width*2/3);
          TamanyoY          := trunc(screen.Height*2/3)-20;
          FormBuscar.Width  := TamanyoX;
          FormBuscar.Height := TamanyoY;
          Funciones.CentrarObjeto(FormBuscar);
        end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.TextoBuscarKeyPress(Sender: TObject; var Key: Char);
begin  Mostrar:=True; end;
//------------------------------------------------------------------------------
procedure TFormBuscar.ComboBox2Click(Sender: TObject);
begin   Mostrar:=True; end;
//------------------------------------------------------------------------------
procedure TFormBuscar.ComboBox3Click(Sender: TObject);
begin  Mostrar:=True; end;
//------------------------------------------------------------------------------
procedure TFormBuscar.Grid1DblClick(Sender: TObject);
begin SalirSeleccionando(nil); end;
//------------------------------------------------------------------------------
procedure TFormBuscar.Foto2Click(Sender: TObject);
begin

end;
//------------------------------------------------------------------------------
procedure TFormBuscar.Salir2Click(Sender: TObject);
begin

end;
//------------------------------------------------------------------------------
procedure TFormBuscar.TextoBuscar2KeyPress(Sender: TObject; var Key: Char);
begin
  IF key = #13 Then
  begin
    SalirSeleccionando(nil);
    exit;
  end;
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.DBAdvGrid2KeyPress(Sender: TObject; var Key: Char);
begin if Key=#13 then SalirSeleccionando(NIl); end;
//------------------------------------------------------------------------------
procedure TFormBuscar.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  BitBtn3Click(NIL);
end;
//------------------------------------------------------------------------------
procedure TFormBuscar.TextoBuscar2Change(Sender: TObject);
begin
  TextoBuscar.Text:=TextoBuscar2.Text;
end;

end.
