unit uFrmCadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmCadPadrao, Data.DB, uPedido,uFrmPadrao,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmCadPedido = class(TFrmCadPadrao)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtNumero: TEdit;
    edtPreco: TEdit;
    edtData: TEdit;
    ImageBotoes: TImageList;
    Panel2: TPanel;
    Panel7: TPanel;
    BtnExc: TButton;
    BtnIns: TButton;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    DBGrid2: TDBGrid;
    Label5: TLabel;
    SQLItens: TFDQuery;
    SQLProdutos: TFDQuery;
    dsProdutos: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnInsClick(Sender: TObject);
    procedure BtnExcClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Pedido : TPedido;
    function  ValidaCadastro: Boolean; Override;
    procedure SalvaCadastro; Override;
    procedure PreencheDados; Override;
  end;

var
  FrmCadPedido: TFrmCadPedido;

implementation

{$R *.dfm}

uses uDM;

{ TFrmCadPedido }

procedure TFrmCadPedido.BtnExcClick(Sender: TObject);
begin
  inherited;
  SQLItens.Delete;
end;

procedure TFrmCadPedido.BtnInsClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TFrmCadPedido.FormCreate(Sender: TObject);
begin
  inherited;
  Pedido := TPedido.create;
end;

procedure TFrmCadPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Pedido);
end;

procedure TFrmCadPedido.PreencheDados;
begin
  inherited;
  if Botao = btAlterar then
  begin
    Pedido.NUMERO  := dsDados.DataSet.FieldByName('NUMERO').AsInteger;
    edtNumero.Text := dsDados.DataSet.FieldByName('NUMERO').AsString;
    edtData.Text   := dsDados.DataSet.FieldByName('DATA').AsString;
    edtPreco.Text  := dsDados.DataSet.FieldByName('PRECO').AsString;
  end
  else
  begin
    Pedido.NUMERO  := 0;
    edtNumero.Text := '';
    edtData.Text   := FormatDateTime('DD/MM/YYYY',Now());
    edtPreco.Text  := '';
  end;

end;

procedure TFrmCadPedido.SalvaCadastro;
begin
  inherited;

end;

function TFrmCadPedido.ValidaCadastro: Boolean;
begin

end;

end.
