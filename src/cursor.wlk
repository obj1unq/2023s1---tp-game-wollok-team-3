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
		if(!game.uniqueCollider(self).estaMarcada()){ //Si NO esta marcada
			game.uniqueCollider(self).marcada()	//Poner Bandera
		}else{
			game.uniqueCollider(self).ocultar()	//Ocultar bandera
		}
		
	}
	/*
	method desmarcarCelda() {
		if (game.uniqueCollider(self).estaMarcada()) {
			game.uniqueCollider(self).ocultar()
		}
	}*/
	
	method revelar(){
		
	}
	
	
}