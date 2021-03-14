inherited FrmCadProduto: TFrmCadProduto
  Caption = 'Cadastro Produto'
  ClientHeight = 175
  ClientWidth = 526
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 542
  ExplicitHeight = 214
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBotoes: TPanel
    Width = 526
    ExplicitWidth = 526
    inherited PanelSave: TPanel
      Left = 365
      ExplicitLeft = 365
      inherited ImgAdd: TImage
        OnMouseDown = ImgAddMouseDown
        OnMouseLeave = ImgAddMouseLeave
        OnMouseMove = ImgAddMouseMove
        ExplicitTop = -3
      end
    end
    inherited PanelSair: TPanel
      Left = 445
      ExplicitLeft = 445
      inherited ImgSair: TImage
        OnMouseDown = ImgAddMouseDown
        OnMouseLeave = ImgAddMouseLeave
        OnMouseMove = ImgAddMouseMove
        ExplicitTop = -3
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 57
    Width = 526
    Height = 118
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 78
      Height = 13
      Caption = 'Codigo Produto:'
    end
    object Label2: TLabel
      Left = 44
      Top = 51
      Width = 50
      Height = 13
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 63
      Top = 79
      Width = 31
      Height = 13
      Caption = 'Pre'#231'o:'
    end
    object edtCodigo: TEdit
      Left = 100
      Top = 21
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Left = 100
      Top = 48
      Width = 373
      Height = 21
      TabOrder = 1
    end
    object edtPreco: TEdit
      Left = 100
      Top = 75
      Width = 101
      Height = 21
      TabOrder = 2
    end
  end
  inherited dsDados: TDataSource
    Left = 240
  end
end
