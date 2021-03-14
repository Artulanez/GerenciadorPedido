inherited FrmListProdutos: TFrmListProdutos
  Caption = 'Produtos'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBotoes: TPanel
    ExplicitLeft = -1
    ExplicitTop = -6
    inherited PanelEdit: TPanel
      inherited ImgEdit: TImage
        ExplicitLeft = 5
      end
    end
  end
  inherited PanelFiltro: TPanel
    object Label1: TLabel [0]
      Left = 16
      Top = 13
      Width = 89
      Height = 13
      Caption = 'Codigo de produto'
    end
    inherited BtnFiltrar: TBitBtn
      Top = 30
      OnClick = AtualizaDadosGrid
      ExplicitTop = 30
    end
    object edtCodigo: TEdit
      Left = 16
      Top = 32
      Width = 257
      Height = 21
      TabOrder = 1
    end
  end
  inherited PanelGrid: TPanel
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 703
      Height = 297
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
          FieldName = 'COD_PRODUTO'
          Title.Caption = 'Codigo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 450
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO'
          Title.Caption = 'Pre'#231'o'
          Visible = True
        end>
    end
  end
  inherited dsDados: TDataSource
    Left = 32
    Top = 168
  end
  inherited SQLQuery: TFDQuery
    Connection = DM.SQLConnection
    SQL.Strings = (
      'select COD_produto, descricao, preco from produto')
    Left = 104
    Top = 168
    object SQLQueryCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 10
    end
    object SQLQueryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
    object SQLQueryPRECO: TCurrencyField
      FieldName = 'PRECO'
      Origin = 'PRECO'
    end
  end
end
