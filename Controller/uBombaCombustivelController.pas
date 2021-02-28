unit uBombaCombustivelController;

interface

uses uBombaCombustivel, uDMPrincipal;

type
  TBombaCombustivelController = class
    procedure PesquisarBomba(pBombaCombustivel: TBombaCombustivel; pID: Integer);

  end;


implementation

{ TBombaCombustivelController }

procedure TBombaCombustivelController.PesquisarBomba(pBombaCombustivel: TBombaCombustivel; pID: Integer);
begin
  DMPrincipal.PesquisarBomba(pBombaCombustivel,pID);
end;

end.
