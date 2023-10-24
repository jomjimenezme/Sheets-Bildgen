#!/bin/bash

########################################################################
#
# Erzeugt Aufgabenlisten aus einem gegebenen Verzeichnis.
# Aufgaben mit Namen "muster" (Gross-/Kleinschreibung egal) werden
#   ignoriert.
#
########################################################################

# There are some special variables that a pre-defined for you whenever a
# shell script is running.
#
#   $0   --   $0 is the name of the currently running script, as 
#             specified to the system. If you run the script with 
#             "./script", then $0 will be "./script". If you run the 
#             script with "/home/joeblow/bin/script", then $0 will be 
#             "/home/joeblow/bin/script".
#
#   $#   --   The number of arguments that were given to the script.
#
#   $*   --   All of the arguments together, but be careful, because you
#             lose quoting (see below).
#
#   $1   --   $n is the nth argument, and is undefined if there was no
#    .        nth argument. The shift command moves every argument "down
#    .        a notch". $2 becomes $1, $3 becomes $2, $4 becomes $3, etc.
#    .        (The value of the previous $1 is discarded).
#   $9
#
#   $$   --   The PID of the script. Often used to assign unique 
#             temporary filenames.
#
#   $?   --   The exit value of the last command run from the script.

usage(){
	echo "Usage: $0 path outfile"
	echo " "
	echo "Erzeugt eine Liste von Aufgaben aus dem angegeben Pfad."
	exit 0
}

# Main

if (test $# -eq 1) then
	touch $1
	if (test -w $1) then
		echo "Ausgabedatei $1 okay."
	else
		echo "Kann nicht in $1 schreiben."
		exit 1
	fi
else
	usage
fi

echo "% Automatisch generierte Liste." > $1

# Folder-list always sorted? Else try:            for X in `ls -v $1/*`;
for X in *; do 
	if (test -d $X) then
		if (test -f $X/content.tex) then
			echo "\\phantomsection\\addcontentsline{toc}{section}{$X}%" >> $1
			echo "\\bivinclude{$X}" >> $1
		fi
	fi
done

echo "Done."
