--3
CREATE PROCEDURE UpdateFinanzas
AS
TRUNCATE TABLE FinanzasCobranzas.dbo.Finanzas

INSERT INTO FinanzasCobranzas.dbo.Finanzas
SELECT v.autogenerado, factura, tipofactura, numero, simbolo, total,
cambio, fecha, vto, 
cliente, nrocliente, nombre, posicion, tipo, imputacion, vendedor,
analista, detalle,

max(p.FechaPago) as FechaPago, sum(p.monto) as Pagado

FROM FinanzasCobranzas.dbo.VentasFIN as v
LEFT JOIN FinanzasCobranzas.dbo.PagosFIN as p ON (v.autogenerado = p.autogenerado)

GROUP BY v.autogenerado, factura, tipofactura, numero, simbolo, total,
cambio, fecha, vto, 
cliente, nrocliente, nombre, posicion, tipo, imputacion, vendedor,
analista, detalle
