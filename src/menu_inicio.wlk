import wollok.game.*
import tablero.*


object menuInicio {
	
	const property position = game.at(0, 0)
	
	method image(){
		
		if(dificultad.nivel() == facil){
			return "assets/Menu_Facil.jpg"
		}else if(dificultad.nivel() == medio){
			return "assets/Menu_Medio.jpg"
		}else{
			return "assets/Menu_Dificil.jpg"
		}
		
	}
	
	method iniciarMenu(){
	

		game.addVisual(self)
		
		//Selecciona una opcion de dificultad
		keyboard.num1().onPressDo({ dificultad.facil()})
		keyboard.num2().onPressDo({ dificultad.medio()})
		keyboard.num3().onPressDo({ dificultad.dificil()})
		
		//Iniciar el juego
		keyboard.enter().onPressDo({juego.configurar(dificultad.nivel())}) 
			
	}
	
}//end_menuInicio
	

object dificultad {
	

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


object facil{
	
}
object medio{
	
}
object dificil{
	
}



