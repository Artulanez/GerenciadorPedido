unit F_Funcao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uDM,
  DB, StrUtils, inifiles, ExtCtrls, DBClient, DBGrids, Printers, Math,
  Menus, ShellApi, StdCtrls, ComCtrls, WinSock, Variants,
  COMOBJ;

type
  TipoExtenso     = (teNone, teMonetario, teFolhas);      // Tipo do ObtemValorExtenso
  TipoGenero      = (tgMasculino, tgFeminino);            // ObtemValorExtenso em masculino/feminino
  TTipoRetorno    = (trString, trNumber);                 // Tipo de retorno de avaliaexpressao
  TCaseCapitalize = (ccFirstsWord, ccFirstsPhrase);       // Tipo de Capitalizacao
  TTiposValores   = (tvNone, tvString, tvNumber, tvDate); // Tipo de Valores do Box

  // Tipo de som a ser emitido na ativa��o dos forms
  TTipoSom = (tsNenhum,   // Sem som
              tsNormal,   // Normal
              tsAtencao,  // Aviso de Atencao
              tsErro,     // Aviso de Erro
              tsBigErro); // Aviso de Erro GRANDE

  //egsn
  TIconKind = (ikError,    // 0 - error,
               ikInfo,     // 1 - info
               ikQuestion, // 2 - question
               ikWarn,     // 3 - warn
               ikAutomatic); // default � info, mas tenta achar pelo texto da mensagem




  TDialogs = class(TPersistent)
  private
  public
    constructor Create        (AOwner: TComponent);
    destructor  Destroy;      override;

//    class function    IsBrowser     (AForm: TCustomForm): Boolean;
//    class procedure   AboutDlg;
//    class function    DataFinderDlg (const ANewInstance,ADataDetail: Boolean; ADataFinder: TEstalo_DataFinder; ARefresh: Boolean; var AReturn: Variant; const ATotals: string = ''): Boolean;
//    class function    LoginDlg      (var AUser: string): Boolean;
    class function    MsgDlg        (ATitle: string; AText: string; AButtonsText: array of string; {ATypeSound: TTipoSom = tsNormal; AIconKind: TIconKind = ikAutomatic;} ABigSize: Boolean = False): Integer;
//    class function    PswDlg        (ATitle: string; APsw:  string; ALenPsw: Integer): Integer;
//    class function    PswChangeDlg  (var ANewPsw: string; var AExpDate: TDateTime): Boolean;
  end;


  TArray = array of string;
  TMens  = class
    class function  Quest(qMenssagem: pChar; qBooBotao: Boolean = True): Boolean;
    class function  YesNoCancel(qMenssagem: pChar; Focus: Integer = 2): string;
    class procedure Aviso(qMenssagem: pChar; pBooSair: Boolean = False; pFocar: TWinControl = nil);
    class procedure Erro(qMenssagem: pChar);
    class procedure ErroSys(qMenssagem: string);
    class procedure AbreAnimacao(Form : TForm);
  end;

  TArredondNota = class
    class function  ArredondaNota(Nota : Double; Etapa, Turma : String): Double;
  end;

  TFormatacao = class
    class function FormataEndereco(Tabela: TDataSet; LOG, COMP, BAIRRO, UF, CIDADE, CEP, FONE, FAX: string): string;
    class function RetornaArray(xStr: string; xCharDelimitador: Char; xIntTamanho: Integer): TArray;
    class function ReadINI(xStrFile, xStrSession, xStrKey, xStrResultCaseFalse: string): string;
    class function PadR(const AString : AnsiString; const nLen : Integer;const Caracter : AnsiChar) : AnsiString;
    class function PadL(const AString : AnsiString; const nLen : Integer;const Caracter : AnsiChar) : AnsiString;
    class function PadC(const AString : AnsiString; const nLen : Integer;const Caracter : AnsiChar) : AnsiString;
    class function ValorPorExtenso(vlr : Real): String;
    class function IniciaisMaiusculas(texto: string): String;
  end;

  TRelatorio = class
    class procedure Proc_MarcaRelatorioAtivo(var ACanvas: TCanvas; Value: Variant); static;
    class procedure Proc_CriaComponentesRelatorio(Form: TForm; Var Grid: TDBGrid; sqlDados : TUniQuery; dsDados : TDataSource); static;
    class procedure Proc_AlteraRelatorio(Form: TForm; var Grid: TDBGrid; ppR: TppReport; sNomeRelatorio : String; Confirmacao : Boolean = True); static;
    class procedure Proc_NovoRelatorio(Form: TForm; Grid: TDBGrid; ppR: TppReport; sNomeRelatorio : String; SqlAuxiliar : TUniQuery; ExibeRel : Boolean); static;
    class procedure Proc_CarregaRelatorio(Form: TForm; sqlDados: TUniQuery; ppR: TppReport; CodigoLayout : String); static;
    class procedure Proc_ExcluiRelatorio(Form: TForm; Grid: TDBGrid; ppR: TppReport); static;
    class function  Func_GeraCodigoRelatorio(Form: String; SqlAuxiliar: TUniQuery): Integer; static;
    class procedure Proc_ExportaRelatorio(Form: TForm; var Grid: TDBGrid; sNomeRelatorio, FileName : String; CdsExportar : TClientDataSet); static;
    class procedure Proc_ImportarRelatorio(DataSet : TUniQuery; FileName : String; CdsExportar : TClientDataSet); static;
    class procedure ExportaExcel(sCaption : String; CdsDados : TClientDataSet);
  end;

  TRelatFastReport = class

  end;

  TArqDiscos = class
    class function VerDiscoDrive(WPDrive: PChar): boolean;
  end;

  TSystem = class
    class function PathAlias(Alias: string): string;
    class function HostName : String;
    class function UserName : String;
    class function MacRede(IPAddress : String): String;
  end;

  TArquivo = class
    class procedure AplicaScriptBanco;
    class procedure AplicaScript;
    class procedure SalvaScriptAplicado(Script : String; Aplicado : Boolean);
    class procedure ArqParaLixeira(const NomeArq: string; var MsgErro: string);
  end;

  TValidacao = class
    class function  TiraMascara(Chave: string): string;
    class function  RetornaNumero(Valor: string): Double;
    class function  CPF(xCPF: string): boolean;
    class function  CGC(xCGC: string): boolean;
    class function  VencMesmoDia(vencanterior: tdatetime): tdatetime;
    class function  UltimoDiadoMes(data: tdatetime): tdatetime;
    class function  DiadoMes(data: tdatetime): tdatetime;
    class function  QTDDias(xDataMaior, xDataMenor: TDateTime; RetiraDia: Integer): Integer;
    class function  ValidaEmail(Email: string): Boolean;
    class function  Inscricao(Inscricao, Tipo: string): Boolean;
    class function  Mascara_Inscricao(Inscricao, Estado: string): string;
    class function  GetComparaValores(Valor1, Valor2: Currency; Operador: string; Tolerancia: Currency = 0): Boolean;
    class function  DeCriptografa(Codigo: string): string;
    class procedure DeCriptografaLista(Lista: TStrings; var ListaRetorno : TStrings);

    class function Criptografa(Autorizacao: string): string;
    class function DescripCript(wStri : string):String;
    class function RetiraEspacoDuplicado(Texto : string):String;
    class function DiaSemana(Data:TDateTime): String;
  end;

  TMetodos = class
    class procedure SetMontaIndices(Cds: TClientDataSet; Grd: TDBGrid);
    class procedure SetChamaIndices(Cds: TClientDataSet; Grd: TDBGrid; Column: TColumn; shpCrescente, shpDecrescente: TShape);
    class procedure SetImpressoraPadrao(NomeImpressora: string);
    class procedure SetListaImpressoras(Lista: TStrings);
    class procedure SetEscreveArquivo(var Campos: array of string; var Arquivo: TStringList; NomeArquivo: string = '');
    class function  GetImpressoraPadrao: string;
    class function  GetForm(Sender: TObject): TComponent;
    class function  GetBuildInfo:string;
  end;

  TMetodo = class
    class function  GetFormatar(Texto: string; TamanhoDesejado: integer; AcrescentarADireita: boolean = true; CaracterAcrescentar: char = ' '): string;
    class function  GetTiraMascara(Texto: string): string;
    class procedure SetEscreveArquivo(var Campos: array of string; var Arquivo: TStringList; NomeArquivo: string = '');
  end;

  TImpressora = class
    class function RetornaPortaImpPadrao : String;
  end;

  function Formatar(Texto: string; TamanhoDesejado: integer; AcrescentarADireita: boolean = true; CaracterAcrescentar: char = ' '): string;
  function RetiraAcentos(Texto: String): String;
  function StrReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
  function ReplaceStr(const AText, AFromText, AToText: string): string;
  function Administrador : Boolean;

  procedure CriaMenuAtalho;
  procedure ExcluiMenuAtalho;

  procedure CriarForm(pStrNomeForm: string);
  procedure ChamaForm(InstanceClass : TComponentClass; var Reference; Sender : TOBject; Obj : TObject = nil);
  procedure CarregarModulo(pStrFile: string);
  procedure DescarregarModulos;

  function RetornaApenasNumero(Chave: string): string;
  function RetornaMes(NumeroMes: Integer): string;

  //function VerificaBaixaTipoPagamento(sTipo: string): Boolean;

  function FileLastModified(const TheFile: string): string;

  procedure MontaAtalhosMenu(sNomePanel : TPanel; sForm : TForm);
  procedure MontaAtalhosPopu(sPopup : TPopupMenu; sForm : TForm);

  //Fun��es estalo_funcoes
  function  ExistKeyPress:                 Boolean;
  procedure GridOrdenaTitleClick(GridDados: TDBGrid; Column: TColumn);

  function  Tone                           (Freq: Word; MSecs: Integer): Boolean;
  function  PixelsText                     (const inString: string; AFont: TFont; var PixelsWidth: Integer; var PixelsHeight: Integer; Form: TCustomForm = nil): Boolean;
  function  StringTran                     (inString: string; const SubStr1: string; const SubStr2: string; IgnoreCase: Boolean = False): string;
  function  CAPSOnWords                    (const inString: string; ACase: TCaseCapitalize): string;


  //Utiliza��o de DLLs
  function SendARP(DestIp: DWORD; srcIP: DWORD; pMacAddr: pointer; PhyAddrLen: Pointer): DWORD;stdcall; external 'iphlpapi.dll';

implementation

uses Buttons, ppendUsr, FormExpr,
  oObjects, ParseClass, ParseExpr, Form_DialogoMensagem, uFrmLayoutRel,
  uFrmCadPadrao, uFrmPadrao, Vcl.ActnList;

var
  vet_valido: array[0..35] of string = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');
  Modulos: array of HModule;

