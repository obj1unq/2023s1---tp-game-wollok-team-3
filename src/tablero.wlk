import celda.*
import coordenadas.*
import wollok.game.*
import menu_inicio.*
import cursor.*



class Tablero {

	const ancho 	 // = 0 // Número
	const largo 	 // = 0 // Número
	const minasTotal // = 0 // Número
	const celdasDelTablero = [] // [Celda]

	method ancho() = ancho

	method largo() = largo

	method celdasDelTablero() = celdasDelTablero

	method prepararCeldasEn(unaLista) {
		self.verificarUnicoElementoEn(unaLista) // Verificación
		((ancho * largo) - 1).times{ n => self.prepararUnaCeldaEn(unaLista)} // Las coordenadas esperadas en total menos la coordenada [ 0, 0 ]
	}

	method prepararUnaCeldaEn(unaLista) {
		const ultimaCoordenada = unaLista.vacias().last() // Toma la última coordenada en esa lista. Para la primera ejecución espera el elemento [ 0, 0 ]
		var nuevaCoordenadaX = coordenada.posicionX(ultimaCoordenada) // La coordenada X de la constante
		var nuevaCoordenadaY = coordenada.posicionY(ultimaCoordenada) // La coordenada Y de la constante
		if (not self.estaEnBordeY(nuevaCoordenadaY)) { // Pregunta si la coordenada Y no está en el borde
			nuevaCoordenadaY += 1 // Entonces suma 1 a la coordenada Y
		} else {
			nuevaCoordenadaX += 1 // Si está en el borde, suma 1 a la coordenada X nueva
			nuevaCoordenadaY = 0 // "Reinicia" la coordenada Y
		}
		unaLista.agregarA(unaLista.vacias(), [ nuevaCoordenadaX, nuevaCoordenadaY ]) // Agrega esa nueva coordenada a la lista. De repetirse este method, esta coordenada se convierte en la última
	}

	method verificarUnicoElementoEn(unaLista) {
		if (unaLista.vacias() != [ [0, 0] ]) { // Solamente espera que contenga ese único elemento
			self.error("La lista utilizada no contiene el elemento esperado o contiene más de un elemento.")
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
		const coordenadaAleatoria = unaLista.vacias().anyOne() // Pide una coordenada cualquiera
		self.ponerUnaCeldaMinadaEn(coordenadaAleatoria)
		unaLista.agregarA(unaLista.minadas(), coordenadaAleatoria) // Agrega esta coordenada para ser utilizada en el futuro
		unaLista.eliminarDe(unaLista.vacias(), coordenadaAleatoria) // Elimina esta coordenada de la lista para prevenir que se vuelva a elegir
	}

	method ponerUnaCeldaMinadaEn(unaCoordenada) {
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(coordenada.posicionX(unaCoordenada), coordenada.posicionY(unaCoordenada)))) // Añade una nueva celda a la lista
		celdasDelTablero.last().insertarBomba() // Inserta una mina en esta
	}

	method ponerNumerosCon(unaLista) {
		unaLista.vacias().forEach({ celda => self.ponerUnNumeroCon(unaLista)})
	}

	method ponerUnNumeroCon(unaLista) {
		const coordenadaAleatoria = unaLista.vacias().anyOne()
		celdasDelTablero.add(new Celda(estado = oculto, position = game.at(coordenada.posicionX(coordenadaAleatoria), coordenada.posicionY(coordenadaAleatoria)), numero = self.minasAlrededorDe(coordenadaAleatoria)))
		unaLista.eliminarDe(unaLista.vacias(), coordenadaAleatoria)
	}

	method hayMinaAl(unaCoordenada, direccion, unaLista) = if (unaLista.minadas().contains(coordenada.desplazarHacia(unaCoordenada, direccion))) 1 else 0

	method minasAlrededorDe(unaCoordenada, unaLista) = self.hayMinaAl(unaCoordenada, norte, unaLista) + self.hayMinaAl(unaCoordenada, noreste, unaLista) + self.hayMinaAl(unaCoordenada, este, unaLista) + self.hayMinaAl(unaCoordenada, sureste, unaLista) + self.hayMinaAl(unaCoordenada, sur, unaLista) + self.hayMinaAl(unaCoordenada, suroeste, unaLista) + self.hayMinaAl(unaCoordenada, oeste, unaLista) + self.hayMinaAl(unaCoordenada, noroeste, unaLista)

	method prepararCon(unaLista) {
		self.prepararCeldasEn(unaLista)
		self.prepararMinasEn(unaLista)
		self.ponerNumerosCon(unaLista)
	}

}

object juego {

	//Ya se define las dimensiones en juego.wpgm
	/*
	method ajustarDimensiones() {
		game.width(30)
		game.height(20)
	}*/

	method configurar(nivelTablero, unaLista) {
		//self.ajustarDimensiones()
		
		//1ro - Borramos el menu
		game.removeVisual(menuInicio)
		
		//2do - Seteamos y dibujamos el tablero
		nivelTablero.prepararCon(unaLista)
		nivelTablero.celdasDelTablero().forEach({ celda => game.addVisual(celda)})
		
		//3ro - Añadimos el cursor al final
		game.addVisualCharacter(cursor)
	}

}

