vsim -gui -l msim_transcript work.InvMixColumns
# vsim -gui -l msim_transcript work.InvMixColumns 
# Start time: 20:44:49 on Apr 28,2023
# Loading work.InvMixColumns
add wave -position end  sim:/InvMixColumns/in
add wave -position end  sim:/InvMixColumns/out
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: islam  Hostname: LAPTOP-FUHKK385  ProcessID: 3040
#           Attempting to use alternate WLF file "./wlftz0gckq".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftz0gckq
force -freeze sim:/InvMixColumns/in 'hbd6e7c3df2b5779e0b61216e8b10b689 0
run
force -freeze sim:/InvMixColumns/in 'hfde3bad205e5d0d73547964ef1fe37f1 0
run