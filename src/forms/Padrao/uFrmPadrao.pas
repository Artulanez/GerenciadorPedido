unit uFrmPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.StrUtils,
  Data.FMTBcd, Data.DB, Data.SqlExpr;

type

  TBotao = (btInserir, btAlterar, btCancelar, btExcluir, btBrowser, btImprimir, btSair);

  TFrmPadrao = class(TForm)

    procedure ApenasNumero(Sender: TObject; var Key: Char);
    procedure ApenasNumeroVirgula(Sender: TObject; var Key: Char);
    procedure MascaraExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vObj : TObject;
    bShowOk : Boolean;
    Botao : TBotao;
  end;

var
  FrmPadrao: TFrmPadrao;

const
  msgErroAdm = 'Entre entre em contato com o Administrador';
  ConstApenasNumero  = ['0','1','2','3','4','5','6','7','8','9',#13,#27,#8];                        //,#46 = .
  ConstNumeroVirgula = ['0','1','2','3','4','5','6','7','8','9',#13,#27,#8,','];


implementation

{$R *.dfm}

{ TFrmPadrao }

procedure TFrmPadrao.ApenasNumero(Sender: TObject; var Key: Char);
begin
  if not (key in ConstApenasNumero) then
    key := #0;
end;

procedure TFrmPadrao.ApenasNumeroVirgula(Sender: TObject; var Key: Char);
begin
  if not (key in ConstNumeroVirgula) then
    key := #0;
end;

procedure TFrmPadrao.MascaraExit(Sender: TObject);
begin
  TEdit(Sender).Text := FormatFloat(',0.00',StrToFloatDef(ReplaceStr(TEdit(Sender).Text,'.',''), 0));
end;

end.
