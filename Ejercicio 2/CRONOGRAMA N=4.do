onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 60 -label RES /bp_circuitocombinacional/res
add wave -noupdate -height 60 -label DESBORDAMIENTO /bp_circuitocombinacional/desbordamiento
add wave -noupdate -height 60 -label CERO /bp_circuitocombinacional/cero
add wave -noupdate -height 60 -label SIGNO /bp_circuitocombinacional/signo
add wave -noupdate -height 60 -label B /bp_circuitocombinacional/b
add wave -noupdate -height 60 -label A /bp_circuitocombinacional/a
add wave -noupdate -height 60 -label CIN /bp_circuitocombinacional/cin
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2517472 ps} 0}
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
WaveRestoreZoom {0 ps} {200 ns}
