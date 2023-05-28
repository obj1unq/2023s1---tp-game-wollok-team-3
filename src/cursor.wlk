import wollok.game.*

object cursor {
	
	var property position = game.center()
	
	//method position() = game.center()
	
	method image() = "cursor.png"
	

	method revelarCelda(){
		
		//Siempre colisiono con una celda en mi posicion
		game.uniqueCollider(self).revelar()

		
	}

	method marcarCelda(){
		
		//Siempre colisiono con una celda en mi posicion
		game.uniqueCollider(self).marcada()

		
	}
	
	
	
}