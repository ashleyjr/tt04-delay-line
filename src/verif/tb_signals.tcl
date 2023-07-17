set sigs [list]

lappend sigs "i_clk"
lappend sigs "i_rst"
lappend sigs "tb.u_dut.u_rx.i_rx"
lappend sigs "tb.u_dut.u_tx.o_tx"


set added [ gtkwave::addSignalsFromList $sigs ]
gtkwave::/Time/Zoom/Zoom_Full
