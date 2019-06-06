--2
CREATE PROCEDURE UpdatePagosFIN
AS
TRUNCATE TABLE FinanzasCobranzas.dbo.PagosFIN

INSERT INTO FinanzasCobranzas.dbo.PagosFIN
SELECT vtas.FechaImpu as FechaPago, vtas.autofac as Autogenerado, vtas.monto
--into FinanzasCobranzas.dbo.PagosFIN

FROM [Dataset_InternationalLine_2018].[dbo].[Impuvtas] as vtas 
inner join FinanzasCobranzas.dbo.VentasFIN ON (FinanzasCobranzas.dbo.VentasFIN.autogenerado = vtas.autofac)
