module x_delay_line_bulk( 
   input    logic    i_dl, 
   output   logic    o_inv,
   output   logic    o_dl
);
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
   (* keep = "true" *) logic dl_11;
   (* keep = "true" *) logic dl_12;
   (* keep = "true" *) logic dl_13;
   (* keep = "true" *) logic dl_14;
 
   assign o_inv = dl_0;

   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_0  (  .A(i_dl),   .Y(dl_0 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_1  (  .A(dl_0),   .Y(dl_1 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_2  (  .A(dl_1),   .Y(dl_2 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_3  (  .A(dl_2),   .Y(dl_3 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_4  (  .A(dl_3),   .Y(dl_4 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_5  (  .A(dl_4),   .Y(dl_5 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_6  (  .A(dl_5),   .Y(dl_6 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_7  (  .A(dl_6),   .Y(dl_7 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_8  (  .A(dl_7),   .Y(dl_8 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_9  (  .A(dl_8),   .Y(dl_9 ));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_10 (  .A(dl_9),   .Y(dl_10));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_11 (  .A(dl_10),  .Y(dl_11));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_12 (  .A(dl_11),  .Y(dl_12));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_13 (  .A(dl_12),  .Y(dl_13));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_14 (  .A(dl_13),  .Y(dl_14));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_15 (  .A(dl_14),  .Y(o_dl ));
endmodule
