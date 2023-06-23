import wollok.game.*
import tablero.*
import coordenadas.*

object menuInicio {
	
	const property position = game.at(0, 0)
	
	method image(){
		
		return nivelDificultad.nivel().image()
		
	}
	
	method iniciarMenu(){
	

		game.addVisual(self)
		
		//Selecciona una opcion de dificultad
		keyboard.num1().onPressDo({ nivelDificultad.facil()})
		keyboard.num2().onPressDo({ nivelDificultad.medio()})
		keyboard.num3().onPressDo({ nivelDificultad.dificil()})
		
		//Iniciar el juego
		keyboard.enter().onPressDo({juego.configurar(nivelDificultad.nivel().tablero(), listaDeCoordenadas)}) 
			
	}
	
}//end_menuInicio
	

object nivelDificultad {
	

	var property nivel = medio
	
	method facil() {
		
		nivel = facil
		
	}

	method medio() {
		
		nivel = medio
		
	}

	method dificil() {
	
		nivel = dificil
		
	}
}

class Dificultad{
	
	const nroMinas
	const property tablero = new Tablero(minasTotal = nroMinas, ancho = 10, largo = 10)
}

object facil inherits Dificultad(nroMinas = 10){
	
	method image() = "assets/Menu_Facil.jpg"
	
	
	
}
object medio inherits Dificultad(nroMinas = 15){
	
	method image() = "assets/Menu_Medio.jpg"
	
	
}
object dificil inherits Dificultad(nroMinas = 20){
	
	method image() = "assets/Menu_Dificil.jpg"
	
}



