# VALIDATE ADCP
Author: Mariangel Garcia (mariangel.garcia@tecnico.ulisboa.pt)
2018/10/15
Tool to validate ADCP with MOHID: The aiming of this tool is to save some team reading and postprocessing data and been able to do some statistic while validating the Mohid with ADCP. 
It will requiere some kndolodge of Matlab to adapat to you needs.
WARNING: This is not a production tool, this is more a research oriented tool to explore the data and compare with MOHID output. 

    1. Please donwload the demo data here:
    https://ulisboa-my.sharepoint.com/:f:/r/personal/ist428189_tecnico_ulisboa_pt/Documents/dataMatlab?csf=1&e=1wDo7d
    
    2. Copy the data to the ./data directory 
    
    3. Open the validateADCP_demo.mlx or validateADCP_demo.m
 
 Just look aroud all the script, it is self explained, try to run it with the demo data first and after that, feel free to adjust your plots for what is better for you.
    
INPUT DEMO FILES: 
mohid_file: Hydrodynamic.hdf5 (Mohid Hydro File)
ADCP      : SANE_000.000in    (ADCP bin file)
Atmosphere: windADPC2009.csv  (Athmosphere Data)

It use this toolbox to read ADCP in Binary format: https://www.eoas.ubc.ca/~rich/#RDADCP
It is already in the src/download so not need to downloaded again. But if you want to learn how the ADCP is read into matlab please follow this link.

TO DO LIST:
- ADD support to read ADCP from .txt file
- ADD support to read Vertical Profile from MOHId Time Series Data.
- ADD Support for Salinity and Temperature

Comments and improvement please email me: mariangel.garcia@tecnico.ulisboa.pt