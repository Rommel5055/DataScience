insert into JoinInternational.dbo.temp 
SELECT 
      [numero]
      ,[num]
      ,[origen]
      ,[destino]
      ,[clientes]
      ,[transportista]
      ,[Pago]
      ,[agente]
      ,[consignatario]
      ,[embarcador]
      ,[nombre]
      ,[InicialesSeguimiento]
      ,[InicialesEmbarqueAereo]
      ,[movimiento]
      ,[tipo]
      ,[unidad]
      ,[terminos]
      ,[peso]
      ,[volumen]
      ,[tara]
      ,[Envase]
      ,[empresa]
      ,[consolidado]
      ,[posicion]
      ,[pagoflete]
      ,[fechaembarque]
      ,[fecharetiro]
      ,[InicialesEmbarque]
      ,[ContratoCLIEmbarque]
      ,[ContratoTraEmbarque]
      ,[ETDembarque]
      ,[ETAembarque]
      ,[operacion]
      ,[Trafico]
      ,[ContratoCLISeguimiento]
      ,[ContratoTraSeguimiento]
      ,[ETAseguimiento]
      ,[ETDseguimiento]
      ,[StatusEmbarque]
      ,[StatusSeguimiento]
      ,[modo]
      ,[Activo]
      ,[origenBoleta]
      ,[destinoBoleta]
      ,[BD]
      ,[teus]
      ,[profit]
      ,[fecha]
      ,[vencimiento]
      ,[myStatus]
  FROM [JoinInternational].[dbo].[inteligence]
  where NOT EXISTS(
  SELECT * from JoinInternational.dbo.temp
  where JoinInternational.dbo.temp.numero = JoinInternational.dbo.inteligence.numero)
  --order by fecha desc
  
  ------------------------------------------------------------------------------
  UPdate JoinInternational.dbo.temp
