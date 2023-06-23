import wollok.game.*
import cursor.*

class Celda {
	
	var estado = oculto
	const numero = 0
	var property position 
	var tieneBomba = false
	
	method estado(cambioDeEstado){
		estado = cambioDeEstado
	}
	
	method estado(){
		return estado
	}
	
	method image(){
		return(
			estado.image(self)
		)
	}
	
	method insertarBomba(){
		self.tieneBomba(true)
	}
	
//	method numero(_numero){
//		numero = _numero
//	}

	method numero() = numero
	
	method marcada(){
		estado =  marcada
	} 
	
	method revelar(){
		estado = revelado
	} 
	
	method tieneBomba(cambio){
		tieneBomba = cambio
	}
	
	method tieneBomba(){
		return tieneBomba
	}
	
}


class Bomba{
	
	method image(celda) = "minaExplotada.png"
	
}



class Estado{
	
	method image(celda)
}


object oculto inherits Estado{
	
	override method image(celda) = "celdaSinMarcar.png"
	

}
object revelado inherits Estado {
	
	override method image(celda) {
		return(
			if(celda.tieneBomba()){
				"minaExplotada.png"
			} else if (celda.numero() == 0) {
				"celdaReveladaSinBomba.png"
			} else if (celda.numero() == 1) {
				"numero1.png"
			} else if (celda.numero() == 2) {
				"numero2.png"
			} else if (celda.numero() == 3) {
				"numero3.png"
			} else if (celda.numero() == 4) {
				"numero4.png"
			} else if (celda.numero() == 5) {
				"numero5.png"
			} else if (celda.numero() == 6) {
				"numero6.png"
			} else if (celda.numero() == 7) {
				"numero7.png"
			} else {
				console.println("No tiene numero/Bomba" + celda.numero())
				"numero8.png"
				//self.error("No tiene numero/Bomba" + celda.numero() ) 
			}
		)
	}	
}

object marcada inherits Estado{
	
	override method image(celda) = "bandera.png"

}

