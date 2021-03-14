unit uFrmListPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmListPadrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, uPedido, uFrmCadPedido;

type
  TFrmListPedido = class(TfrmlistPadrao)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    edtNumero: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure AtualizaDadosGrid(Sender : TObject); Override;
    procedure ImgExcClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Pedido : TPedido;
    procedure ChamaMnt; Override;
  end;

var
  FrmListPedido: TFrmListPedido;

implementation

{$R *.dfm}

uses uDM;

procedure TFrmListPedido.AtualizaDadosGrid(Sender: TObject);
begin
  inherited;
  Pedido.NUMERO := StrToIntDef(edtNumero.Text,0);
  Pedido.CarregaDataSet(SQLQuery);
end;

procedure TFrmListPedido.ChamaMnt;
begin
  inherited;
  inherited;
  try
    Application.CreateForm(TFrmCadPedido, FrmCadPedido);
    with FrmCadPedido do
    begin
      dsDados.DataSet := self.dsDados.DataSet;
      Botao := self.Botao;
      PreencheDados;
      ShowModal;
    end;
  finally
    FreeAndNil(FrmCadPedido);
  end;
end;

procedure TFrmListPedido.FormCreate(Sender: TObject);
begin
  inherited;
  Pedido := TPedido.Create
end;

procedure TFrmListPedido.ImgExcClick(Sender: TObject);
begin
  inherited;
  Pedido.NUMERO := dsDados.DataSet.FieldByName('NUMERO').AsInteger;
  Pedido.Excluir;
  AtualizaDadosGrid(Sender);
end;

end.
