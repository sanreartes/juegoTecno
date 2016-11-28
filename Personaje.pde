// Se crea una clase Personaje, para que luego tanto la clase Jugador como la clase Enemigo, hereden sus variables iniciales.

class Personaje {
  int posX, posY, ancho, alto;

  Personaje () {
    ancho=100;
    alto=500;
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------


class Jugador extends Personaje {
  PImage imagenJugador;
  int posXMov, posXIzquierdaAbs, posXDerechaAbs, posXVida, posYVida, vidaTotal;
  boolean izquierdaActivado, derechaActivado;

  Jugador() {
    posX=width/2+40;
    posY=height-175;
    pushStyle();
    imagenJugador = loadImage("data/Imagenes/imagenJugador.png");
    popStyle();
    posXMov=180;
    posXIzquierdaAbs = width/2 - 320;
    posXDerechaAbs = width/2 + 220;
    izquierdaActivado = true;
    derechaActivado = true;
    posXVida = 20;
    posYVida = 20;
    vidaTotal = 150;
  }

  void dibujar() {

    imageMode(CORNER);
    image(imagenJugador, posX, posY, ancho, alto);
  }

  void vida() {

    // Se dibuja un rectángulo rojo que representa la "vida" del jugador, y otro negro debajo para que funcione a modo de indicador acerca de cuanta vida lleva perdida el jugador.
    fill(0);
    rect(posXVida, posYVida, 150, 30);
    fill(0, 100, 100);
    rect(posXVida, posYVida, vidaTotal, 30);

    if (this.posX == posXIzquierdaAbs || this.posX ==  posXDerechaAbs) {
      vidaTotal--;
    }

    if (vidaTotal == 0) {
      juego.etapaActual = "gameOver";
    }
  }

  void mover() {

    // Se comprueba que el "auto" se encuentre en una de las dos posiciones en las cuales podría moverse en ambas direcciones.
    if (this.posX == width/2+40 || this.posX == width/2-180) {
      izquierdaActivado = true;
      derechaActivado = true;
    }

    // Se "mueve" al "auto" solo si se encuentra en una de las posiciones designadas.
    if (keyPressed) {
      if (keyCode == LEFT && izquierdaActivado) {
        this.posX-=posXMov;
        if (this.posX == posXIzquierdaAbs) {
          izquierdaActivado = false;
        }
      } else if (keyCode == RIGHT && derechaActivado) {
        this.posX+=posXMov;
        if (this.posX == posXDerechaAbs) {
          derechaActivado = false;
        }
      }
    }
  }
}


//-----------------------------------------------------------------------------------------------------------------------------------------------


class Enemigo extends Personaje {
  PImage imagenEnemigo;
  int posicionXAzar, dist;

  Enemigo() {
    int posicionXAzar =  int(random(0, 2));
    if (posicionXAzar == 0) {
      posX=width/2+40;
    } else {
      posX=(width/2+40)-180;
    }
    posY=-350;
    imagenEnemigo = loadImage("data/Imagenes/imagenEnemigo.png");
  }

  void dibujar(int dist) {
    this.dist = dist * 350;
    imageMode(CORNER);
    image(imagenEnemigo, posX, posY-this.dist, ancho, alto);
  }


  void mover(int posY) {
    this.posY+=posY;
    posY++;
  }
}