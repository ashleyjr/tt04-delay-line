module x_delay_line_cell( 
   input    logic    i_a, 
   output   logic    o_y
);

`ifdef SIMULATION

   // 1ns
   assign #1 o_y = i_a;

`else

   (* keep = "true" *) sky130_fd_sc_hd__dlygate4sd3_1 u_inv_a(
      .A(i_a),  
      .Y(o_y)
   );

`endif

endmodule
