unit uFrmListPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Data.FMTBcd, Data.SqlExpr,
  Datasnap.DBClient, Datasnap.Provider, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmlistPadrao = class(TFrmPadrao)
    PanelBotoes: TPanel;
    PanelAdd: TPanel;
    ImgAdd: TImage;
    PanelEdit: TPanel;
    ImgEdit: TImage;
    PanelExc: TPanel;
    ImgExc: TImage;
    PanelSair: TPanel;
    ImgSair: TImage;
    PanelFiltro: TPanel;
    PanelGrid: TPanel;
    dsDados: TDataSource;
    BtnFiltrar: TBitBtn;
    SQLQuery: TFDQuery;
    procedure ImgAddClick(Sender: TObject);
    procedure ImgEditClick(Sender: TObject);
    procedure ImgExcClick(Sender: TObject);
    procedure ImgSairClick(Sender: TObject);

    procedure AtualizaDadosGrid(Sender : TObject); Virtual; Abstract;
    procedure ImgAddMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgAddMouseLeave(Sender: TObject);
    procedure ImgAddMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ChamaMnt; Virtual;Abstract;
  end;

var
  frmlistPadrao: TfrmlistPadrao;

implementation

{$R *.dfm}

procedure TfrmlistPadrao.ImgAddClick(Sender: TObject);
begin
  inherited;
  Botao := btInserir;
  ChamaMnt;

  AtualizaDadosGrid(Sender);
end;

procedure TfrmlistPadrao.ImgAddMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := $009F9F9F; //clAqua;;
end;

procedure TfrmlistPadrao.ImgAddMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := clBtnFace; //clLime;
end;

procedure TfrmlistPadrao.ImgAddMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := $00CDCDCD; //clGreen;
end;

procedure TfrmlistPadrao.ImgEditClick(Sender: TObject);
begin
  inherited;
  if not dsDados.DataSet.IsEmpty then
  begin
    Botao := btAlterar;
    ChamaMnt;

    AtualizaDadosGrid(Sender);

//    dsDados.DataSet.Bookmark := sBookMark;
  end
  else
    MessageDlg('Não existem dados para Alteração.'+#13+msgErroAdm,mtInformation, [mbOk],0);
end;

procedure TfrmlistPadrao.ImgExcClick(Sender: TObject);
begin
  inherited;
  if not dsDados.DataSet.IsEmpty then
  begin
    Botao := btExcluir;
  end
  else
    MessageDlg('Não existem dados para Exclusão.', mtError,[mbOK],0);
end;

procedure TfrmlistPadrao.ImgSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
