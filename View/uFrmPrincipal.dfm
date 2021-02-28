object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'GERENCIAR ABASTECIMENTOS'
  ClientHeight = 376
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 195
    Height = 376
    Align = alLeft
    TabOrder = 0
    object lblPosto: TLabel
      Left = 10
      Top = 38
      Width = 39
      Height = 16
      Caption = 'NOME:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 4
      Top = 275
      Width = 175
      Height = 2
    end
    object Label1: TLabel
      Left = 4
      Top = 291
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 4
      Top = 310
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object btnIniciarPosto: TBitBtn
      Left = 20
      Top = 7
      Width = 151
      Height = 25
      Caption = 'Iniciar Posto'
      TabOrder = 0
      OnClick = btnIniciarPostoClick
    end
    object sgdBombas: TStringGrid
      Left = 4
      Top = 75
      Width = 189
      Height = 161
      ColCount = 3
      FixedColor = clGradientActiveCaption
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 1
      RowHeights = (
        24
        24)
    end
    object btnIniciarBomba: TBitBtn
      Left = 48
      Top = 242
      Width = 97
      Height = 25
      Caption = 'Iniciar Bomba'
      Enabled = False
      TabOrder = 2
      OnClick = btnIniciarBombaClick
    end
    object btnRelatorio: TButton
      Left = 71
      Top = 337
      Width = 75
      Height = 25
      Caption = 'Relat'#243'rio'
      TabOrder = 3
      OnClick = btnRelatorioClick
    end
    object dtpDataFim: TDateTimePicker
      Left = 71
      Top = 310
      Width = 90
      Height = 21
      Date = 44255.000000000000000000
      Time = 0.477564212960714900
      TabOrder = 4
    end
    object dtpDataIni: TDateTimePicker
      Left = 71
      Top = 283
      Width = 90
      Height = 21
      Date = 44255.000000000000000000
      Time = 0.477564212960714900
      TabOrder = 5
    end
  end
end
