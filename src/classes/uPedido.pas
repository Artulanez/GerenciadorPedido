unit uPedido;

interface

uses uController, System.Generics.Collections , System.Types , System.SysUtils , Data.SqlExpr, System.Classes, uItemPedido,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type

TPedido = class(TController)
  private
    FNUMERO: integer;
    FDATA: TDateTime;
    FPRECO: Double;
    procedure SetData(const Value: TDateTime);
    procedure Setnumero(const Value: integer);
    procedure SetPRECO(const Value: Double);

    procedure AtualizaDados(); override;
    function TABELA   : String; override;
    function GENERATOR : String; override;
    function ValidaCadastro() : boolean; override;


public
  SqlAux: TFDQuery;
  Itens : TList<TItemPedido>;
  property NUMERO : integer read FNUMERO write Setnumero;
  property DATA : TDateTime read FDATA write SetData;
  property PRECO : Double read FPRECO write SetPRECO;


  function ValidaItemRepedito(pCod_PRODUTO: String):Boolean;

  procedure CarregaDataSet(sDataSet : TFDQuery);
  procedure CarregaItens(sDataSet: TFDQuery);

  procedure Incluir;
  procedure Alterar;
  procedure Excluir;

  procedure ExcluirItens;

  constructor Create;
  destructor Destroy; override;
end;

implementation

{ TPedido }

procedure TPedido.Alterar;
begin
  Excluir;
  Incluir;
end;

procedure TPedido.AtualizaDados;
begin
  inherited;
  Campos[0] := 'NUMERO';
  Campos[1] := 'DATA';
  Campos[2] := 'PRECO';

  Valores[0] := NUMERO;
  Valores[1] := DATA;
  Valores[2] := PRECO;
end;

procedure TPedido.CarregaDataSet(sDataSet: TFDQuery);
begin
  sDataSet.Close;
  sDataSet.SQL.Clear;
  sDataSet.SQL.Add(' SELECT NUMERO,DATA,PRECO '+
                   '   FROM PEDIDO WHERE 1=1 ');

  if NUMERO > 0 then
  begin
    sDataSet.SQL.Add(' AND NUMERO = '+IntToStr(NUMERO));
  end;

  sDataSet.Open;
end;

procedure TPedido.CarregaItens(sDataSet: TFDQuery);
begin
  sDataSet.Close;
  sDataSet.SQL.Clear;
  sDataSet.SQL.Add(' SELECT P.COD_PRODUTO, '+
                   '        P.DESCRICAO, '+
                   '        P.PRECO, '+
                   '        I.NUM_PEDIDO , '+
                   '        I.QUANTIDADE '+
                   '   FROM PRODUTO P, '+
                   '        ITEM_PEDIDO I '+
                   '  WHERE I.COD_PRODUTO = P.COD_PRODUTO ');

  if NUMERO > 0 then
  begin
    sDataSet.SQL.Add(' AND I.NUM_PEDIDO = '+IntToStr(NUMERO));
  end;
  sDataSet.Open;


end;

constructor TPedido.Create;
begin
  SetLength(Campos , 3);
  SetLength(Valores, 3);

  SqlAux := TFDQuery.Create(nil);
  SqlAux.Connection := getConnection;

  Itens := TList<TItemPedido>.Create;
end;

destructor TPedido.Destroy;
begin
  FreeAndNil(SqlAux);
  inherited;
end;

procedure TPedido.Excluir;
var
 item : TItemPedido;
begin
  AtualizaDados;
  ExcluirItens;
  Delete(self,'NUMERO',IntToStr(NUMERO));
end;

procedure TPedido.ExcluirItens;
begin
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add( 'DELETE FROM ITEM_PEDIDO '+
                  ' WHERE NUM_PEDIDO = '+IntToStr(NUMERO));
  SqlAux.ExecSQL();

end;

function TPedido.GENERATOR: String;
begin
  Result := 'GEN_PEDIDO';
end;

procedure TPedido.Incluir;
var
  item : TItemPedido;
begin
  if NUMERO > 0 then
    NUMERO := GetGenerator;

  AtualizaDados;
  Insert(Self, Campos, Valores);

  for item in Itens do
  begin
    item.NUM_PEDIDO := NUMERO;
    item.Incluir;
  end;

end;

procedure TPedido.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TPedido.Setnumero(const Value: integer);
begin
  Fnumero := Value;
end;

procedure TPedido.SetPRECO(const Value: Double);
begin
  FPRECO := Value;
end;

function TPedido.TABELA: String;
begin
  Result := 'PEDIDO'
end;

function TPedido.ValidaCadastro: boolean;
begin

end;

function TPedido.ValidaItemRepedito(pCod_PRODUTO: String): Boolean;
begin

end;

end.
