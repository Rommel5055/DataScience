insert into InternationalBI.dbo.calculations_2014

Select [impmarit].[dbo].[Envases].numero,
	[impmarit].[dbo].[Embarqueaereo].posicion,
	(CASE
	when [impmarit].[dbo].[Envases].[unidad] = '20'
		then ([impmarit].[dbo].[Envases].[cantidad] * count([impmarit].[dbo].[Envases].[numero]))
	when [impmarit].[dbo].[Envases].[unidad] = '40' or [impmarit].[dbo].[Envases].[unidad] = '45'
		then ([impmarit].[dbo].[Envases].[cantidad] * 2 * count([impmarit].[dbo].[Envases].[numero]))
	else
		0
		END) AS teus,
	[impmarit].[dbo].[Envases].movimiento,
	[impmarit].[dbo].[Envases].tipo,
	[impmarit].[dbo].[Envases].tara,
	[impmarit].[dbo].[Envases].envase,
	[impmarit].[dbo].[Envases].profit,
	--null as profit,
	[impmarit].[dbo].[Envases].precio*[impmarit].[dbo].[Envases].cantidad as pc,
	[impmarit].[dbo].[Envases].costo*[impmarit].[dbo].[Envases].cantidad as cc,
	[impmarit].[dbo].[serviceaereo].precio,
	[impmarit].[dbo].[serviceaereo].costo,
	[impmarit].[dbo].[serviceaereo].arbitraje


  FROM [impmarit].[dbo].[Envases]
  left join [impmarit].[dbo].[embarqueaereo] ON ([impmarit].[dbo].[embarqueaereo].numero = [impmarit].[dbo].[Envases].numero)
  left join [impmarit].[dbo].[serviceaereo] ON ([impmarit].[dbo].[serviceaereo].numero = [impmarit].[dbo].[envases].numero)
  group by [impmarit].[dbo].[envases].numero, [impmarit].[dbo].[serviceaereo].numero, 
  unidad, cantidad, movimiento, tipo, tara, envase, 
  profit, 
  [impmarit].[dbo].[serviceaereo].precio, [impmarit].[dbo].[serviceaereo].costo,
  [impmarit].[dbo].[Envases].precio, [impmarit].[dbo].[Envases].cantidad,
  [impmarit].[dbo].[Envases].costo, [impmarit].dbo.serviceaereo.arbitraje,
  [impmarit].dbo.embarqueaereo.posicion
  --------------------------------------------------------
  
  
  
  
  
  
  SELECT 
concat(str([seguir].[dbo].[Seguimiento].[numero]),'IL') as numero,
[seguir].[dbo].[Seguimiento].[numero] as num,
[seguir].[dbo].[Seguimiento].[origen],
[seguir].[dbo].[Seguimiento].[destino],
[Basico_InterLine_2018].[dbo].[clientes].[empresa] as clientes,  
[Dataset_InterLine_2018].[dbo].[InfoFactura].[transportista],
[seguir].[dbo].[Seguimiento].[Pago],
[Dataset_InterLine_2018].[dbo].[Boleta].[agente],   
[Dataset_InterLine_2018].[dbo].[Boleta].[consignatario],
[Dataset_InterLine_2018].[dbo].[Boleta].[embarcador],
[Basico_InterLine_2018].[dbo].[vendedores].[nombre],
[seguir].[dbo].[Seguimiento].[Iniciales] as InicialesSeguimiento,
[import].[dbo].[Embarqueaereo].[iniciales] as InicialesEmbarqueAereo,
--[seguir].[dbo].[Envases].[movimiento],
null as movimiento,
--[seguir].[dbo].[Envases].[tipo],
null as tipo,
null as unidad,
--[import_2014].[dbo].[Envases].[unidad],
[import].[dbo].[Embarqueaereo].[terminos],
--null as terminos,
null as peso, null as volumen, null as tara, null as Envase, null as profit,
--[seguir].[dbo].[Envases].[Peso],
--[seguir].[dbo].[Envases].[volumen],
--[seguir].[dbo].[Envases].[tara],
--[seguir].[dbo].[Envases].[Envase],
--[seguir].[dbo].[Envases].[profit],
--null as profit,
[import].[dbo].[Embarqueaereo].[empresa],
[import].[dbo].[Embarqueaereo].[consolidado],
[import].[dbo].[Embarqueaereo].[posicion],
[import].[dbo].[Embarqueaereo].[pagoflete],
[import].[dbo].[Embarqueaereo].[fechaembarque],
[import].[dbo].[Embarqueaereo].[fecharetiro],
[import].[dbo].[Embarqueaereo].[iniciales] AS InicialesEmbarque, 
[import].[dbo].[Embarqueaereo].[ContratoCli] as ContratoCLIEmbarque,
[import].[dbo].[Embarqueaereo].[ContratoTra] as ContratoTraEmbarque,
[import].[dbo].[Embarqueaereo].[ETD] as ETDembarque,
[import].[dbo].[Embarqueaereo].[ETA] as ETAembarque,
[import].[dbo].[Embarqueaereo].[operacion],

