# FFT IP Core Verification
Custom verification of the Altera FFT IP Core.

## Requirements
- Linux or Windows machine   
- Quartus  (v18.1 and v25.1 tested)   
- ModelSim (v20.1 tested)   
- Python (SciPy and NumPy must be installed)   

## Video Demo

[FFT IP Verification: Demo](https://drive.google.com/file/d/1ZvP60REn9MFPzRUoFLkTNAwQMamZ1G7b/view?usp=sharing)  

## A. Project file structure
```
.
├── README.md
├── ip
│   └── fft_ip.qsys             # Platform Designer FFT IP config file 
├── scripts                     # Scripts to generate Quartus project
│   ├── create_project.bat
│   ├── create_project.sh
│   └── create_project.tcl
└── tb
    ├── fft_ip_tb_top.sv
    ├── golden_model
    │   └── testvectors_gen.py
    ├── sim_top.bat
    ├── sim_top.sh
    └── sim_top.tcl
```

## B. Generating the Quartus project

Use the following commands.
### 1. Linux  
```
cd scripts
source create_project.sh 
```

### 2. Windows (PowerShell)  
```
cd scripts
cmd /c create_project.bat 
```

## C. Generating the testbench system

In order to generate the testbench system (HDL files, BFMs, and Tcl scripts), refer to the [P1_FFT_instructions](../docs/P1_FFT_instructions.pdf) document.    

## D. Running the testbench

Use the following commands.
### 1. Linux  
```
cd tb
source sim_top.sh
```

### 2. Windows (PowerShell)  
```
cd tb
cmd /c sim_top.bat
```
