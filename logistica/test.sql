select concat(seg.embarque, LEFT(seg.posicion,2)) as numero, seg.etd as Embarque, seg.eta as llegada, seg.origen, seg.destino, 
--client.codigo as cliente, client.codigo as transportista, 
seg.awb as conocimiento, 
--consolidado?
seg.hawb as house, seg.pago, 
--profits and shit
seg.posicion, sum(env.bultos) as bultos, sum(env.peso) as peso, seg.volumen,
--aplicable??
--client.codigo as agente--????, client.codigo as consignatario client.codigo as embarcador
vend.nombre as vendedor, seg.iniciales as 'user', seg.vapor, seg.viaje, 
--calcular teus
env.tipo, env.movimiento, 
-- concat nrocontendro envase
--propio not found
--cotizacion not found
seg.numero as seguimiento, 
--ruc cliente cliente
--due agent due carrier
--producto
--tarifa venta
--identificar pais
seg.refcliente, seg.iniciales as customer, seg.status, seg.modo, seg.booking, seg.estimadorecepcion as activacionSeguimiento, 
--env precinto as precinto
--fech crecion not found
seg.terminos, seg.notificar --cliente algo

into LogisticaOperaciones.dbo.test

from Seguir_2014.dbo.Seguimiento as seg

 INNER JOIN seguir_2014.dbo.Envases as env ON (env.numero = seg.numero)
 INNER JOIN Basico_Internationalline_2018.dbo.vendedores as vend ON (vend.codigo = seg.vendedor)

 group by env.numero, seg.embarque, seg.posicion, seg.etd, seg.eta, seg.origen, seg.destino, seg.awb, seg.hawb, seg.volumen, vend.nombre, seg.iniciales,
 seg.vapor, seg.Viaje, env.tipo, env.movimiento, seg.numero, seg.refcliente, seg.status, seg.modo, seg.booking, seg.estimadorecepcion, seg.terminos, seg.Notificar,
 seg.pago