[Basico_InterLine_2018].[dbo].[Traficos].[nombre] as Trafico, 
[seguir].[dbo].[Seguimiento].[ContratoCli] as ContratoCLISeguimiento,
[seguir].[dbo].[Seguimiento].[ContratoTra] as ContratoTraSeguimiento,
[seguir].[dbo].[Seguimiento].[eta] as ETAseguimiento,
[seguir].[dbo].[Seguimiento].[etd] as ETDseguimiento,
[import].[dbo].[Embarqueaereo].[status] as StatusEmbarque,
[seguir].[dbo].[Seguimiento].[status] as StatusSeguimiento,
[seguir].[dbo].[Seguimiento].[modo],
[Basico_InterLine_2018].[dbo].[vendedores].[Activo],
[Dataset_InterLine_2018].[dbo].[Boleta].[Origen] as origenBoleta,
[Dataset_InterLine_2018].[dbo].[Boleta].[Destino] as destinoBoleta,

'InterLine' as [BD]
INTO [JoinData].[dbo].[InterLineSix]
FROM [import].[dbo].[Embarqueaereo] 
--LEFT JOIN [import].[dbo].[embarqueaereo] ON ([import].[dbo].[envases].[numero] = [import].[dbo].[embarqueaereo].[numero])
INNER JOIN [seguir].[dbo].[Seguimiento]ON ([seguir].[dbo].[Seguimiento].[numero] = [import].[dbo].[Embarqueaereo].[Seguimiento])
LEFT JOIN [Basico_InterLine_2018].[dbo].[clientes] ON ([Basico_InterLine_2018].[dbo].[clientes].[codigo] = [seguir].[dbo].[Seguimiento].[cliente])
LEFT JOIN [Dataset_InterLine_2018].[dbo].[Boleta] ON ([Dataset_InterLine_2018].[dbo].[Boleta].[posicion] = [seguir].[dbo].[Seguimiento].[posicion])
LEFT JOIN [Basico_InterLine_2018].[dbo].[vendedores] ON ([seguir].[dbo].[Seguimiento].[vendedor] = [Basico_InterLine_2018].[dbo].[Vendedores].[codigo])
LEFT JOIN [Basico_InterLine_2018].[dbo].[Traficos] ON ([Basico_InterLine_2018].[dbo].[Traficos].[codigo] = [seguir].[dbo].[Seguimiento].[trafico])
LEFT JOIN [Dataset_InterLine_2018].[dbo].[InfoFactura] ON ([Dataset_InterLine_2018].[dbo].[InfoFactura].[seguimiento] = [seguir].[dbo].[Seguimiento].[numero])
--LEFT JOIN [seguir].[dbo].[Envases] ON ([seguir].[dbo].[Envases].[numero] = [seguir].[dbo].[Seguimiento].[numero])

GROUP BY 
[seguir].[dbo].[Seguimiento].[numero],
[seguir].[dbo].[Seguimiento].[origen],
[seguir].[dbo].[Seguimiento].[destino],
[Basico_InterLine_2018].[dbo].[clientes].[empresa],  
[Dataset_InterLine_2018].[dbo].[InfoFactura].[transportista],
[seguir].[dbo].[Seguimiento].[Pago],
[Dataset_InterLine_2018].[dbo].[Boleta].[agente],   
[Dataset_InterLine_2018].[dbo].[Boleta].[consignatario],
[Dataset_InterLine_2018].[dbo].[Boleta].[embarcador],
[Basico_InterLine_2018].[dbo].[vendedores].[nombre],
[seguir].[dbo].[Seguimiento].[Iniciales],
[import].[dbo].[Embarqueaereo].[iniciales],
[import].[dbo].[Embarqueaereo].[terminos],
--null as terminos,
[import].[dbo].[Embarqueaereo].[empresa],
[import].[dbo].[Embarqueaereo].[consolidado],
[import].[dbo].[Embarqueaereo].[posicion],
[import].[dbo].[Embarqueaereo].[pagoflete],
[import].[dbo].[Embarqueaereo].[fechaembarque],
[import].[dbo].[Embarqueaereo].[fecharetiro],
[import].[dbo].[Embarqueaereo].[iniciales], 
[import].[dbo].[Embarqueaereo].[ContratoCli],
[import].[dbo].[Embarqueaereo].[ContratoTra],
[import].[dbo].[Embarqueaereo].[ETD],
[import].[dbo].[Embarqueaereo].[ETA],
[import].[dbo].[Embarqueaereo].[operacion],

