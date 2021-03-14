object DM: TDM
  OldCreateOrder = False
  Height = 280
  Width = 383
  object SQLConnection: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\Delphi\GerenciaPedidos\database\GERENCIAPED' +
        'IDOS.FDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 88
    Top = 32
  end
  object SqlAuxiliar: TFDQuery
    Connection = SQLConnection
    Left = 232
    Top = 32
  end
  object FDTransaction: TFDTransaction
    Connection = SQLConnection
    Left = 88
    Top = 88
  end
end
