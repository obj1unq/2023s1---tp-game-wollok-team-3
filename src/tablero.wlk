import celda.*
import coordenadas.*
import wollok.game.*

// g h G H []
class Tablero {

	const ancho = 0 // Número
	const largo = 0 // Número
	const minasTotal = 0 // Número
	const celdasDelTablero = [] // [Celda]

	method ancho() = ancho

	method largo() = largo

	method celdasDelTablero() = celdasDelTablero

	method prepararCeldasEn(unaLista) {
		self.verificarPrimerElementoEn(unaLista)
		((ancho * largo) - 1).times{ n => self.prepararUnaCeldaEn(unaLista)}
	}

	method prepararUnaCeldaEn(unaLista) {
		const ultimaCoordenada = unaLista.vacias().last()
		var nuevaCoordenadaX = ultimaCoordenada.first()
		var nuevaCoordenadaY = ultimaCoordenada.last()
		if (not self.estaEnBordeY(nuevaCoordenadaY)) {
			nuevaCoordenadaY += 1
		} else {
			nuevaCoordenadaX += 1
			nuevaCoordenadaY = 0
		}
		unaLista.agregarA(unaLista.vacias(), [ nuevaCoordenadaX, nuevaCoordenadaY ])
	}

	method verificarPrimerElementoEn(unaLista) {
		if (unaLista.vacias() != [[0, 0]]) {
			self.error("La lista utilizada no contiene el elemento esperado o contiene más de un elemento")
		}
	}

	method estaEnBordeY(coordenadaY) = coordenadaY == largo - 1

	method prepararMinasEn(unaLista) {
		self.verificarTotalMinas()
		minasTotal.times({ n => self.prepararUnaMinaEn(unaLista)})
	}

	method verificarTotalMinas() {
		if (minasTotal > ancho * largo) {
			self.error("La cantidad de minas configurada supera el número total de celdas del tablero.")
		}
	}

	method prepararUnaMinaEn(unaLista) {
		const coordenadaAleatoria = unaLista.vacias().anyOne()
		self.ponerUnaCeldaMinadaEn(coordenadaAleatoria)
		unaLista.agregarA(unaLista.minadas(), coordenadaAleatoria)
		unaLista.eliminarDe(unaLista.vacias(), coordenadaAleatoria)
	}

	method ponerUnaCeldaMinadaEn(unaCoordenada) {
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(unaCoordenada.first(), unaCoordenada.last())))
		celdasDelTablero.last().insertarBomba()
	}

	method ponerNumerosCon(unaLista) {
		unaLista.vacias().forEach({ celda => self.ponerUnNumeroCon(unaLista)})
	}

	method ponerUnNumeroCon(unaLista) {
		const coordenadaAleatoria = unaLista.vacias().anyOne()
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(coordenadaAleatoria.first(), coordenadaAleatoria.last(), numero = self.minasAlrededorDe(coordenadaAleatoria))))
	}

	method hayMinaAl(unaCoordenada, direccion, unaLista) = if (unaLista.minadas().contains(direccion.proximoDe(unaCoordenada))) 1 else 0

	method minasAlrededorDe(unaCoordenada, unaLista) = self.hayMinaAl(unaCoordenada, norte, unaLista) + self.hayMinaAl(unaCoordenada, noroeste, unaLista) + self.hayMinaAl(unaCoordenada, este, unaLista) + self.hayMinaAl(unaCoordenada, sureste, unaLista) + self.hayMinaAl(unaCoordenada, sur, unaLista) + self.hayMinaAl(unaCoordenada, suroeste, unaLista) + self.hayMinaAl(unaCoordenada, oeste, unaLista) + self.hayMinaAl(unaCoordenada, noroeste, unaLista)

	method prepararCon(unaLista) {
		self.prepararCeldasEn(unaLista)
		self.prepararMinasEn(unaLista)
		self.ponerNumerosCon(unaLista)
	}

}

object juego {

	method ajustarDimensiones() {
		game.width(30)
		game.height(20)
	}

	method configurar(nivelTablero) {
		self.ajustarDimensiones()
		nivelTablero.preparar()
		nivelTablero.celdasDelTablero().forEach({ celda => game.addVisual(celda)})
	}

}

