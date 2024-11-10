onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_testbench/current_test
add wave -noupdate -expand -group SYSTEM /fifo_testbench/clk_i
add wave -noupdate -expand -group SYSTEM /fifo_testbench/rst_i
add wave -noupdate -expand -group SYSTEM /fifo_testbench/en_i
add wave -noupdate -expand -group CONTROL /fifo_testbench/shift_i
add wave -noupdate -expand -group CONTROL /fifo_testbench/load_i
add wave -noupdate -expand -group CONTROL /fifo_testbench/data_valid_o
add wave -noupdate -expand -group {SERIAL IO} /fifo_testbench/serial_i
add wave -noupdate -expand -group {SERIAL IO} /fifo_testbench/serial_o
add wave -noupdate -expand -group {PARALLEL IO} /fifo_testbench/parallel_i
add wave -noupdate -expand -group {PARALLEL IO} /fifo_testbench/parallel_o
add wave -noupdate -expand -group REGISTERS /fifo_testbench/dut/sr
add wave -noupdate -expand -group REGISTERS /fifo_testbench/dut/hr
add wave -noupdate -expand -group {SHIFT COUNTER} /fifo_testbench/dut/bits_shifted
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
WaveRestoreZoom {0 ps} {2048 ns}
