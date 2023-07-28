module x_delay_line_cell( 
   input    logic    i_a, 
   output   logic    o_y
);

`ifdef SIMULATION

   assign #17 o_y = ~i_a;

`else

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv(
      .A(i_a),  
      .Y(o_y)
   );

`endif

endmodule
