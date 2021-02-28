program TesteFortesPosto;

uses
  Vcl.Forms,
  uAbastecimentoController in 'Controller\uAbastecimentoController.pas',
  uBombaCombustivelController in 'Controller\uBombaCombustivelController.pas',
  uMovimentoController in 'Controller\uMovimentoController.pas',
  uPostoController in 'Controller\uPostoController.pas',
  uDMPrincipal in 'Dao\uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uAbastecimento in 'Model\uAbastecimento.pas',
  uBombaCombustivel in 'Model\uBombaCombustivel.pas',
  uMovimento in 'Model\uMovimento.pas',
  uPosto in 'Model\uPosto.pas',
  uTanque in 'Model\uTanque.pas',
  uFrmBomba in 'View\uFrmBomba.pas' {frmBomba},
  uFrmPrincipal in 'View\uFrmPrincipal.pas' {frmPrincipal},
  uFrmRelVendas in 'View\uFrmRelVendas.pas' {frmRelVendas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.Run;
end.
