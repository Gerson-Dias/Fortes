unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, uPosto, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DB, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, uTanque, uBombaCombustivel, FireDAC.Stan.Param,
  FireDAC.DApt, uMovimento, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet;

type
  TDMPrincipal = class(TDataModule)
    FDConnPrincipal: TFDConnection;
    FDTransacPrincipal: TFDTransaction;
    dsQryRelVEndas: TDataSource;
    FDQryRelVendas: TFDQuery;
    FDQryRelVendasDIA: TDateField;
    FDQryRelVendasTANQUE: TIntegerField;
    FDQryRelVendasBOMBA_ID: TIntegerField;
    FDQryRelVendasBOMBA: TStringField;
    FDQryRelVendasLITROS: TSingleField;
    FDQryRelVendasVALOR: TSingleField;
    FDQryRelVendasIMPOSTO: TSingleField;
  private
    { Private declarations }
    procedure CriaConexaoBanco;
  public
    { Public declarations }
    function  IniciarPosto(pIDPosto: Integer): TPosto;
    function  PesquisarMovimento(pMovimento: TMovimento; pBomba_ID: Integer; pData: TDate): Boolean;
    function  IncluirMovimento(pMovimento: TMovimento; pBomba_ID: Integer; pData: TDate): Boolean;
    function  IncluirAbastecimento(pMovimento_ID: Integer; pQtd_Litro: Double; pValor_Total, pValor_Imposto: Currency): Boolean;

    procedure PesquisarBomba(pBombaCombustivel: TBombaCombustivel; pBomba_ID: Integer);
    procedure IniciarMovimento(pMovimento: TMovimento; pBomba_ID: Integer; pData: TDate);
    procedure FinalizarMovimento(pMovimento: TMovimento);
    procedure RelatorioVendas(pDataIni, pDataFim: TDate);
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMPrincipal }

