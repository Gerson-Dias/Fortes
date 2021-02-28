object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConnPrincipal: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDTransacPrincipal: TFDTransaction
    Connection = FDConnPrincipal
    Left = 128
    Top = 16
  end
  object dsQryRelVEndas: TDataSource
    DataSet = FDQryRelVendas
    Left = 129
    Top = 82
  end
  object FDQryRelVendas: TFDQuery
    Connection = FDConnPrincipal
    SQL.Strings = (
      
        'select mv.data as Dia, tq.id as Tanque, mv.bomba_id, bc.nome_bom' +
        'ba as Bomba, Cast(Sum(ab.qtd_litro) as Float) as Litros, Cast(Su' +
        'm(ab.valor_total) as Float) as Valor, Cast(Sum(ab.valor_imposto)' +
        ' as Float) as Imposto'
      'from tb_movimento mv'
      'join tb_abastecimento ab on ab.movimento_id = mv.id'
      'join tb_bomba_combustivel bc on bc.id = mv.bomba_id'
      'join tb_tanque tq on tq.id = bc.tanque_id'
      'where mv.data between :dataIni and :dataFim'
      'group by mv.data, tq.id, mv.bomba_id, bc.nome_bomba'
      'order by mv.data')
    Left = 32
    Top = 82
    ParamData = <
      item
        Name = 'DATAINI'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
        ParamType = ptInput
      end>
    object FDQryRelVendasDIA: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DIA'
      Origin = 'DIA'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQryRelVendasTANQUE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'TANQUE'
      Origin = 'TANQUE'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQryRelVendasBOMBA_ID: TIntegerField
      FieldName = 'BOMBA_ID'
      Origin = 'BOMBA_ID'
      Required = True
    end
    object FDQryRelVendasBOMBA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'BOMBA'
      Origin = 'BOMBA'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQryRelVendasLITROS: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'LITROS'
      Origin = 'LITROS'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object FDQryRelVendasVALOR: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object FDQryRelVendasIMPOSTO: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'IMPOSTO'
      Origin = 'IMPOSTO'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
  end
end
