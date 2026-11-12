@echo off
echo:
echo =============================== Running FFT IP Simulation ===============================
echo:
vsim -nolog -c -do "do sim_top.tcl"