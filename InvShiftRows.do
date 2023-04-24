vsim work.InvShiftRows
# vsim work.InvShiftRows 
# Start time: 01:43:02 on Apr 24,2023
# Loading work.InvShiftRows
add wave -position insertpoint  \
sim:/InvShiftRows/S0in \
sim:/InvShiftRows/S1in \
sim:/InvShiftRows/S2in \
sim:/InvShiftRows/S3in \
sim:/InvShiftRows/S0out \
sim:/InvShiftRows/S1out \
sim:/InvShiftRows/S2out \
sim:/InvShiftRows/S3out
force -freeze sim:/InvShiftRows/S0in 'h12345678 0
force -freeze sim:/InvShiftRows/S1in 'h68135724 0
force -freeze sim:/InvShiftRows/S2in 'h45119632 0
force -freeze sim:/InvShiftRows/S3in 'h43183726 0