object frmBomba: TfrmBomba
  Left = 0
  Top = 0
  Caption = 'Bomba'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 41
    Align = alTop
    TabOrder = 0
    object dtpData: TDateTimePicker
      Left = 8
      Top = 12
      Width = 90
      Height = 21
      Date = 44254.000000000000000000
      Time = 0.858074502313684200
      TabOrder = 0
    end
    object btnIniciarMovimento: TButton
      Left = 104
      Top = 8
      Width = 161
      Height = 25
      Caption = 'Iniciar Movimento do Dia'
      TabOrder = 1
      OnClick = btnIniciarMovimentoClick
    end
    object btnFinalizarMovimento: TButton
      Left = 271
      Top = 8
      Width = 161
      Height = 25
      Caption = 'Finalizar Movimento'
      Enabled = False
      TabOrder = 2
      OnClick = btnFinalizarMovimentoClick
    end
  end
  object pnlInformacao: TPanel
    Left = 0
    Top = 41
    Width = 447
    Height = 32
    Align = alTop
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 1
    object lblValorLitro: TLabel
      Left = 8
      Top = 6
      Width = 52
      Height = 13
      Caption = 'Valor Litro:'
    end
    object lblImposto: TLabel
      Left = 152
      Top = 6
      Width = 57
      Height = 13
      Caption = '% Imposto:'
    end
    object lblStatus: TLabel
      Left = 336
      Top = 6
      Width = 35
      Height = 13
      Caption = 'Status:'
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 80
    Width = 431
    Height = 105
    Caption = 'Abastecer Ve'#237'culo'
    TabOrder = 2
    object btnAbastecer: TButton
      Left = 168
      Top = 67
      Width = 75
      Height = 25
      Caption = 'Abastecer'
      Enabled = False
      TabOrder = 0
      OnClick = btnAbastecerClick
    end
    object edtPorLitro: TLabeledEdit
      Left = 272
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Por Litros'
      Enabled = False
      TabOrder = 1
      OnChange = edtPorLitroChange
      OnEnter = edtPorLitroEnter
      OnExit = edtPorLitroExit
    end
    object edtPorValor: TLabeledEdit
      Left = 32
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'Por Valor'
      Enabled = False
      TabOrder = 2
      OnChange = edtPorValorChange
      OnEnter = edtPorValorEnter
      OnExit = edtPorValorExit
    end
  end
end
