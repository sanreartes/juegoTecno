
void setup() {

  // Se cambia el modo de color a HSB porque proporcióna más control (aunque el juego en sí no requiere un manejo complejo del color).
  colorMode(HSB, 360, 100, 100);

  // Se cambia el modo de renderizado a P2D para aprovechar la aceleración por hardware.
  size(800, 740, P2D);  

  // Se crea un objeto de la clase "Juego" que es la que maneja a todas las demas clases.
  juego = new Juego ();
}

void draw() {

  // Se inicializa el método "etapas" del objeto juego, para que el juego comience.
  juego.etapas();
}

void keyPressed() {

  // Se emplea el método moverJugador en void keyPressed para que con cada presión de los botones "izquierda" o "derecha", solo se mueva de a un "espacio" a la vez.
  nivel1.moverJugador();
  nivel2.moverJugador();
}

void mousePressed() {

  // Se emplean los siguientes métodos en void mousePressed para que el programa diferencie bien entre cada click del mouse.
  juego.comprobarMouse();
}