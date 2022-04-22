#!/bin/bash
source /opt/cuda/cuda-env.sh
export CUDA_VISIBLE_DEVICES=1
mpirun -np 12 pmemd.MPI -O -i 01_min_solv.in -o 01_min_solvent.out -c complex_solv.leap.inpcrd -p complex_solv.leap.prmtop -r 01_min_solvent.rst -ref complex_solv.leap.inpcrd
mpirun -np 12 pmemd.MPI -O -i 02_min_sidechain.in -o 02_min_sidechain.out -p complex_solv.leap.prmtop -c 01_min_solvent.rst -r 02_min_sidechain.rst -ref 01_min_solvent.rst 
mpirun -np 12 pmemd.MPI -O -i 03_min_all.in -o 03_min_all.out -p complex_solv.leap.prmtop -c 02_min_sidechain.rst -r 03_min_all.rst -ref 02_min_sidechain.rst 
mpirun -np 12 pmemd.MPI -O -i 04_heat_100ps.in -o 04_heat_100ps.out -c 03_min_all.rst -p complex_solv.leap.prmtop -r 04_heat_100ps.rst -x 04_heat_100ps.nc -ref 03_min_all.rst
mpirun -np 12 pmemd.MPI -O -i 05_equil_100ps.in -o 05_equil_100ps.out -c 04_heat_100ps.rst -p complex_solv.leap.prmtop -r 05_equil_100ps.rst -x 05_equil_100ps.nc -ref 04_heat_100ps.rst
pmemd.cuda -O -i 06_prod_1000ns.in -o 06_prod_1000ns.out -c 05_equil_100ps.rst -p complex_solv.leap.prmtop -r 06_prod_1000ns.rst -x 06_prod_1000ns.nc -ref 05_equil_100ps.rst
