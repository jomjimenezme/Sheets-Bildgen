/// \file    iothread.h
/// \author  Holger Arndt, Martin Galgon
/// \version 0.4
/// \date    11.11.2016

#ifndef IOTHREAD_H
#define IOTHREAD_H

#include <QApplication>
#include <QThread>
#include <QWaitCondition>
#include <QMutexLocker>

#include <iostream>

#include "maindraw.h"

/// Der Thread, der in der Kommandoshell läuft; verwendet Singleton-Pattern
class IOThread : public QThread
{
  Q_OBJECT

private:
  /// Die IOThread Instanz
  static IOThread* theInstance;

  /// Veranlasst die IOThread Instanz auf das schließen des Fensters zu warten
  void awaitWindowClose(unsigned time = UINT_MAX)
  {
    QWaitCondition closeWindow;
    QMutex mutex;
    QMutexLocker locker(&mutex);
    emit sigAllowClose(&closeWindow);
    if(time == UINT_MAX){
      std::cout << "Fenster schließen oder CTRL-C" << std::endl;
      closeWindow.wait(&mutex);
    }else{
      std::cout << "Fenster schließen oder CTRL-C, automatischer Abbruch nach " << time << " Sekunden" << std::endl;
      closeWindow.wait(&mutex, time * 1000L);
    }
  }

public:
  /// Schlafe für \p i Sekunden
  static void sleep(int i){ QThread::sleep(i); }
  /// Schlafe für \p i Milliosekunden
  static void msleep(int i){ QThread::msleep(i); }
  /// Schlafe für \p i Mikrosekunden
  static void usleep(int i){ QThread::usleep(i); }

  /// Veranlasst die IOThread Instanz auf das schließen des Fensters zu warten
  static void waitForWindow(unsigned time = UINT_MAX)
  {
    getInstance()->awaitWindowClose(time);
  }

  /// Gibt die IOThread Instanz zurück
  static IOThread* getInstance()
  {
    if (theInstance == nullptr)
      theInstance = new IOThread;
    return theInstance;
  }

protected:
  /// Ruft die Methode maindraw auf
  virtual void run() override { maindraw(); }

signals:
  /// Signalisiert dem Fenster das manuelle Schließen zuzulassen
  void sigAllowClose(QWaitCondition* closeWindow);

};

#endif
