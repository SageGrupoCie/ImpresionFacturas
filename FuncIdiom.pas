unit FuncIdiom;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, Buttons, Grids, CheckLst, AdvPanel, AdvGrid,
  ComCtrls, ToolWin, DBGrids, typinfo, DBCtrls, funciones, AdvPageControl, DBAdvNavigator,
  {Chart, }DBAdvGrid, ADODB,DB;//,DBTables;
const
  letras = ['A'..'Z', 'á', 'é', 'í', 'ó', 'ú', 'Ñ', 'a'..'z', 'ñ', 'Á', 'É', 'Í', 'Ó', 'Ú', ' '];
  simbolos = ['&', '¿', '.', ',', '%', '@', '_', '?'];
  simbolosHTML = ['&', '<', '>', '/', '\', '=', '"'];
  Numeros = ['0'..'9'];

procedure TraduceForm(Clase: string);
procedure TrataComponentes(Componente: TComponent);
procedure TraduceMenu(OpcionMenu: TMenuItem);
function Traduce(Linea: string): string;
function Traduc(sLinea: string): string;
procedure TrataHint(Componente: TComponent);
procedure PasaCastellano(Clase: string);
function RecupCastellano(Palabra: string): string;

procedure IniciIdioma(Idioma: Integer; const TRADUCEIZQ, TRADUCEDRC: string; Tabla: TADOQuery);

implementation
//uses ConstantesForm;

var _OldIdioma: shortint;
  _IDIOMA: Integer;
  _TRADUCEIZQ, _TRADUCEDRC, _Formulario, _Componente: string;
  TablaIdioma: TAdoQuery;                                   
  _Resaltar: Boolean;

procedure TraduceForm(Clase: string);
var
  Formulario: Tform;
  i: integer;
  //Pantalla, pantalla2: HWND;
  Buffer: array[0..60] of char;
  sAnfitrion: string;
  FormAnfitrion: TForm;

begin
//
//  // Obtencion del Anfitrion
//
//  Pantalla := GetForegroundWindow;
//  GetClassName(Pantalla, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla := GetFocus;
//  GetClassName(Pantalla, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla := GetDesktopWindow;
//  GetClassName(Pantalla, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla := GetActiveWindow;
//  GetClassName(Pantalla, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla:=GetTopWindow(Pantalla);
//
//  Pantalla2:=GetNextwindow(Pantalla,GW_HWNDPREV);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla := GetActiveWindow;
//
//
//  Pantalla2:=GetNextwindow(Pantalla,GW_HWNDPREV);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//  Pantalla2:=GetNextwindow(Pantalla2,GW_HWNDPREV);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//  Pantalla2:=GetNextwindow(Pantalla2,GW_HWNDPREV);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//  Pantalla2:=GetNextwindow(Pantalla2,GW_HWNDPREV);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//  Pantalla := GetActiveWindow;
//
//  Pantalla2:=Getwindow(Pantalla,GW_HWNDNEXT);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla2:=Getwindow(Pantalla,GW_HWNDLAST);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla2:=Getwindow(Pantalla,GW_HWNDFIRST);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla2:=Getwindow(Pantalla,GW_HWNDPREV);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla2:=Getwindow(Pantalla,GW_OWNER);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  Pantalla2:=Getwindow(Pantalla,GW_CHILD);
//  GetClassName(Pantalla2, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//  GetClassName(Application.DialogHandle, Buffer, 60);
//  sAnfitrion := Trim(string(Buffer));
//
//
//
//
//
  if (_IDIOMA = -1) or (TablaIdioma = nil) then exit;
//  // Obtencion del Anfitrion
//    Pantalla := GetActiveWindow;
//    GetClassName(Pantalla, Buffer, 60);
//    sAnfitrion := Trim(string(Buffer));
//    sAnfitrion := copy(sAnfitrion, 2, length(sAnfitrion) - 1);
//    FormAnfitrion:=Application.FindComponent(sAnfitrion) as TForm;
////

  _Formulario := Clase;
  Formulario := Application.FindComponent(Clase) as TForm;
  Formulario.Caption := Traduce(Formulario.Caption);
  for i := 0 to Formulario.ComponentCount - 1 do
  begin
    TrataComponentes(Formulario.Components[i]);
  end;
  _Formulario := '';
end;

procedure TrataComponentes(Componente: TComponent);
var
  i, j: integer;
  Aux: string;
  PropInfo: PPropInfo;
begin
  try
    PropInfo := GetPropInfo(Componente.ClassInfo, 'HelpContext');
//    if (not Assigned(PropInfo))
//    and not (Componente is TMainMenu)
//      and not (Componente is TPopUpMenu)
//    then exit;
    if Assigned(PropInfo) then
      if TWinControl(Componente).HelpContext = -2 then exit; // no traduce los componentes del contenedor marcado a -2
    for i := 0 to Componente.ComponentCount - 1 do
    begin
      TrataComponentes(Componente.Components[i]); //recursividad
    end;
    if Assigned(PropInfo) then
      if TWinControl(Componente).HelpContext = -1 then exit; // no traduce el componente marcado a -1
// trata los caption y similares
    _Componente := TComponent(Componente).Name;
    if (Componente is TLabel)
      or (Componente is TRadioButton)
      or (Componente is TDBRadioGroup)
      or (Componente is TCheckBox)
      or (Componente is TDBCheckBox)
      or (Componente is TButton)
      or (Componente is TToolButton)
      or (Componente is TGroupBox)
      or (Componente is TPanel)
      or (Componente is TSpeedButton)
      or (Componente is TBitBtn)
      or (Componente is TStaticText) then
    begin
      TLabel(Componente).Caption := Traduce(TLabel(Componente).Caption);
      if _Resaltar = True then TLabel(Componente).Font.Color := clRed;
    end;
//
    if Componente is TAdvPanel then
    begin
      TAdvPanel(Componente).Caption.Text := Traduce(TAdvPanel(Componente).Caption.Text);
      if _Resaltar = True then TAdvPanel(Componente).Caption.Font.Color := clRed;
    end;
//
    if Componente is TAdvPanelGroup then
    begin
      for j := 0 to TAdvPanelGroup(Componente).ComponentCount - 1 do
      begin
        TrataComponentes(TAdvPanelGroup(Componente).Components[j]); //recursividad
      end;
    end;
//
//
//    if Componente is TChart then
//    begin
//      for j := 0 to TChart(Componente).Title.Text.Count - 1 do
//      begin
//        TChart(Componente).Title.Text.Strings[j] := Traduce(TChart(Componente).Title.Text.Strings[j]);
//        if _Resaltar = True then TChart(Componente).Title.Font.Color := clRed;
//      end;
//      for j := 0 to TChart(Componente).SeriesList.Count - 1 do
//      begin
//        TChart(Componente).SeriesList.Series[j].Title := Traduce(TChart(Componente).SeriesList.Series[j].Title);
//        if _Resaltar = True then TChart(Componente).SeriesList.Series[j].SeriesColor := clRed;
//      end;
//    end;


//
    if (Componente is TLabeledEdit) then
    begin
      TLabeledEdit(Componente).EditLabel.Caption := Traduce(TLabeledEdit(Componente).EditLabel.Caption);
      if _Resaltar = True then TLabeledEdit(Componente).Font.Color := clRed;
    end;
//
    if (Componente is TMainMenu)
      or (Componente is TPopUpMenu) then
      for J := 0 to TMainMenu(Componente).Items.Count - 1 do
      begin
        TraduceMenu(TMainMenu(Componente).Items[j]);
        TMainMenu(Componente).Items[j].Caption := Traduce(TMainMenu(Componente).Items[j].Caption);
//      if _Resaltar=True then TMainMenu(Componente).Color := clRed;

      end;
//
    if (Componente is TListBox)
      or (Componente is TCheckListBox) then
      for j := 0 to TListBox(Componente).Items.Count - 1 do
      begin
        TListBox(Componente).Items.Strings[j] := Traduce(TListBox(Componente).Items.Strings[j]);
        if _Resaltar = True then TListBox(Componente).Font.Color := clRed;
      end;
//
    if Componente is TComboBox then
    begin
      Aux := TComboBox(Componente).text;
      for j := 0 to TComboBox(Componente).Items.Count - 1 do
      begin
        TComboBox(Componente).Items.Strings[j] := Traduce(TComboBox(Componente).Items.Strings[j]);
        if _Resaltar = True then TComboBox(Componente).Font.Color := clRed;
      end;
      TComboBox(Componente).text := Traduce(Aux);
      if _Resaltar = True then TComboBox(Componente).Font.Color := clRed;

    end;
//  Anulado por incapacidad de tratar este componente
{   if Componente      is TComboBoxEx then
      begin
         TComboBoxEx(Componente).text:=Traduce(TComboBoxEx(Componente).text);
               // a continuación esto falla. Cuando se intenta actualizar el primero da un error de memoria
         for j:=0 to TComboBoxEx(Componente).Items.Count -1 do
      end;}
//
    if Componente is TRadioGroup then
    begin
      TRadioGroup(Componente).caption := Traduce(TRadioGroup(Componente).caption);
      if _Resaltar = True then TRadioGroup(Componente).Font.Color := clRed;
      for j := 0 to TRadioGroup(Componente).Items.Count - 1 do
        TRadioGroup(Componente).Items.Strings[j] := Traduce(TRadioGroup(Componente).Items.Strings[j]);
    end;
//
    if Componente is TStringGrid then
    begin
      if TStringGrid(Componente).fixedCols = 1 then
        for J := 0 to TStringGrid(Componente).ColCount - 1 do
        begin
          TStringGrid(Componente).Cells[J, 0] := Traduce(TStringGrid(Componente).Cells[J, 0]);
          if _Resaltar = True then TStringGrid(Componente).Font.Color := clRed;
        end;
      if TStringGrid(Componente).fixedRows = 1 then
        for J := 1 to TStringGrid(Componente).ColCount - 1 do
        begin
          TStringGrid(Componente).Cells[0, J] := Traduce(TStringGrid(Componente).Cells[0, J]);
          if _Resaltar = True then TStringGrid(Componente).Font.Color := clRed;
        end;
    end;
//
    if (Componente is TDBGrid) then
      if TDBGrid(Componente).Columns <> nil then
        for J := 0 to TDBGrid(Componente).Columns.Count - 1 do
        begin
          TDBGrid(Componente).Columns[j].Title.Caption := Traduce(TDBGrid(Componente).Columns[j].Title.Caption);
          if _Resaltar = True then TDBGrid(Componente).Font.Color := clRed;
        end;
// ojo con no utilizar el campo header, porque por defecto trae el nombre del campo en BD y obviamente no lo traduce
    if (Componente is TDBAdvGrid) then
      if TDBAdvGrid(Componente).Columns <> nil then
        for J := 0 to TDBAdvGrid(Componente).Columns.Count - 1 do
        begin
          TDBAdvGrid(Componente).Columns[j].Header := Traduce(TDBAdvGrid(Componente).Columns[j].Header);
          if _Resaltar = True then TDBAdvGrid(Componente).Font.Color := clRed;
        end;

//
    if (Componente is TPageControl)
      or (Componente is TAdvPageControl)
      then
      for j := 0 to TPageControl(Componente).PageCount - 1 do
      begin
        TPageControl(Componente).Pages[j].Caption := Traduce(TPageControl(Componente).Pages[j].Caption);
        if _Resaltar = True then TPageControl(Componente).Font.Color := clRed;
      end;
//
    if Componente is TTabControl then
      for j := 0 to TTabControl(Componente).Tabs.Count - 1 do
      begin
        TTabControl(Componente).Tabs[j] := Traduce(TTabControl(Componente).Tabs[j]);
        if _Resaltar = True then TTabControl(Componente).Font.Color := clRed;
      end;
//
    if Componente is TTreeView then
      for j := 0 to TTreeView(Componente).Items.Count - 1 do
      begin
        TTreeView(Componente).Items[j].Text := Traduce(TTreeView(Componente).Items[j].Text);
        if _Resaltar = True then TTreeView(Componente).Font.Color := clRed;
      end;
//
    if Componente is TListView then
      for j := 0 to TListView(Componente).Columns.Count - 1 do
      begin
        TListView(Componente).Columns[j].Caption := Traduce(TListView(Componente).Columns[j].Caption);
        if _Resaltar = True then TListView(Componente).Font.Color := clRed;
      end;
//
    if Componente is TStatusBar then
      for j := 0 to TStatusBar(Componente).Panels.Count - 1 do
      begin
        TStatusBar(Componente).Panels[j].Text := Traduce(TStatusBar(Componente).Panels[j].Text);
        if _Resaltar = True then TStatusBar(Componente).Font.Color := clRed;
      end;



//------------------------------------------------------------------
// trata los Hint
    TrataHint(Componente);
  except on X:exception do begin

    MessageDlg(X.message+' Error traducción (nmbr):'+TControl(Componente).name, mtWarning, [mbOK], 0);
    MessageDlg('Error traducción (hlpctx):'+IntToStr(TWinControl(Componente).HelpContext), mtWarning, [mbOK], 0);
  end;
  end;
end;

procedure TraduceMenu(OpcionMenu: TMenuItem);
var
  z: integer;
begin

  for Z := 0 to OpcionMenu.Count - 1 do
  begin
    TraduceMenu(OpcionMenu.Items[z]); // recursividad
    OpcionMenu.Items[z].Caption := Traduce(OpcionMenu.Items[z].Caption);
    TrataHint(OpcionMenu.Items[z])
  end;
end;

function Traduce(Linea: string): string;
var
  Aux: string;
  i: Integer;
  lTraducir, lFinPalabra, lHayHTML: Boolean;
begin
  Result := ''; Aux := '';
  lTraducir := False; lFinPalabra := False; lHayHTML := False;

  if Pos(_TRADUCEIZQ, Linea) > 0 then
  begin
    if (_IDIOMA = -1) or (TablaIdioma = nil) then
    begin
      Linea:=StringReplace(Linea, _TRADUCEIZQ, '', [rfReplaceAll]);
      Linea:=StringReplace(Linea, _TRADUCEDRC, '', [rfReplaceAll]);
      Result := Linea;
      exit;
    end;
  if (pos('<', Linea) > 0) and (pos('>', Linea) > 0)
    then lHayHTML := True;
    
    i := 1;
    while i <= length(Linea) do
    begin
      if Linea[i] = _TRADUCEIZQ then
      begin
        lTraducir := True;
        lFinPalabra := True;
      end
      else
        if (Linea[i] = _TRADUCEDRC) or (i = length(Linea)) then
        begin
          lTraducir := False;
          lFinPalabra := True;
          if (i = length(Linea)) and (Linea[i] <> _TRADUCEDRC) then Aux := Aux + Linea[i];
        end
        else Aux := Aux + Linea[i];
      if lFinPalabra then
      begin
        if lTraducir then Result := Result + Traduce(Aux) else Result := Result + Aux;
        lFinPalabra := False;
        Aux := '';
      end;
      inc(i);
    end;
  end
  else
  begin
    if (_IDIOMA = -1) or (TablaIdioma = nil) then
    begin
      Result := Linea;
      exit;
    end;
    i := 1;
    while i <= length(Linea) do
    begin

      if (Linea[i] in letras)
        or (Linea[i] in Simbolos)
        or ((Linea[i] in SimbolosHTML) and lHayHTML) then
      begin
        Aux := Aux + Linea[i];
        if (i = length(Linea))
          then Result := Result + Traduc(Aux);
      end;

      if not ((Linea[i] in letras) or (Linea[i] in Simbolos) or ((Linea[i] in SimbolosHTML) and lHayHTML)) then
      begin
        if (i > 1)
          and (((Linea[i - 1] in SimbolosHTML) and (lHayHTML))
          or (Linea[i - 1] in Simbolos)
          or (Linea[i - 1] in letras))
          then
        begin
          Result := Result + Traduc(Aux);
          Aux := '';
        end;
        Result := Result + Linea[i];
      end;
      Inc(i);
    end;
  end;
end;


function Traduc(sLinea: string): string;
var
  i: integer;
  sDelante, sDetras, sTexto: string;
  lHayHTML, lHayEspacio: Boolean;

begin
  if (_IDIOMA = -1) or (Trim(sLinea) = '') then
  begin
    Result := sLinea;
    exit;
  end;
  lHayHTML := False;
  if sLinea[1] = ' ' then lHayEspacio := True else lHayEspacio := False;
  sLinea := Trim(sLinea);

  sDetras := ''; sDelante := ''; sTexto := '';
  //Quita HTML
  if (sLinea <> '') and (sLinea[1] = '<') and (pos('>', sLinea) > 0) then
  begin
    i := 1;
    lHayHTML := True;
    while (slinea[i] <> '>') or (sLinea[i + 1] = '<') do
    begin
      sDelante := sDelante + sLinea[i];
      inc(i);
    end;

    if (slinea[i] = '>') and ((sLinea[i + 1] in letras) or (sLinea[i + 1] in numeros) or (sLinea[i + 1] in Simbolos)) then
    begin
      sDelante := sDelante + sLinea[i];
      inc(i);
      while ((sLinea[i] in letras) or (sLinea[i] in numeros)) and (i <= length(sLinea)) do
      begin
        sTexto := sTexto + sLinea[i];
        inc(i);
      end;
    end;
    if i <= length(sLinea) then
    begin
      sDetras := sDetras + sLinea[i];
      inc(i);
    end;
    while i <= length(sLinea) do
    begin
      sDetras := sDetras + sLinea[i];
      inc(i);
    end;
    sLinea := sTexto;
  end; // fin quitar HTML

// limpiar 'salto línea'
  sLinea := StringReplace(sLinea, #13, '#13', [rfReplaceAll]);

  //

  if (sLinea = '') or not ((sLinea[1] in letras) or (sLinea[1] in numeros) or (sLinea[1] = '&')) then // no tratamos blancos ni si empieza por caracteres raros, menos el &
  begin
    Result := sLinea;
    exit;
  end;
  _Resaltar := False;
  if _IDIOMA <> 0 then
  begin
    try
      if TablaIdioma.Locate('CLAVE', copy(sLinea, 1, 30), [])
        then // lo ha encontrado
      begin
        case _IDIOMA of
          0: Result := TablaIdioma.FieldByName('Castellano').value;
          1: Result := TablaIdioma.FieldByName('Valenciano').value;
          2: Result := TablaIdioma.FieldByName('Catalan').value;
          3: Result := TablaIdioma.FieldByName('Gallego').value;
          4: Result := TablaIdioma.FieldByName('Vasco').value;
          5: Result := TablaIdioma.FieldByName('Portugues').value;
          6: Result := TablaIdioma.FieldByName('Frances').value;
          7: Result := TablaIdioma.FieldByName('Ingles').value;
          8: Result := TablaIdioma.FieldByName('Italiano').value;
          9: Result := TablaIdioma.FieldByName('Otros').value;
        end;
        _Resaltar := TablaIdioma.FieldByName('Resaltar').value;
      end
      else
      begin // no lo encuentra
        if Trim(_Formulario) = '' then
          _Formulario := '<Funcion Traduce>';

        TablaIdioma.Insert;
        TablaIdioma.FieldByName('Clave').value := copy(sLinea, 1, 30);
        TablaIdioma.FieldByName('Castellano').value := sLinea;
//      FormConstantes.TablaIdiomaValenciano.value := '@' + sLinea;
        TablaIdioma.FieldByName('Valenciano').value := sLinea + 'V'; //copy(sLinea, 1, Length(sLinea) - 1) + #183;
        TablaIdioma.FieldByName('Catalan').value := sLinea + 'C';
        TablaIdioma.FieldByName('Gallego').value := sLinea + 'G';
        TablaIdioma.FieldByName('Vasco').value := sLinea + 'K';
        TablaIdioma.FieldByName('Portugues').value := sLinea + 'P';
        TablaIdioma.FieldByName('Frances').value := sLinea + 'F';
        TablaIdioma.FieldByName('Ingles').value := sLinea + 'I';
        TablaIdioma.FieldByName('Italiano').value := sLinea + 'T';
        TablaIdioma.FieldByName('Otros').value := sLinea + 'O';


        TablaIdioma.FieldByName('Formulario').value := _Formulario;
        TablaIdioma.FieldByName('Resaltar').value := False;
        if trim(_Componente) = '' then _Componente := '<En codigo>';
        TablaIdioma.FieldByName('Componente').value := _Componente;
        TablaIdioma.Post;
        Result := sLinea;
      end;
      except
//        on E: EDbEngineError do
//        begin
//        MessageDlg(Format('%s.', [E.Message])+#13+'El literal es: '+#13+sLinea+'('+IntToStr(length(sLinea))+')', mtWarning, [mbOK], 0);
//        TablaIdioma.Cancel;
//        Result:='';
//        end;
        on E: EDataBaseError do
        begin
        MessageDlg(Format('%s.', [E.Message])+#13+'El literal es: '+#13+sLinea+'('+IntToStr(length(sLinea))+')', mtWarning, [mbOK], 0);
        TablaIdioma.Cancel;
        Result:='';
        end;
      end;
    end
  else
  begin
    case _OldIdioma of
      1: TablaIdioma.Locate('Valenciano', sLinea, []);
      2: TablaIdioma.Locate('Catalan', sLinea, []);
      3: TablaIdioma.Locate('Gallego', sLinea, []);
      4: TablaIdioma.Locate('Vasco', sLinea, []);
      5: TablaIdioma.Locate('Portugues', sLinea, []);
      6: TablaIdioma.Locate('Frances', sLinea, []);
      7: TablaIdioma.Locate('Ingles', sLinea, []);
      8: TablaIdioma.Locate('Italiano', sLinea, []);
      9: TablaIdioma.Locate('Otros', sLinea, []);
    end;
    Result := TablaIdioma.FieldByName('Castellano').value;
  end;

// repone html
  if lHayHTML then Result := sDelante + Result + sDetras;
// reponer 'Espacio por delante'
  if lHayEspacio then result := ' ' + Result;
// reponer 'salto línea'
  Result := StringReplace(Result, '#13', #13, [rfReplaceAll]);

end;


procedure TrataHint(Componente: TComponent);
var
  PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(Componente.ClassInfo, 'ShowHint');
  if Assigned(PropInfo) then
    if Tcontrol(Componente).ShowHint = True then
      Tcontrol(Componente).Hint := Traduce(Tcontrol(Componente).Hint);
end;
//------------------------------------------------------------------------------------

procedure PasaCastellano(Clase: string);
begin
  if TablaIdioma = nil then exit;
  _OldIdioma := _Idioma;
  _IDIOMA := 0;
  TraduceForm(Clase);
  _IDIOMA := _OldIdioma;
end;

function RecupCastellano(Palabra: string): string;
begin
  if TablaIdioma = nil then exit;
  _OldIdioma := _Idioma;
  _IDIOMA := 0;
  Result := Traduce(Palabra);
  _IDIOMA := _OldIdioma;
end;

procedure IniciIdioma(Idioma: Integer; const TRADUCEIZQ, TRADUCEDRC: string; Tabla: TAdoQuery);
begin
  _IDIOMA := Idioma;
  if Idioma=0 then
  begin
  MessageDlg('Idioma 0 en IniciIdioma', mtWarning, [mbOK], 0);
  Idioma:=-1;
  end;
  if Trim(TRADUCEIZQ) <> '' then _TRADUCEIZQ := TRADUCEIZQ; // No traduce los que este entre
  if Trim(TRADUCEDRC) <> '' then _TRADUCEDRC := TRADUCEDRC; // estos dos caracteres ej: numeros variables dentro de un literal
  if Tabla <> nil then TablaIdioma := Tabla;
end;

end.

