import wollok.game.*

class Tablero {

	const ancho = null // Número.
	const largo = null // Número.
	const minasTotal = null // Número. Depende del nivel.
	const celdasVacias = []
	const celdasConMinas = []

	method ponerCeldas() {
		(ancho * largo).times{ n => self.ponerUnaCelda()}
	}

	method ponerUnaCelda() {
		const xRandom = (0.randomUpTo(ancho - 1)).truncate(0)
		const yRandom = (0.randomUpTo(largo - 1)).truncate(0)
		if (not celdasVacias.contains([ xRandom, yRandom ])) {
			// new Celda(conMina = false, position = game.at(xRandom, yRandom)...)
			celdasVacias.add([ xRandom, yRandom ])
		} else {
			self.ponerUnaCelda()
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
		const celdaAleatoria = celdasVacias.anyOne() // Una coordenada de celda aleatoria.
			// new Celda(conMina = true, position = game.at(celda.first(), celda.last())...)
		celdasConMinas.add(celdaAleatoria)
		celdasVacias.remove(celdaAleatoria)
	}

	/* method ponerNumeros() {
	 * 		celdasVacias.forEach({...}) // Se pretende que cada elemento de 'celdasVacias' actúe en funcion de la lista 'celdasConMinas'
	 */
	method validarTablero() {
		if (game.width() < ancho or game.height() < largo) {
			self.error("El ancho y/o largo configurados de Wollok Game no satisface los requisitos del tablero.")
		}
	}

	method preparar() {
		self.validarTablero()
		self.ponerCeldas()
		self.ponerMinas()
	// self.ponerNumeros()
	}

}

