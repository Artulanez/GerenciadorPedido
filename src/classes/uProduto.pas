unit uProduto;

interface

uses uController, System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TProduto = class(TController)
  private
    FPRECO: Double;
    FDESCRICAO: String;
    FCODIGO: String;
    procedure SetCODIGO(const Value: String);
    procedure SetDESCRICAO(const Value: String);
    procedure SetPRECO(const Value: Double);

    procedure AtualizaDados(); override;
    function TABELA   : String; override;
    function ValidaCadastro() : boolean; override;
  public
    SqlAux: TFDQuery;
    property CODIGO : String read FCODIGO write SetCODIGO;
    property DESCRICAO : String read FDESCRICAO write SetDESCRICAO;
    property PRECO : Double read FPRECO write SetPRECO;

    procedure Incluir();
    procedure Alterar();
    procedure Excluir;

    function ValidaCodigoRepedito():Boolean;

    procedure CarregaDataSet(sDataSet : TFDQuery);

    constructor Create;
    destructor Destroy; override;
  end;

implementation


{ TProduto }

procedure TProduto.Alterar;
begin
  AtualizaDados;
  Update(Self,Campos,Valores,'COD_PRODUTO',FCODIGO);
end;

procedure TProduto.AtualizaDados;
begin
  inherited;
  Campos[0] := 'COD_PRODUTO';
  Campos[1] := 'DESCRICAO';
  Campos[2] := 'PRECO';

  Valores[0] := FPRECO;
  Valores[1] := FDESCRICAO;
  Valores[2] := FPRECO;
end;

procedure TProduto.CarregaDataSet(sDataSet: TFDQuery);
begin
  sDataSet.Close;
  sDataSet.SQL.Clear;
  sDataSet.SQL.Add(' SELECT COD_PRODUTO,DESCRICAO,PRECO '+
                   '   FROM PRODUTO WHERE 1=1 ');

  if FCODIGO <> '' then
  begin
    sDataSet.SQL.Add(' AND COD_PRODUTO = '+QuotedStr(FCODIGO));
  end;

  sDataSet.Open;
end;

constructor TProduto.Create;
begin
  SqlAux := TFDQuery.Create(nil);
  SqlAux.Connection := getConnection;
end;

destructor TProduto.Destroy;
begin
  FreeAndNil(SqlAux);
  inherited;
end;

procedure TProduto.Excluir;
begin
  AtualizaDados;
  Delete(Self, 'COD_PRODUTO', FCODIGO);
end;

procedure TProduto.Incluir;
begin
  AtualizaDados;
  Insert(Self,Campos,Valores);
end;

procedure TProduto.SetCODIGO(const Value: String);
begin
  FCODIGO := Value;
end;

procedure TProduto.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

procedure TProduto.SetPRECO(const Value: Double);
begin
  FPRECO := Value;
end;

function TProduto.TABELA: String;
begin
  Result := 'PRODUTO';
end;

function TProduto.ValidaCadastro: boolean;
begin

end;

function TProduto.ValidaCodigoRepedito: Boolean;
begin
  SqlAux.Close;
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add('SELECT COUNT(*) TOTAL '+
                 '  FROM PRODUTO '+
                 ' WHERE COD_PRODUTO = '+QuotedStr(FCODIGO));
  SqlAux.Open;

  Result := (SqlAux.FieldByName('TOTAL').AsInteger = 0)
end;

end.
