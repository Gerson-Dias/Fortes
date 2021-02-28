unit uMovimentoController;

interface

uses uDMPrincipal, uMovimento;

type
  TMovimentoController = class
    procedure IniciarMovimento(pMovimento: TMovimento; pBomba_ID: Integer; pData: TDate);
    procedure FinalizarMovimento(pMovimento: TMovimento);
  end;
implementation

{ TMovimentoController }

procedure TMovimentoController.IniciarMovimento(pMovimento: TMovimento; pBomba_ID: Integer;  pData: TDate);
begin
  DMPrincipal.IniciarMovimento(pMovimento, pBomba_ID, pData);
end;

procedure TMovimentoController.FinalizarMovimento(pMovimento: TMovimento);
begin
  DMPrincipal.FinalizarMovimento(pMovimento);
end;

end.