SET 

     JoinInternational.dbo.temp.[origen] = JoinInternational.dbo.inteligence.[origen]
      ,JoinInternational.dbo.temp.[destino] = JoinInternational.dbo.inteligence.destino
      ,JoinInternational.dbo.temp.[clientes] = JoinInternational.dbo.inteligence.clientes
      ,JoinInternational.dbo.temp.[transportista] = JoinInternational.dbo.inteligence.transportista
      ,JoinInternational.dbo.temp.[Pago] = JoinInternational.dbo.inteligence.Pago
      ,JoinInternational.dbo.temp.[agente] = JoinInternational.dbo.inteligence.agente
      ,JoinInternational.dbo.temp.[consignatario] = JoinInternational.dbo.inteligence.consignatario
      ,JoinInternational.dbo.temp.[embarcador] = JoinInternational.dbo.inteligence.embarcador
      ,JoinInternational.dbo.temp.[nombre] = JoinInternational.dbo.inteligence.nombre
      ,JoinInternational.dbo.temp.[InicialesSeguimiento] = JoinInternational.dbo.inteligence.InicialesSeguimiento
      ,JoinInternational.dbo.temp.[InicialesEmbarqueAereo] = JoinInternational.dbo.inteligence.InicialesEmbarqueAereo
      ,JoinInternational.dbo.temp.[movimiento] = JoinInternational.dbo.inteligence.movimiento
      ,JoinInternational.dbo.temp.[tipo] = JoinInternational.dbo.inteligence.tipo
      ,JoinInternational.dbo.temp.[unidad] = JoinInternational.dbo.inteligence.unidad
      ,JoinInternational.dbo.temp.[terminos] = JoinInternational.dbo.inteligence.terminos
      ,JoinInternational.dbo.temp.[peso] = JoinInternational.dbo.inteligence.peso
      ,JoinInternational.dbo.temp.[volumen] = JoinInternational.dbo.inteligence.volumen
      ,JoinInternational.dbo.temp.[tara] = JoinInternational.dbo.inteligence.tara
      ,JoinInternational.dbo.temp.[Envase] = JoinInternational.dbo.inteligence.Envase
      ,JoinInternational.dbo.temp.[empresa] = JoinInternational.dbo.inteligence.empresa
      ,JoinInternational.dbo.temp.[consolidado] = JoinInternational.dbo.inteligence.consolidado
      ,JoinInternational.dbo.temp.[posicion] = JoinInternational.dbo.inteligence.posicion
      ,JoinInternational.dbo.temp.[pagoflete] = JoinInternational.dbo.inteligence.pagoflete
      ,JoinInternational.dbo.temp.[fechaembarque] = JoinInternational.dbo.inteligence.fechaembarque
      ,JoinInternational.dbo.temp.[fecharetiro] = JoinInternational.dbo.inteligence.fecharetiro
      ,JoinInternational.dbo.temp.[InicialesEmbarque] = JoinInternational.dbo.inteligence.InicialesEmbarque
      ,JoinInternational.dbo.temp.[ContratoCLIEmbarque] = JoinInternational.dbo.inteligence.ContratoCLIEmbarque
      ,JoinInternational.dbo.temp.[ContratoTraEmbarque] = JoinInternational.dbo.inteligence.ContratoTraEmbarque
      ,JoinInternational.dbo.temp.[ETDembarque] = JoinInternational.dbo.inteligence.ETDembarque
      ,JoinInternational.dbo.temp.[ETAembarque] = JoinInternational.dbo.inteligence.ETAembarque
      ,JoinInternational.dbo.temp.[operacion] = JoinInternational.dbo.inteligence.operacion
      ,JoinInternational.dbo.temp.[Trafico] = JoinInternational.dbo.inteligence.Trafico
      ,JoinInternational.dbo.temp.[ContratoCLISeguimiento] = JoinInternational.dbo.inteligence.ContratoCLISeguimiento
      ,JoinInternational.dbo.temp.[ContratoTraSeguimiento] = JoinInternational.dbo.inteligence.ContratoTraSeguimiento
      ,JoinInternational.dbo.temp.[ETAseguimiento] = JoinInternational.dbo.inteligence.ETAseguimiento
      ,JoinInternational.dbo.temp.[ETDseguimiento] = JoinInternational.dbo.inteligence.ETDseguimiento
      ,JoinInternational.dbo.temp.[StatusEmbarque] = JoinInternational.dbo.inteligence.StatusEmbarque
      ,JoinInternational.dbo.temp.[StatusSeguimiento] = JoinInternational.dbo.inteligence.StatusSeguimiento
      ,JoinInternational.dbo.temp.[modo] = JoinInternational.dbo.inteligence.modo
      ,JoinInternational.dbo.temp.[Activo] = JoinInternational.dbo.inteligence.Activo
      ,JoinInternational.dbo.temp.[origenBoleta] = JoinInternational.dbo.inteligence.origenBoleta
      ,JoinInternational.dbo.temp.[destinoBoleta] = JoinInternational.dbo.inteligence.destinoBoleta
      ,JoinInternational.dbo.temp.[BD] = JoinInternational.dbo.inteligence.BD
      ,JoinInternational.dbo.temp.[teus] = JoinInternational.dbo.inteligence.teus
      ,JoinInternational.dbo.temp.[profit] = JoinInternational.dbo.inteligence.profit
      ,JoinInternational.dbo.temp.[fecha] = JoinInternational.dbo.inteligence.fecha
      ,JoinInternational.dbo.temp.[vencimiento] = JoinInternational.dbo.inteligence.vencimiento
      ,JoinInternational.dbo.temp.[myStatus] = JoinInternational.dbo.inteligence.myStatus
  FROM [JoinInternational].[dbo].temp
	INNER JOIN JoinInternational.dbo.inteligence ON JoinInternational.dbo.inteligence.numero = JoinInternational.dbo.temp.numero
  where [JoinInternational].[dbo].inteligence.posicion is not null
  AND JoinInternational.dbo.temp.posicion is null
