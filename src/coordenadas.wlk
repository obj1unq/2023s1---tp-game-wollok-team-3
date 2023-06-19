object listaDeCoordenadas {

	const vacias = [[0, 0]]
	const minadas = []
	
	method vacias() = vacias
	
	method minadas() = minadas

	method agregarA(lista, unaCoordenada) {
		lista.add(unaCoordenada)
	}
	
	method eliminarDe(lista, unaCoordenada) {
		self.existeLaCoordenadaEn(unaCoordenada, lista)
		lista.remove(unaCoordenada)
	}

	method existeLaCoordenadaEn(unaCoordenada, lista) {
		if (not lista.contains(unaCoordenada)) {
			self.error("¡La coordenada solicitada no existe!")
		}
	}

}

class Direccion {
	
	method coordenadaXDe(unaCoordenada) = unaCoordenada.first()
	
	method coordenadaYDe(unaCoordenada) = unaCoordenada.last()
	
	method proximoDe(unaCoordenada) = [ self.coordenadaXDe(unaCoordenada), self.coordenadaYDe(unaCoordenada) ] // unaCoordenada = [Número, Número] 
	// Los elementos representan a las coordenadas x e y respectivamente.

}

object norte inherits Direccion {

	override method coordenadaYDe(unaCoordenada) = super(unaCoordenada) + 1

}

object noreste inherits Direccion {

	override method coordenadaXDe(unaCoordenada) = super(unaCoordenada) + 1
	
	override method coordenadaYDe(unaCoordenada) = super(unaCoordenada) + 1

}

object este inherits Direccion {

	override method coordenadaXDe(unaCoordenada) = super(unaCoordenada) + 1

}

object sureste inherits Direccion {

	override method coordenadaXDe(unaCoordenada) = super(unaCoordenada) + 1
	
	override method coordenadaYDe(unaCoordenada) = super(unaCoordenada) - 1

}

object sur inherits Direccion {
	
	override method coordenadaYDe(unaCoordenada) = super(unaCoordenada) - 1

}

object suroeste inherits Direccion {

	override method coordenadaXDe(unaCoordenada) = super(unaCoordenada) - 1
	
	override method coordenadaYDe(unaCoordenada) = super(unaCoordenada) - 1

}

object oeste inherits Direccion {

	override method coordenadaXDe(unaCoordenada) = super(unaCoordenada) - 1

}

object noroeste inherits Direccion {

	override method coordenadaXDe(unaCoordenada) = super(unaCoordenada) - 1
	
	override method coordenadaYDe(unaCoordenada) = super(unaCoordenada) + 1

}