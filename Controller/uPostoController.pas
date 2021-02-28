unit uPostoController;

interface

uses uPosto;

type
  TPostoController = class
    function IniciarPosto(pIDPosto: Integer): TPosto;

  end;

implementation

{ TPostoConttroller }

uses uDMPrincipal;


function TPostoController.IniciarPosto(pIDPosto: Integer): TPosto;
begin
  Result := DMPrincipal.IniciarPosto(pIDPosto);
end;

end.
