#!/bin/bash

for i in $(seq -w 00 39)
do 
 echo trajin ./window-$i-01.mdcrd >> cpptraj.in
done
cat  << EOF >> cpptraj.in 
center mass origin
image origin center

strip :WAT
strip :Na+
strip :Cl-
trajout window-00-39_nobox.mdcrd offset 10 nobox
EOF
cpptraj -i cpptraj.in -p complex_solv.leap.prmtop > cpptraj.log
