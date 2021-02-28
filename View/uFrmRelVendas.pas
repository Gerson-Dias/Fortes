unit uFrmRelVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, uDMPrincipal, Vcl.Imaging.jpeg;

type
  TfrmRelVendas = class(TForm)
    RLRptRelatorioVendas: TRLReport;
    RLBndTitulo: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLLabel1: TRLLabel;
    RLLblPeriodo: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel2: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLImage1: TRLImage;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RelatorioVendas(pDataIni, pDataFim: TDate);
  end;

var
  frmRelVendas: TfrmRelVendas;

implementation

{$R *.dfm}

{ TfrmRelVendas }

procedure TfrmRelVendas.RelatorioVendas(pDataIni, pDataFim: TDate);
begin
  DMPrincipal.RelatorioVendas(pDataIni,pDataFim);
  RLLblPeriodo.Caption := 'Período: ' + DateToStr(pDataIni) + ' até ' + DateToStr(pDataFim);
  RLRptRelatorioVendas.Preview;
end;

end.
