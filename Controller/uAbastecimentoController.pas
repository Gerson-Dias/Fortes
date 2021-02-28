unit uAbastecimentoController;

interface

uses uDMPrincipal;
type TAbastecimentoController = class
      function  IncluirAbastecimento(pMovimento_ID: Integer; pQtd_Litro: Double; pValor_Total, pValor_Imposto: Currency): Boolean;
end;

implementation

function TAbastecimentoController.IncluirAbastecimento(pMovimento_ID: Integer; pQtd_Litro: Double; pValor_Total, pValor_Imposto: Currency): Boolean;
begin
  Result := DMPrincipal.IncluirAbastecimento(pMovimento_ID, pQtd_Litro, pValor_Total, pValor_Imposto);
end;

end.
