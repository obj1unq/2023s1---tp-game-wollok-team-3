import wollok.game.*
import menu_inicio.*
import celda.*
import tablero.*

object cursor {
	
	var property position = game.center()
	
	//method position() = game.center()
	
	method image() = "cursor.png"
	

	method revelarCelda(tablero){
		
		//Siempre colisiono con una celda en mi posicion
		game.uniqueCollider(self).revelar()
		juego.victoria(tablero)

		
	}

	method marcarCelda(){
		
		// Siempre colisiono con una celda en mi posicion
		game.uniqueCollider(self).marcada()
		// Falta poder desmarcar con la misma letra m la celda	
	}
	
	method desmarcarCelda() {
		if (game.uniqueCollider(self).estaMarcada()) {
			game.uniqueCollider(self).ocultar()
		}
	}
	
	method revelar(){
		
	}
	
	
}