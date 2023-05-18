import wollok.game.*

object cursor {
	
	var property position = game.center()
	
	//method position() = game.center()
	
	method image() = "cursor.png"
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)	
	}	

	method revelarCeldaEn(posicion){
		
		//TODO:
		// Aca deberia conectar con la celda en la posicion actual del cursor
		// y cambiarle el estado? 
		
	}

}