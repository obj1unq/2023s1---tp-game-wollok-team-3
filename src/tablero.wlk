import wollok.game.*

class Tablero {

	const ancho = null // game.width()
	const largo = null // game.height()
	const minasTotal = null // Número
	// Se llenan despues de usar tablero.preparar()
	const celdasDelTablero = [] // Contiene Celdas (CeldaVacia, CeldaMinada, CeldaNumerada)

	method ponerCeldas() {
		(ancho * largo).times{ n => self.ponerUnaCelda()}
	}

	method ponerUnaCelda() {
		const xRandom = (0.randomUpTo(ancho - 1)).truncate(0)
		const yRandom = (0.randomUpTo(largo - 1)).truncate(0)
		if (not coordenadas.vacias().contains([ xRandom, yRandom ])) {
			// self.ponerCeldaEn(xRandom, yRandom)
			coordenadas.agregarAVacias([ xRandom, yRandom ])
		} else {
			self.ponerUnaCelda()
		}
	}

	method ponerCeldaVaciaEn(x, y) {
	// celdasDelTablero.add(new Celda(conMina = false, estado = oculto, position = game.at(x, y)))
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
		const coordenadaAleatoria = coordenadas.vacias().anyOne() // Una coordenada de celda aleatoria.
			// self.ponerMinaEn(coordenadaAleatoria.first(), coordenadaAleatoria.last()))
		coordenadas.agregarAMinadas(coordenadaAleatoria)
		coordenadas.eliminarDeVacias(coordenadaAleatoria)
	}

	method ponerCeldaMinadaEn(x, y) {
	// celdasDelTablero.add(new Celda(conMina = true, estado = oculto, position = game.at(x, y)))
	}

	method ponerNumerosEn(coordenadaVacia) {
		coordenadas.vacias().forEach({celda => self.ponerNumeroEnCelda(coordenadaVacia)})
	}
	
	method ponerNumeroEnCelda(coordenada) {
	// celdasDelTablero.add(new Celda(conMina = false, estado = oculto, position = game.at(x, y), numero = self.minasAlrededorDe(x, y)))
	}

	method minasAlrededorDe(coordenada) {
	// return hayMinaAl(
	}

	method hayMinaAl(coordenada, direccion) = return if (coordenadas.minadas().contains(direccion.proximoDe(coordenada))) 1 else 0

}

object coordenadas {

	const vacias = []
	const minadas = []

	method vacias() {
		return vacias
	}

	method agregarAVacias(coordenada) {
		vacias.add(coordenada)
	}

	method eliminarDeVacias(coordenada) {
		self.existeLaCoordenadaEn(coordenada, vacias)
		vacias.remove(coordenada)
	}

	method minadas() {
		return minadas
	}

	method agregarAMinadas(coordenada) {
		minadas.add(coordenada)
	}

	method eliminarDeMinadas(coordenada) {
		self.existeLaCoordenadaEn(coordenada, minadas)
		minadas.remove(coordenada)
	}

	method existeLaCoordenadaEn(coordenada, lista) {
		if (not lista.contains(coordenada)) {
			self.error("¡La coordenada solicitada no existe!")
		}
	}

}

object coordenada {

	const x = null // Número
	const y = null // Número

	method x() {
		return x
	}

	method y() {
		return y
	}

	method coordenadaCompleta() {
		return [ x, y ]
	}

}

class Direccion {

	method proximoDe(coordenada)

}

object norte inherits Direccion {

	override method proximoDe(coordenada) {
		return [ coordenada.x(), coordenada.y() + 1 ]
	}

}

object noreste inherits Direccion {

	override method proximoDe(coordenada) {
		return [ coordenada.x() + 1, coordenada.y() + 1 ]
	}

}

object este inherits Direccion {

	override method proximoDe(coordenada) {
		return [ coordenada.x() + 1, coordenada.y() ]
	}

}

object sureste inherits Direccion {

	override method proximoDe(coordenada) {
		return [ coordenada.x() + 1, coordenada.y() - 1 ]
	}

}

object sur inherits Direccion {

	override method proximoDe(coordenada) {
		return [ coordenada.x(), coordenada.y() - 1 ]
	}

}

object suroeste inherits Direccion {

	override method proximoDe(coordenada) {
		return [ coordenada.x() - 1, coordenada.y() - 1 ]
	}

}

object noroeste inherits Direccion {

	override method proximoDe(coordenada) {
		return [ coordenada.x() - 1, coordenada.y() + 1 ]
	}

}

object juego {

	method configurar(nivelTablero) {
		nivelTablero.preparar()
		nivelTablero.celdasDelTablero().forEach({ celda => game.addVisual(celda)})
	}

}

