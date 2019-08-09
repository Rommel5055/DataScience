Select [seguir_2014].[dbo].[Envases].numero,
    [seguir_2014].[dbo].[seguimiento].posicion,
    (CASE
    when [seguir_2014].[dbo].[Envases].[unidad] = '20'
        then ([seguir_2014].[dbo].[Envases].[cantidad])
    when [seguir_2014].[dbo].[Envases].[unidad] = '40' or [seguir_2014].[dbo].[Envases].[unidad] = '45'
        then ([seguir_2014].[dbo].[Envases].[cantidad] * 2)
    else
        0
        END) AS teus,
    [seguir_2014].[dbo].[Envases].movimiento,
    [seguir_2014].[dbo].[Envases].tipo,
    [seguir_2014].[dbo].[Envases].tara,
    [seguir_2014].[dbo].[Envases].envase,
    [seguir_2014].[dbo].[Envases].volumen,
    [seguir_2014].[dbo].[Envases].precio*[seguir_2014].[dbo].[Envases].cantidad as pc,
    [seguir_2014].[dbo].[Envases].costo*[seguir_2014].[dbo].[Envases].cantidad as cc,
    [seguir_2014].[dbo].[serviceaereo].precio,
    [seguir_2014].[dbo].[serviceaereo].costo,
    [seguir_2014].[dbo].[serviceaereo].arbitraje
 
--  into LogisticaOperaciones.dbo.calculations_2014
 
    FROM [seguir_2014].[dbo].[Envases]
    left join [seguir_2014].[dbo].[Seguimiento] ON ([seguir_2014].[dbo].[seguimiento].numero = [seguir_2014].[dbo].[Envases].numero)
  left join [seguir_2014].[dbo].[serviceaereo] ON ([seguir_2014].[dbo].[serviceaereo].numero = [seguir_2014].[dbo].[envases].numero)
 
  group by
  [seguir_2014].[dbo].[Envases].numero,
    [seguir_2014].[dbo].[seguimiento].posicion,
    [seguir_2014].[dbo].[Envases].[unidad],
    [seguir_2014].[dbo].[Envases].[cantidad],
 
[seguir_2014].[dbo].[Envases].movimiento,
    [seguir_2014].[dbo].[Envases].tipo,
    [seguir_2014].[dbo].[Envases].tara,
    [seguir_2014].[dbo].[Envases].envase,
    [seguir_2014].[dbo].[Envases].volumen,
    [seguir_2014].[dbo].[Envases].precio*[seguir_2014].[dbo].[Envases].cantidad,
    [seguir_2014].[dbo].[Envases].costo*[seguir_2014].[dbo].[Envases].cantidad,
    [seguir_2014].[dbo].[serviceaereo].precio,
    [seguir_2014].[dbo].[serviceaereo].costo,
    [seguir_2014].[dbo].[serviceaereo].arbitraje
 
 
   
 
      ,[seguir_2014].[dbo].[serviceaereo].[servicio]
      ,[seguir_2014].[dbo].[serviceaereo].[moneda]
      ,[seguir_2014].[dbo].[serviceaereo].[modo]
      ,[seguir_2014].[dbo].[serviceaereo].[detalle]
      ,[seguir_2014].[dbo].[serviceaereo].[tipogasto]
      ,[seguir_2014].[dbo].[serviceaereo].[pinformar]
      ,[seguir_2014].[dbo].[serviceaereo].[notomaprofit]
      ,[seguir_2014].[dbo].[serviceaereo].[secomparte]
      ,[seguir_2014].[dbo].[serviceaereo].[descripcion]
      ,[seguir_2014].[dbo].[serviceaereo].[Notas]
      ,[seguir_2014].[dbo].[serviceaereo].[Socio]
 
      ,[seguir_2014].[dbo].[Envases].[unidad]
      ,[seguir_2014].[dbo].[Envases].[tipo]
      ,[seguir_2014].[dbo].[Envases].[movimiento]
      ,[seguir_2014].[dbo].[Envases].[marcas]
      ,[seguir_2014].[dbo].[Envases].[precinto]
      ,[seguir_2014].[dbo].[Envases].[tara]
      ,[seguir_2014].[dbo].[Envases].[bonifcli]
      ,[seguir_2014].[dbo].[Envases].[Envase]
      ,[seguir_2014].[dbo].[Envases].[bultos]
      ,[seguir_2014].[dbo].[Envases].[Peso]
      ,[seguir_2014].[dbo].[Envases].[nrocontenedor]
      ,[seguir_2014].[dbo].[Envases].[ID]
