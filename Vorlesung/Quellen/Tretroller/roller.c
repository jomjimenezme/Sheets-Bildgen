// Tretroller in OpenGL
// Autor:   Bruno Lang, Holger Arndt
// Version: 25.10.2019

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include <GL/gl.h>      // Open Graphics Library (OpenGL) header
#include <GL/glut.h>    // The GL Utility Toolkit (GLUT) header

const int BILD_BREITE = 800;
const int BILD_HOEHE = 600;
const char* BILD_TITEL = "Vorlesung Bildgenerierung: Tretroller";
const int SICHTFELD_WINKEL = 45;
const float Z_NEAR = 1.0f;
const float Z_FAR = 500.0f;

double minuten = 0.0;
int anzeige = 0;

// eine Speiche und ein dazu gehöriges Stück des Reifens zeichnen
void zeichneSpeicheReifen(void)
{
  // für die Speiche die Farbe auf Blau setzen
  // (Beiträge an Rot, Grün, Blau)
  glColor3f(0.0, 0.0, 1.0);

  // alte Transformationsmatrix sichern
  glPushMatrix();
  // aus einem Einheitswürfel [-0,5; 0,5]³ durch
  // Skalierung eine Speiche erzeugen und danach(!)
  // verschieben, so dass sie im Ursprung anliegt
  glTranslated(0.0, 0.5, 0.0);
  glScaled(0.02, 1.0, 0.02);
  glutSolidCube(1.0);
  // alte Transformation wiederherstellen
  glPopMatrix();

  // analog für grünes Stück Reifen
  glColor3f(0.0, 1.0, 0.0);
  glPushMatrix();
  glTranslated(0.0, 1.00, 0.00);
  glScaled(0.3, 0.15, 0.1);
  glutSolidCube(1.0);
  glPopMatrix();
}

// ein aus anzahl_speichen bestehendes Rad zeichnen
void zeichneRad(int anzahlSpeichen)
{
  glPushMatrix();

  // das Rad aus anzahlSpeichen Speichen zusammensetzen
  // (jeweils um 360 / anzahlSpeichen Grad WEITERdrehen)
  for (int k = 0; k < anzahlSpeichen; k++)
    {
      glRotated(360.0 / anzahlSpeichen, 0.0, 0.0, 1.0);
      zeichneSpeicheReifen();
    }

  glPopMatrix();
}

// Die aus Vordergabel, vertikaler Stange und horizontaler
// Lenkerstange bestehende Lenkergruppe zeichnen
void zeichneLenkergruppe(void)
{
  // Vorderrad zeichnen
  glPushMatrix();
  glScaled(0.6, 0.6, 1.8);
  zeichneRad(16);
  glPopMatrix();

  // roten Rahmen dazu zeichnen
  glColor3f(1.0, 0.0, 0.0);

  // linke Strebe der Radgabel
  glPushMatrix();
  glTranslated(0.0, 0.35, -0.2);
  glScaled(0.1, 0.8, 0.05);
  glutSolidCube(1.0);
  glPopMatrix();

  // vier weitere Quader für rechte und horizontale Strebe
  // der Gabel, vertikale Stange und Lenkerstange

  // …
  glPushMatrix();
  glTranslated(0.0, 0.35, 0.2);
  glScaled(0.1, 0.8, 0.05);
  glutSolidCube(1.0);
  glPopMatrix();

  glPushMatrix();
  glTranslated(0.0, 0.8, 0.0);
  glScaled(0.1, 0.1, 0.4);
  glutSolidCube(1.0);
  glPopMatrix();

  glPushMatrix();
  glTranslated(0.0, 1.65, 0.0);
  glScaled(0.1, 1.6, 0.1);
  glutSolidCube(1.0);
  glPopMatrix();

  glPushMatrix();
  glTranslated(0.0, 2.45, 0.0);
  glScaled(0.1, 0.1, 1.4);
  glutSolidCube(1.0);
  glPopMatrix();
}

