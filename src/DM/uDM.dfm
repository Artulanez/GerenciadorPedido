object DM: TDM
  OldCreateOrder = False
  Height = 280
  Width = 383
  object SQLConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Projetos\Delphi\GerenciaPedidos\database\GERENCIAPED' +
        'IDOS.FDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 224
    Top = 24
  end
  object SqlAuxiliar: TFDQuery
    Connection = SQLConnection
    Left = 224
    Top = 80
  end
end
