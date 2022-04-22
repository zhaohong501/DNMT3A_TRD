#!/bin/bash

#===========================================================
# Description: 
# 小分子配体准备，以及在tleap中与蛋白PDB combine生成参数
# 需要文件：小分子mol2，以及蛋白pdb
#===========================================================

function gaff_resp(){

	#pre protein
	awk '$1=="ATOM" || $1=="HETATM" || $1=="TER" || $1=="END"' 4u7t_min.pdb > 4u7t_min_clean1.pdb
	pdb4amber -i 4u7t_min_clean1.pdb -o 4u7t_min_clean2.pdb -y
		
	#pre ligand
	mn=SAH1     
	antechamber -i $mol2name -fi mol2 -o $mn.gjf -fo gcrt -ch "$mn.chk" 
	-gm  "%mem=4096MB" -gn "%nproc=12" -nc 1
	g09 $mn.gjf > $mn.logs
	antechamber -i $mn.log -fi gout -o $mn.resp.mol2 -fo mol2 -c resp -pf y
	parmchk -i $mn.resp.mol2 -f mol2 -o $mn.frcmod	

	mn=SAH2
	antechamber -i $mol2name -fi mol2 -o $mn.gjf -fo gcrt -ch "$mn.chk" 
	-gm  "%mem=4096MB" -gn "%nproc=12" -nc 1
	g09 $mn.gjf > $mn.log
	antechamber -i $mn.log -fi gout -o $mn.resp.mol2 -fo mol2 -c resp -pf y
	parmchk -i $mn.resp.mol2 -f mol2 -o $mn.frcmod


    cat << EOF > leap.cmd
		source leaprc.ff14SB
		source leaprc.water.tip3p
		source leaprc.gaff
                addAtomTypes { { "ZN" "Zn" "sp3" } { "S1" "S" "sp3" } }
                loadoff atomic_ions.lib
                loadamberprep /opt/amber/16/dat/mtkpp/ZAFF/201108/ZAFF.prep
                loadamberparams /opt/amber/16/dat/mtkpp/ZAFF/201108/ZAFF.frcmod
		set default pbradii mbondi2
                
                lig1 = loadmol2 SAH1.resp.mol2
                loadamberparams SAH1.frcmod
                saveoff lig SAH1.lib
                saveamberparm lig SAH1.leap.prmtop SAH1.leap.inpcrd
                savepdb lig SAH1.leap.pdb
                
                lig2 = loadmol2 SAH2.resp.mol2
                loadamberparams SAH2.frcmod
                saveoff lig SAH2.lib
                saveamberparm lig SAH2.leap.prmtop SAH2.leap.inpcrd
                savepdb lig SAH2.leap.pdb

                
                prot = loadpdb 4u7t_min_clean2.pdb
                bond prot.899.ZN prot.21.SG
                bond prot.899.ZN prot.24.SG
                bond prot.899.ZN prot.41.SG
                bond prot.899.ZN prot.44.SG
                bond prot.900.ZN prot.67.SG
                bond prot.900.ZN prot.86.SG
                bond prot.900.ZN prot.89.SG
                bond prot.900.ZN prot.64.SG
                bond prot.901.ZN prot.76.SG
                bond prot.901.ZN prot.81.SG
                bond prot.901.ZN prot.113.SG
                bond prot.901.ZN prot.110.SG
                bond prot.902.ZN prot.463.SG
                bond prot.902.ZN prot.480.SG
                bond prot.902.ZN prot.483.SG
                bond prot.902.ZN prot.460.SG
                bond prot.903.ZN prot.525.SG
                bond prot.903.ZN prot.503.SG
                bond prot.903.ZN prot.506.SG
                bond prot.903.ZN prot.528.SG
                bond prot.904.ZN prot.520.SG
                bond prot.904.ZN prot.549.SG
                bond prot.904.ZN prot.515.SG
                bond prot.904.ZN prot.552.SG
                saveamberparm prot prot.leap.prmtop prot.leap.inpcrd
                savepdb prot prot.leap.pdb
		
		complex = combine{prot lig1 lig2}
		saveamberparm complex complex.leap.prmtop complex.leap.inpcrd
		savepdb complex complex.leap.pdb
		
                addions2 complex Cl- 0
                addions2 complex Na+ 0
                charge complex
		solvatebox complex TIP3PBOX 10.0
		
		saveamberparm complex complex_solv.leap.prmtop complex_solv.leap.inpcrd
		savepdb complex complex_solv.leap.pdb
		quit
EOF
		tleap -f leap.cmd > ${mn}_tleap.log
	
}

gaff_resp
