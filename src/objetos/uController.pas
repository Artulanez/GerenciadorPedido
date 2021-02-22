unit uController;

interface

uses uConexao,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
TController = class(TConexao)
    protected
      Campos  : Array of string;
      Valores : Array of Variant;
      function ValidaCadastro() : boolean; virtual; abstract;
      function GetGenerator() : Integer;
      function getConnection() : TFDConnection;

    public
      procedure Insert(Objeto: TConexao; vCampos : Array of String; vValores : Array of Variant);
      procedure Update(Objeto: TConexao; vCampos : Array of String; vValores : Array of Variant; vChave, vValor: String);
      procedure Delete(Objeto: TConexao; vChave, vValor : String);
  end;

implementation

{ TController }

uses System.TypInfo, uDM, System.SysUtils, Vcl.Dialogs;

procedure TController.Delete(Objeto: TConexao; vChave, vValor: String);
var
  Sair : Word;
begin
  try
    with DM.SqlAuxiliar do
    begin
      Sair := MessageDlg('Confirma a Exclusão do Registro Selecionado?', mtConfirmation, mbOKCancel,0);
      if Sair = 1 then
      begin
        Close;
        SQL.Text := 'DELETE FROM ' +TABELA+
                    ' WHERE '+vChave+' = '+vValor;
        ExecSQL;
        MessageDlg('Dados Alterados com Sucesso.', mtInformation, [mbOk],0);
      end;
    end;
  except
    MessageDlg('Erro na Exclusão dos Dados.'+#13+msgErroAdm, mtInformation, [mbOk],0);
  end;
end;

function TController.getConnection: TFDConnection;
begin
  Result := DM.SQLConnection;
end;

function TController.GetGenerator: Integer;
begin
  with DM.SqlAuxiliar do
  begin
    Close;
    SQL.Text := 'SELECT GEN_ID('+GENERATOR+', 1) AS VALOR FROM RDB$DATABASE';
    Open();

    Result := FieldByName('VALOR').AsInteger;
  end;
end;

procedure TController.Insert(Objeto: TConexao; vCampos: array of String;
  vValores: array of Variant);
var
  Script, Campos, Valores : String;
  I: Integer;
  propInfo: PPropInfo;
begin
  Script := 'INSERT INTO '+Objeto.TABELA;

  for i := Low(vCampos) to High(vCampos) do
  begin
    Campos  := Campos  + vCampos[i]+',';
    Valores := Valores + ':'+vCampos[i]+',';
  end;

  Campos  := copy(Campos,  1, length(Campos)-1);
  Valores := copy(Valores, 1, length(Valores)-1);

  try

    with DM.SqlAuxiliar do
    begin
      Close;
      SQL.Text := Script +'('+Campos+') values ('+valores+')';

      for i := Low(vValores) to High(vValores) do
      begin
        Params[i].Value := vValores[i];
      end;

      ExecSQL;
    end;
  except
    on E:Exception do
      ShowMessage('Erro de Inclusão: '+E.Message);
  end;

end;

procedure TController.Update(Objeto: TConexao; vCampos: array of String;
  vValores: array of Variant; vChave, vValor: String);
var
  i: Integer;
begin
  try
    with DM.SqlAuxiliar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE '+TABELA+' SET ');

      for i := Low(vCampos) to High(vCampos) do
      begin
        if i > 0 then
          SQL.Add(',');

        SQL.Add(vCampos[i]+'= :'+vCampos[i]);
      end;

      SQL.Add('  WHERE '+vChave+' ='+ vValor);

      for i := Low(vValores) to High(vValores) do
      begin
        Params[i].Value := vValores[i];
      end;

      ExecSQL;

      MessageDlg('Dados Alterados com Sucesso.', mtInformation, [mbOk],0);
    end;
  except
    MessageDlg('Erro na Alteração dos Dados.'+#13+msgErroAdm, mtInformation, [mbOk],0);
  end;
end;

end.
