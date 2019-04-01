SELECT mdetalle, monedas.simbolo, movims.mtotal, movims.mcambio, movims.mfechamov, movims.mvtomov, movims.mnombre, movims.mcliente, monedas.nombre
into InternationalBI.dbo.TEMP1
FROM Dataset_InternationalLine_2018.dbo.movims
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON (
	[Basico_InternationalLine_2018].[dbo].[Monedas].codigo = movims.mMoneda)
WHERE [Dataset_InternationalLine_2018].[dbo].movims.mnombremov = 'COBRO' 
and (mdetalle like '1%' OR
  mdetalle like '2%' OR
  mdetalle like '3%' OR
  mdetalle like '4%' OR
  mdetalle like '5%' OR
  mdetalle like '6%' OR
  mdetalle like '7%' OR
  mdetalle like '8%' OR
  mdetalle like '9%' OR
  mdetalle like '0%')
  

AND LEN(movims.mdetalle) - LEN(REPLACE(movims.mdetalle, ';', '')) > 1
GROUP BY mdetalle, monedas.simbolo, movims.mtotal, movims.mcambio, movims.mfechamov, movims.mvtomov, movims.mnombre, movims.mcliente, monedas.nombre
order by mdetalle

-------------------------------------------------------------------
SELECT mdetalle, monedas.simbolo, movims.mtotal, movims.mcambio, movims.mfechamov, movims.mvtomov, movims.mnombre, movims.mcliente, monedas.nombre
into InternationalBI.dbo.TEMP2
FROM Dataset_InternationalLine_2018.dbo.movims
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON (
	[Basico_InternationalLine_2018].[dbo].[Monedas].codigo = movims.mMoneda)
WHERE [Dataset_InternationalLine_2018].[dbo].movims.mnombremov = 'COBRO' 
and (mdetalle like '1%' OR
  mdetalle like '2%' OR
  mdetalle like '3%' OR
  mdetalle like '4%' OR
  mdetalle like '5%' OR
  mdetalle like '6%' OR
  mdetalle like '7%' OR
  mdetalle like '8%' OR
  mdetalle like '9%' OR
  mdetalle like '0%')
  

AND LEN(movims.mdetalle) - LEN(REPLACE(movims.mdetalle, ';', '')) >= 1
GROUP BY mdetalle, monedas.simbolo, movims.mtotal, movims.mcambio, movims.mfechamov, movims.mvtomov, movims.mnombre, movims.mcliente, monedas.nombre
order by mdetalle


------------------------
SELECT c.factura, c.tipofactura, c.numero, c.cobros, 
m.mtotal as pagos, --sum(m.mtotal) as pagos, 
c.cambio as cambioCobro, m.mcambio as cambioPagos, c.fecha as FechaFactura, 
m.mfechamov as FechaPago, --max(m.mfechamov) as FechaPago, 
c.vto as VencimientoFactura, c.cliente, c.nrocliente, c.nombre as moneda,
c.posicion, c.vendedor, c.analista, a.detalle

into InternationalBI.dbo.TEMP3

FROM InternationalBI.dbo.cobros2 as c
INNER JOIN Dataset_InternationalLine_2018.dbo.movims as m ON (
	concat(c.numero,';') = m.mdetalle AND c.nrocliente = m.mcliente AND c.moneda = m.mmoneda)
JOIN Dataset_InternationalLine_2018.dbo.asientos as a ON (
	convert(varchar,numero) = a.documento AND c.nrocliente = a.cliente)

WHERE m.mnombremov = 'COBRO' 
and (m.mdetalle like '1%' OR
  m.mdetalle like '2%' OR
  m.mdetalle like '3%' OR
  m.mdetalle like '4%' OR
  m.mdetalle like '5%' OR
  m.mdetalle like '6%' OR
  m.mdetalle like '7%' OR
  m.mdetalle like '8%' OR
  m.mdetalle like '9%' OR
  m.mdetalle like '0%')
  

AND LEN(m.mdetalle) - LEN(REPLACE(m.mdetalle, ';', '')) = 1


GROUP BY 
c.factura, c.tipofactura, c.numero, c.cobros, c.cambio, m.mcambio, 
c.fecha, c.vto, c.cliente, c.nrocliente, c.nombre,
c.posicion, c.vendedor, c.analista, a.detalle

,m.mtotal, m.mfechamov
--------------------------------------------------

SELECT c.cliente, m.mdetalle, sum(c.cobros) as cobros, m.mtotal as pagos, c.nombre, c.vendedor, c.analista, m.mfechamov
--into resumenPagos
FROM InternationalBI.dbo.cobros2 as c
LEFT JOIN [Dataset_InternationalLine_2018].[dbo].[Movims] as m ON (m.mdetalle like concat('%',c.numero,';%') AND c.nrocliente = m.mcliente AND c.moneda = m.mmoneda)
where m.mnombremov = 'COBRO'
--AND c.cliente = 'MINING DRILLING FLUIDS S.A.'

GROUP BY c.cliente, c.nombre, c.vendedor, c.analista, m.mcliente, m.mdetalle, m.mtotal, m.mfechamov

--------------------------------------------
