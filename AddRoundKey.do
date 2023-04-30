vsim work.AddRoundKey
# vsim work.AddRoundKey 
# Start time: 17:24:13 on Apr 28,2023
# Loading work.AddRoundKey
add wave -position insertpoint  \
sim:/AddRoundKey/w0_curr \
sim:/AddRoundKey/w1_curr \
sim:/AddRoundKey/w2_curr \
sim:/AddRoundKey/w3_curr \
sim:/AddRoundKey/k0_curr \
sim:/AddRoundKey/k1_curr \
sim:/AddRoundKey/k2_curr \
sim:/AddRoundKey/k3_curr \
sim:/AddRoundKey/w0_next \
sim:/AddRoundKey/w1_next \
sim:/AddRoundKey/w2_next \
sim:/AddRoundKey/w3_next
force -freeze sim:/AddRoundKey/w0_curr 'h046681e5 0
force -freeze sim:/AddRoundKey/w1_curr 'he0cb199a 0
force -freeze sim:/AddRoundKey/w2_curr 'h48f8d37a 0
force -freeze sim:/AddRoundKey/w3_curr 'h2806264c 0
force -freeze sim:/AddRoundKey/k0_curr 'ha0fafe17 0
force -freeze sim:/AddRoundKey/k1_curr 'h88542cb1 0
force -freeze sim:/AddRoundKey/k2_curr 'h23a33939 0
force -freeze sim:/AddRoundKey/k3_curr 'h2a6c7605 0
run