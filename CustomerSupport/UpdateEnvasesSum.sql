CREATE PROCEDURE UpdateEnvasesSum
AS

TRUNCATE table International.dbo.EnvasesSum

--DROP TABLE #MyTable

CREATE TABLE #MyTable ([numero] INT, tipo varchar(50), [nrocontenedor] varchar(100), movimiento varchar(30),
bultos int, peso float, precinto varchar(100), temperatura varchar(50), activo char(1), UnidadTemp char(1), 
precio money, costo money, profit money, volumen float, cotizacion int, cantidad float)

INSERT INTO #MyTable SELECT numero, tipo, [nrocontenedor], movimiento, bultos, peso, precinto, temperatura, activo, 
unidadTemp, precio, costo, profit, volumen, cotizacion, cantidad from seguir_2014.dbo.envases

INSERT INTO International.dbo.EnvasesSum
SELECT 
  numero,
  movimiento,
  sum(bultos) as bultos,
  sum(peso) as peso,
  STUFF((
    SELECT ', ' + tipo +' ' + [nrocontenedor]
    FROM #MyTable 
    WHERE (numero = Results.numero) AND (tipo != 'S/I')
    FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)')
  ,1,2,'') AS Contenedores,
  
  
  STUFF((
    SELECT ', ' + precinto
    FROM #MyTable 
    WHERE (numero = Results.numero) AND (precinto != 'S/I')
    FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)')
  ,1,2,'') AS Precintos,

  STUFF((
    SELECT ', ' + temperatura
    FROM #MyTable 
    WHERE (numero = Results.numero) AND (temperatura is not null)
    FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)')
  ,1,2,'') AS temperatura,
  activo,
  [UnidadTemp] as Unidad,
  sum(precio) as Ingresos,
  sum(costo) as Egresos,
  sum(profit) as Profit,
  sum(volumen) as Volumen,
  sum(cotizacion) as Cotizacion,
  sum(cantidad) as CantidadContainers



  --into JoinInternational.dbo.EnvasesSum
FROM #MyTable Results
GROUP BY numero
,
tipo, [nrocontenedor], movimiento, precinto, temperatura, activo, 
unidadTemp

DROP TABLE #MyTable