// Den kompletten Tretroller zeichnen; dabei die Lenkergruppe
// und das Hinterrad je nach verstrichener Zeit (angegeben in
// minuten) drehen.
void zeichneRoller(double minuten)
{
  // gedrehte Lenkergruppe zeichnen
  glPushMatrix();
  glRotated(minuten * -0.2, 0.0, 1.0, 0.0);
  zeichneLenkergruppe();
  glPopMatrix();

  // Trittbrett zeichnen
  glPushMatrix();
  glTranslated(1.8, 0.0, 0.0);
  glScaled(2.0, 0.1, 0.4);
  glutSolidCube(1.0);
  glPopMatrix();

  // vier weitere Quader für Befestigung an Lenkergruppe
  // und Hinterradgabel zeichnen

  // …
  glPushMatrix();
  glTranslated(0.4, 1.0, 0.0);
  glScaled(0.8, 0.1, 0.1);
  glutSolidCube(1.0);
  glPopMatrix();

  glPushMatrix();
  glTranslated(0.8, 0.5, 0.0);
  glScaled( 0.1, 1.0, 0.1 ) ;
  glutSolidCube( 1.0 ) ;
  glPopMatrix() ;

  glPushMatrix() ;
  glTranslated(3.2, 0.0, -0.2);
  glScaled(0.8, 0.1, 0.05);
  glutSolidCube(1.0);
  glPopMatrix();

  glPushMatrix();
  glTranslated(3.2, 0.0, 0.2);
  glScaled(0.8, 0.1, 0.05);
  glutSolidCube(1.0);
  glPopMatrix();

  // gedrehtes Hinterrad zeichnen
  glPushMatrix();
  glTranslated(3.65, 0.0, 0.0);
  glRotated(minuten * -1.0, 0.0, 0.0, 1.0);
  glScaled(0.6, 0.6, 1.2);
  zeichneRad(32);
  glPopMatrix();
}

void display()
{
  double t;

  // Bildschirm und Tiefenpuffer löschen
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  // Transformationsmatrix zurücksetzen
  glLoadIdentity();

  // Projektion durch 3D Augenpunkt, 3D Zielpunkt und
  // 3D Aufwärtsrichtung festlegen
  if (anzeige == 5)
    {
      t = minuten * 0.005;
      gluLookAt(8 * sin(t), -2 * sin(t), 5 * cos(t), 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0);
      zeichneRoller(minuten);
    }
  else
    {
      gluLookAt(0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
      switch (anzeige)
        {
          case 1: zeichneSpeicheReifen(); break;
          case 2: zeichneRad(24); break ;
          case 3:
            glPushMatrix();
            glRotated(45.0, 0.0, 1.0, 0.0);
            zeichneLenkergruppe();
            glPopMatrix();
            break;
          case 4: zeichneRoller(minuten); break;
        }
    }

  // Zeit weiterzählen
  minuten++;

  // anderen Puffer zum Zeichnen vorbereiten
  glutSwapBuffers();
}

void initialize()
{
  // select projection matrix
  glMatrixMode(GL_PROJECTION);
  // set the viewport
  glViewport(0, 0, BILD_BREITE, BILD_HOEHE);
  // reset projection matrix
  glLoadIdentity();
  GLfloat aspect = (GLfloat)BILD_BREITE / BILD_HOEHE;
  // set up a perspective projection matrix
  gluPerspective(SICHTFELD_WINKEL, aspect, Z_NEAR, Z_FAR);
  // specify which matrix is the current matrix
  glMatrixMode(GL_MODELVIEW);

  glShadeModel(GL_SMOOTH);

  // specify the clear value for the depth buffer
  glClearDepth(1.0f);
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LEQUAL);

  // specify implementation-specific hints
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);

  GLfloat amb_light[] = { 0.1, 0.1, 0.1, 1.0 };
  GLfloat diffuse[] = { 0.6, 0.6, 0.6, 1 };
  GLfloat specular[] = { 0.7, 0.7, 0.3, 1 };
  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, amb_light);
  glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
  glLightfv(GL_LIGHT0, GL_SPECULAR, specular);
  glEnable(GL_LIGHT0);
  glEnable(GL_COLOR_MATERIAL);
  glShadeModel(GL_SMOOTH);
  glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, GL_FALSE);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glClearColor(0.0, 0.0, 0.0, 1.0);
}

// Reaktion auf Tastatureingaben festlegen
void keyboard (unsigned char key, int mousePositionX, int mousePositionY)
{
  if (key == 'q')
    exit(0);
}

int main(int argc, char** argv)
{
  printf("Anzeige wählen:\n");
  printf("  1 : Speiche\n");
  printf("  2 : Rad\n");
  printf("  3 : Lenkergruppe\n");
  printf("  4 : Roller\n");
  printf("  5 : Bewegung\n");
  printf("Ihre Wahl: ");
  scanf("%d", &anzeige);

  // GLUT initialisieren
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
  // Fenster öffnen
  glutInitWindowSize(BILD_BREITE, BILD_HOEHE);
  glutCreateWindow(BILD_TITEL);
  // obige Funktion display() als Display Function und
  // Idle Function, keyboard() als Keyboard handler registrieren
  glutDisplayFunc(display);
  glutIdleFunc(display);
  glutKeyboardFunc(keyboard);
  // obige Funktion initialize() setzt diverse Parameter
  initialize();

  // run GLUT mainloop
  glutMainLoop();
}
