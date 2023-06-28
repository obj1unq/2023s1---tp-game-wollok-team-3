import wollok.game.*
import cursor.*
import coordenadas.*
import menu_inicio.*

class Celda {
	
	var estado = oculto
	var property position 
	var contenido = vacia
	
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
		contenido = bomba
	}
	
	method tieneBomba() {
		return contenido == bomba
	}
	
	method marcada(){
		estado =  marcada
	} 
	
	method estaMarcada() {
		return estado == marcada
	}
	
	method revelar() {
		estado.revelar(self)
	}
	
	method estaRevelada() {
		return estado == revelado
	}
	
	method ocultar() {
		self.estado(oculto)
	}
	
	method contenido(){
		return contenido
	}
	
	method revelarVecinos(){
		self.vecinos().forEach({celda => celda.revelar()})
	}
	
	method vecinos(){
		const posiciones = [
			game.at(self.position().x() - 1, self.position().y()),
			game.at(self.position().x() - 1, self.position().y() - 1),
			game.at(self.position().x() - 1, self.position().y() + 1),
			game.at(self.position().x() + 1, self.position().y()),
			game.at(self.position().x() + 1, self.position().y() - 1),
			game.at(self.position().x() + 1, self.position().y() + 1),
			game.at(self.position().x() , self.position().y() - 1),
			game.at(self.position().x() , self.position().y() + 1)
		]
		
		return posiciones.filter({posicion => nivelDificultad.contiene(posicion)}).flatMap({posicion => game.getObjectsIn(posicion)})
	}
	


}


object bomba{
	
	method image() = "minaExplotada.png"
	
	method revelar(celda){
		game.say(cursor, "Perdiste")
		game.onTick(5000, "Cerrar", { => game.stop()})
	}
}


class Numero{
	var numero = 0
	
	method image() = "numero" + numero + ".png"
	
	method revelar(celda){
		
	}
}

object vacia{
	
	method image() = "celdaReveladaSinBomba.png"
	
	method revelar(celda){
		celda.revelarVecinos()
	}
	
}


class Estado{
	
	method image(celda)
	
	method revelar(celda){
		
	}
	
}


object oculto inherits Estado{
	
	override method image(celda) = "celdaSinMarcar.png"
	
	override method revelar(celda){
		celda.estado(revelado)
		celda.contenido().revelar(celda)
	}

}

object revelado inherits Estado {
	
	override method image(celda) {
		return(
			celda.contenido().image()
		)
	}	
}

object marcada inherits Estado{
	
	override method image(celda) = "bandera.png"

}

