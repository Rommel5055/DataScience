--1
CREATE PROCEDURE UpdateVentasFIN
AS
TRUNCATE TABLE FinanzasCobranzas.dbo.VentasFIN

INSERT INTO FinanzasCobranzas.dbo.VentasFIN
SELECT asientos.autogenerado, concat(boleta.tipofactura, boleta.numero) as factura, boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total,
asientos.cambio, Asientos.fecha, boleta.vto, 
boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion, asientos.tipo, asientos.imputacion, analistas.nombre as vendedor,
analistas.analista, asientos.detalle


FROM Dataset_InternationalLine_2018.dbo.asientos
INNER JOIN Dataset_InternationalLine_2018.dbo.boleta ON (

	asientos.autogenerado = boleta.autogenerado
	AND asientos.moneda = boleta.moneda)
INNER JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON (
	[Basico_InternationalLine_2018].[dbo].[Monedas].codigo = asientos.Moneda)

INNER JOIN [Basico_InternationalLine_2018].[dbo].[clientes] ON (
	[Basico_InternationalLine_2018].[dbo].[clientes].codigo = boleta.nrocliente)
INNER JOIN FinanzasCobranzas.[dbo].[analistas] ON (FinanzasCobranzas.[dbo].[analistas].codigo = [Basico_InternationalLine_2018].[dbo].[clientes].vendedor)

WHERE Dataset_InternationalLine_2018.dbo.asientos.imputacion = 1
AND (Dataset_InternationalLine_2018.dbo.asientos.tipo = 'G' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'P' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'V' OR Dataset_InternationalLine_2018.dbo.asientos.tipo = 'Z')
AND Dataset_InternationalLine_2018.dbo.asientos.detalle not like 'not/cred%'
AND asientos.cliente != 0

GROUP BY asientos.autogenerado, boleta.tipofactura, boleta.numero, monedas.simbolo, boleta.total, 
asientos.cambio, Asientos.fecha, boleta.vto, 
boleta.cliente, boleta.nrocliente, monedas.nombre, boleta.posicion, asientos.tipo, asientos.imputacion, analistas.nombre,
analistas.analista, asientos.detalle
