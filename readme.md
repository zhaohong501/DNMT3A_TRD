------------------------------------------------------------------------------------------------------------------------------------
Structural view on the role of TRD loop in regulating DNMT3A activity: a molecular dynamics study: Datasets and Supplementary Materials
------------------------------------------------------------------------------------------------------------------------------------              

Contact information:       Hong Zhao, Zhejiang University,
                           21919061@zju.edu.cn

Associated publication:

Link to publication:

-------------------------------------------------------------------------------------------------------------

This parameter file or data contained in each folder and their description are described next

  ---------------------------------------------------------------------
  Documentation for the MD folder
  ---------------------------------------------------------------------

    This folder contains parameter settings of conventional MD simulations

    The role of files are stated as follows:

    01_min_solv.in         System optimization 
    02_min_sidechain.in
    03_min_all.in         
    04_heat_100ps.in       System heating up
    05_equil_100ps.in      Balance system
    06_prod_200ns.in       Molecular dynamics simulation	
    MDtleapzaff.sh         Establish the initial structure of protein and ligand     
    runmd.sh               Run the entire MD simulation


  ---------------------------------------------------------------
  Documentation for the US folder
  ---------------------------------------------------------------

    This folder contains parameter settings of umbrella sampling simulations 

    The role of files are stated as follows:

    genwindow.sh           Training parameters required for each window
    genqsub.sh             Run the entire US simulation
    gencpptraj.sh.         Integrate the trajectory of each window
    genwhamin.sh           Integrate the dat of each window
    run_wham.sh            calculate the PMF


  ----------------------------------------------------------
  Documentation for the Results folder
  ----------------------------------------------------------
 
    This folder contains the raw data of the studied systems in this paper. 
    
    
  ------------------------------------------------------------------
  The reported crystal structures
  ------------------------------------------------------------------
    4u7p_min.pdb           Three crystal structures were prepared by the Protein Preparation Wizard
    4u7t_min.pdb           in Schrödinger
    5yx2_min.pdb

*************************************************************************************************************
