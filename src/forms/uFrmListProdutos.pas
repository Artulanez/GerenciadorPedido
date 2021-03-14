unit uFrmListProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmListPadrao, Data.FMTBcd,
  Data.SqlExpr, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Datasnap.DBClient, Datasnap.Provider, Vcl.Grids, uProduto, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uFrmCadProduto;

type
  TFrmListProdutos = class(TfrmlistPadrao)
    DBGrid1: TDBGrid;
    edtCodigo: TEdit;
    Label1: TLabel;
    SQLQueryCOD_PRODUTO: TStringField;
    SQLQueryDESCRICAO: TStringField;
    SQLQueryPRECO: TCurrencyField;
    procedure FormCreate(Sender: TObject);

    procedure AtualizaDadosGrid(Sender : TObject); Override;
    procedure ImgExcClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Produto : TProduto;
    procedure ChamaMnt; Override;
  end;

var
  FrmListProdutos: TFrmListProdutos;

implementation

{$R *.dfm}

uses uDM;

procedure TFrmListProdutos.AtualizaDadosGrid(Sender: TObject);
begin
  inherited;
  Produto.CODIGO := edtCodigo.Text;
  Produto.CarregaDataSet(SQLQuery);
end;

procedure TFrmListProdutos.ChamaMnt;
begin
  inherited;
  try
    Application.CreateForm(TFrmCadProduto, FrmCadProduto);
    with FrmCadProduto do
    begin
      dsDados.DataSet := self.dsDados.DataSet;
      Botao := self.Botao;
      PreencheDados;
      ShowModal;
    end;
  finally
    FreeAndNil(FrmCadProduto);
  end;
end;

procedure TFrmListProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  Produto := TProduto.Create();
end;

procedure TFrmListProdutos.ImgExcClick(Sender: TObject);
begin
  inherited;
  Produto.CODIGO := dsDados.DataSet.FieldByName('COD_PRODUTO').AsString;
  Produto.Excluir;
  AtualizaDadosGrid(Sender);
end;

end.
