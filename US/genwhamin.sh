#!/bin/base
#cp ../*dat ./
initvar=13.2
for i in ./window-*.dat
do 
 echo $i $initvar 32.7 >> wham.in
 initvar=`echo $initvar + 0.5 | bc`
done
