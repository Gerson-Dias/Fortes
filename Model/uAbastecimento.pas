unit uAbastecimento;

interface

type
  TAbastecimento = class
  private
    FID: Integer;
    FMovimento_ID: Integer;
    FQTD_Litro: Double;
    FValor_Total: Double;
    FValor_Imposto: Double;

  public
    property ID: Integer read FID write FID;
    property Movimento_ID: Integer read FMovimento_ID write FMovimento_ID;
    property QTD_Litro: Double read FQTD_Litro write FQTD_Litro;
    property Valor_Total: Double read FValor_Total write FValor_Total;
    property Valor_Imposto: Double read FValor_Imposto write FValor_Imposto;

  end;
implementation

{ TAbastecimento }


end.
