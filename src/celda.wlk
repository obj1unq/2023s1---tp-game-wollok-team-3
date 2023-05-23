import wollok.game.*
import cursor.*

class Celda {
	
	var estado = oculto
	
	
	method estado(cambioDeEstado){
		estado = cambioDeEstado
	}
	
	method estado(){
		return estado
	}
	
	method image(){
		return(
			estado.image()
		)
	}
	
	method insertarBomba(){
		estado.tieneBomba(true)
	}
	
}

class Bomba{
	
	method image() = "bomba.png"
	
}


object oculto{
	
	var tieneBomba = false
	
	method image() = "celdaOculta.png"
	
	method tieneBomba(cambio){
		tieneBomba = !tieneBomba
	}
	
	method tieneBomba(){
		return tieneBomba
	}
}

object revelado{
	
	var tieneBomba = false
	
	method image() {
		return(
			if(tieneBomba){
				"bomba.png"
			} else{
				"celdaReveladaVacia.png"
			}
		)
	}	

	method tieneBomba(cambio){
		tieneBomba = !tieneBomba
	}

	method tieneBomba(){
		return tieneBomba
	}
}

object marcada{
	
	var tieneBomba = false
	
	method image() = "celdaMarcada.png"
	
	method tieneBomba(cambio){
		tieneBomba = !tieneBomba
	}
	
	method tieneBomba(){
		return tieneBomba
	}
}

