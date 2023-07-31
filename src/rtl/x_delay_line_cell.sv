module x_delay_line_cell( 
   input    logic    i_a, 
   output   logic    o_y
);

`ifdef SIMULATION

   // 1ns
   assign #1 o_y = i_a;

`else

   logic a;

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_a(
      .A(i_a),  
      .Y(a)
   );

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_b(
      .A(a),  
      .Y(b)
   );

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_c(
      .A(b),  
      .Y(c)
   );

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_d(
      .A(c),  
      .Y(d)
   );

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_e(
      .A(d),  
      .Y(e)
   );

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_f(
      .A(e),  
      .Y(f)
   );

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_g(
      .A(f),  
      .Y(g)
   );

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_h(
      .A(g),  
      .Y(o_y)
   );
`endif

endmodule
