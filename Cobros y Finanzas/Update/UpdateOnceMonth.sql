--4
CREATE PROCEDURE UpdateOnceMonth
AS
TRUNCATE TABLE FinanzasCobranzas.dbo.OnceMonth

INSERT INTO FinanzasCobranzas.dbo.OnceMonth

SELECT autogenerado, factura, tipofactura, numero, simbolo, total,
cambio, fecha, vto, 
cliente, nrocliente, nombre, posicion, tipo, imputacion, vendedor,
analista, detalle,
FechaPago, Pagado

FROM FinanzasCobranzas.dbo.Finanzas
