vsim work.ShiftRows
# vsim work.ShiftRows 
# Start time: 22:54:43 on Apr 24,2023
# Loading work.ShiftRows
add wave -position insertpoint  \
sim:/ShiftRows/w0_curr \
sim:/ShiftRows/w1_curr \
sim:/ShiftRows/w2_curr \
sim:/ShiftRows/w3_curr \
sim:/ShiftRows/w0_next \
sim:/ShiftRows/w1_next \
sim:/ShiftRows/w2_next \
sim:/ShiftRows/w3_next
force -freeze sim:/ShiftRows/w0_curr 'h7a9f1027 0
force -freeze sim:/ShiftRows/w1_curr 'h89d5f50b 0
force -freeze sim:/ShiftRows/w2_curr 'h2beffd9f 0
force -freeze sim:/ShiftRows/w3_curr 'h3dca4ea7 0
run
force -freeze sim:/ShiftRows/w0_curr 'h12345678 0
force -freeze sim:/ShiftRows/w1_curr 'h24681357 0
force -freeze sim:/ShiftRows/w2_curr 'h96324511 0
force -freeze sim:/ShiftRows/w3_curr 'h18372643 0
run