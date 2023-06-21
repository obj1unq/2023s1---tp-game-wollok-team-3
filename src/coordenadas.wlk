object coordenada {

	method posicionX(unaLista) = unaLista.first()

	method posicionY(unaLista) = unaLista.last()
	
	method desplazarHacia(unaLista, direccion) = direccion.desplazamientoXY(unaLista)

}

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
	
	method desplazamientoX(unaCoordenada) = coordenada.posicionX(unaCoordenada)
	
	method desplazamientoY(unaCoordenada) = coordenada.posicionY(unaCoordenada)
	
	method desplazamientoXY(unaCoordenada) = [ self.desplazamientoX(unaCoordenada), self.desplazamientoY(unaCoordenada) ]

}

object norte inherits Direccion {

	override method desplazamientoY(unaCoordenada) = super(unaCoordenada) + 1

}

object noreste inherits Direccion {

	override method desplazamientoX(unaCoordenada) = super(unaCoordenada) + 1
	
	override method desplazamientoY(unaCoordenada) = super(unaCoordenada) + 1

}

object este inherits Direccion {

	override method desplazamientoX(unaCoordenada) = super(unaCoordenada) + 1

}

object sureste inherits Direccion {

	override method desplazamientoX(unaCoordenada) = super(unaCoordenada) + 1
	
	override method desplazamientoY(unaCoordenada) = super(unaCoordenada) - 1

}

object sur inherits Direccion {
	
	override method desplazamientoY(unaCoordenada) = super(unaCoordenada) - 1

}

object suroeste inherits Direccion {

	override method desplazamientoX(unaCoordenada) = super(unaCoordenada) - 1
	
	override method desplazamientoY(unaCoordenada) = super(unaCoordenada) - 1

}

object oeste inherits Direccion {

	override method desplazamientoX(unaCoordenada) = super(unaCoordenada) - 1

}

object noroeste inherits Direccion {

	override method desplazamientoX(unaCoordenada) = super(unaCoordenada) - 1
	
	override method desplazamientoY(unaCoordenada) = super(unaCoordenada) + 1

}