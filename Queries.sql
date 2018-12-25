SELECT 
[expmarit].[dbo].[envases].[numero],
[expmarit].[dbo].[embarqueaereo].[origen],
[Basico_InternationalLine_2018].[dbo].[clientes].[empresa],  
[expmarit].[dbo].[embarqueaereo].[transportista],------ Where does it connect?
[expmarit].[dbo].[embarqueaereo].[Pago],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[agente],    -------agente?
[Dataset_InternationalLine_2018].[dbo].[Boleta].[consignatario],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[embarcador],
[Basico_InternationalLine_2018].[dbo].[vendedores].[nombre],
[expmarit].[dbo].[Envases].[movimiento],
[Basico_InternationalLine_2018].[dbo].[CliTraficos].[trafico], ------embarqueaereo
[expmarit].[dbo].[embarqueaereo].[terminos],
[expmarit].[dbo].[embarqueaereo].[ContratoCli],
[expmarit].[dbo].[embarqueaereo].[ContratoTra]

---INTO [JoinTables].[Joinexpmarit]
FROM [expmarit].[dbo].[envases]
LEFT JOIN [expmarit].[dbo].[embarqueaereo] ON ([expmarit].[dbo].[envases].[numero] = [expmarit].[dbo].[embarqueaereo].[numero])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[clientes] ON ([Basico_InternationalLine_2018].[dbo].[clientes].[codigo] = [expmarit].[dbo].[Embarqueaereo].[cliente])
LEFT JOIN [Dataset_InternationalLine_2018].[dbo].[Boleta] ON ([Dataset_InternationalLine_2018].[dbo].[Boleta].[numero] = [expmarit].[dbo].[envases].[numero])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[vendedores] ON ([expmarit].[dbo].[embarqueaereo].[vendedor] = [Basico_InternationalLine_2018].[dbo].[Vendedores].[codigo])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[CliTraficos] ON ([Basico_InternationalLine_2018].[dbo].[CliTraficos].[codigo] = [expmarit].[dbo].[embarqueaereo].[trafico])

GROUP BY [expmarit].[dbo].[envases].[numero],
[expmarit].[dbo].[embarqueaereo].[origen],
[Basico_InternationalLine_2018].[dbo].[clientes].[empresa],  
[expmarit].[dbo].[embarqueaereo].[transportista],------ Where does it connect?
[expmarit].[dbo].[embarqueaereo].[Pago],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[agente],    -------agente?
[Dataset_InternationalLine_2018].[dbo].[Boleta].[consignatario],
[Dataset_InternationalLine_2018].[dbo].[Boleta].[embarcador],
[Basico_InternationalLine_2018].[dbo].[vendedores].[nombre],
[expmarit].[dbo].[Envases].[movimiento],
[Basico_InternationalLine_2018].[dbo].[CliTraficos].[trafico], ------embarqueaereo
[expmarit].[dbo].[embarqueaereo].[terminos],
[expmarit].[dbo].[embarqueaereo].[ContratoCli],
[expmarit].[dbo].[embarqueaereo].[ContratoTra]

------------------------
CREATE TABLE [JoinTables].[dbo].[JoinAll] (
    ID int IDENTITY(1,1) PRIMARY KEY,
    numero int,
    origen varchar(255),
	empresa varchar(255),
    transportista int,
	Pago varchar(255),
	agente varchar(255),
	consignatario varchar(255),
	embarcador varchar(255),
	nombre varchar(255),
	movimiento varchar(255),
	trafico varchar(255),
	terminos varchar(255),
	ContratoCli varchar(255),
	ContratoTra varchar(255)
);

-----------------------------

Update [JoinTables].[dbo].[JoinAll]
SET 
	[JoinTables].[dbo].[JoinAll].[Operacion] = [expterra].[dbo].[Embarqueaereo].[operacion]
FROM [JoinTables].[dbo].[JoinAll]
INNER JOIN [expterra].[dbo].[Embarqueaereo] ON ([expterra].[dbo].[Embarqueaereo].[numero] = [JoinTables].[dbo].[JoinAll].[numero])

-----------------------------------
SELECT c.name AS ColName, t.name AS TableName
FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
WHERE c.name LIKE '%MyCol%';
--------------------------

SELECT 
j.numero,
j.empresa,
e.ETD,
j.ETA,
j.Operacion	
into JoinClientesRecientes
from JoinAll2 as j
INNER JOIN export.dbo.embarqueaereo as e ON (j.numero = e.numero) -- do for the other DBs
Where e.etd >= DATEADD(month, -6, GETDATE())
GROUP BY  
j.numero,
j.empresa,
e.ETD,
j.ETA,
j.Operacion	
 -------
SELECT 
j.numero,
j.empresa,
e.ETD,
j.ETA,
j.Operacion	
into JoinClientesAntiguos
from JoinAll2 as j
INNER JOIN export.dbo.embarqueaereo as e ON (j.numero = e.numero) -- do for the other DBs
Where e.etd < DATEADD(month, -6, GETDATE())
GROUP BY  
j.numero,
j.empresa,
e.ETD,
j.ETA,
j.Operacion	
----------------------------------------------------------
SELECT 
j.numero,
j.nombre,
e.volumencubico,
e.profitage * 690 as profit, -- precio dolar
j.Operacion	
into JoinAgentesxProfit
from JoinTables.dbo.JoinAll as j
INNER JOIN export.dbo.embarqueaereo as e ON (j.numero = e.numero) -- do for the other DBs
Where e.moneda = 2 -- dolares
GROUP BY  
j.numero,
j.nombre,
e.volumencubico,
e.profitage,
j.Operacion	
