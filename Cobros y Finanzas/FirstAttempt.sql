;WITH sumdeber AS (
SELECT documento, cuenta, moneda, sum(monto) as montoOriginal, 
(CASE
	WHEN cambio = 0
		then sum(monto)
	ELSE
		sum(monto) / cambio
		END) as montoDolares,
cambio
FROM [Dataset_InternationalLine_2018].[dbo].[Asientos]
WHERE cuenta = 11401 AND imputacion = 1
AND ([Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'G' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'V' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'Z')
GROUP BY documento, cuenta, moneda, cambio
),

sumhaber AS (
SELECT documento, cuenta, moneda, sum(monto) as montoOriginal, 
(CASE
	WHEN cambio = 0
		then sum(monto)
	ELSE
		sum(monto) / cambio
		END) as montoDolares,
cambio
FROM [Dataset_InternationalLine_2018].[dbo].[Asientos]
WHERE cuenta = 11401 AND imputacion = 2
AND ([Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'G' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'V' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'Z')
GROUP BY documento, cuenta, moneda, cambio
)


Select [Dataset_InternationalLine_2018].[dbo].[Cuentas].xnombre as cuenta, -- xcodigo
[Basico_InternationalLine_2018].[dbo].[clientes].empresa as cliente,
[Dataset_InternationalLine_2018].[dbo].[Asientos].fecha,
[Dataset_InternationalLine_2018].[dbo].[Asientos].documento,
[Basico_InternationalLine_2018].[dbo].[Monedas].nombre as moneda,
sumdeber.montoOriginal as sumdeber,
sumdeber.montoDolares as sumdeberDolares,
sumhaber.montoOriginal as sumhaber,
sumhaber.montoDolares as sumhaberDolares,
sumdeber.montoOriginal - sumhaber.montoOriginal as Saldo,
sumdeber.montoDolares - sumhaber.montoDolares as SaldoDolares,
(Case
	WHEN sumdeber.montoOriginal - sumhaber.montoOriginal <= 0
		THEN 'PAGADO'
	WHEN sumdeber.montoOriginal - sumhaber.montoOriginal >= sumdeber.montoOriginal
		THEN 'NO PAGADO'
	ELSE 'PAGADO PARCIALMENTE'
	END) as estado,
[Dataset_InternationalLine_2018].[dbo].[Asientos].vto,
[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo

FROM [Dataset_InternationalLine_2018].[dbo].[Asientos]
INNER JOIN sumdeber ON ([Dataset_InternationalLine_2018].[dbo].[Asientos].documento = sumdeber.documento)
INNER JOIN sumhaber ON ([Dataset_InternationalLine_2018].[dbo].[Asientos].documento = sumhaber.documento)
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON ([Basico_InternationalLine_2018].[dbo].[Monedas].codigo = [Dataset_InternationalLine_2018].[dbo].[Asientos].moneda)
INNER JOIN [Basico_InternationalLine_2018].[dbo].[clientes] ON ([Basico_InternationalLine_2018].[dbo].[clientes].codigo = [Dataset_InternationalLine_2018].[dbo].[Asientos].[cliente])
INNER JOIN [Dataset_InternationalLine_2018].[dbo].[Cuentas] ON ([Dataset_InternationalLine_2018].[dbo].[Cuentas].xcodigo = [Dataset_InternationalLine_2018].[dbo].[Asientos].cuenta)

WHERE [Dataset_InternationalLine_2018].[dbo].[Asientos].cuenta = 11401
AND ([Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'G' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'V' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'Z')

GROUP BY [Dataset_InternationalLine_2018].[dbo].[Asientos].cuenta,
[Dataset_InternationalLine_2018].[dbo].[Cuentas].xnombre,
[Basico_InternationalLine_2018].[dbo].[clientes].empresa,
[Dataset_InternationalLine_2018].[dbo].[Asientos].fecha,
[Dataset_InternationalLine_2018].[dbo].[Asientos].documento,
[Basico_InternationalLine_2018].[dbo].[Monedas].nombre,
sumdeber.montoOriginal,
sumdeber.montoDolares,
sumhaber.montoOriginal,
sumhaber.montoDolares,
[Dataset_InternationalLine_2018].[dbo].[Asientos].vto,
[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo

order by fecha, documento

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [fecha]
      ,[cuenta]
      ,[moneda]
      ,[monto]
      ,[cambio]
      ,[detalle]
      ,[asiento]
      ,[imputacion]
      ,[tipo]
      ,[documento]
      ,[vto]
      ,[pasado]
      ,[autogenerado]
      ,[cliente]
      ,[banco]
      ,[centro]
      ,[mov]
      ,[mesimpu]
      ,[anoimpu]
      ,[conciliado]
      ,[estacion]
      ,[posicion]
      ,[enviado]
      ,[clearing]
      ,[voucher]
      ,[revertir]
      ,[fecrevertir]
      ,[area]
      ,[Iniciales]
      ,[Paridad]
      ,[NumeroEnvio]
      ,[Vinculo]
      ,[SocioCom]
      ,[MonedaOrigen]
      ,[TCCorreccion]
      ,[ParCorreccion]
      ,[Modo]
      ,[FechaEmision]
      ,[FechaVencimiento]
      ,[NroComprobante]
      ,[DesRetencion]
      ,[BaseImponible]
      ,[Control]
      ,[Base]
      ,[Jurisdiccion]
      ,[NroServ]
      ,[FechaCheque]
      ,[BancoOriDest]
      ,[CuentaOriDest]
      ,[LinkRetencion]
      ,[FolioFiscal]
  FROM [Dataset_InternationalLine_2018].[dbo].[Asientos]
  where cuenta = 11401 AND documento = '1189'
  AND ([Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'G' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'V' OR[Dataset_InternationalLine_2018].[dbo].[Asientos].tipo = 'Z')
  
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

