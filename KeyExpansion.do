vsim -gui -l msim_transcript work.KeyExpansion
# vsim -gui -l msim_transcript work.KeyExpansion 
# Start time: 00:53:28 on May 02,2023
# Loading work.KeyExpansion
# Loading work.ExpandKey
# Loading work.RotWord
# Loading work.SubBytes
# Loading work.SBox
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[1]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[2]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[3]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[4]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[5]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[6]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[7]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[8]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[9]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
# ** Warning: (vsim-3015) D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/KeyExpansion.v(21): [PCDPC] - Port size (6) does not match connection size (32) for port 'iteration'. The port definition is at: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v(2).
#    Time: 0 ps  Iteration: 0  Instance: /KeyExpansion/expand_key[10]/expandkey File: D:/CHS/Junior/CMPN111 (Logic Design-2)/Project/ExpandKey.v
add wave -position end  sim:/KeyExpansion/Nk
add wave -position end  sim:/KeyExpansion/Nb
add wave -position end  sim:/KeyExpansion/Nr
add wave -position end  sim:/KeyExpansion/key
add wave -position end  sim:/KeyExpansion/out
add wave -position end  sim:/KeyExpansion/w
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: abdal  Hostname: DESKTOP-8QR5MSB  ProcessID: 9420
#           Attempting to use alternate WLF file "./wlft0qxjx0".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlft0qxjx0
force -freeze sim:/KeyExpansion/key 'h000102030405060708090a0b0c0d0e0f 0
run