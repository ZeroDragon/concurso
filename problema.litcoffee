Desafío de Verano 2014
=======

Las reglas son las siguientes:

- Un jugador dibuja un rectángulo y pide a otro que dibuje dentro de él 11 puntos (ya tenemos el campo y los jugadores).

- A continuación, por orden de edad, de menor a mayor, cada jugador en su turno conecta una pareja de puntos dibujando una línea recta que los una.

- Al dibujar una línea se deben respetar tres condiciones: las líneas no pueden salirse del rectángulo, no pueden atravesar a otra ya dibujada y tampoco pueden conectar dos puntos ya unidos previamente.

- Llegará un momento en que no será posible unir más puntos sin incumplir alguna de las condiciones. Cuando esto ocurra, la triangulación está terminada y el juego acaba. El ganador es el jugador que haya dibujado la última línea.

**Y ahora, el desafío:**

El reto consiste en averiguar quién ganará la partida si se colocan cuatro de los once puntos en las cuatro esquinas del campo, manteniendo los otros siete en el interior, y participan en el juego cinco amigos. Como siempre, además de la respuesta correcta, se debe explicar razonadamente el porqué.

##Comenzamos el programa

Primero defino las variables globales, mismas que usaré varias veces para facilitar calcular las líneas programáticamente.

    lineas = esquinas = centro = orbita = false

Para mantener la prueba lo más limpia posible, creé un archivo con las funciones que estarémos utilizando. Para más información, pueden leer `.funciones.litcoffee`.   
También creé un campo, su único propósito es ayudar a observar los puntos en el mismo, se puede ver el archivo en `campo.litcoffee`.  
A continuación requerimos dichos archivos y creamos algunas funciones útiles.  

    app = require './funciones'
    Linea = app.Line
    Punto = app.Dot
    config = require './config.json'
    logger = require('nicelogger').config config.logger, __dirname
    campo = require('./campo')(logger)

Esta pequeña función nos ayuda a verificar si podemos seguir agregando  
elementos al arreglo general de líneas

    puedoAgregar = (linea, debug = false)->
      intersecta = false
      for existente in lineas
        if app.isIntersect linea, existente
          logger.debug linea, 'intersecta con', existente if debug
          intersecta = true
          break
      return !intersecta

El problema nos plantea que deben haber cuatro puntos, uno en cada esquina  
pero no nos dice donde deben estar los demás. Para que sea lo más equitativo  
posible, estoy acomodando los faltantes siete puntos en dos grupos:  
un centro con un punto y una órbita con los seis puntos restantes.   
Para observar como quedaron acomodados, podemos ver el campo.

    exports.setUp = (done)->
      console.log()
      logger.debug 'Iniciamos los puntos en el mapa'
      esquinas = [
        new Punto 1   , 50
        new Punto 100 , 50
        new Punto 100 ,  1
        new Punto 1   ,  1
      ]
      centro = new Punto 50 , 25
      orbita = [
        new Punto 30 , 30
        new Punto 50 , 40
        new Punto 70 , 30
        new Punto 70 , 20
        new Punto 50 , 10
        new Punto 30 , 20
      ]
      logger.debug campo
      done()


Para crear las líneas entre los puntos, primero vamos a crear todas las  
posibles combinaciones entre el centro y la órbita, posteriormente  
las combinaciones con los puntos de la órbita, luego las líneas entre  
las esquinas y finalmente las posibles líneas entre las esquinas y la órbita

    exports.ResolvemosElProblema = (test)->
      lineas = []

**Paso1**  
Creamos líneas entre el centro y la órbita,  
checamos contra el arreglo de líneas, si no intersecta con alguna otra  
línea creada, si no estorba, la agregamos al arreglo de líneas. El número de líneas creadas solo pueden ser seis

      for punto in orbita
        linea = new Linea punto, centro
        lineas.push linea if linea.dot1 and puedoAgregar linea

      logger.debug 'Lineas creadas:',lineas.length.blue, ', deben ser:', 6.blue
      test.equal lineas.length, 6

**Paso2**  
Creamos líneas con los puntos de la órbita entre ellos mismos  
Como ya existen líneas creadas entre el centro y la órbita, las únicas  
posibles líneas deben ser las que unan la órbita en un hexágono (es decir, seis más).

      for punto in orbita
        for puntoPrimo in orbita
          linea = new Linea punto, puntoPrimo
          lineas.push linea if linea.dot1 and puedoAgregar linea

      logger.debug 'Lineas creadas:',lineas.length.blue, ', deben ser:', 12.blue
      test.equal lineas.length, 12

**Paso3**  
Creamos líneas con los puntos de las esquinas. Debido a la órbita ya dibujada  
solo se podrán hacer cuatro líneas más (un total de 16 al momento).

      for punto in esquinas
        for puntoPrimo in esquinas
          linea = new Linea punto, puntoPrimo
          lineas.push linea if linea.dot1 and puedoAgregar linea

      logger.debug 'Lineas creadas:',lineas.length.blue, ', deben ser:', 16.blue
      test.equal lineas.length, 16

**Paso4**  
Ya con todas las líneas creadas, intentamos crear líneas entre la órbita  
y las esquinas, deben ser otras 10

      for punto in esquinas
        for puntoPrimo in orbita
          linea = new Linea punto, puntoPrimo
          lineas.push linea if linea.dot1 and puedoAgregar linea

      logger.debug 'Lineas creadas:',lineas.length.blue, ', deben ser:', 26.blue
      test.equal lineas.length, 26

**Paso5**  
Con todas las posibles líneas creadas, vamos a determinar el ganador.  
Puesto que los jugadores son cinco, toman turnos ordenados y para ganar  
debe ser la última persona que pueda dibujar una línea.  
El ganador lo determinamos al obtener el modal (sobrante) de al división del  
número de jugadas (líneas) entre el número de jugadores.

      jugadores = [
        'Mario',
        'Luigi',
        'Peach',
        'Daisy',
        'Toad'
      ]

      sobrante = lineas.length % jugadores.length
      ganador = sobrante-1 # restamos uno, porque los arreglos se inician en cero

      console.log()
      logger.box {
        'Ganador  : ' : jugadores[ganador]
        'Posición : ' : sobrante
        'Author   : ' : 'Carlos Flores <zr.drgn@gmail.com>'
      }

Prueba final: Nuestro jugador ganador debe ser el primero del arreglo (Mario)

      test.equal jugadores[ganador], 'Mario'

      test.done()

##Notas finales
Si bien esto es más fuerza bruta programática que equaciones trigonométricas, no definieron las reglas de como llegar a una respuesta válida, solo pidieron la explicación de la misma.  

Entre otras cosas, fue bastante entretenido jugar con algoritmos de colisión de vectores.

Carlos Flores
