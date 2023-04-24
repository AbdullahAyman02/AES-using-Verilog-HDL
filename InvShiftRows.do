vsim work.InvShiftRows
# vsim work.InvShiftRows 
# Start time: 23:11:05 on Apr 24,2023
# Loading work.InvShiftRows
add wave -position insertpoint  \
sim:/InvShiftRows/w0_curr \
sim:/InvShiftRows/w1_curr \
sim:/InvShiftRows/w2_curr \
sim:/InvShiftRows/w3_curr \
sim:/InvShiftRows/w0_next \
sim:/InvShiftRows/w1_next \
sim:/InvShiftRows/w2_next \
sim:/InvShiftRows/w3_next
force -freeze sim:/InvShiftRows/w0_curr 'h7ad5fda7 0
force -freeze sim:/InvShiftRows/w1_curr 'h89ef4e27 0
force -freeze sim:/InvShiftRows/w2_curr 'h2bca100b 0
force -freeze sim:/InvShiftRows/w3_curr 'h3d9ff59f 0
run
force -freeze sim:/InvShiftRows/w0_curr 'h12684543 0
force -freeze sim:/InvShiftRows/w1_curr 'h24322678 0
force -freeze sim:/InvShiftRows/w2_curr 'h96375657 0
force -freeze sim:/InvShiftRows/w3_curr 'h18341311 0
run