onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk_intf/clk
add wave -noupdate /tb/clk_intf/pre_clk
add wave -noupdate /tb/ctr_intf/rst_n
add wave -noupdate /tb/ctr_intf/enable
add wave -noupdate /tb/ctr_intf/load
add wave -noupdate /tb/ctr_intf/up_down_n
add wave -noupdate /tb/ctr_intf/data_input
add wave -noupdate /tb/ctr_intf/data_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {129 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {12 ns}
