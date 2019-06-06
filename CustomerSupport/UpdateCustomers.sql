CREATE PROCEDURE UpdateCustommers
AS

TRUNCATE table international.dbo.customer

INSERT INTO international.dbo.customer
SELECT boleta.consignatario, boleta.embarcador, clientes.empresa, boleta.agente, concat(seguimiento.origen,'/',seguimiento.destino) as 'OriDno.', 
seguimiento.fecha as 'activacion', seguimiento.vencimiento, seguimiento.numero, seguimiento.posicion, seguimiento.status, seguimiento.vapor, 
--?ORDEN
e.movimiento, 
vendedores.nombre as vendedor, 
e.contenedores, e.bultos, e.peso, 
infofactura.transportista, 
--??DOCS
--##########seguimiento.observaciones as notas, seguimiento.terminos as IncoTerms, 
cast(seguimiento.observaciones as varchar(999)) as notas, cast(seguimiento.terminos as varchar(999)) as IncoTerms, 
e.precintos,
seguimiento.awb as 'Master', seguimiento.hawb as 'House', seguimiento.booking, 
e.temperatura, e.activo, e.unidad,
--???? concat marcas as productos, 
seguimiento.iniciales as Customer, seguimiento.pago as pagoFleteVenta, 
e.ingresos, e.egresos, e.profit, e.volumen, 
seguimiento.valor, seguimiento.Wreceipt, 
--marcas
seguimiento.ArriboReal as RecepcionEfectivadelaCompra,
--enlace
e.cotizacion,
--status operacion, flete, calcular teus
--enlace. cantidad as cantidadContainers
--costo flete
seguimiento.etd as ETD, seguimiento.eta as ETA, seguimiento.refproveedor as RefProveedor, seguimiento.origen, seguimiento.destino, seguimiento.modo, 
seguimiento.estimadorecepcion as EstimadoPorelProveedor, seguimiento.tieneseguro as seguro, seguimiento.nroseguro, seguimiento.prima, monedas.nombre as Moneda,
seguimiento.demora as DiasdeDemoraPermitidos, reservas.pagoflete as PagoFleteCompra, seguimiento.fechacutoff, seguimiento.contratotra as ContratoTransportista,
seguimiento.operacion, seguimiento.proyecto, seguimiento.FechaCutOffVGM as cutoffVGM, seguimiento.DeadDocumentos
--into international.dbo.customer


FROM seguir_2014.dbo.seguimiento
LEFT JOIN [Dataset_InternationalLine_2018].[dbo].[Boleta] ON ([Dataset_InternationalLine_2018].[dbo].[Boleta].[posicion] = [seguir_2014].[dbo].[Seguimiento].[posicion])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[clientes] ON ([Basico_InternationalLine_2018].[dbo].[clientes].[codigo] = [seguir_2014].[dbo].[Seguimiento].[cliente])
LEFT JOIN [Dataset_InternationalLine_2018].[dbo].[InfoFactura] ON ([Dataset_InternationalLine_2018].[dbo].[InfoFactura].[seguimiento] = [seguir_2014].[dbo].[Seguimiento].[numero])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[vendedores] ON ([seguir_2014].[dbo].[Seguimiento].[vendedor] = [Basico_InternationalLine_2018].[dbo].[Vendedores].[codigo])
LEFT JOIN [Basico_InternationalLine_2018].[dbo].[Monedas] ON ([Basico_InternationalLine_2018].[dbo].[Monedas].codigo = seguimiento.moneda)
LEFT JOIN seguir_2014.dbo.reservas ON (seguir_2014.dbo.reservas.numero = seguir_2014.dbo.seguimiento.numero)
LEFT JOIN international.[dbo].[EnvasesSum] as e ON (e.numero = seguimiento.numero)


group by seguimiento.numero,
boleta.consignatario, boleta.embarcador, clientes.empresa, boleta.agente, concat(seguimiento.origen,'/',seguimiento.destino), 
seguimiento.fecha, seguimiento.vencimiento, seguimiento.numero, seguimiento.posicion, seguimiento.status, seguimiento.vapor, 
vendedores.nombre, 
infofactura.transportista, 
cast(seguimiento.observaciones as varchar(999)), cast(seguimiento.terminos as varchar(999)), 
seguimiento.awb, seguimiento.hawb, seguimiento.booking, 
seguimiento.iniciales, seguimiento.pago, 
seguimiento.valor, seguimiento.Wreceipt, 
seguimiento.ArriboReal,
seguimiento.etd, seguimiento.eta, seguimiento.refproveedor, seguimiento.origen, seguimiento.destino, seguimiento.modo, 
seguimiento.estimadorecepcion, seguimiento.tieneseguro, seguimiento.nroseguro, seguimiento.prima, monedas.nombre,
seguimiento.demora, reservas.pagoflete, seguimiento.fechacutoff, seguimiento.contratotra,
seguimiento.operacion, seguimiento.proyecto, seguimiento.FechaCutOffVGM, seguimiento.DeadDocumentos

,e.[movimiento]
      ,e.[bultos]
      ,e.[peso]
      ,e.[Contenedores]
      ,e.[Precintos]
      ,e.[temperatura]
      ,e.[activo]
      ,e.[Unidad]
      ,e.[Ingresos]
      ,e.[Egresos]
      ,e.[Profit]
      ,e.[Volumen]
      ,e.[Cotizacion]
      ,e.[CantidadContainers]
