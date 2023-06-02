object listaDeCoordenadas {

	const vacias = [[0, 0]]
	const minadas = []
	
	method vacias() {
		return vacias
	}
	
	method minadas() {
		return minadas
	}

	method agregarA(lista, unaCoordenada) {
		lista.add(unaCoordenada)
	}
	
	method eliminarDe(lista, unaCoordenada) {
		self.existeLaCoordenadaEn(unaCoordenada, lista)
		lista.remove(unaCoordenada)
	}

	method existeLaCoordenadaEn(coordenada, lista) {
		if (not lista.contains(coordenada)) {
			self.error("¡La coordenada solicitada no existe!")
		}
	}

}

class Direccion {
	
	method proximoDe(unaCoordenada) // unaCoordenada = [Número, Número] 
	// Los elementos representan a las coordenadas x e y respectivamente.

}

object norte inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first(), unaCoordenada.last() + 1 ]
	}

}

object noreste inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first() + 1, unaCoordenada.last() + 1 ]
	}

}

object este inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first() + 1, unaCoordenada.last() ]
	}

}

object sureste inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first() + 1, unaCoordenada.last() - 1 ]
	}

}

object sur inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first(), unaCoordenada.last() - 1 ]
	}

}

object suroeste inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first() - 1, unaCoordenada.last() - 1 ]
	}

}

object oeste inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first() - 1, unaCoordenada.last() ]
	}

}

object noroeste inherits Direccion {

	override method proximoDe(unaCoordenada) {
		return [ unaCoordenada.first() - 1, unaCoordenada.last() + 1 ]
	}

}