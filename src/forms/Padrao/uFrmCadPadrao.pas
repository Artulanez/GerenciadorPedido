unit uFrmCadPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Data.DB,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFrmCadPadrao = class(TFrmPadrao)
    PanelBotoes: TPanel;
    PanelSave: TPanel;
    ImgAdd: TImage;
    PanelSair: TPanel;
    ImgSair: TImage;
    dsDados: TDataSource;
    procedure ImgAddClick(Sender: TObject);
    procedure ImgSairClick(Sender: TObject);
    procedure ImgSairMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgSairMouseLeave(Sender: TObject);
    procedure ImgSairMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    function  ValidaCadastro: Boolean; Virtual; Abstract;
    procedure SalvaCadastro; Virtual; Abstract;
    procedure PreencheDados; Virtual; Abstract;
  end;

var
  FrmCadPadrao: TFrmCadPadrao;

implementation

{$R *.dfm}

procedure TFrmCadPadrao.ImgAddClick(Sender: TObject);
begin
  inherited;
  if ValidaCadastro then
  begin
    SalvaCadastro;
    inherited;
    case Botao of
      btInserir, btAlterar: Close;
    end;
  end;
end;

procedure TFrmCadPadrao.ImgSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadPadrao.ImgSairMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := $009F9F9F; //clAqua;
end;

procedure TFrmCadPadrao.ImgSairMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := clBtnFace; //clLime;
end;

procedure TFrmCadPadrao.ImgSairMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := $00CDCDCD; //clGreen;
end;

end.
