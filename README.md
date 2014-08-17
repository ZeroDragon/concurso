Concurso de Verano
====

##Requerimientos

- [node.js](http://nodejs.org/)

##Instalación

- Primero hacemos un clon de este repositorio

		git clone git@github.com:ZeroDragon/concurso.git

- Luego dentro del repositorio instalamos las dependencias con:

		npm install
		

##Solución y explicación del problema
Todo el problema y los pasos para solucionarlo está en el archivo `problema.litcoffee`. Al ser un litcoffee, se puede ver la explicación con un parser de markdown o en este [link](https://github.com/ZeroDragon/concurso/blob/master/problema.litcoffee).

##Comprobación del resultado
Si lo que queremos es ver el script funcionando, solo debemos ejecutar:

		npm start

Podremos ver como se ejecuta las pruebas en cada paso hasta determinar al ganador.

##Funciones
Las funciones declaradas que nos ayudan a detectar colisiones las podemos encontrar en `funciones.litcoffee`, de igual manera todo está documentado y se puede observar a detalle en este [link](https://github.com/ZeroDragon/concurso/blob/master/funciones.litcoffee)

##Pruebas de funciones
Se creó un archivo de pruebas para determinar que las funciones declaradas hagan bien su trabajo. Esto lo podemos ver en **prueba_de_funciones.litcoffee** o en este [link](https://github.com/ZeroDragon/concurso/blob/master/prueba_de_funciones.litcoffee). Para ejecutar las pruebas solo hay que correr:

		npm test