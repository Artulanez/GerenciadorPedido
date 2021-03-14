inherited FrmListPedido: TFrmListPedido
  Caption = 'Pedidos'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelFiltro: TPanel
    DesignSize = (
      721
      71)
    object Label1: TLabel [0]
      Left = 18
      Top = 24
      Width = 41
      Height = 13
      Caption = 'N'#250'mero:'
    end
    inherited BtnFiltrar: TBitBtn
      Top = 24
      ExplicitTop = 24
    end
    object edtNumero: TEdit
      Left = 63
      Top = 21
      Width = 121
      Height = 21
      TabOrder = 1
    end
  end
  inherited PanelGrid: TPanel
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 719
      Height = 336
      Align = alClient
      DataSource = dsDados
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NUMERO'
          Title.Caption = 'N'#250'mero'
          Width = 97
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_PEDIDO'
          Title.Caption = 'Data'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO'
          Title.Caption = 'Pre'#231'o'
          Width = 81
          Visible = True
        end>
    end
  end
  inherited dsDados: TDataSource
    Left = 272
  end
  inherited SQLQuery: TFDQuery
    Connection = DM.SQLConnection
    SQL.Strings = (
      'select * from pedido')
  end
end
