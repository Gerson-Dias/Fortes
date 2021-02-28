unit uBombaCombustivel;

interface

type
  TBombaCombustivel = class
  private
    FID: Integer;
    FTanque_ID: Integer;
    FNome_Bomba: String;
  public
    property ID: Integer read FID write FID;
    property Tanque_ID: Integer read FTanque_ID write FTanque_ID;
    property Nome_Bomba: String read FNome_Bomba write FNome_Bomba;

  end;

implementation

end.
