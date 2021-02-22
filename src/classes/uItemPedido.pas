unit uItemPedido;

interface

uses uController, System.Types , Data.SqlExpr, System.Classes,
  System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TItemPedido = class(TController)
  private
    FNUM_PEDIDO: integer;
    FCOD_PRODUTO: String;
    FQUANTIDADE: integer;
    procedure SetCOD_PRODUTO(const Value: String);
    procedure SetNUM_PEDIDO(const Value: integer);
    procedure SetQUANTIDADE(const Value: integer);

    procedure AtualizaDados(); override;
    function TABELA   : String; override;
    function ValidaCadastro() : boolean; override;
  public
    SqlAux: TFDQuery;

    property NUM_PEDIDO : integer read FNUM_PEDIDO write SetNUM_PEDIDO;
    property COD_PRODUTO : String read FCOD_PRODUTO write SetCOD_PRODUTO;
    property QUANTIDADE : integer read FQUANTIDADE write SetQUANTIDADE;

    procedure Incluir();
    procedure Excluir();
    procedure ExcluirTodos();

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

implementation

{ TItemPedido }

procedure TItemPedido.AtualizaDados;
begin
  inherited;
  Campos[0] := 'NUM_PEDIDO';
  Campos[1] := 'COD_PRODUTO';
  Campos[2] := 'QUANTIDADE';

  Valores[0] := FNUM_PEDIDO;
  Valores[1] := FCOD_PRODUTO;
  Valores[2] := FQUANTIDADE;
end;

constructor TItemPedido.Create(AOwner: TComponent);
begin
  SqlAux := TFDQuery.Create(nil);
  SqlAux.Connection := getConnection;
end;

destructor TItemPedido.Destroy;
begin
  FreeAndNil(SqlAux);
  inherited;
end;

procedure TItemPedido.Excluir;
begin
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add( 'DELETE FROM '+TABELA+
                  ' WHERE NUM_PEDIDO = '+QuotedStr(IntToStr(FNUM_PEDIDO))+
                  ' AND COD_PRODUTO = '+QuotedStr(FCOD_PRODUTO) );
  SqlAux.ExecSQL();

end;

procedure TItemPedido.ExcluirTodos;
begin
  AtualizaDados;

  Delete(self,'NUM_PEDIDO', IntToStr(FNUM_PEDIDO));
end;

procedure TItemPedido.Incluir;
begin

  AtualizaDados;

  Insert(self,Campos,Valores);
end;

procedure TItemPedido.SetCOD_PRODUTO(const Value: String);
begin
  FCOD_PRODUTO := Value;
end;

procedure TItemPedido.SetNUM_PEDIDO(const Value: integer);
begin
  FNUM_PEDIDO := Value;
end;

procedure TItemPedido.SetQUANTIDADE(const Value: integer);
begin
  FQUANTIDADE := Value;
end;

function TItemPedido.TABELA: String;
begin
  Result := 'ITEM_PEDIDO';
end;

function TItemPedido.ValidaCadastro: boolean;
begin

end;

end.
