module x_delay_line_cell( 
   input    logic    i_clk,
   input    logic    i_rst_n,
   input    logic    i_dl, 
   output   logic    o_dl,
   output   logic    o_data
);

   // The delay line cell
   //
   // - Ideally we would have space for 2 flops to form a resync but
   //   since this an experiment lets just ignore is and deal with 
   //   possible metastability
  
   (* keep = "true" *) logic dl_0; 
   (* keep = "true" *) logic dl_1;
   (* keep = "true" *) logic dl_2;
   (* keep = "true" *) logic dl_3;
   (* keep = "true" *) logic dl_4;
   (* keep = "true" *) logic dl_5;
   (* keep = "true" *) logic dl_6;
   (* keep = "true" *) logic dl_7;
   (* keep = "true" *) logic dl_8;
   (* keep = "true" *) logic dl_9;
   (* keep = "true" *) logic dl_10;

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_0  (  .A(i_dl ),  .Y(dl_0 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_1  (  .A(dl_0 ),  .Y(dl_1 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_2  (  .A(dl_1 ),  .Y(dl_2 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_3  (  .A(dl_2 ),  .Y(dl_3 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_4  (  .A(dl_3 ),  .Y(dl_4 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_5  (  .A(dl_4 ),  .Y(dl_5 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_6  (  .A(dl_5 ),  .Y(dl_6 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_7  (  .A(dl_6 ),  .Y(dl_7 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_8  (  .A(dl_7 ),  .Y(dl_8 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_9  (  .A(dl_8 ),  .Y(dl_9 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_10 (  .A(dl_9 ),  .Y(dl_10));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_11 (  .A(dl_10),  .Y(o_dl));
  
   (* keep = "true" *) sky130_fd_sc_hd__dfrtp_1 u_ff (       
      .CLK     (i_clk   ),
      .D       (o_dl    ),
      .RESET_B (i_rst_n ),
      .Q       (o_data  ) 
   );

endmodule
