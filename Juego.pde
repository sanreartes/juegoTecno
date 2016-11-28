// A partír de esta clase, se crean todos los otros objetos que el juego necesite.

class Juego {

  // Se crean los dos objetos de tipo Menu, para los dos estados distintos.
  Menu menuPrincipal;
  Menu menuInstrucciones;

  String etapaActual = "menu";

  Juego () {

    // Se cambia la fuente del juego simplemente por razones estéticas.
    fuenteJuego = createFont("data/Fuentes/OpenSans-Regular.ttf", 68);

    menuPrincipal = new Menu("RACECING", "Empezar Juego", "Instrucciones", "nivel1", "instrucciones", true);

    /*Al menu de instrucciones se le dan valores null tanto en el "primer rectángulo" como en su "destino", porque de todas formas
     nunca se dibujan por ser falso el último parámetro del constructor.
     */
    menuInstrucciones = new Menu("INSTRUCCIONES", null, "Volver", null, "menu", false);

    //Se crean los dos objetos que corresponden a los dos niveles, cada uno con su correspondiente cantidad de enemigos.
    nivel1 = new Nivel(nivel1, 3);
    nivel2 = new Nivel(nivel2, 7);
  }

  void etapas () {

    //Acá se van dando la sucesion de "if" que van transicionando al juego a través de las distíntas etapas.
    menuPrincipal.dibujarFondo();

    if 
      (etapaActual == "menu") {

      // Se dibujan los elementos que corresponden al menu principal
      menuPrincipal.dibujarRect();
      menuPrincipal.textoEncabezado(4);
      menuPrincipal.textoOpciones();
    } else if 

  (etapaActual == "instrucciones") {

  // Se dibujan los elementos que corresponden al menu de instrucciones
  menuInstrucciones.textoInstrucciones();
  menuInstrucciones.dibujarRect();
  menuInstrucciones.textoEncabezado(6);
  menuInstrucciones.textoOpciones();
} else if

  (etapaActual == "nivel1") {

  nivel1.dibujarFondo();
  nivel1.empezarNivel();
  nivel1.comprobarColision();
  nivel1.superarNivel("nivel2");
} else if

  (etapaActual == "nivel2") {
  nivel2.dibujarFondo();
  nivel2.empezarNivel();
  nivel2.comprobarColision();
  nivel2.superarNivel("finDeJuego");
} else if 

  (etapaActual == "gameOver") {
  menuInstrucciones.gameOver();
} else if

  (etapaActual == "finDeJuego") {
  menuInstrucciones.finDeJuego();
}
}

// Método para que el programa sepa qué hacer al clickear en cada "botón" de los respectivos menues.
void comprobarMouse() {
  if 
    (etapaActual == "menu") {
    menuPrincipal.presionarOpcion1();
    menuPrincipal.presionarOpcion2();
  } else if 
  (etapaActual == "instrucciones") {
  menuInstrucciones.presionarOpcion2();
}
}
}