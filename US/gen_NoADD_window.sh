function gen_input(){
subjob=$1
#restraintmask=$2
#atompair=$3
initdistance=$2

if [ ! -d $subjob ]
then
    mkdir $subjob
fi

for i in $(seq -w 00 39)
do
cat << EOF >$subjob/window-$i.in
Umbrella sampling, 50ns of md production
 &cntrl
  imin = 0, nmropt = 1, irest = 1, ntx = 5,
  nstlim = 25000000, dt = 0.002,
  ntc = 2, ntf = 2,
  cut = 8.0, ntb = 2, ntp = 1, taup = 2.0,
  ntpr = 5000, ntwx = 5000,ntwx=1000,
  ntt = 3, gamma_ln = 2.0, ig = -1,
  temp0 = 300.0,
  ntr = 1, restraint_wt = 5, restraintmask = ' :774 | :2169',
  iwrap = 1, ioutfm = 1, 
 &end
 &wt
  type='DUMPFREQ', istep1=10,
 &end
 &wt
  type='END',
 &end
DISANG=window-$i.disang
DUMPAVE=window-$i-01.dat
EOF

cat << EOF >$subjob/window-$i.disang
Harmonic restraints for $initdistance angstrom
 &rst iat = 1413, 3402,
 r1=0,r2=$initdistance,r3=$initdistance, r4=60.000, rk2 = 20, rk3 = 20,
 &end
EOF

initdistance=`echo $initdistance + 0.5 | bc`


done
}

gen_input 50ns-20kj 32.7
