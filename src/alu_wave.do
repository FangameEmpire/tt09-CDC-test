onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_testbench/CURRENT_TEST
add wave -noupdate -expand -group CONTROLS /alu_testbench/en_i
add wave -noupdate -expand -group CONTROLS /alu_testbench/ctl_i
add wave -noupdate -expand -group DATAPATH /alu_testbench/AB_i
add wave -noupdate -expand -group DATAPATH /alu_testbench/BC_o
add wave -noupdate -expand -group {PORTS (BIN)} /alu_testbench/dut/A
add wave -noupdate -expand -group {PORTS (BIN)} /alu_testbench/dut/B
add wave -noupdate -expand -group {PORTS (BIN)} /alu_testbench/dut/C
add wave -noupdate -expand -group {PORTS (HEX)} -radix hexadecimal /alu_testbench/dut/A
add wave -noupdate -expand -group {PORTS (HEX)} -radix hexadecimal /alu_testbench/dut/B
add wave -noupdate -expand -group {PORTS (HEX)} -radix hexadecimal /alu_testbench/dut/C
add wave -noupdate -expand -group PORTS(DEC) -radix decimal /alu_testbench/dut/A
add wave -noupdate -expand -group PORTS(DEC) -radix decimal /alu_testbench/dut/B
add wave -noupdate -expand -group PORTS(DEC) -radix decimal /alu_testbench/dut/C
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {5800 ps} {21800 ps}
