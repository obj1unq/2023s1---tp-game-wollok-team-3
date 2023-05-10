import wollok.game.*
import cursor.*

class Celda {
	
	var estado = oculto
	
	method image() = "celda.png"
	
	method revelar(){
		estado = revelado
	}
	
	method marcada(){
		estado = marcada
	}
	
}

object oculto{
	
}

object revelado{
	
}

object marcada{
	
}

class Bomba{
	
	var estado = oculto
	
}