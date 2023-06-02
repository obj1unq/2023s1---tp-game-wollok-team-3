import celda.*
import coordenadas.*
import wollok.game.*

class Tablero {

	const ancho = 0 // Número
	const largo = 0 // Número
	const minasTotal = 0 // Número
	const celdasDelTablero = [] // [Celda]
	
	method ancho() = ancho
	
	method largo() = largo
	
	method celdasDelTablero() = celdasDelTablero

	method prepararCeldasEn(unaLista) {
		((ancho * largo) - 1).times({n => self.prepararUnaCeldaEn(unaLista)}) // El - 1 saca la coordenada [ 0, 0 ] que se inicializa siempre en todos los tableros.
		
	}
	
	method prepararUnaCeldaEn(unaLista) {
		const ultimaCoordenada = unaLista.vacias().last() // Toma la última coordenada que está en la lista. Al inicio de todo siempre va a estar la [ 0, 0 ]
		var ultimaCoordenadaX = ultimaCoordenada.first() // Su coordenada X
		var ultimaCoordenadaY = ultimaCoordenada.last() // Su coordenada Y
		if (not self.estaEnBordeY(ultimaCoordenada)) { // Se pregunta si no está en el borde del tablero.
			ultimaCoordenadaY += 1 // Entonces suma 1 a la coordenada Y
		} else {
			ultimaCoordenadaX += 1 // Suma uno a la coordenada X
			ultimaCoordenadaY = 0 // Devuelve al inicio de Y para volver a hacer el recorrido.
		}
		unaLista.agregarA(unaLista.vacias(), [ ultimaCoordenadaX, ultimaCoordenadaY ]) // Agrega una coordenada ya preparada a esa lista.
	}
	
	method estaEnBordeY(unaCoordenada) = unaCoordenada.last() == largo - 1
	
	method prepararMinasEn(unaLista) {
		self.verificarTotalDeMinas()
		minasTotal.times{ n => self.prepararUnaMinaEn(unaLista)}
	}

	method verificarTotalDeMinas() {
		if (minasTotal > ancho * largo) {
			self.error("La cantidad de minas configurada supera el número total de celdas del tablero.")
		}
	}

	method prepararUnaMinaEn(unaLista) {
		const coordenadaAleatoria = unaLista.vacias().anyOne() // Una coordenada de celda aleatoria.
		self.ponerCeldaMinadaCon(coordenadaAleatoria)
		unaLista.agregarA(unaLista.minadas(), coordenadaAleatoria)
		unaLista.eliminarDe(unaLista.vacias(), coordenadaAleatoria)
	}

	method ponerCeldaMinadaCon(unaCoordenada) { // unaCoordenada = [Número, Número]
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(unaCoordenada.first(), unaCoordenada.last())))
		celdasDelTablero.last().insertarBomba()
	}

	method prepararNumerosEn(unaLista) {
		unaLista.vacias().forEach({celda => self.prepararUnNumeroEn(unaLista)})
	}
	
	method prepararUnNumeroEn(unaLista) {
		const coordenadaAleatoria = unaLista.vacias().anyOne()
		self.ponerNumeroCon(coordenadaAleatoria)
	}
	
	method ponerNumeroCon(unaCoordenada) {
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(unaCoordenada.first(), unaCoordenada.last()), numero = self.minasAlrededorDe(unaCoordenada)))
	}
	
	method hayMinaAl(unaCoordenada, direccion, otraLista) { // unaCoordenada = [Número, Número], direccion = Direccion
		if (otraLista.minadas().contains(direccion.proximoDe(unaCoordenada))) {
			return 1
		} else {
			return 0
		}
	}

	method minasAlrededorDe(unaCoordenada, otraLista) { // unaCoordenada = [Número, Número], otraLista = lista
		return self.hayMinaAl(unaCoordenada, norte, otraLista) + self.hayMinaAl(unaCoordenada, noreste, otraLista) + self.hayMinaAl(unaCoordenada, este, otraLista) + self.hayMinaAl(unaCoordenada, sureste, otraLista) +
		self.hayMinaAl(unaCoordenada, sur, otraLista) + self.hayMinaAl(unaCoordenada, suroeste, otraLista) + self.hayMinaAl(unaCoordenada, oeste, otraLista) + self.hayMinaAl(unaCoordenada, noroeste, otraLista) 
	}
	
	method prepararCon(unaLista) {
		self.prepararCeldasEn(unaLista)
		self.prepararMinasEn(unaLista)
		self.prepararNumerosEn(unaLista)
	}

}

object juego {

	method ajustarDimensiones() {
		game.width(30)
		game.height(20)
	}
	
	method configurar(nivelTablero) { // nivelTablero = Tablero
		self.ajustarDimensiones()
		nivelTablero.preparar()
		nivelTablero.celdasDelTablero().forEach({ celda => game.addVisual(celda)})
	}

}

