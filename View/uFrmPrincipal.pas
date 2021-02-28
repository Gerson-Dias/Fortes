unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.Buttons, uBombaCombustivel, uTanque, uPosto, uFrmBomba,
  uBombaCombustivelController, System.IniFiles, uFrmRelVendas;


type
  // Adicionar parametros do sistema aqui.
  TParametrosSistema = record
    PostoID       : Integer;
    Desenvolvedor : String;
  end;

  TfrmPrincipal = class(TForm)
    Panel2: TPanel;
    btnIniciarPosto: TBitBtn;
    sgdBombas: TStringGrid;
    btnIniciarBomba: TBitBtn;
    lblPosto: TLabel;
    Bevel1: TBevel;
    btnRelatorio: TButton;
    dtpDataFim: TDateTimePicker;
    dtpDataIni: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnIniciarPostoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIniciarBombaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    _Posto: TPosto;
    procedure IniciarPosto;
    procedure ParametrosDoSistema;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  ParamSistema: TParametrosSistema;

implementation

{$R *.dfm}

uses uPostoController;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  ParametrosDoSistema;
end;

procedure TfrmPrincipal.ParametrosDoSistema;
var
  cfConfigFile : TIniFile;
begin
  cfConfigFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    ParamSistema.PostoID       := cfConfigFile.ReadInteger('GERAL', 'POSTO_ID', 1 );
    ParamSistema.Desenvolvedor := cfConfigFile.ReadString ('GERAL', 'Desenvolvedor', 'Gerson Dias');
  finally
    cfConfigFile.Free;
  end;

  dtpDataIni.DateTime := StrToDate(FormatDateTime('01/mm/yyyy', Now()));
  dtpDataFim.DateTime := Now();
end;

procedure TfrmPrincipal.btnIniciarBombaClick(Sender: TObject);
var idBomba, i: Integer;
    frmBomba: TFrmBomba;
    oBombaCombustivel : TBombaCombustivel;
    oBombaCombustivelController: TBombaCombustivelController;
begin
  idBomba := StrToIntDef(sgdBombas.Cells[0, sgdBombas.Row],-1);
  if idBomba < 0 then
    raise Exception.Create('Bomba Inválida');

  // Se já foi criado, apresenta.
  for i:=0 to MDIChildCount - 1 do
  begin
    if TfrmBomba(MDIChildren[i]).Bomba_ID = idBomba then
    begin
      MDIChildren[i].Show;
      Exit;
    end;
  end;

  // Cria um novo
  oBombaCombustivelController := TBombaCombustivelController.Create;
  try
    oBombaCombustivel := TBombaCombustivel.Create;
    oBombaCombustivelController.PesquisarBomba(oBombaCombustivel, idBomba);
    frmBomba := TFrmBomba.Create(Application);
    frmBomba.ConfigurarBomba(oBombaCombustivel);
  finally
    oBombaCombustivelController.Free;
  end;

end;

procedure TfrmPrincipal.btnIniciarPostoClick(Sender: TObject);
begin
  IniciarPosto;
end;

procedure TfrmPrincipal.btnRelatorioClick(Sender: TObject);
begin
  frmRelVendas := TfrmRelVendas.Create(Application);
  frmRelVendas.RelatorioVendas(dtpDataIni.Date, dtpDataFim.Date);
end;

procedure TfrmPrincipal.IniciarPosto;
var
  x : Integer;
  oPostoController: TPostoController;
  oTanque: TTanque;
  oBombaCombustivel: TBombaCombustivel;
begin

  oPostoController := TPostoController.Create;
  try

    try
      _Posto := oPostoController.IniciarPosto(ParamSistema.PostoID);

      sgdBombas.Cells[0,0]   := 'Código';
      sgdBombas.Cells[1,0]   := 'Nome da Bomba';
      sgdBombas.Cells[2,0]   := 'Tipo';
      sgdBombas.ColWidths[0] := 40;
      sgdBombas.ColWidths[1] := 90;//130;
      sgdBombas.ColWidths[2] := 50;
      x := 0;

      for oTanque in _Posto.Lista_Tanque do
      begin
        for oBombaCombustivel in oTanque.Lista_Bomba do
        begin
          inc(x);
          sgdBombas.RowCount := x + 1;
          sgdBombas.Cells[0,x] := IntToStr(oBombaCombustivel.ID);
          sgdBombas.Cells[1,x] := oBombaCombustivel.Nome_Bomba;
          sgdBombas.Cells[2,x] := oTanque.Tipo_Combustivel;
        end;
      end;

      btnIniciarBomba.Enabled := True;
      lblPosto.Caption        := 'NOME: ' + IntToStr(_Posto.ID) + '-' +Copy(_Posto.Nome_Posto, 1, 15);

    except on E:exception do
      raise Exception.Create('Não foi possível abrir o Posto. '+#13+E.Message);
    end;

  finally
    oPostoController.Free;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(_Posto) then
    FreeAndNil(_Posto)
end;

end.
