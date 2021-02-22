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
    procedure SetData(const Value: TDateTime);
    procedure Setnumero(const Value: integer);

    procedure AtualizaDados(); override;
    function TABELA   : String; override;
    function GENERATOR : String; override;
    function ValidaCadastro() : boolean; override;

public
  SqlAux: TFDQuery;
  Itens : TList<TItemPedido>;
  property NUMERO : integer read FNUMERO write Setnumero;
  property DATA : TDateTime read FDATA write SetData;

  function ValidaItemRepedito(pCod_PRODUTO: String):Boolean;

  procedure Incluir();
  procedure Alterar();
  procedure Excluir;

  constructor Create(AOwner: TComponent);
  destructor Destroy; override;
end;

implementation

{ TPedido }

procedure TPedido.Alterar;
begin

end;

procedure TPedido.AtualizaDados;
begin
  inherited;
  Campos[0] := 'NUMERO';
  Campos[1] := 'DATA';
  Campos[2] := 'PRECO';

  Valores[0] := FNUMERO;
  Valores[1] := FDATA;
end;

constructor TPedido.Create(AOwner: TComponent);
begin
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
begin

  

  Itens[0]

    

end;

function TPedido.GENERATOR: String;
begin
  Result := 'GEN_PEDIDO';
end;

procedure TPedido.Incluir;
begin
  FNUMERO := GetGenerator;

  AtualizaDados;

  Insert(Self, Campos, Valores);
end;

procedure TPedido.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TPedido.Setnumero(const Value: integer);
begin
  Fnumero := Value;
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
