select concat(seg.embarque, LEFT(seg.posicion,2)) as numero, seg.etd as Embarque, seg.eta as llegada, seg.origen,
seg.destino, cliente.empresa as cliente, trans.empresa as transportista, seg.awb as conocimiento, 
seg.hawb as house, seg.pago, 

prof.prof as 'profit',
sum(calc.teus) as teus,

seg.posicion, sum(env.bultos) as bultos, sum(env.peso) as peso, seg.volumen, ag.empresa as agente, 
cons.empresa as consignatario, emba.empresa as embarcador,
vend.nombre as vendedor, seg.iniciales as 'user', seg.vapor, seg.viaje, 
env.tipo, env.movimiento, 
seg.numero as seguimiento, 
cliente.ruc,
seg.refcliente, seg.iniciales as customer, seg.status, seg.modo, seg.booking, 
seg.estimadorecepcion as activacionSeguimiento, 
env.precinto as precinto,
seg.terminos, cliente.empresa as notificar

into LogisticaOperaciones.dbo.ops

from Seguir_2014.dbo.Seguimiento as seg

 INNER JOIN seguir_2014.dbo.Envases as env ON (env.numero = seg.numero)
 INNER JOIN Basico_Internationalline_2018.dbo.vendedores as vend ON (vend.codigo = seg.vendedor)
 INNER JOIN LogisticaOperaciones.dbo.agente as ag ON (ag.codigo = seg.agente)
 INNER JOIN LogisticaOperaciones.dbo.consignatario as cons ON (cons.codigo = seg.consignatario)
 INNER JOIN LogisticaOperaciones.dbo.embarcador as emba ON (emba.codigo = seg.embarcador)
 INNER JOIN LogisticaOperaciones.dbo.transportista as trans ON (trans.codigo = seg.transportista)
 INNER JOIN Basico_InternationalLine_2018.dbo.clientes as cliente ON (cliente.codigo = seg.cliente)
 INNER JOIN LogisticaOperaciones.dbo.calculations_2014 as calc ON (calc.numero = seg.numero)
 INNER JOIN LogisticaOperaciones.dbo.profits as prof ON (prof.numero = seg.numero)


 group by env.numero, seg.embarque, seg.posicion, seg.etd, seg.eta, seg.origen, seg.destino, seg.awb, seg.hawb, 
 seg.volumen, vend.nombre, seg.iniciales, seg.vapor, seg.Viaje, env.tipo, env.movimiento, seg.numero, seg.refcliente,
 seg.status, seg.modo, seg.booking, seg.estimadorecepcion, seg.terminos, seg.Notificar, seg.pago,
 cliente.empresa, emba.empresa, cons.empresa, ag.empresa, trans.empresa, cliente.ruc, precinto, ag.codigo, 
 prof.prof
