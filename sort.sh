#!/bin/bash
sort -u lista.dat > lista.dat.
mv lista.dat. lista.dat
grep -v '.* => .*[^ ]' lista.dat && exit 1
awk 'BEGIN {FS=" => "}
     elozo == $1 {print "kétszer van: ", $1; exit 2}
     $1 == $2 {print "wtf?", $0}
     {elozo = $1}' lista.dat || exit 2
exit 0

