vsim -gui -l msim_transcript work.MixColumns
# vsim -gui -l msim_transcript work.MixColumns 
# Start time: 19:14:56 on Apr 28,2023
# Loading work.MixColumns
add wave -position end  sim:/MixColumns/in
add wave -position end  sim:/MixColumns/out
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: islam  Hostname: LAPTOP-FUHKK385  ProcessID: 3040
#           Attempting to use alternate WLF file "./wlftfyscfe".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftfyscfe
force -freeze sim:/MixColumns/in 'h6353e08c0960e104cd70b751bacad0e7 0
run
force -freeze sim:/MixColumns/in 'ha7be1a6997ad739bd8c9ca451f618b61 0
run