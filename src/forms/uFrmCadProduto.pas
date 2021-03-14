unit uFrmCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmCadPadrao, Data.DB,uFrmPadrao, uProduto,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls;

type

  TFrmCadProduto = class(TFrmCadPadrao)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    edtPreco: TEdit;
    procedure ImgAddMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgAddMouseLeave(Sender: TObject);
    procedure ImgAddMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgSairClick(Sender: TObject);
    procedure ImgAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Produto : TProduto;

    function  ValidaCadastro: Boolean; Override;
    procedure SalvaCadastro; Override;
    procedure PreencheDados; Override;
  end;

var
  FrmCadProduto: TFrmCadProduto;

implementation

{$R *.dfm}

{ TFrmCadProduto }

procedure TFrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  Produto := TProduto.Create;
end;

procedure TFrmCadProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Produto);
end;

procedure TFrmCadProduto.ImgAddClick(Sender: TObject);
begin
  Produto.CODIGO := edtCodigo.Text;
  Produto.DESCRICAO := edtDescricao.Text;
  Produto.PRECO := StrToFloatDef(edtPreco.Text,0);

  inherited;
end;

procedure TFrmCadProduto.ImgAddMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := $009F9F9F; //clAqua;;
end;

procedure TFrmCadProduto.ImgAddMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := clBtnFace; //clLime;
end;

procedure TFrmCadProduto.ImgAddMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  TPanel(TImage(Sender).Parent).Color := $00CDCDCD; //clGreen;
end;

procedure TFrmCadProduto.ImgSairClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmCadProduto.PreencheDados;
begin
  inherited;
  if Botao = btAlterar then
  begin
    Produto.CODIGO    := dsDados.DataSet.FieldByName('COD_PRODUTO').AsString;
    edtCodigo.Text    := dsDados.DataSet.FieldByName('COD_PRODUTO').AsString;
    edtDescricao.Text := dsDados.DataSet.FieldByName('DESCRICAO').AsString;
    edtPreco.Text     := dsDados.DataSet.FieldByName('PRECO').AsString;

    edtCodigo.Enabled := False;
  end
  else
  begin
    edtCodigo.Text := '';
    edtDescricao.Text := '';
    edtPreco.Text := '';

    edtCodigo.Enabled := True;
  end;
end;

procedure TFrmCadProduto.SalvaCadastro;
begin
  inherited;

  if Botao = btInserir then
  begin
    Produto.Incluir;
  end
  else
  begin
    Produto.Alterar;
  end;

end;

function TFrmCadProduto.ValidaCadastro: Boolean;
begin
  Result := True;

  if Botao = btInserir then
  begin
    if trim(edtCodigo.Text) = '' then
    begin
      MessageDlg('Campo descrição é obrigatorio!', mtInformation, mbOKCancel,0);
      Result := false;
    end;

    if not Produto.ValidaCodigoRepedito then
    begin
      MessageDlg('Codigo ja existente!', mtInformation, mbOKCancel,0);
      Result := false;
    end;
  end;

  if trim(edtDescricao.Text) = '' then
  begin
    MessageDlg('Campo descrição é obrigatorio!', mtInformation, mbOKCancel,0);
    Result := false;
  end;

end;

end.
