unit TxtDatasetForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFormTxtDataset = class(TForm)
    NomFic: TEdit;
    DirIn: TEdit;
    DirOut: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Separador: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    CbAccionFic: TComboBox;
    BitBtn1: TSpeedButton;
    BitBtn2: TSpeedButton;
    CkConCabecera: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    Pulsado:String;
  end;

var
  FormTxtDataset: TFormTxtDataset;

implementation

{$R *.dfm}

procedure TFormTxtDataset.BitBtn1Click(Sender: TObject);
begin
Pulsado:='Ok';
end;

procedure TFormTxtDataset.BitBtn2Click(Sender: TObject);
begin
Pulsado:='Cancel';
end;

end.
