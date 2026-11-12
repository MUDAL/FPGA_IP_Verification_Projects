# # Author: Olaoluwa Raji
# # Date:   12/11/2026
# # Top-level simulation script based on the msim_setup.tcl instructions.

echo "==================== GENERATING TESTVECTORS FOR FFT IP SIMULATION ===================="
# # Execute Python script to generate testvectors.
cd golden_model
if {$tcl_platform(os) eq "Windows NT"} {
    exec python testvectors_gen.py
} else {
    exec python3 testvectors_gen.py
}
echo "==================== TESTVECTOR GENERATION COMPLETED ===================="

# # Dump all simulation artefacts in the build directory. 
cd ..
file mkdir build
cd build

# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project.
set QSYS_SIMDIR ../testbench/

# # Source the generated IP simulation script.
source $QSYS_SIMDIR/mentor/msim_setup.tcl

# # Call command to compile the Quartus EDA simulation library.
dev_com

# # Call command to compile the Quartus-generated IP simulation files.
com

# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
vlog -sv ../fft_ip_tb_top.sv

# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
set TOP_LEVEL_NAME fft_ip_tb_top

# # Call command to elaborate your design and testbench.
elab

# # Run the simulation.
run -a