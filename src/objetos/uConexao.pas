unit uConexao;

interface

type
  TConexao = class
  published
    function TABELA : String; virtual; abstract;
    function GENERATOR : String; virtual; abstract;
    function Consultar : String; Virtual; abstract;
    procedure AtualizaDados();   Virtual; abstract;

    const msgErroAdm = 'Entre entre em contato com o Administrador';
  end;

implementation

end.
