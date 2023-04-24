vsim -gui -l msim_transcript work.InvSubBytes
# vsim -gui -l msim_transcript work.InvSubBytes 
# Start time: 15:38:00 on Apr 24,2023
# Loading work.InvSubBytes
# Loading work.InvSBox
add wave -position end  sim:/InvSubBytes/inv_w0_curr
add wave -position end  sim:/InvSubBytes/inv_w1_curr
add wave -position end  sim:/InvSubBytes/inv_w2_curr
add wave -position end  sim:/InvSubBytes/inv_w3_curr
add wave -position end  sim:/InvSubBytes/inv_w0_next
add wave -position end  sim:/InvSubBytes/inv_w1_next
add wave -position end  sim:/InvSubBytes/inv_w2_next
add wave -position end  sim:/InvSubBytes/inv_w3_next
add wave -position end  sim:/InvSubBytes/Inv_State_curr
add wave -position end  sim:/InvSubBytes/Inv_State_next
force -freeze sim:/InvSubBytes/inv_w0_curr 'h7a9f1027 000
force -freeze sim:/InvSubBytes/inv_w1_curr 'h89d5f50b 000
force -freeze sim:/InvSubBytes/inv_w2_curr 'h2beffd9f 000
force -freeze sim:/InvSubBytes/inv_w3_curr 'h3dca4ea7 000
force -freeze sim:/InvSubBytes/inv_w0_curr 'h5411f4b5 010
force -freeze sim:/InvSubBytes/inv_w1_curr 'h6bd9700e 010
force -freeze sim:/InvSubBytes/inv_w2_curr 'h96a0902f 010
force -freeze sim:/InvSubBytes/inv_w3_curr 'ha1bb9aa1 010
force -freeze sim:/InvSubBytes/inv_w0_curr 'h3e175076 020
force -freeze sim:/InvSubBytes/inv_w1_curr 'hb61c0467 020
force -freeze sim:/InvSubBytes/inv_w2_curr 'h8dfc2295 020
force -freeze sim:/InvSubBytes/inv_w3_curr 'hf6a8bfc0 020
force -freeze sim:/InvSubBytes/inv_w0_curr 'hb415f801 030
force -freeze sim:/InvSubBytes/inv_w1_curr 'h6858552e 030
force -freeze sim:/InvSubBytes/inv_w2_curr 'h4bb6124c 030
force -freeze sim:/InvSubBytes/inv_w3_curr 'h5f998a4c 030
run 40 ps