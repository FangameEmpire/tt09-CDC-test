onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clock_domain_module_testbench/current_test
add wave -noupdate -expand -group SYSTEM /clock_domain_module_testbench/clk_i
add wave -noupdate -expand -group SYSTEM /clock_domain_module_testbench/clk_prev_i
add wave -noupdate -expand -group SYSTEM /clock_domain_module_testbench/rst_i
add wave -noupdate -expand -group SYSTEM /clock_domain_module_testbench/rst_prev_i
add wave -noupdate -expand -group SYSTEM /clock_domain_module_testbench/en_i
add wave -noupdate -expand -group {CONTROL IN} /clock_domain_module_testbench/ctl_i
add wave -noupdate -expand -group {CONTROL IN} /clock_domain_module_testbench/new_data_i
add wave -noupdate -expand -group {CONTROL IN} /clock_domain_module_testbench/done_shifting_i
add wave -noupdate -expand -group {CONTROL OUT} /clock_domain_module_testbench/new_data_o
add wave -noupdate -expand -group {CONTROL OUT} /clock_domain_module_testbench/done_shifting_o
add wave -noupdate -expand -group {CONTROL OUT} /clock_domain_module_testbench/current_state_o
add wave -noupdate -expand -group DATA /clock_domain_module_testbench/data_i
add wave -noupdate -expand -group DATA /clock_domain_module_testbench/data_o
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
WaveRestoreZoom {0 ps} {1 ns}
