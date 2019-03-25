UPDATE [InternationalBI].[dbo].[saldoTemp]
SET fechapago = [InternationalBI].[dbo].[multiplesmovims].mfechamov,
pagadoDolares = PagarenDolares,
cambioPagado = mcambio
FROM [InternationalBI].[dbo].[saldoTemp]
INNER JOIN [InternationalBI].[dbo].[multiplesmovims] ON ([InternationalBI].[dbo].[multiplesmovims].mdetalle like concat('%', RIGHT([InternationalBI].[dbo].saldoTemp.factura, len([InternationalBI].[dbo].saldoTemp.factura) - 1), '%')
AND [InternationalBI].[dbo].[multiplesmovims].mcliente = [InternationalBI].[dbo].saldoTemp.nrocliente)

WHERE [InternationalBI].[dbo].[multiplesmovims].diferencia <= 0

-----------------------------------

UPDATE [saldoTemp]
SET [InternationalBI].[dbo].[saldoTemp].Vendedor = [Basico_InternationalLine_2018].[dbo].[Vendedores].nombre,
detalle = [Dataset_InternationalLine_2018].[dbo].asientos.detalle
FROM [InternationalBI].[dbo].[saldoTemp]
INNER JOIN [Dataset_InternationalLine_2018].[dbo].asientos ON ([Dataset_InternationalLine_2018].[dbo].asientos.documento like concat('%', RIGHT([InternationalBI].[dbo].saldoTemp.factura, len([InternationalBI].[dbo].saldoTemp.factura) - 1), '%')
AND [Dataset_InternationalLine_2018].[dbo].asientos.cliente = [InternationalBI].[dbo].saldoTemp.nrocliente)  

INNER JOIN [Dataset_InternationalLine_2018].[dbo].[Movims] ON ([Dataset_InternationalLine_2018].[dbo].[Movims].mdetalle like concat('%', RIGHT([InternationalBI].[dbo].saldoTemp.factura, len([InternationalBI].[dbo].saldoTemp.factura) - 1), '%')
AND [Dataset_InternationalLine_2018].[dbo].[Movims].mcliente = [InternationalBI].[dbo].saldoTemp.nrocliente)  

INNER JOIN [Basico_InternationalLine_2018].[dbo].[Vendedores] ON ([Basico_InternationalLine_2018].[dbo].[Vendedores].codigo = [Dataset_InternationalLine_2018].[dbo].Movims.mvendedor)

---------------------------------
UPDATE [InternationalBI].[dbo].[saldoTemp]
SET [Simbolo] = [InternationalBI].[dbo].[cobros].simbolo,
[Moneda] = [InternationalBI].[dbo].cobros.nombre
 FROM [InternationalBI].[dbo].[saldoTemp]
 INNER JOIN [InternationalBI].[dbo].[cobros] ON ([InternationalBI].[dbo].[saldoTemp].factura = concat([tipofactura],[numero]))