[Basico_InterLine_2018].[dbo].[Traficos].[nombre], 
[seguir].[dbo].[Seguimiento].[ContratoCli],
[seguir].[dbo].[Seguimiento].[ContratoTra],
[seguir].[dbo].[Seguimiento].[eta],
[seguir].[dbo].[Seguimiento].[etd],
[import].[dbo].[Embarqueaereo].[status],
[seguir].[dbo].[Seguimiento].[status],
[seguir].[dbo].[Seguimiento].[modo],
[Basico_InterLine_2018].[dbo].[vendedores].[Activo],
[Dataset_InterLine_2018].[dbo].[Boleta].[Origen],
[Dataset_InterLine_2018].[dbo].[Boleta].[Destino]

order by numero desc
--------------------------------------------------------------------------
create table JoinData.dbo.InterJoin (
	numero varchar(255),
	num int,
	origen varchar(255),
	destino varchar(255),
	clientes varchar(255),  
	transportista varchar(255),
	Pago varchar(255),
	agente varchar(255),   
	consignatario varchar(255),
	embarcador varchar(255),
	nombre varchar(255),
	InicialesSeguimiento varchar(255),
	InicialesEmbarqueAereo varchar(255),
	movimiento varchar(255),
	tipo varchar(255),
	unidad varchar(255),
	terminos varchar(255),
	peso int,
	volumen int,
	tara int,
	Envase varchar(255),
	profit int,
	empresa int,
	consolidado int,
	posicion varchar(255),
	pagoflete varchar(255),
	fechaembarque datetime,
	fecharetiro datetime,
	InicialesEmbarque varchar(255), 
	ContratoCLIEmbarque varchar(255),
	ContratoTraEmbarque varchar(255),
	ETDembarque datetime,
	ETAembarque datetime,
	operacion varchar(255),
	Trafico varchar(255), 
	ContratoCLISeguimiento varchar(255),
	ContratoTraSeguimiento varchar(255),
	ETAseguimiento datetime,
	ETDseguimiento varchar(255),
	StatusEmbarque varchar(255),
	StatusSeguimiento varchar(255),
	modo varchar(255),
	Activo varchar(255),
	origenBoleta varchar(255),
	destinoBoleta varchar(255),
	BD varchar(255),
	teus int
)
--------------------------------------------------------------------
;with imaginarytable as (																		      ;with [imaginarytable] AS (
SELECT [numero]
      ,sum([teus]) as sumteus
      ,[movimiento]
      ,[tipo]
      ,sum([tara]) as sumtara
      ,[envase]
      ,(sum(precio/arbitraje) - sum(costo/arbitraje))+max(pc)-max(cc) as sumprofit
  FROM [JoinData].[dbo].[calculations_2014]
  group by numero, movimiento, tipo, envase
)

Update JoinData.dbo.InterJoin
SET 
	JoinData.dbo.InterJoin.teus = [imaginarytable].sumteus,
	JoinData.dbo.InterJoin.movimiento = [imaginarytable].movimiento,
	JoinData.dbo.InterJoin.tipo = [imaginarytable].tipo,
	JoinData.dbo.InterJoin.tara = [imaginarytable].sumtara,
	JoinData.dbo.InterJoin.envase = [imaginarytable].envase,
	JoinData.dbo.InterJoin.profit = [imaginarytable].sumprofit
FROM [JoinData].[dbo].[InterJoin]
INNER JOIN [imaginarytable] ON ([imaginarytable].[numero] = [JoinData].[dbo].[InterJoin].[num])
where [JoinData].[dbo].[InterJoin].[BD] = 'InterLine'

--group by numero, movimiento, tipo, envase

--------------------------------------------------------------------
select numero, (sum(precio/arbitraje) - sum(costo/arbitraje))+max(pc)-max(cc) as prof, profit
from InternationalBI.dbo.teus_seguir
group by numero, profit
					    
--------------------------------------------------------------------------------------------------
;with imaginarytable as (																		      
SELECT [posicion], (sum(precio/arbitraje) - sum(costo/arbitraje))+max(pc)-max(cc) as prof
from InternationalBI.dbo.calculations
group by posicion

)

Update InternationalBI.dbo.InterJoin
SET 
	InternationalBI.dbo.InterJoin.profit = [imaginarytable].prof
FROM InternationalBI.[dbo].[InterJoin]
INNER JOIN [imaginarytable] ON ([imaginarytable].posicion COLLATE DATABASE_DEFAULT= InternationalBI.[dbo].[InterJoin].posicion COLLATE DATABASE_DEFAULT)
where InternationalBI.[dbo].[InterJoin].[BD] = 'InterLine'

--group by numero, movimiento, tipo, envase
