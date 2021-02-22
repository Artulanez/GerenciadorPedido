program GerenciaPedidos;

uses
  Vcl.Forms,
  uFrMain in 'src\forms\uFrMain.pas' {frmMain},
  uDM in 'src\DM\uDM.pas' {DM: TDataModule},
  uConexao in 'src\objetos\uConexao.pas',
  uController in 'src\objetos\uController.pas',
  uProduto in 'src\classes\uProduto.pas',
  uPedido in 'src\classes\uPedido.pas',
  uItemPedido in 'src\classes\uItemPedido.pas',
  uFrmPadrao in 'src\forms\Padrao\uFrmPadrao.pas' {FrmPadrao},
  uFrmListPadrao in 'src\forms\Padrao\uFrmListPadrao.pas' {frmlistPadrao},
  uFrmCadPadrao in 'src\forms\Padrao\uFrmCadPadrao.pas' {FrmCadPadrao},
  uFrmListProdutos in 'src\forms\uFrmListProdutos.pas' {FrmListProdutos},
  uFrmCadProduto in 'src\forms\uFrmCadProduto.pas' {FrmCadProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmListProdutos, FrmListProdutos);
  Application.CreateForm(TFrmCadProduto, FrmCadProduto);
  Application.Run;
end.