procedure TDMPrincipal.CriaConexaoBanco;
begin
  if not FDConnPrincipal.Connected then
  begin
    try
      FDConnPrincipal.LoginPrompt := False;
      FDConnPrincipal.ConnectionName := 'ConexaoPrincipal';
      FDConnPrincipal.DriverName     := 'FB';

      FDConnPrincipal.Params.Add('Database=D:\Curso\Teste_Fortes\Banco\BANCOPOSTO.FDB');
      FDConnPrincipal.Params.Add('Password=masterkey');
      FDConnPrincipal.Params.Add('User_Name=SYSDBA');
      FDConnPrincipal.Params.Add('DriverID=FB');
      FDConnPrincipal.Connected := True;
    except on E:Exception do
      raise Exception.Create('Erro na Conexão com o Banco de Dados'+#13+E.Message);
    end;
  end;
end;

procedure TDMPrincipal.IniciarMovimento(pMovimento: TMovimento; pBomba_ID: Integer; pData: TDate);
begin
  try
    if not PesquisarMovimento(pMovimento, pBomba_ID, pData) then
    begin
      if IncluirMovimento(pMovimento, pBomba_ID, pData) then
        PesquisarMovimento(pMovimento, pBomba_ID, pData);
    end
  except on E:Exception do
     raise Exception.Create('Não foi possível iniciar o movimento do dia.' + E.Message);
  end;
end;

function TDMPrincipal.PesquisarMovimento(pMovimento: TMovimento; pBomba_ID: Integer; pData: TDate): Boolean;
var qryMovimento: TFDQuery;
begin

  try
    CriaConexaoBanco;

    qryMovimento  := TFDQuery.Create(nil);

    try
      qryMovimento.Connection  := FDConnPrincipal;

      qryMovimento.SQL.Text := 'select id, bomba_id, data, status, imposto_perc, valor_litro ' +
                               'from tb_movimento mv ' +
                               'where mv.bomba_id = :id_bomba and mv.data = :data ';

      qryMovimento.ParamByName('id_bomba').AsInteger := pBomba_ID;
      qryMovimento.ParamByName('data').AsDate        := pData;
      qryMovimento.Open;
      qryMovimento.First;

      Result := not qryMovimento.Eof;

      if Result then
      begin
        pMovimento.ID           := qryMovimento.FieldByName('ID').AsInteger;
        pMovimento.Bomba_ID     := qryMovimento.FieldByName('BOMBA_ID').AsInteger;
        pMovimento.Data         := qryMovimento.FieldByName('DATA').AsDateTime;
        pMovimento.Status       := qryMovimento.FieldByName('STATUS').AsString;
        pMovimento.Imposto_Perc := qryMovimento.FieldByName('IMPOSTO_PERC').AsFloat;
        pMovimento.Valor_Litro  := qryMovimento.FieldByName('VALOR_LITRO').AsFloat;
      end;

      qryMovimento.Close;
    finally
      qryMovimento.Free;
    end

  except on E:Exception do
    raise Exception.Create('Erro ao pesquisar Movimento'+#13+E.Message);
  end

end;

procedure TDMPrincipal.RelatorioVendas(pDataIni, pDataFim: TDate);
begin
  CriaConexaoBanco;

  FDQryRelVendas.Close;
  FDQryRelVendas.ParamByName('dataIni').AsDate := pDataIni;
  FDQryRelVendas.ParamByName('dataFim').AsDate := pDataFim;
  FDQryRelVendas.Open;
end;

procedure TDMPrincipal.FinalizarMovimento(pMovimento: TMovimento);
var qryMovimento: TFDQuery;
begin

  try
    CriaConexaoBanco;

    qryMovimento  := TFDQuery.Create(nil);

    try
      qryMovimento.Connection  := FDConnPrincipal;

      qryMovimento.SQL.Text := 'update tb_movimento ' +
                               'set tb_movimento.status = ' + QuotedStr('Fechado') +
                               'where tb_movimento.id = :id';

      qryMovimento.ParamByName('id').AsInteger := pMovimento.ID;
      qryMovimento.ExecSQL;
      qryMovimento.Close;
      pMovimento.Status := 'Fechado';
    finally
      qryMovimento.Free;
    end

  except on E:Exception do
    raise Exception.Create('Erro ao fechar Movimento'+#13+E.Message);
  end

end;

function TDMPrincipal.IncluirAbastecimento(pMovimento_ID: Integer;
  pQtd_Litro: Double; pValor_Total, pValor_Imposto: Currency): Boolean;
var qryAbastecimento: TFDQuery;
begin

  try
    CriaConexaoBanco;

    qryAbastecimento  := TFDQuery.Create(nil);

    try
      qryAbastecimento.Connection  := FDConnPrincipal;

      qryAbastecimento.Close;
      qryAbastecimento.SQL.Text := 'insert into tb_abastecimento (id, movimento_id, qtd_litro, valor_total, valor_imposto) ' +
                                   'values (:id, :movimento_id, :qtd_litro, :valor_total, :valor_imposto) ';

      qryAbastecimento.ParamByName('id').AsInteger             := 0;
      qryAbastecimento.ParamByName('movimento_id').AsInteger   := pMovimento_ID;
      qryAbastecimento.ParamByName('qtd_litro').AsFloat        := pQtd_Litro;
      qryAbastecimento.ParamByName('valor_total').AsCurrency   := pValor_Total;
      qryAbastecimento.ParamByName('valor_imposto').AsCurrency := pValor_Imposto;
      qryAbastecimento.ExecSQL;

      Result := True;

    finally
      qryAbastecimento.Free;

    end

  except on E:Exception do
    raise Exception.Create('Erro incluir Abastecimento'+#13+E.Message);
  end

end;

function TDMPrincipal.IncluirMovimento(pMovimento: TMovimento; pBomba_ID: Integer; pData: TDate): Boolean;
var qryMovimento: TFDQuery;
begin

  try
    CriaConexaoBanco;

    qryMovimento  := TFDQuery.Create(nil);

    try
      qryMovimento.Connection  := FDConnPrincipal;

      qryMovimento.Close;
      qryMovimento.SQL.Text := 'insert into tb_movimento (id, bomba_id, data, status, imposto_perc, valor_litro) ' +
                               'values (:id, :bomba_id, :data, :status, :imposto_perc, :valor_litro) ';

      qryMovimento.ParamByName('id').AsInteger           := 0;
      qryMovimento.ParamByName('bomba_id').AsInteger     := pBomba_ID;
      qryMovimento.ParamByName('data').AsDate            := pData;
      qryMovimento.ParamByName('status').AsString        := 'Aberto';
      qryMovimento.ParamByName('imposto_perc').AsFloat   := 13.0; // Obs: Não parametrizei
      qryMovimento.ParamByName('valor_litro').AsCurrency := 5.39; // Obs: Não parametrizei
      qryMovimento.ExecSQL;

      Result := True;

    finally
      qryMovimento.Free;

    end

  except on E:Exception do
    raise Exception.Create('Erro ao iniciar Movimento'+#13+E.Message);
  end

end;


function TDMPrincipal.IniciarPosto(pIDPosto: Integer): TPosto;
var qryTanque, qryBomba, qryPosto: TFDQuery;
    iT, iB : Integer;
begin
  CriaConexaoBanco;

  // Cria o Posto
  Result := TPosto.CriaObjetoPosto;

  qryPosto  := TFDQuery.Create(nil);
  qryTanque := TFDQuery.Create(nil);
  qryBomba  := TFDQuery.Create(nil);

  try

    qryPosto.Connection  := FDConnPrincipal;
    qryPosto.SQL.Text    := 'select pt.id, pt.nome_posto, pt.endereco_posto ' +
                            'from tb_posto pt ' +
                            'where pt.id = :id_posto';

    qryPosto.ParamByName('id_posto').AsInteger := pIDPosto;
    qryPosto.Open;
    qryPosto.First;
    if not qryPosto.Eof then
    begin
      Result.ID             := qryPosto.FieldByName('ID').AsInteger;
      Result.Nome_Posto     := qryPosto.FieldByName('NOME_POSTO').AsString;
      Result.Endereco_Posto := qryPosto.FieldByName('ENDERECO_POSTO').AsString;
    end;
    qryPosto.Close;

    // Tanques e Bombas
    qryTanque.Connection := FDConnPrincipal;
    qryBomba.Connection  := FDConnPrincipal;

    qryTanque.SQL.Text   := 'select tq.id, tq.tipo_combustivel, tq.posto_id ' +
                            'from tb_tanque tq ' +
                            'join tb_posto pt on pt.id = tq.posto_id ' +
                            'where pt.id = :id_posto ' +
                            'order by tq.id ';

    qryTanque.ParamByName('id_posto').AsInteger := Result.ID;

    qryTanque.Open;
    qryTanque.First;
    while not qryTanque.Eof do
    begin
      // Cria os Tanques
      Result.Lista_Tanque.Add(TTanque.Create);

      iT := Result.Lista_Tanque.Count-1;
      TTanque(Result.Lista_Tanque[iT]).ID               := qryTanque.FieldByName('ID').AsInteger;
      TTanque(Result.Lista_Tanque[It]).Tipo_Combustivel := qryTanque.FieldByName('TIPO_COMBUSTIVEL').AsString;
      TTanque(Result.Lista_Tanque[iT]).Posto_ID         := qryTanque.FieldByName('POSTO_ID').AsInteger;

      // Cria as Bombas
      qryBomba.SQL.Text   := 'select bc.id, bc.nome_bomba ' +
                             'from tb_bomba_combustivel bc ' +
                             'join tb_tanque tq on tq.id = bc.tanque_id ' +
                             'where tq.id = :id_tanque ' +
                             'order by bc.id ';

      qryBomba.ParamByName('id_tanque').AsInteger := qryTanque.FieldByName('ID').AsInteger;
      qryBomba.Open;
      qryBomba.First;
      while not qryBomba.Eof do
      begin
        TTanque(Result.Lista_Tanque[iT]).Lista_Bomba.Add(TBombaCombustivel.Create);

        iB := TTanque(Result.Lista_Tanque[iT]).Lista_Bomba.Count-1;
        TBombaCombustivel(TTanque(Result.Lista_Tanque[iT]).Lista_Bomba[iB]).ID         := qryBomba.FieldByName('ID').AsInteger;
        TBombaCombustivel(TTanque(Result.Lista_Tanque[iT]).Lista_Bomba[iB]).Tanque_ID  := qryTanque.FieldByName('ID').AsInteger;
        TBombaCombustivel(TTanque(Result.Lista_Tanque[iT]).Lista_Bomba[iB]).Nome_Bomba := qryBomba.FieldByName('NOME_BOMBA').AsString;

        qryBomba.Next;
      end;

      qryBomba.Close;

      qryTanque.Next;
    end;

    qryTanque.Close;
  finally
    qryPosto.Free;
    qryTanque.Free;
    qryBomba.Free;
  end
end;

procedure TDMPrincipal.PesquisarBomba(pBombaCombustivel: TBombaCombustivel; pBomba_ID: Integer);
var qryBomba: TFDQuery;
begin

  try
    CriaConexaoBanco;

    qryBomba  := TFDQuery.Create(nil);

    try
      qryBomba.Connection  := FDConnPrincipal;

      qryBomba.SQL.Text   := 'select bc.id, bc.tanque_id, bc.nome_bomba ' +
                             'from tb_bomba_combustivel bc ' +
                             'where bc.id = :id_bomba ';
      qryBomba.ParamByName('id_bomba').AsInteger := pBomba_ID;
      qryBomba.Open;
      qryBomba.First;
      if not qryBomba.Eof then
      begin
        pBombaCombustivel.ID         := qryBomba.FieldByName('ID').AsInteger;
        pBombaCombustivel.Tanque_ID  := qryBomba.FieldByName('TANQUE_ID').AsInteger;
        pBombaCombustivel.Nome_Bomba := qryBomba.FieldByName('NOME_BOMBA').AsString;
      end;
      qryBomba.Close;
    finally
      qryBomba.Free;
    end

  except on E:Exception do
    raise Exception.Create('Erro ao pesquisar Bomba'+#13+E.Message);
  end

end;

end.
