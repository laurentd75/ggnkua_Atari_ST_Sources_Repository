#
#       DEMO-SHELLSCRIPT ZUR PROGRAMMIERUNG DER OKAMI-SHELL
#
# showpic: Anzeige von Screenformat-Bildern (>=32000 Bytes)
# @(#) showpic.sh von wr 2.6.-23.11.90


# Anmelden als Applikation, notwendig f�r fsel
gon 2>NULL:

# Einstellung der Shellflags sichern
SAVESET=`set -`

# "echo $REST" bewirkt R�ckkehr zur gespeicherten Cursor-Position und
# Abw�rts-L�schen des Bildschirms.
REST=^033k^033j^033J^c

# Dateinamen in Kleinbuchstaben ausgeben
set +l

# Endlosschleife, wird mit break verlassen
while true
do
  cls
  # den Cursor abschalten (wird durch cls eingeschaltet)
  cursor -v
  echo ************ Anzeige von Screenformat-Bildern ******************
  # aktuelle Cursorposition sichern
  echo ^033j^c
  echo $REST
  echo Bitte w�hlen Sie die Bilddatei aus.
  NAME=`fsel .\*.PI? . X "Welche Datei anzeigen?"`

  # Test auf "Abbruch"
  if [ $X = 0 ]
  then
    break
  fi

  # nur anzeigen, wenn die Datei existiert  
  if [ -f $NAME ]
  then
    extname $NAME | read X
    # OFFSET := L�nge des Datei-Headers ermitteln
    if [ $X = .pic ]
    then
      # Doodle
      OFFEST=0
    else
      if [ $X = .pi3 ]
      then
        # Degas
        OFFSET=34
      else
        # sonstwas, vom Anwender eingeben lassen
        echo Bitte geben Sie die L�nge des Headers der Datei ein:
        echo (0 f�r Doodle, 34 f�r Degas-PI3)
        cursor +v
        read OFFSET
        cursor -v
        # hat er wirklich etwas eingegeben?
        if [ -v OFFSET ]
          OFFSET=0
        fi
      fi
    fi

    echo $REST
    echo ^nNach dem Bild bitte ENTER dr�cken.

    # Bild laden...
    getscr -$OFFSET $NAME
    # und anzeigen
    putscr
    # warten auf ENTER
    read

    # Speicherbereich des Bildes freigeben
    putscr -f
  else # Die Datei gab es nicht
    echo ? Diese Datei existiert nicht.
  fi
done

# den Cursor wieder sichtbar machen
cursor +v

# Shell-Flags wiederherstellen
set $SAVESET

# Benutzte Shellvariablen freigeben
unset SAVESET OFFSET NAME REST X
