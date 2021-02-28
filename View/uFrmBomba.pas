unit uFrmBomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBombaCombustivel, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, uMovimento, uMovimentoController, System.UITypes,
  uAbastecimentoController;

type
  TfrmBomba = class(TForm)
    pnlPrincipal: TPanel;
    dtpData: TDateTimePicker;
    btnIniciarMovimento: TButton;
    btnFinalizarMovimento: TButton;
    pnlInformacao: TPanel;
    lblValorLitro: TLabel;
    lblImposto: TLabel;
    lblStatus: TLabel;
    GroupBox1: TGroupBox;
    btnAbastecer: TButton;
    edtPorLitro: TLabeledEdit;
    edtPorValor: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIniciarMovimentoClick(Sender: TObject);
    procedure edtPorValorChange(Sender: TObject);
    procedure edtPorLitroChange(Sender: TObject);
    procedure edtPorValorEnter(Sender: TObject);
    procedure edtPorLitroEnter(Sender: TObject);
    procedure edtPorValorExit(Sender: TObject);
    procedure edtPorLitroExit(Sender: TObject);
    procedure btnAbastecerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFinalizarMovimentoClick(Sender: TObject);
  private
    { Private declarations }

    _Bomba     : TBombaCombustivel;
    _Movimento : TMovimento;
    procedure CriaMovimentoLocal;
  public
    { Public declarations }
    Bomba_ID: Integer;

    procedure ConfigurarBomba(pBomba: TBombaCombustivel);
    procedure IniciarMovimento;
    procedure FinalizarMovimento;
    procedure AbastecerVeiculo;
  end;

var
  frmBomba: TfrmBomba;

implementation

{$R *.dfm}

{ TfrmBomba }

procedure TfrmBomba.AbastecerVeiculo;
var
    oAbastecimentoController: TAbastecimentoController;
    fQtdLitro     : Double;
    fValorTotal   : Currency;
    fValorImposto : Currency;
begin

  oAbastecimentoController := TAbastecimentoController.Create;

  try
    fQtdLitro     := StrToFloatDef(edtPorLitro.Text,-1);
    fValorTotal   := StrToFloatDef(edtPorValor.Text,-1);
    if fQtdLitro = -1 then
      MessageDlg('Quantidade de Litros Inválida!', mtError, [mbOk], 0)
    else
    if fValorTotal = -1 then
      MessageDlg('Valor Total Inválido!', mtError, [mbOk], 0)
    else
    begin
      fValorImposto := ( fValorTotal * _Movimento.Imposto_Perc  / 100 );

      if oAbastecimentoController.IncluirAbastecimento( _Movimento.ID, fQtdLitro, fValorTotal, fValorImposto) then
      begin
        MessageDlg('Abastecimento Concluído!', mtInformation, [mbOk], 0);
        edtPorLitro.Text := EmptyStr;
        edtPorValor.Text := EmptyStr;
      end
      else
        MessageDlg('Abastecimento não realizado!', mtWarning, [mbOk], 0)

    end;

  finally
    oAbastecimentoController.Free;
  end;
end;

procedure TfrmBomba.btnAbastecerClick(Sender: TObject);
begin
  AbastecerVeiculo;
end;

procedure TfrmBomba.btnFinalizarMovimentoClick(Sender: TObject);
begin
  FinalizarMovimento;
end;

procedure TfrmBomba.FinalizarMovimento;
var
    oMovimentoController: TMovimentoController;
begin
  CriaMovimentoLocal;
  if _Movimento.Status = 'Fechado' then
    MessageDlg('Movimento já está Fechado!',mtInformation, [mbOk],0)
  else
  begin
    oMovimentoController := TMovimentoController.Create;
    try
      oMovimentoController.FinalizarMovimento(_Movimento);
      lblStatus.Caption     := 'Status: ' + _Movimento.Status;

      edtPorValor.Enabled  := False;
      edtPorLitro.Enabled  := False;
      btnAbastecer.Enabled := False;
      btnFinalizarMovimento.Enabled := False;
    finally
      oMovimentoController.Free;
    end
  end;
end;

procedure TfrmBomba.ConfigurarBomba(pBomba: TBombaCombustivel);
begin
  _Bomba   := pBomba;
  Caption  := _Bomba.Nome_Bomba;
  Bomba_ID := _Bomba.ID;
end;

procedure TfrmBomba.CriaMovimentoLocal;
begin
  if not Assigned(_Movimento) then
    _Movimento := TMovimento.Create;
end;

procedure TfrmBomba.btnIniciarMovimentoClick(Sender: TObject);
begin
  IniciarMovimento;
end;

procedure TfrmBomba.IniciarMovimento;
var
    oMovimentoController: TMovimentoController;
begin
  CriaMovimentoLocal;

  oMovimentoController := TMovimentoController.Create;
  try
    oMovimentoController.IniciarMovimento(_Movimento, _Bomba.ID, dtpData.Date);
    lblValorLitro.Caption := 'Valor Litro: ' + FloatToStr(_Movimento.Valor_Litro);
    lblImposto.Caption    := '% Imposto: '   + FloatToStr(_Movimento.Imposto_Perc);
    lblStatus.Caption     := 'Status: '      + _Movimento.Status;

    if _Movimento.Status = 'Fechado' then
    begin
      MessageDlg('Este Movimento está fechado',mtWarning,[mbOk],0);

      edtPorValor.Enabled   := False;
      edtPorLitro.Enabled   := False;
      btnAbastecer.Enabled  := False;
      btnFinalizarMovimento.Enabled := False;
    end
    else
    if Assigned(_Movimento) then
    begin
      edtPorValor.Enabled   := True;
      edtPorLitro.Enabled   := True;
      btnAbastecer.Enabled  := True;
      btnFinalizarMovimento.Enabled := True;
    end;
  finally
    oMovimentoController.Free;
  end;

end;

procedure TfrmBomba.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _Bomba.Free;
  _Movimento.Free;
  Action := caFree;
end;

procedure TfrmBomba.FormCreate(Sender: TObject);
begin
  dtpData.DateTime := Now();
end;

procedure TfrmBomba.edtPorValorChange(Sender: TObject);
begin
  if StrToFloatDef(edtPorValor.Text,0) > 0 then
    edtPorLitro.Text := FormatFloat('0.00', StrToFloatDef(edtPorValor.Text,1) / _Movimento.Valor_Litro ) ;
end;

procedure TfrmBomba.edtPorValorEnter(Sender: TObject);
begin
  edtPorLitro.OnChange := nil;
end;

procedure TfrmBomba.edtPorValorExit(Sender: TObject);
begin
  edtPorLitro.OnChange := edtPorLitroChange;
end;

procedure TfrmBomba.edtPorLitroChange(Sender: TObject);
begin
  if StrToFloatDef(edtPorLitro.Text,0) > 0 then
    edtPorValor.Text := FormatFloat('0.00', _Movimento.Valor_Litro * StrToFloatDef(edtPorLitro.Text,1) );
end;

procedure TfrmBomba.edtPorLitroEnter(Sender: TObject);
begin
  edtPorValor.OnChange := nil;
end;

procedure TfrmBomba.edtPorLitroExit(Sender: TObject);
begin
  edtPorValor.OnChange := edtPorValorChange;
end;

end.
