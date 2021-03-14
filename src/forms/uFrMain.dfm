object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Gerenciar Pedido'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 248
    Top = 32
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
    end
    object Pedido1: TMenuItem
      Caption = 'Pedido'
      object Manutenopedido1: TMenuItem
        Caption = 'Manuten'#231#227'o pedido'
        OnClick = Manutenopedido1Click
      end
    end
  end
end
