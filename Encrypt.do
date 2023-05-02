vsim -gui -l msim_transcript work.Encrypt
# vsim -gui -l msim_transcript work.Encrypt 
# Start time: 02:40:30 on May 02,2023
# Loading work.Encrypt
# Loading work.KeyExpansion
# Loading work.AddRoundKey
# Loading work.SubBytes
# Loading work.ShiftRows
# Loading work.MixColumns
# Loading work.ExpandKey
# Loading work.RotWord
# Loading work.SBox
# ** Warning: (vsim-3017) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/Encrypt.v(19): [TFMPC] - Too few port connections. Expected 3, found 2.
#    Time: 0 ps  Iteration: 0  Instance: /Encrypt/key_expansion File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/Encrypt.v(43): [PCDPC] - Port size (128) does not match connection size (1) for port 'addrk_in'. The port definition is at: C:/AES-using-Verilog-HDL/AddRoundKey.v(14).
#    Time: 0 ps  Iteration: 0  Instance: /Encrypt/add_round_key3 File: C:/AES-using-Verilog-HDL/AddRoundKey.v
add wave -position end  sim:/Encrypt/Nr
add wave -position end  sim:/Encrypt/key_size
add wave -position end  sim:/Encrypt/in
add wave -position end  sim:/Encrypt/key
add wave -position end  sim:/Encrypt/out
add wave -position end  sim:/Encrypt/w
add wave -position end  sim:/Encrypt/sub_byte_out
add wave -position end  sim:/Encrypt/shift_rows_out
add wave -position end  sim:/Encrypt/mix_columns_out
add wave -position end  sim:/Encrypt/add_round_key_out
add wave -position end  sim:/Encrypt/shift_rows
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: abdal  Hostname: DESKTOP-8QR5MSB  ProcessID: 9420
#           Attempting to use alternate WLF file "./wlft64m2d1".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlft64m2d1
force -freeze sim:/Encrypt/in 'h00112233445566778899aabbccddeeff 0
force -freeze sim:/Encrypt/key 'h000102030405060708090a0b0c0d0e0f 0
run