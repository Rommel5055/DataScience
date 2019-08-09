SELECT [posicion], numero, (sum(precio/arbitraje) - sum(costo/arbitraje))+max(pc)-max(cc) as prof
into LogisticaOperaciones.dbo.profits
from LogisticaOperaciones.dbo.calculations_2014
where arbitraje != 0
group by numero, movimiento, tipo, envase, posicion
