#!/bin/bash
rm *.cmp *.ppf *.v *.vhd *.bsf
echo
echo =============================== Running FFT IP Simulation ===============================
echo
vsim -nolog -c -do "do sim_top.tcl"