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

	method prepararCeldas() {
		(ancho * largo).times{ n => self.prepararUnaCelda()}
	}

	method prepararUnaCelda() {
		const xRandom = (0.randomUpTo(ancho - 1)).truncate(0)
		const yRandom = (0.randomUpTo(largo - 1)).truncate(0)
		if (not listaDeCoordenadas.vacias().contains([ xRandom, yRandom ])) {
			listaDeCoordenadas.agregarA(listaDeCoordenadas.vacias(), [ xRandom, yRandom ])
		} else {
			self.prepararUnaCelda()
		}
	}

	method ponerMinas() {
		self.verificarTotalDeMinas()
		minasTotal.times{ n => self.ponerUnaMina()}
	}

	method verificarTotalDeMinas() {
		if (minasTotal > ancho * largo) {
			self.error("La cantidad de minas configurada supera el número total de celdas del tablero.")
		}
	}

	method ponerUnaMina() {
		const coordenadaAleatoria = listaDeCoordenadas.vacias().anyOne() // Una coordenada de celda aleatoria.
		self.ponerCeldaMinadaEn(coordenadaAleatoria)
		listaDeCoordenadas.agregarA(listaDeCoordenadas.minadas(), coordenadaAleatoria)
		listaDeCoordenadas.eliminarDe(listaDeCoordenadas.vacias(), coordenadaAleatoria)
	}

	method ponerCeldaMinadaEn(unaCoordenada) { // unaCoordenada = [Número, Número]
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(unaCoordenada.first(), unaCoordenada.last())))
		celdasDelTablero.last().insertarBomba()
	}

	method ponerNumeros() {
		listaDeCoordenadas.vacias().forEach({celda => self.ponerUnNumero()})
	}
	
	method ponerUnNumero() {
		const coordenadaAleatoria = listaDeCoordenadas.vacias().anyOne()
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(coordenadaAleatoria.first(), coordenadaAleatoria.last()), numero = self.minasAlrededorDe(coordenadaAleatoria)))
	}
	
	method hayMinaAl(unaCoordenada, direccion) { // unaCoordenada = [Número, Número], direccion = Direccion
		if (listaDeCoordenadas.minadas().contains(direccion.proximoDe(unaCoordenada))) {
			return 1
		} else {
			return 0
		}
	}

	method minasAlrededorDe(unaCoordenada) { // unaCoordenada = [Número, Número]
		return self.hayMinaAl(unaCoordenada, norte) + self.hayMinaAl(unaCoordenada, noreste) + self.hayMinaAl(unaCoordenada, este) + self.hayMinaAl(unaCoordenada, sureste) +
		self.hayMinaAl(unaCoordenada, sur) + self.hayMinaAl(unaCoordenada, suroeste) + self.hayMinaAl(unaCoordenada, oeste) + self.hayMinaAl(unaCoordenada, noroeste) 
	}
	
	method preparar() {
		self.ponerMinas()
		self.ponerNumeros()
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