const Caractere: array[1..80] of Char = (
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
    'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!', '#',
    '$', '%', '&', '/', '(', ')', '=', '?', '>', '^', '@', '�', '�', '{', '[', ']', '}', '�', '<',
    '~', '+', '*', '`', '''', '�', '�', '�', '-', '_', ',', '.', ';', ':', '|', '\', '�', '�', '�'
    , '�', '�', '�', ' ');

const Subst: array[1..80] of string = (
    '98', '77', '45', '54', '88', '11', '35', '76', '66', '33', '28', '17', '09', '01', '97',
    '32', '36', '14', '24', '68', '95', '44', '34', '84', '47', '05', '19', '20', '82', '75',
    '37', '48', '74', '63', '27', '13', '10', '39', '31', '42', '65', '58', '78', '41', '21',
    '96', '73', '15', '06', '56', '18', '38', '30', '69', '70', '26', '93', '52', '71', '80',
    '50', '40', '87', '46', '55', '22', '08', '89', '03', '59', '85', '29', '02', '99', '25',
    '23', '91', '64', '51', '00');

  { TMens }

class function TMens.Quest(qMenssagem: pChar; qBooBotao: Boolean = True): Boolean;
begin
  result := false;
  if qBooBotao then
  begin
    if Application.MessageBox(qMenssagem, 'Quest�o', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = idyes then
      result := true;
  end
  else
  begin
    if Application.MessageBox(qMenssagem, 'Quest�o', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = idyes then
      result := true;
  end;
end;

class function TMens.YesNoCancel(qMenssagem: pChar; Focus: Integer = 2): string;
var
  resp: integer;
begin
  case Focus of
    1: resp := Application.MessageBox(qMenssagem, 'Quest�o', MB_ICONQUESTION + MB_YESNOCANCEL + MB_DEFBUTTON1);
    2: resp := Application.MessageBox(qMenssagem, 'Quest�o', MB_ICONQUESTION + MB_YESNOCANCEL + MB_DEFBUTTON2);
    3: resp := Application.MessageBox(qMenssagem, 'Quest�o', MB_ICONQUESTION + MB_YESNOCANCEL + MB_DEFBUTTON3);
  end;

  if resp = 6 then
    result := 'sim'
  else if resp = 7 then
    result := 'nao'
  else
    result := 'can';
end;

class procedure TMens.AbreAnimacao(Form : TForm);
begin
end;

class procedure TMens.Aviso(qMenssagem: pChar; pBooSair: Boolean = False; pFocar: TWinControl = nil);
begin
  Application.MessageBox(qMenssagem, 'Aviso', MB_ICONINFORMATION + MB_OK);
  if pFocar <> nil then
    pFocar.SetFocus;
  if pBooSair then
    Abort;
end;

class procedure TMens.Erro(qMenssagem: pChar);
begin
  Application.MessageBox(qMenssagem, 'Erro de Opera��o', MB_ICONEXCLAMATION + MB_OK);
end;

class procedure TMens.ErroSys(qMenssagem: string);
begin
  Application.MessageBox(Pchar(qMenssagem + chr(13) + chr(13) + 'Contate o suporte e indique local e mensagem deste erro!!!'), 'Erro de Sistema Previsto', MB_ICONERROR + MB_OK);
end;

{ TFormatacao }

class function TFormatacao.FormataEndereco(Tabela: TDataSet; LOG, COMP,
  BAIRRO, UF, CIDADE, CEP, FONE, FAX: string): string;
// FORMATA ENDERE�O PARA RODAP� DE RELAT�RIOS
begin
  Result := trim(Tabela.fieldbyname(LOG).asstring);
  if trim(Tabela.fieldbyname(COMP).asstring) <> '' then
    Result := Result + ' - ' + trim(Tabela.fieldbyname(COMP).asstring);
  Result := Result + ' - ' + trim(Tabela.fieldbyname(BAIRRO).asstring)
    + ' - ' + trim(Tabela.fieldbyname(CIDADE).asstring)
    + ' - ' + trim(Tabela.fieldbyname(UF).asstring);
  if trim(Tabela.fieldbyname(CEP).asstring) <> '' then
    Result := Result + ' - ' + 'CEP: ' + trim(Tabela.fieldbyname(CEP).asstring);
  if (trim(Tabela.fieldbyname(FONE).asstring) <> '') then
    Result := Result + ' - ' + 'Fone: ' + trim(Tabela.fieldbyname(FONE).asstring);
  if (trim(Tabela.fieldbyname(FAX).asstring) <> '') then
    Result := Result + ' - ' + 'Fax: ' + trim(Tabela.fieldbyname(FAX).asstring);
end;

class function TFormatacao.PadR(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar) : AnsiString ;
var
  Tam: Integer;
begin
  Tam := Length(AString);
  if Tam < nLen then
    Result := StringOfChar(Caracter, (nLen - Tam)) + AString
  else
    Result := copy(AString,1,nLen) ;
end;

class function TFormatacao.IniciaisMaiusculas(texto: string): String;
var tam,i: integer;
  aux, s: string;
  c: char;
begin
  texto := AnsiLowerCase(texto);
  aux:='';
  for i:=1 to length(texto) do
  begin
    if i=1 then
    begin
      aux:= Copy(AnsiUpperCase(texto[i]),i,1);
      aux:= aux+texto[i+1];
    end
    else
    if texto[i] = ' ' then
      aux:=aux+Copy(AnsiUpperCase(texto[i+1]),1,1)
    else
      aux:=aux+texto[i+1]
  end;

  //texto:='';
  i:= 2;
  tam:= length(aux);
  while i <= length(aux) do
  begin
    S:= '';
    s:= copy(aux,i,3);
    if (s = 'Do ') or (s = 'Da ') or (s = 'De ') then
    begin
      s:= Copy(LowerCase(aux),i,1);
      aux:= Copy(aux,1,i-1)+S+Copy(aux,i+1,(tam-i));
    end
    else
    if (s = 'Dos') or (s = 'Das') then
    begin
      s:= Copy(LowerCase(aux),i,1);
      aux:= Copy(aux,1,i-1)+S+Copy(aux,i+1,(tam-i));
    end;

    i:=i+1;
  end;
  Result:=AUX;
end;

class function TFormatacao.PadC(const AString: AnsiString; const nLen: Integer;
  const Caracter: AnsiChar): AnsiString;
var
  iCalc,
  Tam: Integer;
  sRetorno, sTexto1, sTexto2 : String;
begin
  sRetorno := EmptyStr;

  Tam := Length(AString);
  if Tam < nLen then
  begin
    //Result := AString + StringOfChar(Caracter, (nLen - Tam))
    iCalc := Trunc((nLen - Length(AString)) / 2);
    sRetorno := PadR(sRetorno, iCalc, Caracter) + AString;
    sRetorno := PadL(sRetorno, nLen, Caracter);
  end
  else
  begin
    sRetorno := AString;
  end;

  Result := sRetorno;
end;

class function TFormatacao.PadL(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar) : AnsiString ;
var
  Tam: Integer;
begin
  Tam := Length(AString);
  if Tam < nLen then
    Result := AString + StringOfChar(Caracter, (nLen - Tam))
  else
    Result := copy(AString,1,nLen) ;


end;

class function TFormatacao.ReadINI(xStrFile, xStrSession, xStrKey,
  xStrResultCaseFalse: string): string;
var
  fIni: Tinifile;
begin
  try
    fIni := TIniFile.Create(xStrFile);
    Result := fIni.ReadString(xStrSession, xStrKey, xStrResultCaseFalse);
  finally
    fIni.Free;
  end;
end;

class function TFormatacao.RetornaArray(xStr: string;
  xCharDelimitador: Char; xIntTamanho: Integer): TArray;
var
  fArrRetorno: TArray;
  fIntI, fIntIndice: Integer;
  fStrValor: string;
begin
  SetLength(fArrRetorno, xIntTamanho);
  fIntIndice := 0;
  while Pos(xCharDelimitador, xStr) > 0 do
  begin
    fIntI := AnsiPos(xCharDelimitador, xStr);
    if (fIntI <> 0) then
    begin
      fStrValor := Copy(xStr, 1, fIntI - 1);
      Delete(xStr, 1, fIntI);
    end;
    fArrRetorno[fIntIndice] := fStrValor;
    Inc(fIntIndice);
  end;
  Result := fArrRetorno;
end;

class function TFormatacao.ValorPorExtenso(vlr: Real): String;
const
  unidade: array[1..19] of string = ('um', 'dois', 'tr�s', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove', 'dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  centena: array[1..9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quinhentos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');
  dezena: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  qualificaS: array[0..4] of string = ('', 'mil', 'milh�o', 'bilh�o', 'trilh�o');
  qualificaP: array[0..4] of string = ('', 'mil', 'milh�es', 'bilh�es', 'trilh�es');
var
  inteiro: Int64;
  resto: real;
  vlrS, s, saux, vlrP, centavos: string;
  n, unid, dez, cent, tam, i: integer;
  umReal, tem: boolean;
begin
  if (vlr = 0) then
  begin
    valorPorExtenso := 'zero';
    exit;
  end;
  inteiro := trunc(vlr); // parte inteira do valor
  resto := vlr - inteiro; // parte fracion�ria do valor
  vlrS := inttostr(inteiro);

  if (length(vlrS) > 15) then
  begin
    valorPorExtenso := 'Erro: valor superior a 999 trilh�es.';
    exit;
  end;

  s := '';
  centavos := inttostr(round(resto * 100));

  // definindo o extenso da parte inteira do valor
  i := 0; umReal := false;
  tem := false;

  while (vlrS <> '0') do
  begin tam := length(vlrS);
    // retira do valor a 1a. parte, 2a. parte, por exemplo, para 123456789:
    // 1a. parte = 789 (centena)
    // 2a. parte = 456 (mil)
    // 3a. parte = 123 (milh�es)
    if (tam > 3) then
    begin
      vlrP := copy(vlrS, tam-2, tam);
      vlrS := copy(vlrS, 1, tam-3);
    end
    else
    begin
      // �ltima parte do valor
      vlrP := vlrS;
      vlrS := '0';
    end;

    if (vlrP <> '000') then
    begin
      saux := '';
      if (vlrP = '100') then
        saux := 'cem'
      else
      begin
        n := strtoint(vlrP);
        // para n = 371, tem-se:
        cent := n div 100; // cent = 3 (centena trezentos)
        dez := (n mod 100) div 10; // dez = 7 (dezena setenta)
        unid := (n mod 100) mod 10; // unid = 1 (unidade um)

        if (cent <> 0) then
          saux := centena[cent];
      
        if ((dez <> 0) or (unid <> 0)) then
        begin
          if ((n mod 100) <= 19) then
          begin
            if (length(saux) <> 0) then
              saux := saux + ' e ' + unidade[n mod 100]
            else
              saux := unidade[n mod 100];
          end
          else
          begin
            if (length(saux) <> 0) then
              saux := saux + ' e ' + dezena[dez]
            else saux := dezena[dez];

            if (unid <> 0) then
              if (length(saux) <> 0) then
                saux := saux + ' e ' + unidade[unid]
              else
                saux := unidade[unid];
          end;
        end;
      end;

      if ((vlrP = '1') or (vlrP = '001')) then
      begin
        if (i = 0)
          // 1a. parte do valor (um real)
        then
          umReal := true
        else
          saux := saux + ' ' + qualificaS[i];
      end
      else
      if (i <> 0) then
        saux := saux + ' ' + qualificaP[i];

      if (length(s) <> 0) then
        s := saux + ', ' + s
      else
        s := saux;
    end;

    if (((i = 0) or (i = 1)) and (length(s) <> 0)) then
      tem := true; // tem centena ou mil no valor

    i := i + 1; // pr�ximo qualificador: 1- mil, 2- milh�o, 3- bilh�o, ...
  end;

  if (length(s) <> 0) then
  begin
    if (umReal) then
      s := s + ' real'
    else
    if (tem) then
      s := s + ' reais'
    else
      s := s + ' de reais';
  end;

  // definindo o extenso dos centavos do valor
  if (centavos <> '0') then // valor com centavos
  begin
    if (length(s) <> 0) then// se n�o � valor somente com centavos
      s := s + ' e ';
    if (centavos = '1') then
      s := s + 'um centavo'
    else
    begin
      n := strtoint(centavos);
      if (n <= 19) then
        s := s + unidade[n]
      else
      begin // para n = 37, tem-se:
        unid := n mod 10; // unid = 37 % 10 = 7 (unidade sete)
        dez  := n div 10; // dez = 37 / 10 = 3 (dezena trinta)
        s := s + dezena[dez];
        if (unid <> 0) then
          s := s + ' e ' + unidade[unid];
      end;
      s := s + ' centavos';
    end;
  end;
  valorPorExtenso := s;
end;

{ TArqDiscos }

class function TArqDiscos.VerDiscoDrive(WPDrive: PChar): boolean;
var
  wTipoDrive: integer;
  wDrive: Char;
  wI, wNumDrive, wModoAnterior: Integer;
  wMsgCdRom, wMsgDisquete: string;
begin
  Result := true;
  wMsgDisquete := 'Disquete inexistente ou n�o formatado...';
  wMsgCdRom := 'Unidade de cdrom vazia...';
  wNumDrive := 0;
  wI := 0;
  wTipoDrive := GetDriveType(WPDrive);
  if (wTipoDrive = DRIVE_REMOVABLE) or (wTipoDrive = DRIVE_CDROM) then
  begin
    for wDrive := 'a' to 'z' do
    begin
      wI := wI + 1;
      if wDrive = Copy(WPDrive, 1, 1) then
      begin
        wNumDrive := wI;
        break;
      end;
    end;
    wModoAnterior := SetErrorMode(SEM_FAILCRITICALERRORS);
    try
      Result := DiskFree(wNumDrive) >= 0;
    finally
      SetErrorMode(wModoAnterior);
    end;
    if not Result then
    begin
      if wTipoDrive = DRIVE_REMOVABLE then
        Application.Messagebox(Pchar(wMsgDisquete), 'Aviso', MB_ICONERROR + MB_OK)
      else
        Application.Messagebox(Pchar(wMsgCdRom), 'Aviso', MB_ICONERROR + MB_OK);
    end;
  end;
end;

{ TSystem }

class function TSystem.HostName: String;
var
  wVersionRequested: word;
  lpWSAData: TWSAData;
  wHostName: PAnsiChar;
begin
  // Inicializa retorno
  Result := '';

  // Inicializa o servico de socket do windows
  wVersionRequested := 2;
  if WSAStartup(wVersionRequested, lpWSAData) <> 0 then
    Exit;

  try
    // Captura o host name local
    GetMem(wHostName,200);
    try
      if GetHostName(wHostName, 100) = 0 then
        Result := Result + wHostName;
    finally
      FreeMem(wHostName);
    end;
  finally
    // Libera servicos de Socket
    WSACleanup;
  end;
end;

class function TSystem.MacRede(IPAddress: String): String;
var
  DestIP: ULONG;
  MacAddr: Array [0..5] of Byte;
  MacAddrLen: ULONG;
  SendArpResult: Cardinal;
begin
  DestIP := inet_addr(PAnsiChar(AnsiString(IPAddress)));
  MacAddrLen := Length(MacAddr);
  SendArpResult := SendARP(DestIP, 0, @MacAddr, @MacAddrLen);

  if SendArpResult = NO_ERROR then
    Result := Format('%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X',
                     [MacAddr[0], MacAddr[1], MacAddr[2],
                      MacAddr[3], MacAddr[4], MacAddr[5]])
  else
    Result := '';
end;

class function TSystem.PathAlias(Alias: string): string;
begin
end;

{******************************************************************************
  Fun��o     : UserName
  Descri��o  : Obter o nome da Usuario logado na rede windows
 ******************************************************************************}
class function TSystem.UserName: String;
var
  wUserName: string;
  wSize: DWord;
begin
  wSize := 256;
  SetLength(wUserName, wSize);
  GetUserName(PChar(wUserName), wSize);
  SetLength(wUserName, StrLen(PChar(wUserName)));
  Result := wUserName;
end;

{ TValidacao }

class function TValidacao.CPF(xCPF: string): boolean;
var
  d1, d4, xx, nCount, resto, digito1, digito2, i: integer;
  Check: string;
begin
  d1 := 0;
  d4 := 0;
  xx := 1;

  Result := false;

  for i := 1 to length(xCPF) do
  begin
    if (copy(xCPF, i, 1) = '.') or (copy(xCPF, i, 1) = '-') or (copy(xCPF, i, 1) = '/') then
      delete(xCPF, i, 1);
  end;

  xCPF := trim(xCPF);

  if (xCPF = '00000000000') or (xCPF = '11111111111') or (xCPF = '22222222222') or
     (xCPF = '33333333333') or (xCPF = '44444444444') or (xCPF = '55555555555') or
     (xCPF = '66666666666') or (xCPF = '77777777777') or (xCPF = '88888888888') or
     (xCPF = '99999999999') then

    TMens.Erro(Pchar('CPF inv�lido!'))

  else if length(xCPF) <> 11 then
    TMens.Erro(Pchar('O CPF tem 11 digitos num�ricos!'))
  else
  begin

    for nCount := 1 to length(xCPF) - 2 do
    begin
      if Pos(Copy(xCPF, nCount, 1), '/-.') = 0 then
      begin
        d1 := d1 + (11 - xx) * strtoint(Copy(xCPF, nCount, 1));
        d4 := d4 + (12 - xx) * strtoint(Copy(xCPF, nCount, 1));
        xx := xx + 1;
      end;
    end;
    resto := (d1 mod 11);
    if resto < 2 then
      digito1 := 0
    else
      digito1 := 11 - resto;
    d4 := d4 + 2 * digito1;
    resto := (d4 mod 11);
    if resto < 2 then
      digito2 := 0
    else
      digito2 := 11 - resto;
    Check := inttostr(digito1) + inttostr(digito2);
    if Check <> Rightstr(xCPF, 2) then
    begin
      Result := False;
      TMens.Erro(Pchar('CPF inv�dido'));
    end
    else
      Result := true;
  end;
end;

class function TValidacao.CGC(xCGC: string): boolean;
var
  d1, d4, xx, nCount, fator, resto, digito1, digito2, i: Integer;
  Check: string;
begin
  d1 := 0;
  d4 := 0;
  xx := 1;

  for i := 1 to length(xCGC) do
  begin
    if (copy(xCGC, i, 1) = '.') or (copy(xCGC, i, 1) = '-') or (copy(xCGC, i, 1) = '/') then
      delete(xCGC, i, 1);
  end;

  xCGC := trim(xCGC);

  if length(xCGC) <> 14 then
    TMens.Erro(Pchar('O CNPJ tem 14 digitos num�ricos!'))
  else
  begin
    for nCount := 1 to length(xCGC) - 2 do
    begin
      if pos(Copy(xCGC, nCount, 1), '/-.') = 0 then
      begin
        if xx < 5 then
        begin
          fator := 6 - xx
        end
        else
        begin
          fator := 14 - xx;
        end;
        d1 := d1 + strtoint(copy(xCGC, nCount, 1)) * fator;
        if xx < 6 then
        begin
          fator := 7 - xx
        end
        else
        begin
          fator := 15 - xx;
        end;
        d4 := d4 + strtoint(Copy(xCGC, nCount, 1)) * fator;
        xx := xx + 1;
      end;
    end;
    resto := (d1 mod 11);
    if resto < 2 then
      digito1 := 0
    else
      digito1 := 11 - resto;
    d4 := d4 + 2 * digito1;
    resto := (d4 mod 11);
    if resto < 2 then
      digito2 := 0
    else
      digito2 := 11 - resto;
    Check := inttostr(Digito1) + inttostr(digito2);
    if Check <> RightStr(xCGC, 2) then
    begin
      TMens.Erro(Pchar('CNPJ inv�lido!'));
      result := false;
    end
    else
      result := true;
  end;
end;

class function TValidacao.VencMesmoDia(vencanterior: tdatetime): tdatetime;
var
  dia, mes, ano, DiaNovo, MesNovo, anoNovo, auxdia, auxmes, auxano: word;
  UltDiaMes, NovaData: TdateTime;
  uano, umes, udia: word;
  mDtTemp: TDateTime;
begin
  DecodeDate(vencanterior, ano, Mes, Dia);
  //calculando o proximo vencimento
  MesNovo := Mes + 1;
  if MesNovo > 12 then
  begin
    anoNovo := ano + 1;
    MesNovo := 1;
  end
  else
    anoNovo := ano;

  //retorna o ultimo dia o mes, de uma data fornecida
  NovaData := strtodate('01/' + inttostr(MesNovo) + '/' + inttostr(anoNovo));
  Decodedate(NovaData, uano, umes, udia);
  mDtTemp := (NovaData - udia) + 33;
  Decodedate(mDtTemp, uano, umes, udia);
  UltDiaMes := mDtTemp - udia;
  DecodeDate(UltDiaMes, auxano, auxmes, auxdia);

  //montado a nova data
  if Dia > auxdia then
    DiaNovo := auxdia
  else
    DiaNovo := Dia;

  Result := strtoDate(inttostr(DiaNovo) + '/' + inttostr(MesNovo) + '/' + inttostr(anoNovo));
end;

class function TValidacao.UltimoDiadoMes(data: tdatetime): tdatetime;
var
  dia, mes, ano, DiaNovo, MesNovo, anoNovo, auxdia, auxmes, auxano: word;
  UltDiaMes, NovaData: TdateTime;
  uano, umes, udia: word;
  mDtTemp, ultimodia: TDateTime;
begin
  DecodeDate(data, ano, Mes, Dia);
  //calculando o proximo vencimento
  MesNovo := Mes + 1;
  if MesNovo > 12 then
  begin
    anoNovo := ano + 1;
    MesNovo := 1;
  end
  else
    anoNovo := ano;

  //retorna o ultimo dia o mes, de uma data fornecida
  NovaData := strtodate('01/' + inttostr(MesNovo) + '/' + inttostr(anoNovo));
  Decodedate(NovaData, uano, umes, udia);
  mDtTemp := (NovaData - udia) + 33;
  Decodedate(mDtTemp, uano, umes, udia);
  UltDiaMes := mDtTemp - udia;
  DecodeDate(UltDiaMes, auxano, auxmes, auxdia);
  ultimodia := EncodeDate(auxano, auxmes, 1) - 1;
  DecodeDate(ultimodia, auxano, auxmes, dianovo);
  Result := strtoDate(inttostr(DiaNovo) + '/' + inttostr(auxmes) + '/' + inttostr(auxano));
end;

class function TValidacao.DiadoMes(data: tdatetime): tdatetime;
var
  dia, mes, ano, DiaNovo, MesNovo, anoNovo, auxdia, auxmes, auxano: word;
  UltDiaMes, NovaData: TdateTime;
  uano, umes, udia: word;
  mDtTemp, ultimodia: TDateTime;
begin
  DecodeDate(data, ano, Mes, Dia);
  //calculando o proximo vencimento
  MesNovo := Mes;
  anoNovo := ano;
  //retorna o ultimo dia o mes, de uma data fornecida
  NovaData := strtodate('01/' + inttostr(MesNovo) + '/' + inttostr(anoNovo));
  Decodedate(NovaData, uano, umes, udia);
  mDtTemp := (NovaData - udia) + 33;
  Decodedate(mDtTemp, uano, umes, udia);
  UltDiaMes := mDtTemp - udia;
  DecodeDate(UltDiaMes, auxano, auxmes, auxdia);
  Result := strtoDate(inttostr(auxdia) + '/' + inttostr(auxmes) + '/' + inttostr(auxano));
end;

class function TValidacao.DiaSemana(Data: TDateTime): String;
var {Retorna dia da semana}
  NoDia : Integer;
  DiaDaSemana : array [1..7] of String[13];
begin
{ Dias da Semana }
  DiaDasemana [1]:= 'Domingo';
  DiaDasemana [2]:= 'Segunda-feira';
  DiaDasemana [3]:= 'Ter�a-feira';
  DiaDasemana [4]:= 'Quarta-feira';
  DiaDasemana [5]:= 'Quinta-feira';
  DiaDasemana [6]:= 'Sexta-feira';
  DiaDasemana [7]:= 'S�bado';
  NoDia     := DayOfWeek(Data);
  DiaSemana := DiaDasemana[NoDia];
end;

class function TValidacao.QTDDias(xDataMaior, xDataMenor: TDateTime;
  RetiraDia: Integer): Integer;
var
  NDias, Retirar: Integer;
begin
  NDias := 0;
  Retirar := 0;
  while (xDataMenor + NDias) < xDataMaior do
  begin
    if DayOfWeek(xDataMenor + NDias) = RetiraDia then
      inc(Retirar);
    inc(NDias);
  end;
  Result := NDias - Retirar;
end;

class function TValidacao.RetiraEspacoDuplicado(Texto: string): String;
var
  x: Integer;
  sRetorno : String;
begin
  for x := 1 to Length(Texto) do
  begin
    if Texto[x] + Texto[x + 1] <> '  ' then
      sRetorno := sRetorno + Texto[x];
  end;

  Result := Trim(sRetorno);
end;

class function TValidacao.RetornaNumero(Valor: string): Double;
var
  I: Integer;
  Retorno : String;
begin
  try
    if Trim(Valor) <> EmptyStr then
    begin
      for I := 1 to length(Valor) do
        if Valor[I] <> '.' then
          Retorno := Retorno + Valor[I];
    end;
    Result := StrToFloat(Retorno);
  except
    Result := 0;
  end;
end;

class function TValidacao.ValidaEmail(Email: string): Boolean;
var
  i, j, tam_email, simb_arroba, simb_arroba2, qtd_arroba, qtd_pontos,
    qtd_pontos_dir, posicao, posicao2, ponto, ponto2: integer;
  vet_email: array of Char;
  Caracter_Invalido: Boolean;
begin
  SetLength(vet_email, Length(Email));
  qtd_pontos := 0;
  qtd_pontos_dir := 0;
  qtd_arroba := 0;
  posicao := 0;
  posicao2 := 0;
  simb_arroba := 0;
  simb_arroba2 := 0;
  ponto := 0;
  ponto2 := 0;
  Result := True;

  if Length(Email) = 0 then
  begin
    Result := False;
    Exit;
  end;

  //Verificando parte inicial do E-mail
  tam_email := Length(email);
  for i := 0 to tam_email - 1 do
  begin
    vet_email[i] := email[i + 1];
    if vet_email[i] = '@' then
    begin
      Inc(qtd_arroba);
      posicao := i;
    end;
  end;

  if ((vet_email[0] = '@') or (vet_email[0] = '.') or (vet_email[0] = '-')) then
  begin
    Result := False;
    Exit;
  end;

  //Verificando se tem o s�mbolo @ e quantos tem
  if qtd_arroba <> 1 then
  begin
    Result := False;
    Exit;
  end
  else
    //Verificando o que vem antes e depois do s�mbolo @
  begin
    for i := 0 to high(vet_valido) do
    begin
      if vet_email[posicao - 1] <> vet_valido[i] then
        Inc(simb_arroba)
      else
        Dec(simb_arroba);

      if vet_email[posicao + 1] <> vet_valido[i] then
        Inc(simb_arroba2)
      else
        Dec(simb_arroba2);
    end;
    if simb_arroba = (high(vet_valido) + 1) then
    begin
      //Antes do arroba h� um s�mbolo desconhecido do vetor v�lido
      Result := False;
      Exit;
    end
    else if simb_arroba2 = (high(vet_valido) + 1) then
    begin
      //Depois do arroba h� um s�mbolo desconhecido do vetor v�lido
      Result := False;
      Exit;
    end
  end;

  //Verificando se h� pontos e quantos, e Verificando parte final do e-mail
  for j := 0 to tam_email - 1 do
    if vet_email[j] = '-' then
      if ((vet_email[j - 1] = '.') or (vet_email[j - 1] = '-')) then
      begin
        Result := False;
        Exit;
      end;
  for i := 0 to tam_email - 1 do
    if vet_email[i] = '.' then
    begin
      Inc(qtd_pontos);
      posicao2 := i + 1;
      if i > posicao then
        Inc(qtd_pontos_dir);
      if ((vet_email[i - 1] = '.') or (vet_email[i - 1] = '-')) then
      begin
        Result := False;
        Exit;
      end;
    end;
  if qtd_pontos < 1 then
  begin
    Result := False;
    Exit;
  end
  else if vet_email[tam_email - 1] = '.' then
  begin
    Result := False;
    Exit;
  end
  else if vet_email[tam_email - 2] = '.' then
  begin
    Result := False;
    Exit;
  end
  else if qtd_pontos_dir > 3 then
  begin
    Result := False;
    Exit;
  end
  else if not ((((tam_email - posicao2) = 2) and (qtd_pontos_dir = 3)) or
    (((tam_email - posicao2) = 3) and (qtd_pontos_dir = 1)) or
    (((tam_email - posicao2) = 2) and (qtd_pontos_dir = 2)) or
    (((tam_email - posicao2) = 2) and (qtd_pontos_dir = 1))) then
  begin
    Result := False;
    Exit;
  end
  else
    //Verificando o que vem antes e depois do ponto
  begin
    for i := 0 to high(vet_valido) do
    begin
      if vet_email[posicao2 - 2] <> vet_valido[i] then
        Inc(ponto)
      else
        Dec(ponto);
      if vet_email[posicao2] <> vet_valido[i] then
        Inc(ponto2)
      else
        Dec(ponto2);
    end;
    if ponto = (high(vet_valido) + 1) then
    begin
      //Antes do ponto h� um s�mbolo desconhecido do vetor v�lido
      Result := False;
      Exit;
    end
    else if ponto2 = (high(vet_valido) + 1) then
    begin
      //Depois do ponto h� um s�mbolo desconhecido do vetor v�lido
      Result := False;
      Exit;
    end
  end;

  for i := 0 to high(vet_email) do
  begin
    if not (vet_email[i] in ['@', '.', '-', '_']) then
    begin
      Caracter_Invalido := True;
      for j := 0 to high(vet_valido) do
      begin
        if vet_email[i] = vet_valido[j] then
        begin
          Caracter_Invalido := False;
          Break;
        end;
      end;
      if Caracter_Invalido then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

class function TValidacao.Inscricao(Inscricao, Tipo: string): Boolean;
var
  Contador: ShortInt;
  Casos: ShortInt;
  Digitos: ShortInt;

  Tabela_1: string;
  Tabela_2: string;
  Tabela_3: string;

  Base_1: string;
  Base_2: string;
  Base_3: string;

  Valor_1: ShortInt;

  Soma_1: Integer;
  Soma_2: Integer;

  Erro_1: ShortInt;
  Erro_2: ShortInt;
  Erro_3: ShortInt;

  Posicao_1: string;
  Posicao_2: string;

  Tabela: string;
  Rotina: string;
  Modulo: ShortInt;
  Peso: string;

  Digito: ShortInt;

  Resultado: string;
  Retorno: Boolean;
begin
  try

    Tabela_1 := ' ';
    Tabela_2 := ' ';
    Tabela_3 := ' ';

    { }{ }
    { Valores possiveis para os digitos (j) }
    { }
    { 0 a 9 = Somente o digito indicado. }
    { N = Numeros 0 1 2 3 4 5 6 7 8 ou 9 }
    { A = Numeros 1 2 3 4 5 6 7 8 ou 9 }
    { B = Numeros 0 3 5 7 ou 8 }
    { C = Numeros 4 ou 7 }
    { D = Numeros 3 ou 4 }
    { E = Numeros 0 ou 8 }
    { F = Numeros 0 1 ou 5 }
    { G = Numeros 1 7 8 ou 9 }
    { H = Numeros 0 1 2 ou 3 }
    { I = Numeros 0 1 2 3 ou 4 }
    { J = Numeros 0 ou 9 }
    { K = Numeros 1 2 3 ou 9 }
    { }
    { -------------------------------------------------------- }
    { }
    { Valores possiveis para as rotinas (d) e (g) }
    { }
    { A a E = Somente a Letra indicada. }
    { 0 = B e D }
    { 1 = C e E }
    { 2 = A e E }
    { }
    { -------------------------------------------------------- }
    { }
    { C T F R M P R M P }
    { A A A O O E O O E }
    { S M T T D S T D S }
    { }
    { a b c d e f g h i jjjjjjjjjjjjjj }
    { 0000000001111111111222222222233333333 }
    { 1234567890123456789012345678901234567 }

    if Tipo = 'AC' then
      Tabela_1 := '1.09.0.E.11.01. . . . 01NNNNNNX.14.00';
    if Tipo = 'AC' then
      Tabela_2 := '2.13.0.E.11.02.E.11.01. 01NNNNNNNNNXY.13.14';
    if Tipo = 'AL' then
      Tabela_1 := '1.09.0.0.11.01. . . . 24BNNNNNX.14.00';
    if Tipo = 'AP' then
      Tabela_1 := '1.09.0.1.11.01. . . . 03NNNNNNX.14.00';
    if Tipo = 'AP' then
      Tabela_2 := '2.09.1.1.11.01. . . . 03NNNNNNX.14.00';
    if Tipo = 'AP' then
      Tabela_3 := '3.09.0.E.11.01. . . . 03NNNNNNX.14.00';
    if Tipo = 'AM' then
      Tabela_1 := '1.09.0.E.11.01. . . . 0CNNNNNNX.14.00';
    if Tipo = 'BA' then
      Tabela_1 := '1.08.0.E.10.02.E.10.03. NNNNNNYX.14.13';
    if Tipo = 'BA' then
      Tabela_2 := '2.08.0.E.11.02.E.11.03. NNNNNNYX.14.13';
    if Tipo = 'CE' then
      Tabela_1 := '1.09.0.E.11.01. . . . 0NNNNNNNX.14.13';
    if Tipo = 'DF' then
      Tabela_1 := '1.13.0.E.11.02.E.11.01. 07DNNNNNNNNXY.13.14';
    if Tipo = 'ES' then
      Tabela_1 := '1.09.0.E.11.01. . . . 0ENNNNNNX.14.00';
    if Tipo = 'GO' then
      Tabela_1 := '1.09.1.E.11.01. . . . 1FNNNNNNX.14.00';
    if Tipo = 'GO' then
      Tabela_2 := '2.09.0.E.11.01. . . . 1FNNNNNNX.14.00';
    if Tipo = 'MA' then
      Tabela_1 := '1.09.0.E.11.01. . . . 12NNNNNNX.14.00';
    if Tipo = 'MT' then
      Tabela_1 := '1.11.0.E.11.01. . . . NNNNNNNNNNX.14.00';
    if Tipo = 'MS' then
      Tabela_1 := '1.09.0.E.11.01. . . . 28NNNNNNX.14.00';
    if Tipo = 'MG' then
      Tabela_1 := '1.13.0.2.10.10.E.11.11. NNNNNNNNNNNXY.13.14';
    if Tipo = 'PA' then
      Tabela_1 := '1.09.0.E.11.01. . . . 15NNNNNNX.14.00';
    if Tipo = 'PB' then
      Tabela_1 := '1.09.0.E.11.01. . . . 16NNNNNNX.14.00';
    if Tipo = 'PR' then
      Tabela_1 := '1.10.0.E.11.09.E.11.08. NNNNNNNNXY.13.14';
    if Tipo = 'PE' then
      Tabela_1 := '1.14.1.E.11.07. . . .18ANNNNNNNNNNX.14.00';
    if Tipo = 'PI' then
      Tabela_1 := '1.09.0.E.11.01. . . . 19NNNNNNX.14.00';
    if Tipo = 'RJ' then
      Tabela_1 := '1.08.0.E.11.08. . . . GNNNNNNX.14.00';
    if Tipo = 'RN' then
      Tabela_1 := '1.09.0.0.11.01. . . . 20HNNNNNX.14.00';
    if Tipo = 'RS' then
      Tabela_1 := '1.10.0.E.11.01. . . . INNNNNNNNX.14.00';
    if Tipo = 'RO' then
      Tabela_1 := '1.09.1.E.11.04. . . . ANNNNNNNX.14.00';
    if Tipo = 'RO' then
      Tabela_2 := '2.14.0.E.11.01. . . .NNNNNNNNNNNNNX.14.00';
    if Tipo = 'RR' then
      Tabela_1 := '1.09.0.D.09.05. . . . 24NNNNNNX.14.00';
    if Tipo = 'SC' then
      Tabela_1 := '1.09.0.E.11.01. . . . NNNNNNNNX.14.00';
    if Tipo = 'SP' then
      Tabela_1 := '1.12.0.D.11.12.D.11.13. NNNNNNNNXNNY.11.14';
    if Tipo = 'SP' then
      Tabela_2 := '2.12.0.D.11.12. . . . NNNNNNNNXNNN.11.00';
    if Tipo = 'SE' then
      Tabela_1 := '1.09.0.E.11.01. . . . NNNNNNNNX.14.00';
    if Tipo = 'TO' then
      Tabela_1 := '1.11.0.E.11.06. . . . 29JKNNNNNNX.14.00';

    if Tipo = 'CNPJ' then
      Tabela_1 := '1.14.0.E.11.21.E.11.22.NNNNNNNNNNNNXY.13.14';
    if Tipo = 'CPF' then
      Tabela_1 := '1.11.0.E.11.31.E.11.32. NNNNNNNNNXY.13.14';

    { Deixa somente os numeros }

    Base_1 := '';

    for Contador := 1 to 30 do
      if Pos(Copy(Inscricao, Contador, 1), '0123456789') <> 0 then
        Base_1 := Base_1 + Copy(Inscricao, Contador, 1);

    { Repete 3x - 1 para cada caso possivel }

    Casos := 0;

    Erro_1 := 0;
    Erro_2 := 0;
    Erro_3 := 0;

    while Casos < 3 do
    begin

      Casos := Casos + 1;

      if Casos = 1 then Tabela := Tabela_1;
      if Casos = 2 then Erro_1 := Erro_3;
      if Casos = 2 then Tabela := Tabela_2;
      if Casos = 3 then Erro_2 := Erro_3;
      if Casos = 3 then Tabela := Tabela_3;

      Erro_3 := 0;

      if Copy(Tabela, 1, 1) <> ' ' then
      begin
        { Verifica o Tamanho }

        if Length(Trim(Base_1)) <> (StrToInt(Copy(Tabela, 3, 2))) then
          Erro_3 := 1;

        if Erro_3 = 0 then
        begin

          { Ajusta o Tamanho }

          Base_2 := Copy(' ' + Base_1, Length(' ' + Base_1) - 13, 14);

          { Compara com valores possivel para cada uma da 14 posi��es }

          Contador := 0;

          while (Contador < 14) and (Erro_3 = 0) do
          begin

            Contador := Contador + 1;

            Posicao_1 := Copy(Copy(Tabela, 24, 14), Contador, 1);
            Posicao_2 := Copy(Base_2, Contador, 1);

            if (Posicao_1 = ' ') and (Posicao_2 <> ' ') then
              Erro_3 := 1;
            if (Posicao_1 = 'N') and (Pos(Posicao_2, '0123456789') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'A') and (Pos(Posicao_2, '123456789') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'B') and (Pos(Posicao_2, '03578') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'C') and (Pos(Posicao_2, '47') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'D') and (Pos(Posicao_2, '34') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'E') and (Pos(Posicao_2, '08') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'F') and (Pos(Posicao_2, '015') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'G') and (Pos(Posicao_2, '1789') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'H') and (Pos(Posicao_2, '0123') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'I') and (Pos(Posicao_2, '01234') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'J') and (Pos(Posicao_2, '09') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'K') and (Pos(Posicao_2, '1239') = 0) then
              Erro_3 := 1;
            if (Posicao_1 <> Posicao_2) and (Pos(Posicao_1, '0123456789') > 0) then
              Erro_3 := 1;

          end;

          { Calcula os Digitos }

          Rotina := ' ';
          Digitos := 000;
          Digito := 000;

          while (Digitos < 2) and (Erro_3 = 0) do
          begin

            Digitos := Digitos + 1;

            { Carrega peso }

            Peso := Copy(Tabela, 5 + (Digitos * 8), 2);

            if Peso <> ' ' then
            begin

              Rotina := Copy(Tabela, 0 + (Digitos * 8), 1);
              Modulo := StrToInt(Copy(Tabela, 2 + (Digitos * 8), 2));

              if Peso = '01' then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
              if Peso = '02' then
                Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
              if Peso = '03' then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.00.02';
              if Peso = '04' then
                Peso := '00.00.00.00.00.00.00.00.06.05.04.03.02.00';
              if Peso = '05' then
                Peso := '00.00.00.00.00.01.02.03.04.05.06.07.08.00';
              if Peso = '06' then
                Peso := '00.00.00.09.08.00.00.07.06.05.04.03.02.00';
              if Peso = '07' then
                Peso := '05.04.03.02.01.09.08.07.06.05.04.03.02.00';
              if Peso = '08' then
                Peso := '08.07.06.05.04.03.02.07.06.05.04.03.02.00';
              if Peso = '09' then
                Peso := '07.06.05.04.03.02.07.06.05.04.03.02.00.00';
              if Peso = '10' then
                Peso := '00.01.02.01.01.02.01.02.01.02.01.02.00.00';
              if Peso = '11' then
                Peso := '00.03.02.11.10.09.08.07.06.05.04.03.02.00';
              if Peso = '12' then
                Peso := '00.00.01.03.04.05.06.07.08.10.00.00.00.00';
              if Peso = '13' then
                Peso := '00.00.03.02.10.09.08.07.06.05.04.03.02.00';
              if Peso = '21' then
                Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
              if Peso = '22' then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
              if Peso = '31' then
                Peso := '00.00.00.10.09.08.07.06.05.04.03.02.00.00';
              if Peso = '32' then
                Peso := '00.00.00.11.10.09.08.07.06.05.04.03.02.00';

              { Multiplica }

              Base_3 := Copy(('0000000000000000' + Trim(Base_2)), Length(('0000000000000000' + Trim(Base_2))) - 13, 14);

              Soma_1 := 0;
              Soma_2 := 0;

              for Contador := 1 to 14 do
              begin

                Valor_1 := (StrToInt(Copy(Base_3, Contador, 01)) * StrToInt(Copy(Peso, Contador * 3 - 2, 2)));

                Soma_1 := Soma_1 + Valor_1;

                if Valor_1 > 9 then
                  Valor_1 := Valor_1 - 9;

                Soma_2 := Soma_2 + Valor_1;

              end;

              { Ajusta valor da soma }

              if Pos(Rotina, 'A2') > 0 then
                Soma_1 := Soma_2;
              if Pos(Rotina, 'B0') > 0 then
                Soma_1 := Soma_1 * 10;
              if Pos(Rotina, 'C1') > 0 then
                Soma_1 := Soma_1 + (5 + 4 * StrToInt(Copy(Tabela, 6, 1)));

              { Calcula o Digito }

              if Pos(Rotina, 'D0') > 0 then
                Digito := Soma_1 mod Modulo;
              if Pos(Rotina, 'E12') > 0 then
                Digito := Modulo - (Soma_1 mod Modulo);

              if Digito < 10 then
                Resultado := IntToStr(Digito);
              if Digito = 10 then
                Resultado := '0';
              if Digito = 11 then
                Resultado := Copy(Tabela, 6, 1);

              { Verifica o Digito }

              if (Copy(Base_2, StrToInt(Copy(Tabela, 36 + (Digitos * 3), 2)), 1) <> Resultado) then
                Erro_3 := 1;

            end;

          end;

        end;

      end;

    end;

    { Retorna o resultado da Verifica��o }

    Retorno := FALSE;

    if (Trim(Tabela_1) <> '') and (ERRO_1 = 0) then
      Retorno := TRUE;
    if (Trim(Tabela_2) <> '') and (ERRO_2 = 0) then
      Retorno := TRUE;
    if (Trim(Tabela_3) <> '') and (ERRO_3 = 0) then
      Retorno := TRUE;

    if Trim(Inscricao) = 'ISENTO' then
      Retorno := TRUE;

    Result := Retorno;
  except
    Result := False;
  end;
end;

class function TValidacao.Mascara_Inscricao(Inscricao, Estado: string): string;
var
  Mascara: string;
  Contador_1: Integer;
  Contador_2: Integer;
begin
  if Estado = 'AC' then
    Mascara := '**.***.***/***-**';
  if Estado = 'AL' then
    Mascara := '*********';
  if Estado = 'AP' then
    Mascara := '*********';
  if Estado = 'AM' then
    Mascara := '**.***.***-*';
  if Estado = 'BA' then
    Mascara := '******-**';
  if Estado = 'CE' then
    Mascara := '********-*';
  if Estado = 'DF' then
    Mascara := '***********-**';
  if Estado = 'ES' then
    Mascara := '*********';
  if Estado = 'GO' then
    Mascara := '**.***.***-*';
  if Estado = 'MA' then
    Mascara := '*********';
  if Estado = 'MT' then
    Mascara := '**********-*';
  if Estado = 'MS' then
    Mascara := '*********';
  if Estado = 'MG' then
    Mascara := '***.***.***/****';
  if Estado = 'PA' then
    Mascara := '**-******-*';
  if Estado = 'PB' then
    Mascara := '********-*';
  if Estado = 'PR' then
    Mascara := '********-**';
  if Estado = 'PE' then
    Mascara := '**.*.***.*******-*';
  if Estado = 'PI' then
    Mascara := '*********';
  if Estado = 'RJ' then
    Mascara := '**.***.**-*';
  if Estado = 'RN' then
    Mascara := '**.***.***-*';
  if Estado = 'RS' then
    Mascara := '***/*******';
  if Estado = 'RO' then
    Mascara := '***.*****-*';
  if Estado = 'RR' then
    Mascara := '********-*';
  if Estado = 'SC' then
    Mascara := '***.***.***';
  if Estado = 'SP' then
    Mascara := '***.***.***.***';
  if Estado = 'SE' then
    Mascara := '*********-*';
  if Estado = 'TO' then
    Mascara := '***********';

  Contador_2 := 1;

  Result := '';

  Mascara := Mascara + '****';

  for Contador_1 := 1 to Length(Mascara) do
  begin

    if Copy(Mascara, Contador_1, 1) = '*' then
      Result := Result + Copy(Inscricao, Contador_2, 1);
    if Copy(Mascara, Contador_1, 1) <> '*' then
      Result := Result + Copy(Mascara, Contador_1, 1);

    if Copy(Mascara, Contador_1, 1) = '*' then
      Contador_2 := Contador_2 + 1;
  end;
  Result := Trim(Result);
end;

function RetiraAcentos(Texto: String): String;
var
  i, TamanhoTexto: Integer;
begin
  Texto := Trim(AnsiUpperCase(Texto));
  TamanhoTexto := Length(Texto);
  for i := 1 to (TamanhoTexto) do
  begin
    if Pos(Texto[i], ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') = 0 then
    begin
      case Texto[i] of
        '�', '�', '�', '�', '�': Texto[i] := 'A';
        '�', '�', '�', '�': Texto[i] := 'E';
        '�', '�', '�', '�': Texto[i] := 'I';
        '�', '�', '�', '�', '�': Texto[i] := 'O';
        '�', '�', '�', '�': Texto[i] := 'U';
        '�': Texto[i] := 'C';
        '�': Texto[i] := 'N';
      else
        Texto[i] := ' ';
      end;
    end;
  end;
  Result := Texto;
end;

function Formatar(Texto: string; TamanhoDesejado: integer; AcrescentarADireita: boolean = true; CaracterAcrescentar: char = ' '): string;
{
   OBJETIVO: Eliminar caracteres inv�lidos e acrescentar caracteres � esquerda
             ou � direita do texto original para que a string resultante fique com o tamanho desejado

   Texto : Texto original
   TamanhoDesejado: Tamanho que a string resultante dever� ter
   AcrescentarADireita: Indica se o car�cter ser� acrescentado � direita ou � esquerda
      TRUE - Se o tamanho do texto for MENOR que o desejado, acrescentar car�cter � direita
             Se o tamanho do texto for MAIOR que o desejado, eliminar �ltimos caracteres do texto
      FALSE - Se o tamanho do texto for MENOR que o desejado, acrescentar car�cter � esquerda
             Se o tamanho do texto for MAIOR que o desejado, eliminar primeiros caracteres do texto
   CaracterAcrescentar: Car�cter que dever� ser acrescentado
}
var
  QuantidadeAcrescentar,
    TamanhoTexto,
    PosicaoInicial,
    i: integer;

begin
  case CaracterAcrescentar of
    '0'..'9', 'a'..'z', 'A'..'Z': ; {N�o faz nada}
  else
    CaracterAcrescentar := ' ';
  end;

  Texto := Trim(AnsiUpperCase(Texto));
  TamanhoTexto := Length(Texto);
  for i := 1 to (TamanhoTexto) do
  begin
    if Pos(Texto[i], ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') = 0 then
    begin
      case Texto[i] of
        '�', '�', '�', '�', '�': Texto[i] := 'A';
        '�', '�', '�', '�': Texto[i] := 'E';
        '�', '�', '�', '�': Texto[i] := 'I';
        '�', '�', '�', '�', '�': Texto[i] := 'O';
        '�', '�', '�', '�': Texto[i] := 'U';
        '�': Texto[i] := 'C';
        '�': Texto[i] := 'N';
      else
        Texto[i] := ' ';
      end;
    end;
  end;

  QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;
  if QuantidadeAcrescentar < 0 then
    QuantidadeAcrescentar := 0;
  if CaracterAcrescentar = '' then
    CaracterAcrescentar := ' ';
  if TamanhoTexto >= TamanhoDesejado then
    PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
  else
    PosicaoInicial := 1;

  if AcrescentarADireita then
    Texto := Copy(Texto, 1, TamanhoDesejado) + StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar)
  else
    Texto := StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar) + Copy(Texto, PosicaoInicial, TamanhoDesejado);

  Result := AnsiUpperCase(Texto);
end;

function StrReplace(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := AnsiUpperCase(S);
    Patt := AnsiUpperCase(OldPattern);
  end
  else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function ReplaceStr(const AText, AFromText, AToText: string): string;
begin
  Result := StringReplace(AText, AFromText, AToText, [rfReplaceAll]);
end;

function Administrador : Boolean;
begin
  with DM, SqlAuxiliar do
  begin
    Close;
    SQL.Text := ' SELECT T009_ADMINISTRADOR, '+
                '        T009_BLOQUEADO, '+
                '        T009_DATA_EXPIRA '+
                '   FROM T009_USUARIO '+
                '  WHERE T009_CODIGO ='+IntToStr(FrmPrincipal.iUsuarioCodigo);
    Open;

    Result := FieldByName('T009_ADMINISTRADOR').AsString = 'S';
  end;
end;

procedure CriaMenuAtalho;
begin
  if not DM.SqlAuxiliar.Transaction.Active then
    DM.SqlAuxiliar.Transaction.StartTransaction;

  DM.SqlAuxiliar.Close;
  DM.SqlAuxiliar.SQL.Text := ' INSERT INTO GEN_ATALHOS ('+
                             ' ID_USUARIO,'+
                             ' NOME_MENU,'+
                             ' CAPTION_MENU'+
                             ') VALUES ('+
                             ' :ID_USUARIO,'+
                             ' :NOME_MENU,'+
                             ' :CAPTION_MENU)';

  DM.SqlAuxiliar.ParamByName('ID_USUARIO').AsInteger := FrmPrincipal.iUsuarioCodigo;
  DM.SqlAuxiliar.ParamByName('NOME_MENU').AsString    := FrmPrincipal.sNomeMenu;
  DM.SqlAuxiliar.ParamByName('CAPTION_MENU').AsString := FrmPrincipal.sCaptionMenu;
  DM.SqlAuxiliar.ExecSQL;

  DM.Commit;

  FrmPrincipal.MontaAtalhos;
end;

procedure ExcluiMenuAtalho;
begin
  DM.SqlAuxiliar.Close;
  if FrmPrincipal.iUsuarioCodigo > 0 then
  begin
    DM.SqlAuxiliar.SQL.Text := ' DELETE FROM GEN_ATALHOS '+
                               '  WHERE ID_USUARIO  =:ID_USUARIO '+
                               '    AND NOME_MENU    =:NOME_MENU   ';
    DM.SqlAuxiliar.ParamByName('ID_USUARIO').AsInteger := FrmPrincipal.iUsuarioCodigo;
    DM.SqlAuxiliar.ParamByName('NOME_MENU').AsString    := DM.sNomeMenuClick;
  end
  else
  begin
    DM.SqlAuxiliar.SQL.Text := ' DELETE FROM GEN_ATALHOS '+
                               '  WHERE NOME_MENU =:NOME_MENU ';
    DM.SqlAuxiliar.ParamByName('NOME_MENU').AsString := DM.sNomeMenuClick;
  end;
  
  DM.SqlAuxiliar.ExecSQL;
  DM.Commit;

  FrmPrincipal.MontaAtalhos;
end;

procedure CriarForm(pStrNomeForm: string);
var
  APersistentClass: TPersistentClass;
  sClassName: string;
  AForm: TForm;
begin
  APersistentClass := GetClass(pStrNomeForm);
  if APersistentClass = nil then
    raise Exception.Create('Aviso essa class n�o foi localizada, contate um suporte.')
  else
  begin
    AForm := TComponentClass(APersistentClass).Create(Application) as TForm;
    AForm.ShowModal;
    AForm.Free;
  end;
end;

procedure ChamaForm(InstanceClass : TComponentClass; var Reference; Sender : TOBject; Obj : TObject = nil);
var
  sForm : TForm;
  sTabSheet : TTabSheet;
  I : Integer;
begin
  try
    if TMenuItem(Sender).Tag = 1 then
    begin
      Application.CreateForm(InstanceClass, Reference);
      TFrmCadPadrao(Reference).ChamaMnt;
      FreeAndNil(TForm(Reference));
    end
    else
    begin
      sTabSheet := TTabSheet.Create(FrmPrincipal.PageControlPrincipal);
      sTabSheet.PageControl := FrmPrincipal.PageControlPrincipal;
      sTabSheet.Name        := 'ts'+TMenuItem(Sender).Name;
      sTabSheet.OnShow      := FrmPrincipal.TabSheet_Enter;

      DM.sNomeMenuClick := TMenuItem(Sender).Name;
      FrmPrincipal.PageControlPrincipal.Visible := True;
      FrmPrincipal.cbPeriodoLetivo.Enabled      := False;
      FrmPrincipal.PageControlPrincipal.Align   := alClient;

      sTabSheet.Parent     := FrmPrincipal.PageControlPrincipal;
      sTabSheet.TabVisible := True;
      sTabSheet.Visible    := True;

      Application.CreateForm(InstanceClass, Reference);
      if Sender is TMenuItem then
        sTabSheet.Caption       := TMenuItem(Sender).Caption //TForm(Reference).Caption;
      else
        sTabSheet.Caption       := TAction(Sender).Caption; //TForm(Reference).Caption;

      sTabSheet.hint            := TForm(Reference).Name;
      FrmPrincipal.sNomeTela    := TForm(Reference).Name;
      FrmPrincipal.sNomeMenu    := TMenuItem(Sender).Name;
      FrmPrincipal.sCaptionMenu := TForm(Reference).Caption;

      DM.sTabSheetPrinc := sTabSheet;
      TForm(Reference).Parent := sTabSheet;
      TForm(Reference).Align  := alClient;
      FrmPrincipal.PageControlPrincipal.ActivePage := sTabSheet;

      if Obj <> nil then
        TFrmPadrao(Reference).vObj := Obj;

      TForm(Reference).Show;
    end;
  except
    FreeAndNil(sTabSheet);

    for I := 0 to FrmPrincipal.PageControlPrincipal.ComponentCount -1 do
    begin
      if FrmPrincipal.PageControlPrincipal.Components[I] is TTabSheet then
        if FrmPrincipal.PageControlPrincipal.Components[I].Name = 'ts'+TMenuItem(Sender).Name then
        begin
//          FrmPrincipal.PageControlPrincipal.ActivePage := TTabSheet(FrmPrincipal.PageControlPrincipal.Components[I]);
          sTabSheet := TTabSheet(FrmPrincipal.PageControlPrincipal.Components[I]);
          FrmPrincipal.PageControlPrincipal.ActivePage := sTabSheet;
          Break;
        end;
    end;

    //Exit;
  end;
end;

procedure CarregarModulo(pStrFile: string);
begin
  if FileExists(pStrFile) then
  begin
    SetLength(Modulos, Length(Modulos) + 1);
    Modulos[Length(Modulos) - 1] := LoadPackage(pStrFile);
  end;
end;

procedure DescarregarModulos;
var
  pInt: integer;
begin
  try
    for pInt := 0 to Length(Modulos) - 1 do
    begin
      if Modulos[pInt] <> 0 then
        UnloadPackage(Modulos[pInt]);
    end;
    SetLength(Modulos, 0);
  except

  end;
end;


function RetornaApenasNumero(Chave: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Chave) do
  begin
    case Chave[I] of
      '1': Result := Result + '1';
      '2': Result := Result + '2';
      '3': Result := Result + '3';
      '4': Result := Result + '4';
      '5': Result := Result + '5';
      '6': Result := Result + '6';
      '7': Result := Result + '7';
      '8': Result := Result + '8';
      '9': Result := Result + '9';
      '0': Result := Result + '0';
      ',': Result := Result + '.';
      '.': Result := Result + '.';
    end;
  end
end;

class function TValidacao.TiraMascara(Chave: string): string;
var
  I: Integer;
  Produto: string;
begin
  for I := 1 to Length(Chave) do
    case Chave[I] of
      '1': Produto := Produto + '1';
      '2': Produto := Produto + '2';
      '3': Produto := Produto + '3';
      '4': Produto := Produto + '4';
      '5': Produto := Produto + '5';
      '6': Produto := Produto + '6';
      '7': Produto := Produto + '7';
      '8': Produto := Produto + '8';
      '9': Produto := Produto + '9';
      '0': Produto := Produto + '0';
    end;
  Result := Produto;
end;

function RetornaMes(NumeroMes: Integer): string;
begin
  case NumeroMes of
    1: Result := 'Jan';
    2: Result := 'Fev';
    3: Result := 'Mar';
    4: Result := 'Abr';
    5: Result := 'Mai';
    6: Result := 'Jun';
    7: Result := 'Jul';
    8: Result := 'Ago';
    9: Result := 'Set';
    10: Result := 'Out';
    11: Result := 'Nov';
    12: Result := 'Dez';
  end;
end;

class function TValidacao.GetComparaValores(Valor1, Valor2: Currency;
  Operador: string; Tolerancia: Currency): Boolean;
var
  pCurDiferenca: Currency;
begin
  pCurDiferenca := Valor1 - Valor2;
  if pCurDiferenca < 0 then
    pCurDiferenca := pCurDiferenca * (-1)
  else if pCurDiferenca = 0 then
    Tolerancia := 0;

  if Operador = '=' then
    Result := (CurrToStr(Valor1) = CurrToStr(Valor2)) or (pCurDiferenca < Tolerancia)
  else if Operador = '<=' then
    Result := ((CurrToStr(Valor1) <> CurrToStr(Valor2)) and (Valor1 <= Valor2)) or (pCurDiferenca < Tolerancia)
  else if Operador = '>=' then
    Result := ((CurrToStr(Valor1) <> CurrToStr(Valor2)) and (Valor1 >= Valor2)) or (pCurDiferenca < Tolerancia)
  else if Operador = '<' then
    Result := ((CurrToStr(Valor1) <> CurrToStr(Valor2)) and (Valor1 < Valor2)) or (pCurDiferenca < Tolerancia)
  else if Operador = '>' then
    Result := ((CurrToStr(Valor1) <> CurrToStr(Valor2)) and (Valor1 > Valor2)) or (pCurDiferenca < Tolerancia);

  Result := Result;
end;

{.: Bruno Borba - Desenvolvedor - APS Inform�tica - 05/07/2007 :.}

class function TValidacao.Criptografa(Autorizacao: string): string;
var
  Vet: Integer;
  CT: Integer;
  Aux: string;
begin
  Result := '';
  CT := 0;
  Vet := 0;
  Aux := '';
  Autorizacao := UpperCase(Autorizacao);
  for Vet := 1 to Length(Autorizacao) do
  begin
    for CT := 1 to 80 do
    begin
      if (Autorizacao[Vet] = Caractere[CT])
        then
      begin
        Aux := Aux + Subst[CT];
      end;
    end;
  end;
  Result := Aux;
end;

class function TValidacao.DeCriptografa(Codigo: string): string;
var
  Vet: Integer;
  CT: Integer;
  CT_Ax: Integer;
  Aux: string;
begin
  Result := '';
  CT := 0;
  CT_Ax := 0;
  Vet := 0;
  Aux := '';
  Codigo := uppercase(Codigo);
  for Vet := 1 to Length(Codigo) do
  begin
    for CT := 1 to 80 do
    begin
      if (Copy(Codigo, CT_Ax + 1, 2) = Subst[CT])
        then
      begin
        Aux := Aux + Caractere[CT];
      end;
    end;
    Inc(CT_Ax, 2);
  end;
  Result := LowerCase(Aux);
end;

class procedure TValidacao.DeCriptografaLista(Lista: TStrings; var ListaRetorno : TStrings);
var
  I : Integer;
  sRetorno: TStrings;
begin
  for I := 0 to Lista.Count-1 do
  begin
    ListaRetorno.Add(DeCriptografa(Lista[I]));
  end;
end;

class function TValidacao.DescripCript(wStri : string):String;
var
  Simbolos : array [0..4] of String;
  x        : Integer;
begin
  Simbolos[1]:= 'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()';
  Simbolos[2]:= '�����׃����5�����Ѫ�������������������';
  Simbolos[3]:= 'abcdefghijlmnopqrstuvxzywk1234567890';
  Simbolos[4]:= '���������龶����-+��߸������յ��졫�';

  for x := 1 to Length(Trim(wStri)) do
  begin
    if pos(copy(wStri,x,1),Simbolos[1])>0 then
        Result := Result+copy(Simbolos[2],
                      pos(copy(wStri,x,1),Simbolos[1]),1)

    else if pos(copy(wStri,x,1),Simbolos[2])>0 then
        Result := Result+copy(Simbolos[1],
                      pos(copy(wStri,x,1),Simbolos[2]),1)

    else if pos(copy(wStri,x,1),Simbolos[3])>0 then
        Result := Result+copy(Simbolos[4],
                      pos(copy(wStri,x,1),Simbolos[3]),1)

    else if pos(copy(wStri,x,1),Simbolos[4])>0 then
        Result := Result+copy(Simbolos[3],
                      pos(copy(wStri,x,1),Simbolos[4]),1);
  end;
end;

{.: Fim :.}

{.: Bruno Borba - Desenvolvedor - APS Inform�tica - 05/07/2007 :.}

//class function TValidacao.Autorizacao(CPFCNPJ: string; Usuario: string; ValorPed: Currency; Loja: Integer; Codigo: Integer; Data: TDateTime; parc: Integer; DiasPrimeira: Integer; Dias: Integer): string;
//var
//  AutorizacaoCript: string;
//  qDividPace, qValorParc, qValorResta: Currency;
//  IntX: Integer;
//  DataParcela: TDate;
//begin
//  if dmcad.pubInfComercio.ReadString('BANCO MASTER', 'AUTORIZACAO', '') = 'S' then
//  begin
//    try
//      DMCad.IBD_Matriz.Close;
//      dmcad.IBD_Matriz.DatabaseName := dmcad.pubInfComercio.ReadString('BANCO MASTER', '2', '');
//      dmcad.IBD_Matriz.Open;
//    except
//      Result := 'B'; // Banco Desconectado
//      exit;
//    end;
//  end;
//  with dmcad.IBQry_Matriz do
//  begin
//    close;
//    sql.Clear;
//    sql.Add('Select SALDO From STPRET_AUTORIZACAO(:CPFCNPJ)');
//    Params[0].AsString := CPFCNPJ;
//    prepare;
//    open;
//
//    if FieldByName('SALDO').AsCurrency >= ValorPed then
//    begin
//      AutorizacaoCript := TValidacao.Criptografa(IntToStr(Codigo) + '|' + CurrToStr(ValorPed));
//      qValorResta := ValorPed;
//      DataParcela := Data + DiasPrimeira;
//      for IntX := 1 to parc do
//      begin
//        qDividPace := 1 + (parc - IntX);
//        qValorParc := RoundTo(qValorResta / qDividPace, -2);
//        qValorResta := (qValorResta - qValorParc);
//
//        close;
//        sql.Clear;
//        sql.Add('Select AUTORIZA From MAUTORIZACAO(:EAUTO_LOJA, :EAUTO_CODPEDVEN, :EAUTO_CPFCGC, :EAUTO_MOVIMENTACOES, :EAUTO_AUTENTICACAO, :EUS_CADAST, :EDATA)');
//        Params[0].AsInteger := Loja;
//        Params[1].AsInteger := Codigo;
//        Params[2].AsString := CPFCNPJ;
//        Params[3].AsFloat := qValorParc;
//        Params[4].AsString := AutorizacaoCript;
//        Params[5].AsString := Usuario;
//        Params[6].AsDate := DataParcela;
//        prepare;
//        open;
//
//        DataParcela := DataParcela + Dias;
//      end;
//      Transaction.CommitRetaining;
//      Result := 'A' // Autorizado
//    end
//    else
//      Result := 'N'; // N�o Autorizado
//  end;
//end;
{.: Fim :.}

{ TMetodos }

class function TMetodos.GetBuildInfo: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: Word;
  Prog : string;
begin
  Prog := Application.Exename;
  VerInfoSize := GetFileVersionInfoSize(PChar(prog), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;

  FreeMem(VerInfo, VerInfoSize);
  result := IntToStr(v1)+ '.' + IntToStr(v2) + '.' + IntToStr(v3) + '.' + IntToStr(v4);
end;

class function TMetodos.GetForm(Sender: TObject): TComponent;
begin
  if Sender is TForm then
    Result := TForm(Sender)
  else if Sender is TDataModule then
    Result := TDataModule(Sender)
  else
    Result := GetForm(TComponent(Sender).Owner);
end;

class function TMetodos.GetImpressoraPadrao: string;
begin
  if (Printer.PrinterIndex >= 0) then
    Result := Printer.Printers[Printer.PrinterIndex]
  else
    raise Exception.Create('Nenhuma impressora Padr�o foi detectada');
end;

class procedure TMetodos.SetChamaIndices(Cds: TClientDataSet; Grd: TDBGrid;
  Column: TColumn; shpCrescente, shpDecrescente: TShape);
var
  pIntX: Integer;
  pClmColuna: TColumn;
begin
  for pIntX := 0 to Grd.Columns.Count - 1 do
  begin
    pClmColuna := Grd.Columns.Items[pIntX];
    pClmColuna.Title.Color := clBtnFace;
  end;

  if Cds.Active and (not Cds.IsEmpty) then
  begin
    if Cds.IndexName = Column.FieldName + 'DESC' then
    begin
      Cds.IndexName := Column.FieldName + 'ASC';
      Column.Title.Color := shpDecrescente.Brush.Color;
    end
    else
    begin
      Cds.IndexName := Column.FieldName + 'DESC';
      Column.Title.Color := shpCrescente.Brush.Color;
    end;
  end;
end;

class procedure TMetodos.SetEscreveArquivo(var Campos: array of string;
  var Arquivo: TStringList; NomeArquivo: string);
var
  pIntX: Integer;
  pStrCampos: string;
begin
  if NomeArquivo = '' then
  begin
    pStrCampos := '';
    for pIntX := Low(Campos) to High(Campos) do
      pStrCampos := pStrCampos + Campos[pIntX];
    Arquivo.Add(pStrCampos);
  end
  else if Arquivo.Text <> '' then
    Arquivo.SaveToFile(NomeArquivo);
end;

class procedure TMetodos.SetImpressoraPadrao(NomeImpressora: string);
var
  I: Integer;
  Device: PChar;
  Driver: Pchar;
  Port: Pchar;
  HdeviceMode: Thandle;
  aPrinter: TPrinter;
begin
  Printer.PrinterIndex := -1;
  getmem(Device, 255);
  getmem(Driver, 255);
  getmem(Port, 255);
  aPrinter := TPrinter.create;
  for I := 0 to Printer.printers.Count - 1 do
  begin
    if Printer.printers[i] = NomeImpressora then
    begin
      aprinter.printerindex := i;
      aPrinter.getprinter(device, driver, port, HdeviceMode);
      StrCat(Device, ',');
      StrCat(Device, Driver);
      StrCat(Device, Port);
      WriteProfileString('windows', 'device', Device);
      StrCopy(Device, 'windows');
      SendMessage(HWND_BROADCAST, WM_WININICHANGE,
        0, Longint(@Device));
    end;
  end;
  Freemem(Device, 255);
  Freemem(Driver, 255);
  Freemem(Port, 255);
  FreeAndNil(aPrinter);
end;

class procedure TMetodos.SetListaImpressoras(Lista: TStrings);
var
  pPrnImpressoras: TPrinter;
  pIntX: Integer;
begin
  pPrnImpressoras := TPrinter.Create;
  Lista.Clear;
  for pIntX := 0 to pPrnImpressoras.Printers.Count - 1 do
  begin
    Lista.Add(pPrnImpressoras.Printers.Strings[pIntX]);
  end;
  FreeAndNil(pPrnImpressoras);
end;

class procedure TMetodos.SetMontaIndices(Cds: TClientDataSet;
  Grd: TDBGrid);
var
  pIntX: Integer;
  pClmColuna: TColumn;
begin
  Cds.IndexDefs.Clear;
  for pIntX := 0 to Grd.Columns.Count - 1 do
  begin
    pClmColuna := Grd.Columns.Items[pIntX];
    Cds.IndexDefs.Add(pClmColuna.FieldName + 'ASC', pClmColuna.FieldName, [ixDescending]);
    Cds.IndexDefs.Add(pClmColuna.FieldName + 'DESC', pClmColuna.FieldName, []);
  end;
  Cds.IndexFieldNames := '';
end;


class function TMetodo.GetFormatar(Texto: string; TamanhoDesejado: integer; AcrescentarADireita: boolean = true; CaracterAcrescentar: char = ' '): string;
{
   OBJETIVO: Eliminar caracteres inv�lidos e acrescentar caracteres � esquerda ou � direita do texto original para que a string resultante fique com o tamanho desejado

   Texto : Texto original
   TamanhoDesejado: Tamanho que a string resultante dever� ter
   AcrescentarADireita: Indica se o car�cter ser� acrescentado � direita ou � esquerda
      TRUE - Se o tamanho do texto for MENOR que o desejado, acrescentar car�cter � direita
             Se o tamanho do texto for MAIOR que o desejado, eliminar �ltimos caracteres do texto
      FALSE - Se o tamanho do texto for MENOR que o desejado, acrescentar car�cter � esquerda
             Se o tamanho do texto for MAIOR que o desejado, eliminar primeiros caracteres do texto
   CaracterAcrescentar: Car�cter que dever� ser acrescentado
}
var
  QuantidadeAcrescentar,
    TamanhoTexto,
    PosicaoInicial,
    i: integer;

begin
  case CaracterAcrescentar of
    '0'..'9', 'a'..'z', 'A'..'Z': ; {N�o faz nada}
  else
    CaracterAcrescentar := ' ';
  end;

  Texto := Trim(AnsiUpperCase(Texto));
  TamanhoTexto := Length(Texto);
  for i := 1 to (TamanhoTexto) do
  begin
    if Pos(Texto[i], ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') = 0 then
    begin
      case Texto[i] of
        '�', '�', '�', '�', '�': Texto[i] := 'A';
        '�', '�', '�', '�': Texto[i] := 'E';
        '�', '�', '�', '�': Texto[i] := 'I';
        '�', '�', '�', '�', '�': Texto[i] := 'O';
        '�', '�', '�', '�': Texto[i] := 'U';
        '�': Texto[i] := 'C';
        '�': Texto[i] := 'N';
      else
        Texto[i] := ' ';
      end;
    end;
  end;

  QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;
  if QuantidadeAcrescentar < 0 then
    QuantidadeAcrescentar := 0;
  if CaracterAcrescentar = '' then
    CaracterAcrescentar := ' ';
  if TamanhoTexto >= TamanhoDesejado then
    PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
  else
    PosicaoInicial := 1;

  if AcrescentarADireita then
    Texto := Copy(Texto, 1, TamanhoDesejado) + StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar)
  else
    Texto := StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar) + Copy(Texto, PosicaoInicial, TamanhoDesejado);

  Result := AnsiUpperCase(Texto);
end;

class function TMetodo.GetTiraMascara(Texto: string): string;
var
  pIntX: Integer;
begin
  for pIntX := 1 to Length(Texto) do
  begin
    if Pos(Texto[pIntX], ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ') > 0 then
      Result := Result + Texto[pIntX]
    else
    begin
      case Texto[pIntX] of
        '�', '�', '�', '�', '�': Result := Result + 'A';
        '�', '�', '�', '�': Result := Result + 'E';
        '�', '�', '�', '�': Result := Result + 'I';
        '�', '�', '�', '�', '�': Result := Result + 'O';
        '�', '�', '�', '�': Result := Result + 'U';
        '�': Result := Result + 'C';
        '�': Result := Result + 'N';
      end;
    end;
  end;
end;

class procedure TMetodo.SetEscreveArquivo(var Campos: array of string;
  var Arquivo: TStringList; NomeArquivo: string);
var
  pIntX: Integer;
  pStrCampos: string;
begin
  if NomeArquivo = '' then
  begin
    pStrCampos := '';
    for pIntX := Low(Campos) to High(Campos) do
      pStrCampos := pStrCampos + Campos[pIntX];
    Arquivo.Add(pStrCampos);
  end
  else if Arquivo.Text <> '' then
    Arquivo.SaveToFile(NomeArquivo);
end;

procedure MontaAtalhosPopu(sPopup : TPopupMenu; sForm : TForm);
var
  sNome : String;
  I : Integer;
  NovoItem : TMenuItem;

  menu  : TMenuItem;
  click : TNotifyEvent;
  texto : String;
  visible,
  Ativo : boolean;
begin
  DM.SqlAuxiliar.Close;
  DM.SqlAuxiliar.Sql.Text := ' SELECT ID_USUARIO, NOME_MENU, CAPTION_MENU '+
                             ' FROM GEN_ATALHOS WHERE ID_USUARIO = '+IntToStr(FrmPrincipal.iUsuarioCodigo);
  DM.SqlAuxiliar.Open;

  I := 0;
  if not DM.SqlAuxiliar.IsEmpty then
  begin

//    for i := 0  to sPopup.Items.Count - 1 do
//      sPopup.Items.Delete(0);

    sPopup.Items.Clear;

    while not DM.SqlAuxiliar.Eof do
    begin
      try
        sNome := 'Atalho'+DM.SqlAuxiliar.FieldByName('NOME_MENU').AsString;
        NovoItem := TMenuItem.Create(sPopup);
        NovoItem.OnClick := FrmPrincipal.ChamaFormAtalho;
        NovoItem.Caption := DM.SqlAuxiliar.FieldByName('CAPTION_MENU').AsString;
        NovoItem.Name    := sNome;
        sPopup.Items.Add(NovoItem);
        DM.SqlAuxiliar.Next;
      except
        DM.SqlAuxiliar.Next;
      end;
    end;
  end;

  for i := 0  to sPopup.Items.Count - 1 do
    sPopup.Items[i].Tag := i;
end;

function  ExistKeyPress:                 Boolean;
var
  Teclado: TKeyboardState;
  I: Byte;
begin
  // Obtem estado de todas as teclas
  GetKeyBoardState(Teclado);

  // Processa as teclas verificando o estado de cada uma
  for I := 0 to 255 do
  begin
    Result := Boolean(Teclado[I] and 128); // Se verdade tecla pressionada
    if Result then Break;                  // Existe pressionada entao sai
  end;
end;

procedure GridOrdenaTitleClick(GridDados: TDBGrid; Column: TColumn);
var
   i: Integer;
   sqlOrigem : String;
begin
  try
    with TUniQuery(GridDados.DataSource.DataSet) do // the DBGrid's query component (a [NexusDB] TnxQuery)
    begin
      sqlOrigem := SQL.Text;
      DisableControls;
      if Active then Close;

      if (Pos('order by', LowerCase(SQL.Text)) > 0) then
      begin
        if (Pos(' desc ',LowerCase(Copy(SQL.Text,Pos('order by', LowerCase(SQL.Text))-1))) > 0) then
          SQL.Text := Copy(SQL.Text,1,Pos('order by', LowerCase(SQL.Text))-1)+
                     'ORDER BY '+Column.FieldName //newOrderBySQL
        else
          SQL.Text := Copy(SQL.Text,1,Pos('order by', LowerCase(SQL.Text))-1)+
                     'ORDER BY '+Column.FieldName +' desc ';
      end
      else
        SQL.Text := SQL.Text + 'ORDER BY '+Column.FieldName;

      // re-add params here if necessary
      if not Active then Open;
      EnableControls;
    end;
  except
    TUniQuery(GridDados.DataSource.DataSet).SQL.Text := sqlOrigem;
    if not TUniQuery(GridDados.DataSource.DataSet).Active then
      TUniQuery(GridDados.DataSource.DataSet).Open;
    TUniQuery(GridDados.DataSource.DataSet).EnableControls;
  end;

end;

function  Tone                           (Freq: Word; MSecs: Integer): Boolean;
  procedure SetPort(Address, Value: Word);
  var
    bValue: Byte;
  begin
    bValue := Lo(Value); // Obtem o byte menos significante
    asm
      mov DX, address    // DX := Address  (Porta)
      mov AL, bValue     // AL := bValue   (Byte)
      out DX, AL         // Envia o Byte para a Porta
    end;
  end;

  function GetPort(Address: Word): Word;
  var
    bValue: Byte;
  begin
    asm
      mov DX, address    // DX := Address  (Porta)
      in  AL, DX         // Obtem o Byte da Porta
      mov bValue, AL     // bValue := AL   (Byte)
    end;
    Result := bValue;    // Retorna o valor
  end;

  procedure NoSound;
  var
    wValue: Word;
  begin
    wValue := GetPort($61);
    wValue := wValue and $FC;
    SetPort($61, wValue);
  end;

  procedure Sound(Freq: Word);
  var
    B : Word;
  begin
    if Freq > 18 then
    begin
      Freq := Word(1193181 div LongInt(Freq));   // Ajusta a frequencia para o processador
      B    := GetPort($61);
      if (B and 3) = 0 then
      begin
        SetPort($61, B or 3);
        SetPort($43, $B6);
      end;
      SetPort($42, Freq);
      SetPort($42, (Freq shr 8));
    end;
  end;

begin
  // Verifica se o SO � o Windows NT (Sandro - 09/04/1999)
//  if Estalo_Funcoes_Internas.WinNT then
//    Result := Windows.Beep(Freq, MSecs) // Utiliza a fun��o "Beep" do Windows NT.
//  else
//  try
//    Result := True;
//    Sound(Freq);  // Emite o som
//    Delay(MSecs); // Durante x Milisegundos
//    NoSound;      // Desabilita o som
//  except
//    Result := False;
//  end;
end;

function  PixelsText                     (const inString: string; AFont: TFont; var PixelsWidth: Integer; var PixelsHeight: Integer; Form: TCustomForm = nil): Boolean;
var
  Rectangle: TRect;
  OldFont:   TFont;
  wCanvas:   TCanvas;
begin
  // Iniciliza valor de retorno
  Result := True;

  // Testa existe um canvas dispon�vel
  if Assigned(Screen.ActiveForm) then
    wCanvas := TControlCanvas(Screen.ActiveForm.Canvas)
  else
    if Assigned(Form) then
      wCanvas := Form.Canvas
    else
      Exit;

  // Guarda a fonte
  OldFont := wCanvas.Font;

  // Cria um retangulo
  Rectangle := Rect(0, 0, 1, 1);
  try
    // Seta a font do form para a font passada
    wCanvas.Font := AFont;

    // Desenha o texto no retangulo sobre o form, obtendo a altura do retangulo
    PixelsHeight := DrawText(wCanvas.Handle,
                             PChar(inString),
                             StrLen(PChar(InString)),
                             Rectangle,
                             DT_SINGLELINE or DT_CALCRECT);

    // Obtem a largura do retangulo (Largura da fonte)
    PixelsWidth := Rectangle.Right;
  finally
    // Volta a fonte original do form ativo
    wCanvas.Font := OldFont;
  end;
end;

function StringTran (inString: string; const SubStr1: string; const SubStr2: string; IgnoreCase: Boolean = False): string;
begin
  // Inicializa valor de retorno
  if not IgnoreCase then
    Result := StringReplace(inString,SubStr1,SubStr2,[rfReplaceAll])
  else
    Result := StringReplace(inString,SubStr1,SubStr2,[rfReplaceAll,rfIgnoreCase]);
end;

function  CAPSOnWords                    (const inString: string; ACase: TCaseCapitalize): string;
var
  CaracteresFinais: string;
  Lower:            Boolean;
  Proxima:          Boolean;
  I:                LongInt;
begin
  try
    Result  := '';     // String de retorno
    Lower   := False;  // Pr�xima letra ser� mai�scula
    Proxima := False;  // Capitaliza a pr�xima letra

    // Guarda os Caracteres de Final de Palavra ou Frase
    case ACase of
      ccFirstsWord:   CaracteresFinais := ' ,.?!;';
      ccFirstsPhrase: CaracteresFinais := '.?!;';
    end;

    // Varre todos os Caracteres
    for I := 1 to Length(inString) do
    begin
      // Para os Caracteres entre Colchetes n�o ser� realizado o CAPSOnWords
      if inString[I] = '[' then
      begin
        Proxima := True;  // N�o capitalizar as pr�ximas letras
        Continue;
      end;

      if inString[I] = ']' then
      begin
        Proxima := False; // Voltar a capitalizar as pr�ximas letras
        Continue;
      end;

      if Proxima then
      begin
        Result := Result + inString[I]; // N�o realiza o CAPSOnWords
        Continue;
      end;

      // Coloca a letra em Maiuscula/Minuscula
      if Lower then
        Result := Result + AnsiLowerCase(inString[I])  // Coloca letra em min�sculo
      else
        Result := Result + AnsiUpperCase(inString[I]); // Coloca letra em mai�sculo

      // Verifica se a palavra/frase vai come�ar
      if Pos(inString[I], CaracteresFinais) <> 0 then
        Lower := False   // Mai�sculo
      else
        if (ACase <> ccFirstsPhrase) or (inString[I] <> ' ') then
          Lower := True; // Min�sculo
    end;
  except
    Result := '';
  end;
end;

procedure MontaAtalhosMenu(sNomePanel : TPanel; sForm : TForm);
var
  sNome : String;
  sShift : TShiftState;
  sEdit   : TEdit;
  sLabel  : TLabel;
  sCombo  : TComboBox;
  sBitBtn : TBitBtn;
begin
  DM.SqlAuxiliar.Close;
  DM.SqlAuxiliar.Sql.Text := ' SELECT ID_USUARIO, NOME_MENU, CAPTION_MENU '+
                             ' FROM GEN_ATALHOS WHERE ID_USUARIO = '+IntToStr(FrmPrincipal.iUsuarioCodigo);
  DM.SqlAuxiliar.Open;

  if not DM.SqlAuxiliar.IsEmpty then
  begin
    while not DM.SqlAuxiliar.Eof do
    begin
      try
        sNome := 'Atalho'+DM.SqlAuxiliar.FieldByName('NOME_MENU').AsString;
        if not Assigned(TBitBtn(FrmPrincipal.FindComponent(sNome))) then
        begin
          sBitBtn             := TBitBtn.Create(sForm);
          sBitBtn.OnClick     := FrmPrincipal.ChamaFormAtalho;
//          sBitBtn.OnMouseDown := FrmPrincipal.BtnAtalhosMouseDown;
          sBitBtn.Parent      := sNomePanel;
          sBitBtn.Align       := alTop;
//          sBitBtn.PopupMenu   := FrmPrincipal.PopupExcAtalho;
          sBitBtn.WordWrap    := True;
          sBitBtn.Caption     := DM.SqlAuxiliar.FieldByName('CAPTION_MENU').AsString;
          sBitBtn.Name        := 'Atalho'+DM.SqlAuxiliar.FieldByName('NOME_MENU').AsString;
          sBitBtn.Visible     := True;
        end
        else
          TBitBtn(FrmPrincipal.FindComponent(sNome)).Visible := True;
      finally
        DM.SqlAuxiliar.Next;
      end;
    end;
  end;
end;

function FileLastModified(const TheFile: string): string;
var
  FileH: THandle;
  LocalFT: TFileTime;
  DosFT: DWORD;
  LastAccessedTime: TDateTime;
  FindData: TWin32FindData;
begin
  Result := '';
  FileH := FindFirstFile(PChar(TheFile), FindData);

  if FileH <> INVALID_HANDLE_VALUE then
  begin
//   Windows.FindClose(Handle) ;

   if (FindData.dwFileAttributes AND
       FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
     FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFT);
     FileTimeToDosDateTime(LocalFT,LongRec(DosFT).Hi, LongRec(DosFT).Lo);
     LastAccessedTime := FileDateToDateTime(DosFT);
     Result := DateTimeToStr(LastAccessedTime);
    end;
  end;
end;

{ TRelatorio }

class procedure TRelatorio.ExportaExcel(sCaption : String; CdsDados : TClientDataSet);
var
  PLANILHA : Variant;
  Linha : Integer;
  I: Integer;
Begin
  inherited;
  // qy_ocorre -----> minha query

  CdsDados.Filtered := False;
  Linha := 2;
  PLANILHA := CreateOleObject('Excel.Application');
  PLANILHA.Caption := sCaption;
  PLANILHA.Visible := False;
  PLANILHA.WorkBooks.add(1);

  // TITULO DAS COLUNAS
  for I := 1 to CdsDados.FieldCount do
  begin
    PLANILHA.Cells[1,I] := CdsDados.Fields[I].DisplayLabel;
  end;

  CdsDados.DisableControls;

  // PRRENCHIMENTO DAS C�LULAS COM OS VALORES DOS CAMPOS DA TABELA
  Try
    CdsDados.First;
    While not CdsDados.Eof do
    Begin

//       PLANILHA.Cells[Linha,1]:= CdsDados.ClientDataSet1CODIGO.Value;
//       PLANILHA.Cells[linha,2] := CdsDados.ClientDataSet1NOME_S.Value;
//       PLANILHA.Cells[Linha,3] := CdsDados.ClientDataSet1NUM_PACI_S.Value;
//       PLANILHA.Cells[Linha,4] := CdsDados.ClientDataSet1NUM_FAMI_S.Value;
//       PLANILHA.Cells[Linha,5] := CdsDados.ClientDataSet1COLEST_TOTAL.Value;
//       PLANILHA.Cells[Linha,6] := CdsDados.ClientDataSet1HDL.Value;
//       PLANILHA.Cells[Linha,7] := CdsDados.ClientDataSet1LDL.Value;
//       PLANILHA.Cells[Linha,8] := CdsDados.ClientDataSet1VLDL.Value;
//       PLANILHA.Cells[Linha,9] := CdsDados.ClientDataSet1TRIGLICERIDES.Value;
//       PLANILHA.Cells[Linha,10] := CdsDados.ClientDataSet1CREATININA.Value;
//       PLANILHA.Cells[Linha,11] := CdsDados.ClientDataSet1HBA1C.Value;
//       PLANILHA.Cells[Linha,12] := CdsDados.ClientDataSet1GLICOSE.Value;
//       PLANILHA.Cells[Linha,13] := CdsDados.ClientDataSet1NOME.Value;
//       PLANILHA.Cells[Linha,14] := CdsDados.ClientDataSet1NUM_PACI.Value;
//       PLANILHA.Cells[Linha,15] := CdsDados.ClientDataSet1NUM_FAMI.Value;

      Linha := Linha + 1;
       CdsDados.Next;
     End;
     PLANILHA.Columns.AutoFit;

     PLANILHA.Visible := True;
 Finally
    CdsDados.EnableControls;
    PLANILHA := Unassigned;
 end; // TRY
end;

class function TRelatorio.Func_GeraCodigoRelatorio(Form: String;
  SqlAuxiliar: TUniQuery): Integer;
begin
  with SqlAuxiliar do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MAX(CODIGO) ');
    SQL.Add('FROM RELAT_PERSONALIZADO TRP');
    SQL.Add('WHERE TRP.NAME_FORM = ' + QuotedStr(Form));
    Open;

    if StrToFloatDef(FieldByName('MAX').AsString, 0) = 0 then
      Result := 1
    else
      Result := FieldByName('MAX').AsInteger + 1;
  end;
end;

class procedure TRelatorio.Proc_AlteraRelatorio(Form: TForm; var Grid: TDBGrid;
  ppR: TppReport; sNomeRelatorio : String; Confirmacao : Boolean = True);
var
  Rel_Stream, Rel_Stream2: TStream; //TMemoryStream;
  ppD: TppDesigner;
  Codigo : String;
  Posicao : TBookMark;
begin
  if not Grid.DataSource.DataSet.IsEmpty then
  Begin
    if sNomeRelatorio = EmptyStr then
    begin
      Application.MessageBox('Nome do relat�rio n�o pode ser Vazio', 'Informa��o...', MB_OK);
      Exit;
    end;

    Codigo := Grid.DataSource.DataSet.FieldByName('CODIGO').AsString;

    Grid.DataSource.DataSet.Filtered := False;
    Grid.DataSource.DataSet.Filter   := 'CODIGO <> ' + QuotedStr(Codigo);
    Grid.DataSource.DataSet.Filtered := True;

    if Grid.DataSource.DataSet.Locate('CAPTION', sNomeRelatorio, [loCaseInsensitive]) Then
    Begin
      Grid.DataSource.DataSet.Filtered := False;
      Application.MessageBox('Nome de Relat�rio j� existente. Entre com um novo Nome','Informa��o...', MB_OK);
      Exit;
    end;

    Grid.DataSource.DataSet.Filter   := EmptyStr;
    Grid.DataSource.DataSet.Filtered := False;
    Grid.DataSource.DataSet.Locate('CODIGO',  Codigo, [loCaseInsensitive]);

    Grid.DataSource.DataSet.Edit;
    Grid.DataSource.DataSet.FieldByName('CAPTION').AsString := Trim(sNomeRelatorio);
    Grid.DataSource.DataSet.Post;

    if Grid.DataSource.DataSet.FieldByName('DADOS').AsString <> EmptyStr then
    begin
      FrmLayoutRel.SqlDados.Locate('CODIGO',  Codigo, [loCaseInsensitive]);

      Rel_Stream := TMemoryStream.Create;
      TBlobField(FrmLayoutRel.SqlDadosDADOS).SaveToStream(Rel_Stream);
      Rel_Stream.Seek(0, soFromBeginning);

      ppR.Template.LoadFromStream(Rel_Stream);
      Rel_Stream.Destroy;

//      TBlobField(FrmLayoutRel.SqlDadosDADOS).SaveToFile('c:\temp\relatTemp.rtm');
//      ppR.Template.FileName := 'c:\temp\relatTemp.rtm';
//      ppR.Template.LoadFromFile;
    end;

    ppD := TppDesigner.Create(Form);
    ppD.Report := ppR;
    ppD.ShowModal;
    ppD.Destroy;

    Rel_Stream2 := TMemoryStream.Create;
    ppR.Template.SaveToStream(Rel_Stream2);

    if Confirmacao then
    begin
      if TMens.Quest('Confirma a Altera��o do Layout.') then
      begin
        Grid.DataSource.DataSet.Edit;
        TBlobField(Grid.DataSource.DataSet.FieldByName('DADOS')).LoadFromStream(Rel_Stream2);
        Grid.DataSource.DataSet.Post;

        TClientDataSet(Grid.DataSource.DataSet).ApplyUpdates(0);
        Rel_Stream2.Destroy;

        Application.MessageBox('Relat�rio salvo com sucesso', 'Informa��o...', MB_OK);
      end;
    end
    else
    begin
      Grid.DataSource.DataSet.Edit;
      TBlobField(Grid.DataSource.DataSet.FieldByName('DADOS')).LoadFromStream(Rel_Stream2);
      Grid.DataSource.DataSet.Post;

      TClientDataSet(Grid.DataSource.DataSet).ApplyUpdates(0);
      Rel_Stream2.Destroy;

      Application.MessageBox('Relat�rio salvo com sucesso', 'Informa��o...', MB_OK);
    end;
    //refresh na grid
    Grid.DataSource.DataSet.Close;
    Grid.DataSource.DataSet.Open;
    Grid.DataSource.DataSet.Filtered := False;
  end
  else
    Application.MessageBox('N�o existem Relat�rios a serem Alterados','Informa��o...',  MB_OK);
end;

class procedure TRelatorio.Proc_CarregaRelatorio(Form: TForm;
  sqlDados: TUniQuery; ppR: TppReport; CodigoLayout: String);
var
 Rel_Stream: TMemoryStream;
 SelRegistro: TBookMark;
begin
  sqlDados.Close;
  sqlDados.SQL.Text := ' SELECT * from RELAT_PERSONALIZADO ' +
                       ' WHERE NAME_FORM = '+QuotedStr(FORM.Name)+
                       ' AND CAPTION     = '+QuotedStr(CodigoLayout);
  sqlDados.Open;

  if sqlDados.IsEmpty Then
    Exit;

  SelRegistro := sqlDados.GetBookmark;

  sqlDados.Filtered := False;
  sqlDados.Filter   := 'ATIVO = ' + QuotedStr('True');
  sqlDados.Filtered := True;

  if sqlDados.RecordCount = 0 then
  begin
    sqlDados.Filtered := False;
    if sqlDados.BookMarkValid(SelRegistro) then
      sqlDados.GotoBookMark(SelRegistro);
  end;

  if sqlDados.FieldByName('DADOS').AsString <> EmptyStr then
  begin
    Rel_Stream := TMemoryStream.Create;
    TBlobField(sqlDados.FieldByName('DADOS')).SaveToStream(Rel_Stream);
    Rel_Stream.Seek(0, soFromBeginning);
    ppR.Template.LoadFromStream(Rel_Stream);
  end;

  sqlDados.Filtered := False;
  if sqlDados.BookMarkValid(SelRegistro) then
    sqlDados.GotoBookMark(SelRegistro);
end;

class procedure TRelatorio.Proc_CriaComponentesRelatorio(Form: TForm;
  var Grid: TDBGrid; sqlDados : TUniQuery; dsDados : TDataSource);
Var
  I, E : Integer;
begin
  if Grid.DataSource <> Nil then
    Exit;

  E := 3;
  For I := 0 to Form.ComponentCount - 1 do
  Begin
    if (Form.Components[i] is TppReport) then
    Begin

//  FrmLayoutRel.sqlDados.Name := 'Qy_' + (Form.Components[i] as TppReport).Name;
//  FrmLayoutRel.dsDados.DataSet := FrmLayoutRel.sqlDados;
//  FrmLayoutRel.dsDados.Name := 'Dt_' + (Form.Components[i] as TppReport).Name;

      Inc(E);
      with sqlDados do
      begin
        Close;
        Sql.Clear;
        SQL.Add('Select * From RELAT_PERSONALIZADO TRP');
        SQL.Add('WHERE TRP.Name_Form = ' + QuotedStr(Form.Name));
        SQL.Add('AND TRP.Nivel_Relatorio = ' + QuotedStr((Form.Components[i] as TppReport).Name));
        Open;
      end;
    end;
  end;
  Grid.DataSource := dsDados;
end;

class procedure TRelatorio.Proc_ExcluiRelatorio(Form: TForm; Grid: TDBGrid;
  ppR: TppReport);
begin
  if MessageDlg('Confirma a Exclus�o do Registro Selecionado?', mtConfirmation, mbOKCancel,0) = 1 then
  begin
    Grid.DataSource.DataSet.Delete;
    TClientDataSet(Grid.DataSource.DataSet).ApplyUpdates(0);
  end;
end;

class procedure TRelatorio.Proc_ExportaRelatorio(Form: TForm; var Grid: TDBGrid;
  sNomeRelatorio, FileName: String; CdsExportar : TClientDataSet);
var
  ListaRel : TStrings;
  ppD: TppDesigner;
  Codigo : String;
  Rel_Stream : TMemoryStream;
  ppR: TppReport;
begin
  if not Grid.DataSource.DataSet.IsEmpty then
  Begin
    if sNomeRelatorio = EmptyStr then
    begin
      Application.MessageBox('Nome do relat�rio n�o pode ser Vazio', 'Informa��o...', MB_OK);
      Exit;
    end;

    Codigo := Grid.DataSource.DataSet.FieldByName('CODIGO').AsString;

    Grid.DataSource.DataSet.Filter   := EmptyStr;
    Grid.DataSource.DataSet.Filtered := False;
    Grid.DataSource.DataSet.Locate('CODIGO',  Codigo, [loCaseInsensitive]);

    FrmLayoutRel.SqlDados.Locate('CODIGO',  Codigo, [loCaseInsensitive]);

    if FrmLayoutRel.SqlDadosDADOS.AsString <> EmptyStr then
    begin
      try
        CdsExportar.Insert;
        CdsExportar.FieldByName('CODIGO').AsString          := Grid.DataSource.DataSet.FieldByName('CODIGO').AsVariant;
        CdsExportar.FieldByName('CAPTION').AsString         := Grid.DataSource.DataSet.FieldByName('CAPTION').AsVariant;
        CdsExportar.FieldByName('NAME_FORM').AsString       := Grid.DataSource.DataSet.FieldByName('NAME_FORM').AsVariant;
        CdsExportar.FieldByName('NIVEL_RELATORIO').AsString := Grid.DataSource.DataSet.FieldByName('NIVEL_RELATORIO').AsVariant;
        CdsExportar.FieldByName('DADOS').AsVariant          := FrmLayoutRel.SqlDadosDADOS.AsVariant;
        CdsExportar.FieldByName('ATIVO').AsString           := Grid.DataSource.DataSet.FieldByName('ATIVO').AsVariant;
        CdsExportar.Post;
        CdsExportar.SaveToFile(FileName);
      finally
        ppR.Free;
        Rel_Stream.Free;
        ListaRel.Free;
      end;
    end;

    //refresh na grid
    Grid.DataSource.DataSet.Close;
    Grid.DataSource.DataSet.Open;
    Grid.DataSource.DataSet.Filtered := False;
  end
  else
    Application.MessageBox('N�o Existem Relat�rios a serem Exportados','Informa��o...',  MB_OK);
end;

class procedure TRelatorio.Proc_ImportarRelatorio(DataSet : TUniQuery; FileName: String; CdsExportar : TClientDataSet);
var
  ListaRel : TStrings;
  TDados : TDataSet;
  sNomeRelatorio, sForm : String;
  Rel_Stream, Rel_Stream2 : TMemoryStream;
  ppR: TppReport;
begin
  try
    DataSet.Close;
    DataSet.Open;

    CdsExportar.LoadFromFile(FileName);
    sForm          := CdsExportar.FieldByName('NAME_FORM').AsString;
    sNomeRelatorio := CdsExportar.FieldByName('CAPTION').AsString;

    if DataSet.Locate('NAME_FORM;CAPTION', VarArrayOf([sForm, sNomeRelatorio]), [loCaseInsensitive]) Then
    begin
      DataSet.Edit;
    end
    else
    begin
      with DataSet do
      begin
        Insert;
        FieldByName('CODIGO').AsInteger   := Func_GeraCodigoRelatorio(sForm, DM.SqlAuxiliar);
        FieldByName('CAPTION').AsString   := Trim(sNomeRelatorio);
        FieldByName('NAME_FORM').AsString := sForm;
        FieldByName('ATIVO').AsString     := 'False';
        FieldByName('NIVEL_RELATORIO').AsString := 'Relatorio';
      end;
    end;

    with DataSet do
    begin  //Carrega relatorio padrao no banco de dados
      DataSet.FieldByName('DADOS').Value := CdsExportar.FieldByName('DADOS').Value;

      Post;
//      TClientDataSet(DataSet).ApplyUpdates(0);
    end;
    TMens.Aviso('Relat�rio Importado com Sucesso.');
  finally
    ListaRel.Free;
  end;
end;


class procedure TRelatorio.Proc_MarcaRelatorioAtivo(var ACanvas: TCanvas;
  Value: Variant);
begin
  if (Value = 'True') then
  begin
    ACanvas.font.name := 'Ariel';
    ACanvas.font.size := 9;
    ACanvas.font.Style := [fsbold];
    ACanvas.font.color := ClBlue;
  end
  else
  begin
    ACanvas.font.name := 'Ariel';
    ACanvas.font.size := 9;
    ACanvas.font.Style := [fsBold];
    ACanvas.font.color := ClBlack;
  end;
end;

class procedure TRelatorio.Proc_NovoRelatorio(Form: TForm; Grid: TDBGrid;
  ppR: TppReport; sNomeRelatorio : String; SqlAuxiliar : TUniQuery; ExibeRel : Boolean);
var
  Rel_Stream: TMemoryStream;
begin
  if Trim(sNomeRelatorio) = EmptyStr then
  begin
    Application.MessageBox('Insira o Nome do Relat�rio','Informa��o...', MB_OK);
    Exit;
  end;

  if not Grid.DataSource.DataSet.isempty then
  begin
    if Grid.DataSource.DataSet.Locate('CAPTION', Trim(sNomeRelatorio), []) Then
    begin
      Application.MessageBox('Nome de relat�rio j� existente entre com um Nome diferente', 'Informa��o...', MB_OK);
      Exit;
    end;
  end;

  with Grid.DataSource.DataSet do
  begin
    Insert;
    FieldByName('CODIGO').AsInteger   := Func_GeraCodigoRelatorio(Form.Name, SqlAuxiliar);
    FieldByName('CAPTION').AsString   := Trim(sNomeRelatorio);
    FieldByName('NAME_FORM').AsString := Form.Name;
    FieldByName('ATIVO').AsString     := 'False';

    //Carrega relatorio padrao no banco de dados
    Rel_Stream := TMemoryStream.Create;
    ppR.Template.SaveToStream(Rel_Stream);
    TBlobField(FieldByName('DADOS')).LoadFromStream(Rel_Stream);
    Rel_Stream.Destroy;

    FieldByName('NIVEL_RELATORIO').AsString := ppR.Name;
    //   FieldByName('FILIAL').AsInteger := Funcoes.func_FilialAtiva;
    Post;
    TClientDataSet(Grid.DataSource.DataSet).ApplyUpdates(0);
  end;

  if ExibeRel then
    Proc_AlteraRelatorio(Form, Grid, ppR, sNomeRelatorio, False);
end;

{ TCalcNotas }

{ TArquivo }

class procedure TArquivo.AplicaScript;
var
  LinhaTexto,
  Caminho  : String;
  Arquivo  : TStrings;
  Script   : String;
  Decript  : TStrings;
  Mensagem : String;
  Y, I, Dialect : Integer;
begin
  Caminho := ExtractFilePath(ParamStr(0))+'Script.sql';
  Script  := Emptystr;

  if FileExists(Caminho) then
  begin
    try
      Decript := TStringList.Create;
      Arquivo := TStringList.Create;
      Arquivo.LoadFromFile(Caminho);

      TValidacao.DeCriptografaLista(Arquivo, Decript);

      Arquivo.Clear;

      with DM.SqlAuxiliar do
      begin
        for I := 0 to Decript.Count-1 do
        begin
          LinhaTexto := Decript[I];

          for Y := 1 to Length(LinhaTexto) do
          begin
            if (LinhaTexto[Y] = '*') then //or (LinhaTexto[Y] = ';') then
            begin
              try
                if Script <> EmptyStr then
                  Arquivo.Add(Script);

                {Recebe o Script Criptografado e Descriptografa para sua execucao}
                SQL := Arquivo;
                ExecSQL;
                {Apos aplicar o script Salva o mesmo numa pasta Separada}
                SalvaScriptAplicado(TValidacao.Criptografa(Arquivo.Text)+#13+'--------Hora: '+TimeToStr(Now)+'---------', True);
                Script := Emptystr;
                Arquivo.Clear;
              Except
                on E: Exception do
                begin
                  SalvaScriptAplicado(Arquivo.Text+#13+'Erro: '+E.Message+#13+'--------Hora: '+TimeToStr(Now)+'---------', False);
                  Script := Emptystr;
                  Arquivo.Clear;
                end;
              end;
            end
            else
              Script := Script + LinhaTexto[Y];
          end;

          if Script <> EmptyStr then
          begin
            Arquivo.Add(Script);
            Script := EmptyStr;
          end;
        end;

        if Trim(Arquivo.Text) <> EmptyStr then
        begin
          try
            SQL := Arquivo;
            ExecSQL;
            {Apos aplicar o script Salva o mesmo numa pasta Separada}
            SalvaScriptAplicado(TValidacao.Criptografa(Arquivo.Text)+#13+'--------Hora: '+TimeToStr(Now)+'---------', True);
          except
            on E: Exception do
              SalvaScriptAplicado(TValidacao.Criptografa(Arquivo.Text)+#13+'Erro: '+E.Message+#13+'--------Hora: '+TimeToStr(Now)+'---------', False);
          end;
        end;

        ArqParaLixeira(Caminho, Mensagem);
        if Mensagem <> EmptyStr then
          TMens.Aviso(pChar(Mensagem), False);
      end;
    finally
//      DM.Banco.SQLDialect := Dialect;
      FreeAndNil(Decript);
      FreeAndNil(Arquivo);
    end;
  end;
end;

class procedure TArquivo.AplicaScriptBanco;
Var
  sCodigo : String;
begin
  with DM.SqlAuxiliar do
  begin
    Close;
    SQL.Text := 'SELECT * FROM GEN_SIST_ATUALIZACAO ' +
                ' WHERE ((APLICAR = ''S'' ) or (OBRIGATORIO = ''S'')) ' +
                '   AND APLICADO = ''N''' +
                ' ORDER BY OBRIGATORIO, SEQ_SCRIPT';
    Open;

    try
//      if not DM.FDScript.Transaction.Active then
//        DM.FDScript.Transaction.StartTransaction;

      First;
      while not Eof do
      begin
        sCodigo := FieldByName('CODIGO').AsString;
//        DM.FDScript.Arguments.Clear;
//        DM.FDScript.Arguments.Add(FieldByName('SCRIPT').AsVariant);
//        DM.FDScript.Arguments.Add('UPDATE GEN_SIST_ATUALIZACAO set ' +
//                               '       APLICADO = ''S'', ' +
//                               '       DT_HR_APLICACAO = CURRENT_TIMESTAMP '+
//                               ' WHERE CODIGO = '+sCodigo);
//        DM.FDScript.ExecuteAll;
        Next;
      end;

//      if DM.FDScript.Transaction.Active then
//        DM.FDScript.Transaction.Commit;
    except
      on E: exception do
        TMens.Aviso(pChar('Erro: '+e.Message));
    end;
  end;
end;


class procedure TArquivo.ArqParaLixeira(const NomeArq: string; var MsgErro: string);
var
  Op: TSHFileOpStruct;
begin
  MsgErro := '';

  if not FileExists(NomeArq) then
  begin
    MsgErro := 'Arquivo n�o encontrado.';
    Exit;
  end;

  FillChar(Op, SizeOf(Op), 0);

  with Op do
  begin
    wFunc := FO_DELETE;
    pFrom := PChar(NomeArq);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;

  if ShFileOperation(Op) <> 0 then
    MsgErro := 'N�o foi poss�vel enviar o arquivo para a lixeira.';
end;

class procedure TArquivo.SalvaScriptAplicado(Script: String; Aplicado: Boolean);
var
  Caminho,
  Diretorio,
  sScript : String;
  Arquivo   : TStrings;
begin
  sScript := Script;
  if Aplicado then
  begin
                 //FrmPrincipal.Servidor+'ScriAplicado';
    Diretorio := ExtractFilePath(ParamStr(0))+'ScriAplicado';
                 //FrmPrincipal.Servidor+'ScriAplicado\Script'+ReplaceStr(DateToStr(Now),'/','-') +'.sql';
    Caminho   := ExtractFilePath(ParamStr(0))+'ScriAplicado\Script'+ReplaceStr(DateToStr(Now),'/','-') +'.sql';
  end
  else
  begin          //FrmPrincipal.Servidor+'ScriNaoAplicado';
    Diretorio := ExtractFilePath(ParamStr(0))+'ScriNaoAplicado';
                 //FrmPrincipal.Servidor+'ScriNaoAplicado\Script'+ReplaceStr(DateToStr(Now),'/','-') +'.sql';
    Caminho   := ExtractFilePath(ParamStr(0))+'ScriNaoAplicado\Script'+ReplaceStr(DateToStr(Now),'/','-') +'.sql';
  end;   

  {1 Verifica se o Diretorio Existe. Caso n�o exista, ser� criado}
  if not DirectoryExists(Diretorio) then
    CreateDir(Diretorio);

  {2 Verifica se o Arquivo Existe}
  if FileExists(Caminho) then
  begin
    try
      Arquivo := TStringList.Create;
      {Carrega com o Arquivo j� existente}
      Arquivo.LoadFromFile(Caminho);
      {Adiciona o Ultimo Script Aplicado}
      Arquivo.Add(Trim(sScript));
      {Salva o Arquivo Com o Script Aplicado}
      Arquivo.SaveToFile(Caminho);
    finally
      FreeAndNil(Arquivo);
    end;
  end
  else
  begin
    try
      Arquivo := TStringList.Create;
      {Adiciona o Ultimo Script Aplicado}
      Arquivo.Add(sScript);
      {Salva o Arquivo Com o Script Aplicado}
      Arquivo.SaveToFile(Caminho);
    finally
      FreeAndNil(Arquivo);
    end;
  end;
end;

{ TExpressao }

{ TArredondNota }

class function TArredondNota.ArredondaNota(Nota: Double; Etapa,
  Turma: String): Double;
Var
  sNotaArredond : String;
begin
  //Montar o sql de valida��o do arredondamento
  with DM.SqlFuncao do
  begin
    Close;
    SQL.Text := 'SELECT COD_NOTA_ARREDOND ' +
                '  FROM NOTA_CALC ' +
                ' WHERE COD_TURMA =:COD_TURMA ' +
                '   AND ETAPA =:ETAPA ' +
                '   AND COD_NOTA_ARREDOND IS NOT NULL';
    ParamByName('COD_TURMA').AsString := Turma;
    ParamByName('ETAPA').AsString := Etapa;
    Open;

    if not IsEmpty then
    begin
      sNotaArredond := FieldByName('COD_NOTA_ARREDOND').AsString;
      Close;
      SQL.Text := 'SELECT NOTA_SUBSTITUI '+
                  '  FROM NOTAS_ARREDONDAMENTO '+
                  ' WHERE :NOTA BETWEEN NOTA_INI AND NOTA_FIM '+
                  '   AND COD_ARREDOND =:CODIGO ';
      ParamByName('NOTA').AsFloat    := Nota;
      ParamByName('CODIGO').AsString := sNotaArredond;      
      Open;

      if Not IsEmpty then
        Result := FieldByName('NOTA_SUBSTITUI').AsFloat
      else
        Result := Nota;
    end
    else
      Result := Nota;
  end;
end;

{ TDialogs }

constructor TDialogs.Create(AOwner: TComponent);
begin
  inherited Create;

  // Inicializa
  DM.FOwner         := AOwner;
  DM.FFrmDataFinder := nil;
  DM.FFormMsg       := nil;
end;

destructor TDialogs.Destroy;
begin
  // Libera
//  if Assigned(FFrmDataFinder) then FFrmDataFinder.Free;
  if Assigned(DM.FFormMsg)  then DM.FFormMsg.Free;

  // Destroy herdado
  inherited;
end;

class function TDialogs.MsgDlg(ATitle, AText: string;
  AButtonsText: array of string; ABigSize: Boolean): Integer;
begin
  // Cria o formul�rio de mensagem se nao foi criado
  if not Assigned(DM.FFormMsg) then
    DM.FFormMsg := TFrm_DialogoMensagem.Create(DM.FOwner);

  try
    // Mostra mensagem
    Result := TFrm_DialogoMensagem(DM.FFormMsg).Exibe(ATitle, AText, AButtonsText, {ATypeSound, }ikAutomatic {AIconKind}, ABigSize);
  finally
    // Libera
    DM.FFormMsg.Free;
    DM.FFormMsg := nil;
  end;
end;

{ TImpressora }

class function TImpressora.RetornaPortaImpPadrao: String;
//const
//  what: array[0..1] of string = ('True\','False\');
var
  Device, FName, Port : array[0..100] of Char;
  DevMode : THandle;
  sPorta : String;
begin
  Printer.GetPrinter(Device, FName, Port, DevMode);
  sPorta := StrPas(Port);
  Result := sPorta;
end;

end.

