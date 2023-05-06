vsim -gui -l msim_transcript work.Decrypt
# vsim -gui -l msim_transcript work.Decrypt 
# Start time: 03:07:35 on May 06,2023
# Loading work.Decrypt
# Loading work.KeyExpansion
# Loading work.AddRoundKey
# Loading work.InvShiftRows
# Loading work.InvSubBytes
# Loading work.InvMixColumns
# Loading work.ExpandKey
# Loading work.RotWord
# Loading work.SubBytes
# Loading work.InvSBox
# Loading work.SBox
# ** Warning: (vsim-3017) C:/Users/islam/OneDrive/Desktop/Spring 2023/Logic 2/AES-using-Verilog-HDL/Decrypt.v(19): [TFMPC] - Too few port connections. Expected 3, found 2.
#    Time: 0 ps  Iteration: 0  Instance: /Decrypt/key_expansion File: C:/Users/islam/OneDrive/Desktop/Spring 2023/Logic 2/AES-using-Verilog-HDL/KeyExpansion.v
add wave -position end  sim:/Decrypt/Nr
add wave -position end  sim:/Decrypt/key_size
add wave -position end  sim:/Decrypt/in
add wave -position end  sim:/Decrypt/key
add wave -position end  sim:/Decrypt/out
add wave -position end  sim:/Decrypt/w
add wave -position end  sim:/Decrypt/sub_byte_out
add wave -position end  sim:/Decrypt/shift_rows_out
add wave -position end  sim:/Decrypt/mix_columns_out
add wave -position end  sim:/Decrypt/add_round_key_out
force -freeze sim:/Decrypt/in 'h69c4e0d86a7b0430d8cdb78070b4c55a 0
force -freeze sim:/Decrypt/key 'h000102030405060708090a0b0c0d0e0f 0