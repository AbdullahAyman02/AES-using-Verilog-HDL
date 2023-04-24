vsim work.ShiftRows
# vsim work.ShiftRows 
# Start time: 01:43:02 on Apr 24,2023
# Loading work.ShiftRows
add wave -position insertpoint  \
sim:/ShiftRows/S0in \
sim:/ShiftRows/S1in \
sim:/ShiftRows/S2in \
sim:/ShiftRows/S3in \
sim:/ShiftRows/S0out \
sim:/ShiftRows/S1out \
sim:/ShiftRows/S2out \
sim:/ShiftRows/S3out
force -freeze sim:/ShiftRows/S0in 'h12345678 0
force -freeze sim:/ShiftRows/S1in 'h24681357 0
force -freeze sim:/ShiftRows/S2in 'h96324511 0
force -freeze sim:/ShiftRows/S3in 'h18372643 0