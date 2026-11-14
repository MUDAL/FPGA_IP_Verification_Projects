@echo off
cd ..
mkdir build
cd build
quartus_sh -t ../scripts/create_project.tcl
quartus fft_top.qpf