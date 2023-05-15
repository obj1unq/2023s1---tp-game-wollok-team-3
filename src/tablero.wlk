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
	// self.ponerNumeros()
	}

	method verificarTotalDeMinas() {
		if (minasTotal > ancho * largo) {
			self.error("La cantidad de minas configurada supera el número total de celdas del tablero.")
		}
	}

	method ponerUnaMina() {
		const xRandom = (0.randomUpTo(ancho - 1)).truncate(0)
		const yRandom = (0.randomUpTo(largo - 1)).truncate(0)
		if (not celdasConMinas.contains([ xRandom, yRandom ])) {
			// celdasVacias.remove([ xRandom, yRandom ])
			// new Celda(conMina = true, position = game.at(xRandom, yRandom)...)
			celdasConMinas.add([ xRandom, yRandom ])
		} else {
			self.ponerUnaMina()
		}
	}

/* method ponerNumeros() {
 * 		celdasVacias.forEach({...})
 */
 
	method preparar() {
		self.ponerCeldas()
		self.ponerMinas()
		// self.ponerNumeros()
	}
}

