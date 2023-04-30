vsim -gui -l msim_transcript work.MixColumns
# vsim -gui -l msim_transcript work.MixColumns 
# Start time: 19:14:56 on Apr 28,2023
# Loading work.MixColumns
add wave -position end  sim:/MixColumns/in
add wave -position end  sim:/MixColumns/out
force -freeze sim:/MixColumns/in 'h6353e08c0960e104cd70b751bacad0e7 0
run
force -freeze sim:/MixColumns/in 'ha7be1a6997ad739bd8c9ca451f618b61 0
run