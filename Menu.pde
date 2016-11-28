//La clase menu es usada tanto para crear el menu principal como para crear el menu de instrucciones

class Menu {
  int posXopcion1, posYopcion1, tamXopcion1, tamYopcion1, backPosX, backPosY;
  String encabezado, opcion1, opcion2, destino1, destino2;
  boolean opcionActiva;
  PImage backgroundMenu;

  /*El constructor toma los siguientes parámetros: un String "encabezado" para el menu, dos String "opciones" para dibujar los rectangulos y el texto,
   dos String "destino" para designar a donde el juego debería "ir" tras clickear en cada rectangulo y un boolean que permite dibujar o no el primer rectangulo
   (porque no hacen falta dos rectangulos para las instrucciones, pero si el principal).
   */

  Menu (String encabezado, String opcion1, String opcion2, String destino1, String destino2, boolean opcionActiva) {

    //Se asignan los valores del constructor a las variables globales de la clase, para que luego estas últimas puedan modificarse en cada instancia creada de la clase.
    this.destino1 = destino1;
    this.destino2 = destino2;
    this.encabezado = encabezado;
    this.opcion1 = opcion1;
    this.opcion2 = opcion2;
    this.opcionActiva = opcionActiva;
    opcionActiva = true;

    backgroundMenu = loadImage("data/imagenes/menu.jpg");

    // La posicion en X del primer rectangulo sirve para dibujar el segundo también, porque su posición se calcula en base a la del primero. El tamaño es el mismo
    posXopcion1 = width/2;
    posYopcion1 = height/2;

    // Se define el tamaño de los rectangulos que sirven como "opciones".
    tamXopcion1 = 500;
    tamYopcion1 = 100;
  }

  void dibujarFondo() {

    // Se dibuja el fondo y se le da el doble de ancho, para que luego, al llegar este a cierto punto, se reinicie, dando la sensación de que es infinito.
    pushStyle();
    imageMode(CORNER);
    tint(#7BA9CB);
    image(backgroundMenu, backPosX, backPosY, width*2, height);
    popStyle();
    backPosX--;

    if (backPosX <= 0-width/2) 
      backPosX=backPosY=0;
  }


  void textoEncabezado(int divisorEncabezado) {

    pushStyle();
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(fuenteJuego);

    // Se emplea el tamaño en X de los rectangulos para calcular el tamaño del encabezado simplemente para que mantenga una relación de aspecto parcial con el resto de los elementos
    textSize(tamXopcion1/divisorEncabezado);

    text(encabezado, posXopcion1, 80);
    popStyle();
  }

  void textoInstrucciones() {

    // Con este método, se usa la función text para indicar que se dibujará cuando la "Etapa Actual" del juego sea la pantalla de instrucciones.

    pushStyle();

    textAlign(CENTER, CENTER);
    fill(360);
    textFont(fuenteJuego);

    textSize(tamXopcion1/20);
    text("El objetivo es controlar un auto que se encuentra en la posición\n inferior de la pantalla, moviendolo con las flechas\n IZQUIERDA y DERECHA, para esquivar una serie de autos. \nEl jugador cuenta con una barra de vida que decrecerá si se\n sale de la pista. El juego tiene dos niveles.", width/2, posYopcion1-50);

    popStyle();
  }

  void textoOpciones() {

    // Con este método, se determinan los textos que actuarán a modo de "opciones" en los objetos de la clase Menu creados.

    pushStyle();

    //Se emplea el modo CENTER para que el texto se centre en relación a los rectagulos
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(fuenteJuego);
    textSize(tamXopcion1/10);

    // El texto, al igual que el rectangulo sobre el que se dibujará, solo se dibujarán si esta variable boolean tiene true como valor.
    if (opcionActiva == true) {
      text(opcion1, posXopcion1, posYopcion1);
    }
    text(opcion2, posXopcion1, posYopcion1+150);

    popStyle();
  }


  void dibujarRect() {

    // Se dibujan los rectángulos que actúan a modo de "botones" para las "opciones".

    pushStyle();
    noFill();
    rectMode(CENTER);
    fill(360);
    if (opcionActiva == true) {
      rect(posXopcion1, posYopcion1+15, tamXopcion1, tamYopcion1);
    }
    rect(posXopcion1, posYopcion1+165, tamXopcion1, tamYopcion1);
    popStyle();
  }


  void presionarOpcion1() {

    //Se determina si el mouse esta en el rango del "primer botón", y a donde envía al jugador al clickear en él.

    if (mouseX>posXopcion1-250 && mouseX<posXopcion1 + 250 && mouseY>posYopcion1 - 45 && mouseY<posYopcion1 + 65) {

      pushStyle();
      strokeWeight(5);
      fill(360);
      rectMode(CENTER);
      rect(posXopcion1, posYopcion1+15, tamXopcion1, tamYopcion1);
      textoOpciones();
      popStyle();

      if (mousePressed) {
        juego.etapaActual=destino1;
      }
    }
  }

  void presionarOpcion2() {

    //Se determina si el mouse esta en el rango del "segundo botón", y a donde envía al jugador al clickear en él.

    if (mouseX > posXopcion1-250 && mouseX < posXopcion1 + 250 && mouseY > posYopcion1 + 115 && mouseY < posYopcion1 + 215) {

      pushStyle();
      strokeWeight(5);
      fill(360);
      rectMode(CENTER);
      rect(posXopcion1, posYopcion1+165, tamXopcion1, tamYopcion1);
      textoOpciones();
      popStyle();

      if (mousePressed) {
        juego.etapaActual=destino2;
      }
    }
  }

  void gameOver() {

    // La pantalla de "Game Over", a la que el jugador llega tanto si su "barra de vida" llega a 0, como si "choca" con algún auto.

    opcionActiva=false;
    juego.menuPrincipal.dibujarFondo();
    textAlign(CENTER, CENTER);
    fill(360);
    textFont(fuenteJuego);
    textSize(width/5);
    text("Perdiste", width/2, height/2-100);
    dibujarRect();
    textoOpciones();

    // Si se aprieta el mouse en el "botón de volver", entonces el objeto juego se vuelve a crear, y por ende, todo el juego se "reinicia".
    if (mouseX > posXopcion1-250 && mouseX < posXopcion1 + 250 && mouseY > posYopcion1 + 115 && mouseY < posYopcion1 + 215) {
      if (mousePressed) {
        juego = new Juego ();
      }
    }
  }

  void finDeJuego() {

    // Este método se da cuando el jugador cumple todos los niveles del juego.

    opcionActiva=false;
    juego.menuPrincipal.dibujarFondo();
    textAlign(CENTER, CENTER);
    fill(360);
    textFont(fuenteJuego);
    textSize(width/5);
    text("¡GANASTE!", width/2, height/2-100);
    dibujarRect();
    textoOpciones();

    // Si se aprieta el mouse en el "botón de volver", entonces el objeto juego se vuelve a crear, y por ende, todo el juego se "reinicia".
    if (mouseX > posXopcion1-250 && mouseX < posXopcion1 + 250 && mouseY > posYopcion1 + 115 && mouseY < posYopcion1 + 215) {
      if (mousePressed) {
        juego = new Juego ();
      }
    }
  }
}