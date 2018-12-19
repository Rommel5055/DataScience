SELECT 
[expmarit].[dbo].[envases].[numero],
[expmarit].[dbo].[embarqueaereo].[origen],
[Basico_InternationalLine_2018].[dbo].[clientes].[empresa],  
[expmarit].[dbo].[embarqueaereo].[transportista],------ Where does it connect?
[expmarit].[dbo].[embarqueaereo].[Pago],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[agente],    -------agente?
[Dataset_InternationalLine_2018].[dbo].[Boleta].[consignatario],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[embarcador],
[Basico_InternationalLine_2018].[dbo].[vendedores].[nombre],
[expmarit].[dbo].[Envases].[movimiento],
[Basico_InternationalLine_2018].[dbo].[CliTraficos].[trafico], ------embarqueaereo
[expmarit].[dbo].[embarqueaereo].[terminos],
[expmarit].[dbo].[embarqueaereo].[ContratoCli],
[expmarit].[dbo].[embarqueaereo].[ContratoTra]

---INTO [JoinTables].[Joinexpmarit]
FROM [expmarit].[dbo].[envases]
LEFT JOIN [expmarit].[dbo].[embarqueaereo] ON ([expmarit].[dbo].[envases].[numero] = [expmarit].[dbo].[embarqueaereo].[numero])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[clientes] ON ([Basico_InternationalLine_2018].[dbo].[clientes].[codigo] = [expmarit].[dbo].[Embarqueaereo].[cliente])
LEFT JOIN [Dataset_InternationalLine_2018].[dbo].[Boleta] ON ([Dataset_InternationalLine_2018].[dbo].[Boleta].[numero] = [expmarit].[dbo].[envases].[numero])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[vendedores] ON ([expmarit].[dbo].[embarqueaereo].[vendedor] = [Basico_InternationalLine_2018].[dbo].[Vendedores].[codigo])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[CliTraficos] ON ([Basico_InternationalLine_2018].[dbo].[CliTraficos].[codigo] = [expmarit].[dbo].[embarqueaereo].[trafico])

GROUP BY [expmarit].[dbo].[envases].[numero],
[expmarit].[dbo].[embarqueaereo].[origen],
[Basico_InternationalLine_2018].[dbo].[clientes].[empresa],  
[expmarit].[dbo].[embarqueaereo].[transportista],------ Where does it connect?
[expmarit].[dbo].[embarqueaereo].[Pago],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[agente],    -------agente?
[Dataset_InternationalLine_2018].[dbo].[Boleta].[consignatario],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[embarcador],
[Basico_InternationalLine_2018].[dbo].[vendedores].[nombre],
[expmarit].[dbo].[Envases].[movimiento],
[Basico_InternationalLine_2018].[dbo].[CliTraficos].[trafico], ------embarqueaereo
[expmarit].[dbo].[embarqueaereo].[terminos],
[expmarit].[dbo].[embarqueaereo].[ContratoCli],
[expmarit].[dbo].[embarqueaereo].[ContratoTra]

