vsim -gui -l msim_transcript work.SubBytes
# vsim -gui -l msim_transcript work.SubBytes 
# Start time: 16:09:50 on Apr 24,2023
# Loading work.SubBytes
# Loading work.SBox
add wave -position end  sim:/SubBytes/w0_curr
add wave -position end  sim:/SubBytes/w1_curr
add wave -position end  sim:/SubBytes/w2_curr
add wave -position end  sim:/SubBytes/w3_curr
add wave -position end  sim:/SubBytes/w0_next
add wave -position end  sim:/SubBytes/w1_next
add wave -position end  sim:/SubBytes/w2_next
add wave -position end  sim:/SubBytes/w3_next
add wave -position end  sim:/SubBytes/State_curr
add wave -position end  sim:/SubBytes/State_next
force -freeze sim:/SubBytes/w0_curr 'h00102030 000
force -freeze sim:/SubBytes/w1_curr 'h40506070 000
force -freeze sim:/SubBytes/w2_curr 'h8090a0b0 000
force -freeze sim:/SubBytes/w3_curr 'hc0d0e0f0 000
force -freeze sim:/SubBytes/w0_curr 'h4f637606 010
force -freeze sim:/SubBytes/w1_curr 'h43e0aa85 010
force -freeze sim:/SubBytes/w2_curr 'haff8c9d0 010
force -freeze sim:/SubBytes/w3_curr 'h41fa0de4 010
force -freeze sim:/SubBytes/w0_curr 'hcb02818c 020
force -freeze sim:/SubBytes/w1_curr 'h17d2af9c 020
force -freeze sim:/SubBytes/w2_curr 'h62aa6442 020
force -freeze sim:/SubBytes/w3_curr 'h8bb25fd7 020
force -freeze sim:/SubBytes/w0_curr 'hf75c7778 030
force -freeze sim:/SubBytes/w1_curr 'ha327c8ed 030
force -freeze sim:/SubBytes/w2_curr 'h8cfebfc1 030
force -freeze sim:/SubBytes/w3_curr 'ha6c37f53 030
run 40 ps