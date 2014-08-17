Prueba de funciones
====
Generamos esta prueba para poder determinar si nuestras funciones sirven  
para los propósitos que necesitamos.  
La prueba evaluará todos los casos posibles para determinar si las  
funciones están regresando los valores esperados.

Variables globales. Las necesitamos para usarlas en un futuro

    app = Line = Dot = false
    lineas = []

Requerimos el archivo de funciones para evaluar sus resultados.  
También definimos unos constructores que nos ayudan a generar las  
líneas y puntos

    exports.setUp = (done)->
      app  = require './funciones'
      Line = app.Line
      Dot  = app.Dot

Ahora vamos a crear las líneas a ocupar dentro de nuestras pruebas:  

      lineas[1]  = new Line(new Dot(10,10), new Dot(90,10))
      lineas[2]  = new Line(new Dot(10,90), new Dot(90,90))
      lineas[3]  = new Line(new Dot(20,95), new Dot(20,5))
      lineas[4]  = new Line(new Dot(20,95), new Dot(30,80))
      lineas[5]  = new Line(new Dot(90,10), new Dot(10,10))
      lineas[6]  = new Line(new Dot(30,30), new Dot(60,30))
      lineas[7]  = new Line(new Dot(40,30), new Dot(50,30))
      lineas[8]  = new Line(new Dot(30,30), new Dot(50,30))
      lineas[9]  = new Line(new Dot(30,50), new Dot(45,50))
      lineas[10] = new Line(new Dot(60,50), new Dot(45,50))

      done()

##Corremos las pruebas

**Primera prueba:**  
Dos líneas paralelas
    
    exports.Paralelas = (test)->
      prueba = app.isIntersect lineas[1], lineas[2]
      test.equal prueba, false
      test.done()

**Segunda prueba:**  
Dos líneas perpendiculares

    exports.Perpendiculares = (test)->
      prueba = app.isIntersect lineas[1], lineas[3]
      test.equal prueba, true
      test.done()

**Tercera prueba:**  
Dos líneas con el mismo origen, en teoria se intersectan  
en el origen, pero debemos descartar esto, pues las regalas  
nos dicen que es posible generar dos líneas en diferentes  
direcciones con un mismo origen.

    exports.Mismo_Origen_Diferente_Direccion = (test)->
      prueba = app.isIntersect lineas[3], lineas[4]
      test.equal prueba, false
      test.done()

**Cuarta prueba:**  
Dos lineas con origenes y destinos opuestos.  
Estas líneas son del mismo vector y mismo segmento pero  
diferente dirección.

    exports.Origenes_Y_Destinos_Opuestos = (test)->
      prueba = app.isIntersect lineas[1], lineas[5]
      test.equal prueba, true
      test.done()

**Quinta prueba:**  
La misma dirección diferentes origenes.  
Estas dos líneas representan un mismo vector y misma dirección,  
Pero un segmento contiene al otro.

    exports.Misma_Direccion_Diferentes_Origenes = (test)->
      prueba = app.isIntersect lineas[6], lineas[7]
      test.equal prueba, true
      test.done()

**Sextra prueba:**  
La misma dirección, comparten un origen.  
Esta es muy parecida a la anterior, mismo vector, misma dirección,  
Un segmento contiene al otro pero comparten un mismo origen.

    exports.Misma_Direccion_Un_Origen_Comun = (test)->
      prueba = app.isIntersect lineas[6], lineas[8]
      test.equal prueba, true
      test.done()

**Septima prueba:**  
La misma direccion, diferente origen  
Mismo vector, diferente dirección, un mismo punto de destino.

    exports.Misma_Direccion_Un_Destino_Comun = (test)->
      prueba = app.isIntersect lineas[9], lineas[10]
      test.equal prueba, false
      test.done()

Pruebas finalizadas