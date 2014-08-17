Este es el archivo de funciones
====

Ecuación general para determinar si dos segmentos se intersectan

    exports.isIntersect = (line1, line2, debug = false)->
      x1 = line1.dot1.lng; y1 = line1.dot1.lat
      x2 = line1.dot2.lng; y2 = line1.dot2.lat
      x3 = line2.dot1.lng; y3 = line2.dot1.lat
      x4 = line2.dot2.lng; y4 = line2.dot2.lat

      x=((x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4))
      y=((x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4))

      interseccion = {lng:x,lat:y}
      puntos = [
        JSON.stringify(line1.dot1)
        JSON.stringify(line1.dot2)
        JSON.stringify(line2.dot1)
        JSON.stringify(line2.dot2)
      ]

      console.log interseccion if debug

      if isNaN(x) and isNaN(y)

Cuando tanto `x` como `y` son "Not a Number", significa que son dos segmentos  
de un mismo vector, sin embargo, debemos determinar si se tocan o se traslapan.  

Si los puntos 3 y 1 son iguales, significa que comparten un mismo fin, así que son válidos

        return false if puntos[3] is puntos[1]

Cualquier otro caso, es un choque de segmentos

        return true

Ahora bien, si solo uno de los dos es Not a Number, es porque son paralelas.  
Las líneas paralelas nunca se intersectan.

      else if isNaN(x) or isNaN(y)
        return false
      else
      
Aun tenemos un caso en el que los segmentos compartan un origen o destino y no  
sean paralelos ni parte del mismo vector, entonces vamos a validar si es este  
caso, pues aun debe ser válido para nuestros propósitos.

        encontrados = 0
        for punto in puntos
          encontrados++ if punto is JSON.stringify(interseccion)
        if encontrados is 2
          return false

Si no fue ninguna de las anteriores, Es porque los vectores de los segmentos  
deben juntarse en algún momento, sin embargo, debemos determinar si dicha  
intersección está dentro de los segmentos para regresar una colisión positiva

        if (x1>=x2)
          return false if (!(x2<=x and x<=x1))
        else
          return false if (!(x1<=x and x<=x2))

        if (y1>=y2)
          return false if (!(y2<=y and y<=y1))
        else
          return false if (!(y1<=y and y<=y2))

        if (x3>=x4)
          return false if (!(x4<=x and x<=x3))
        else
          return false if (!(x3<=x and x<=x4))

        if (y3>=y4)
          return false if (!(y4<=y and y<=y3))
        else
          return false if (!(y3<=y and y<=y4))

      return true

Estas son funciones comunes que usamos de constructores para hacer puntos

    exports.Dot = (x,y)->
      @.lng = x
      @.lat = y
      return

y líneas, basadas en puntos
    
    exports.Line = (dot1,dot2)->
      return if JSON.stringify(dot1) is JSON.stringify(dot2)
      @.dot1 = dot1
      @.dot2 = dot2
      return

Hasta aquí con las funciones!