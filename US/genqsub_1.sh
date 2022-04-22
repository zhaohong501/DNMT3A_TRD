function run_us_md(){
prmtop=$1
restrt=$2

cat << EOF > window-00.lsf
#!/bin/bash
#PBS -N run_us_md
#PBS -l nodes=ltl-gpu02:ppn=1:gpus=1
#PBS -l walltime=2000:00:00
#PBS -q batch
#PBS -S /bin/bash
cd $(pwd)
export CUDA_VISIBLE_DEVICES=0
pmemd.cuda -O -i window-00.in -o window-00-01.out -p $prmtop -c $restrt  -r window-00-01.rst -x window-00-01.mdcrd -ref $restrt -inf window-00-01.info
ambpdb -p $prmtop -c window-00-01.rst > window-00-01.pdb
EOF

for i in $(seq -w 1 39)
do
j=`echo $i - 1 | bc | awk '{printf("%02d\n",$0)}'`
cat << EOF > window-$i.lsf
pmemd.cuda -O -i window-$i.in -o window-$i-01.out -p $prmtop -c window-$j-01.rst -r window-$i-01.rst -x window-$i-01.mdcrd -ref $restrt -inf window-$i-01.info
ambpdb -p $prmtop -c window-$i-01.rst > window-$i-01.pdb
EOF

done

ls | cat *.lsf>>qsub_us.pbs
}

run_us_md complex_solv.leap.prmtop 06_equil_100ps.rst
