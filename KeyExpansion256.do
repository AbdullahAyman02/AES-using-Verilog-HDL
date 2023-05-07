vsim -gui -l msim_transcript work.KeyExpansion256
# vsim -gui -l msim_transcript work.KeyExpansion256 
# Start time: 23:55:51 on May 07,2023
# Loading work.KeyExpansion256
# Loading work.ExpandKey256
# Loading work.RotWord
# Loading work.SubBytes
# Loading work.SBox
add wave -position end  sim:/KeyExpansion256/Nk
add wave -position end  sim:/KeyExpansion256/Nb
add wave -position end  sim:/KeyExpansion256/Nr
add wave -position end  sim:/KeyExpansion256/key_size
add wave -position end  sim:/KeyExpansion256/key
add wave -position end  sim:/KeyExpansion256/out
add wave -position end  sim:/KeyExpansion256/w
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: abdal  Hostname: DESKTOP-8QR5MSB  ProcessID: 12784
#           Attempting to use alternate WLF file "./wlftqy6vr1".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftqy6vr1
force -freeze sim:/KeyExpansion256/key 'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 0
run