unit uTanque;

interface

uses System.Generics.Collections, uBombaCombustivel;

type
  TTanque = Class
    private
      FID: Integer;
      FPosto_ID: Integer;
      FTipo_Combustivel: String;
      FLista_Bomba: TObjectList<TBombaCombustivel>;

    public
      property ID: Integer read FID write FID;
      property Posto_ID: Integer read FPosto_ID write FPosto_ID;
      property Tipo_Combustivel: String read FTipo_Combustivel write FTipo_Combustivel;
      property Lista_Bomba: TObjectList<TBombaCombustivel> read FLista_Bomba write FLista_Bomba;

      constructor Create;
      destructor Destroy; override;

  End;

implementation

{ TTanque }

constructor TTanque.Create;
begin
  inherited;
  FLista_Bomba := TObjectList<TBombaCombustivel>.Create;
end;

destructor TTanque.Destroy;
begin
  FLista_Bomba.Destroy;
  inherited;
end;

end.
