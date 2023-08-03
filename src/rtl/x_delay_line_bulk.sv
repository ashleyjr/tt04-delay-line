module x_delay_line_bulk( 
   input    logic    i_dl, 
   output   logic    o_dl
);

`ifdef SIMULATION

   // 1ns
   assign #1 o_dl = i_dl;

`else

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
   (* keep = "true" *) logic dl_A;
   (* keep = "true" *) logic dl_B;
   (* keep = "true" *) logic dl_C;
   (* keep = "true" *) logic dl_D;
   (* keep = "true" *) logic dl_E;

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_0 (  .A(i_dl),  .Y(dl_0));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_1 (  .A(dl_0),  .Y(dl_1));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_2 (  .A(dl_1),  .Y(dl_2));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_3 (  .A(dl_2),  .Y(dl_3));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_4 (  .A(dl_3),  .Y(dl_4));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_5 (  .A(dl_4),  .Y(dl_5));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_6 (  .A(dl_5),  .Y(dl_6));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_7 (  .A(dl_6),  .Y(dl_7));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_8 (  .A(dl_7),  .Y(dl_8));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_9 (  .A(dl_8),  .Y(dl_9));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_A (  .A(dl_9),  .Y(dl_A));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_B (  .A(dl_A),  .Y(dl_B));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_C (  .A(dl_B),  .Y(dl_C));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_D (  .A(dl_C),  .Y(dl_D));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_E (  .A(dl_D),  .Y(dl_E));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_F (  .A(dl_E),  .Y(o_dl));

`endif

endmodule
