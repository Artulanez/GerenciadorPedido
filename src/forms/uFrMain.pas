unit uFrMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uFrmListProdutos, uFrmListPedido,
  Vcl.Menus;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Pedido1: TMenuItem;
    Manutenopedido1: TMenuItem;
    procedure Produtos1Click(Sender: TObject);
    procedure Manutenopedido1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Manutenopedido1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmListPedido, FrmListPedido);
  FrmListPedido.ShowModal;
  FrmListPedido.Free;
  FrmListPedido :=nil;
end;

procedure TfrmMain.Produtos1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmListProdutos, FrmListProdutos);
  FrmListProdutos.ShowModal;
  FrmListProdutos.Free;
  FrmListProdutos :=nil;
end;

end.
