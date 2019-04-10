SELECT concat(boleta.tipofactura, boleta.numero) as factura, boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total, 
asientos.monto as cobro, asientos.cambio, sum(vtas.monto) as pagos, Asientos.fecha, max(vtas.FechaImpu) as FechaPago, boleta.vto, 
boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion, asientos.tipo, asientos.imputacion, analistas.nombre as vendedor,
analistas.analista
into InternationalBI.dbo.cobranzas

FROM Dataset_InternationalLine_2018.dbo.asientos
INNER JOIN Dataset_InternationalLine_2018.dbo.boleta ON (
/*
	Dataset_InternationalLine_2018.dbo.boleta.fecha = Dataset_InternationalLine_2018.dbo.asientos.fecha 
	AND Dataset_InternationalLine_2018.dbo.asientos.documento = convert(varchar(10), Dataset_InternationalLine_2018.dbo.boleta.numero) 
	AND Dataset_InternationalLine_2018.dbo.asientos.cliente = Dataset_InternationalLine_2018.dbo.boleta.NROcliente
	*/
	asientos.autogenerado = boleta.autogenerado
	AND asientos.moneda = boleta.moneda)
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON (
	[Basico_InternationalLine_2018].[dbo].[Monedas].codigo = asientos.Moneda)

INNER JOIN [Basico_InternationalLine_2018].[dbo].[clientes] ON (
	[Basico_InternationalLine_2018].[dbo].[clientes].codigo = boleta.nrocliente)
INNER JOIN [InternationalBI].[dbo].[analistas] ON ([InternationalBI].[dbo].[analistas].codigo = [Basico_InternationalLine_2018].[dbo].[clientes].vendedor)

LEFT JOIN [Dataset_InternationalLine_2018].[dbo].[Impuvtas] as vtas ON (
--	convert(int,RIGHT(vtas.autofac,6)) = boleta.numero
--	AND Dataset_InternationalLine_2018.dbo.boleta.NROcliente = vtas.cliente
--	AND 
	vtas.autofac = asientos.autogenerado)

WHERE Dataset_InternationalLine_2018.dbo.asientos.imputacion = 1
AND (Dataset_InternationalLine_2018.dbo.asientos.tipo = 'G' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'P' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'V' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'Z')
AND asientos.cliente != 0

AND (vtas.autofac like '%0'
	OR vtas.autofac like '%1'
	OR vtas.autofac like '%2'
	OR vtas.autofac like '%3'
	OR vtas.autofac like '%4'
	OR vtas.autofac like '%5'
	OR vtas.autofac like '%6'
	OR vtas.autofac like '%7'
	OR vtas.autofac like '%8'
	OR vtas.autofac like '%9')
AND vtas.monto > 0


GROUP BY boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total, asientos.cambio, Asientos.fecha, boleta.vto, boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion, asientos.tipo
,asientos.imputacion, analistas.nombre, analistas.analista, asientos.monto,
vtas.cliente, vtas.autofac
