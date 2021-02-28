unit uMovimento;

interface

type
  TMovimento = class
  private
    FID: Integer;
    FBomba_ID: Integer;
    FData: TDate;
    FStatus: String;
    FImposto_Perc: Double;
    FValor_Litro: Double;

  public
   property ID: Integer read FID write FID;
   property Bomba_ID: Integer read FBomba_ID write FBomba_ID;
   property Data: TDate read FData write FData;
   property Status: String read FStatus write FStatus;
   property Imposto_Perc: Double read FImposto_Perc write FImposto_Perc;
   property Valor_Litro: Double read FValor_Litro write FValor_Litro;

  end;

implementation

{ TMovimento }


end.
