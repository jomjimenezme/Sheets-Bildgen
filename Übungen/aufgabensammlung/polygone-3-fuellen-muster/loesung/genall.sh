#!/bin/bash
for i in ../material/*.in
do
    echo $i
    b=`basename $i .in`
    polygmuster < $i
    cp -f polygmuster.png polygmuster_$b.png
done
