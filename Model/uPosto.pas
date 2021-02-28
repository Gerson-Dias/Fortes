unit uPosto;

interface

uses System.Generics.Collections, uTanque;

type
  TPosto = class
  private
    FID: Integer;
    FNome_Posto: String;
    FEndereco_Posto: String;
    FLista_Tanque: TObjectList<TTanque>;
  public
    property ID: Integer read FID write FID;
    property Nome_Posto: String read FNome_Posto write FNome_Posto;
    property Endereco_Posto: String read FEndereco_Posto write FEndereco_Posto;
    property Lista_Tanque: TObjectList<TTanque> read FLista_Tanque write FLista_Tanque;

    procedure AdicionarTanque(pTanque: TTanque);
    class function CriaObjetoPosto: TPosto;
    constructor create;
    destructor Destroy; override;
  end;

implementation

{ TPosto }

var Posto: TPosto;

procedure TPosto.AdicionarTanque(pTanque: TTanque);
var i: Integer;
begin

  FLista_Tanque.Add(TTanque.Create);

  i := FLista_Tanque.Count-1;

  TTanque(FLista_Tanque[i]).ID               := pTanque.ID;
  TTanque(FLista_Tanque[i]).Posto_ID         := pTanque.Posto_ID;
  TTanque(FLista_Tanque[i]).Tipo_Combustivel := pTanque.Tipo_Combustivel;
end;

constructor TPosto.Create;
begin
  inherited;

  FLista_Tanque := TObjectList<TTanque>.Create;
end;

class function TPosto.CriaObjetoPosto: TPosto;
begin
  if not Assigned(Posto) then
    Posto := TPosto.Create;
  Result := Posto;
end;

destructor TPosto.Destroy;
begin
  Posto.FLista_Tanque.Destroy;
  inherited;
end;

end.
