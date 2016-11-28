
class Nivel {

  // Variables iniciales que incluyen dos imagenes que compondrían un "fondo", el jugador, la serie de enemigos, la variable que determina su cantidad y las posiciones del fondo.

  PImage background, backgroundLinea;
  Jugador jugador;
  Enemigo enemigo [];
  int cantEnemigos, backPosX, backPosY;

  // El constructor determina el nivel en el que está el jugador y la cantidad de enemigos que tiene este.

  Nivel(Nivel nivelActual, int cantEnemigos) {
    background = loadImage ("data/Imagenes/background.png");
    backgroundLinea = loadImage ("data/Imagenes/backgroundLinea.png");
    backPosY=0;
    jugador = new Jugador();
    this.cantEnemigos = cantEnemigos;
    enemigo = new Enemigo [cantEnemigos];

    //Se inicializa al arreglo de "enemigos".

    for (int i=0; i<cantEnemigos; i++) {
      enemigo[i] = new Enemigo ();
    }
  }

  void empezarNivel() {
    jugador.dibujar();
    jugador.vida();

    for (int i=0; i<cantEnemigos; i++) {
      enemigo[i].dibujar(i);
      enemigo[i].mover(5);
    }
  }

  void moverJugador() {

    // Permite al jugador moverse de izquierda a derecha (a menos que se encuentre en los bordes de la pantalla).

    jugador.mover();
  }

  void dibujarFondo() {

    // Se dibuja el fondo recursivo que corresponde a los niveles del juego.

    image(background, 0, 0, width, height*2);
    pushStyle();
    imageMode(CENTER);
    image(backgroundLinea, width/2, backPosY, 20, height*2);
    popStyle();
    backPosY+=5;
    if (backPosY>=height-height/2) {
      backPosY=0;
    }
  }

  void comprobarColision() {

    // Se comprueba que no colisionen los "autos"; en caso de hacerlo, el jugador pierde y es enviado a la pantalla de "Game Over".

    for (int i=0; i<cantEnemigos; i++) {
      if (enemigo[i].posX < jugador.posX + jugador.ancho &&
        enemigo[i].posX + enemigo[i].ancho > jugador.posX &&
        enemigo[i].posY - enemigo[i].dist < jugador.posY + jugador.alto &&
        enemigo[i].posY - enemigo[i].dist + enemigo[i].alto > jugador.posY)
      {
        juego.etapaActual = "gameOver";
      }
    }
  }

  void superarNivel(String siguienteEtapa) {

    /* Se determina que si el último auto de la serie supera el rango de visión del jugador (que correspondería a el hecho de si el jugador logro superar el nivel),
     entonces el jugador es enviado a la siguiente etapa que corresponda del juego. */

    if ((enemigo[cantEnemigos-1].posY - enemigo[cantEnemigos-1].dist) - 10 > height)
    {
      juego.etapaActual = siguienteEtapa;
    }
  }
}