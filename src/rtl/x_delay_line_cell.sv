`ifdef SIMULATION

   // Simulation
   // - Replace the cell with RTL sim models
   // - Wen building will instance sky130 cell

   module sky130_fd_sc_hd__inv_1(
      input    logic A,
      output   logic Y
   );      
      logic [2:0] d;
      logic [1:0] sel;

      assign       d[0]  = 1'b0;
      assign #27ps d[1]  = A;
      assign #35ps d[2]  = d[1]; 
      
      assign Y = ~d[sel];
   
   endmodule

   module sky130_fd_sc_hd__dfrtp_1(
      input  logic CLK,
      input  logic D,
      input  logic RESET_B,
      output logic Q
   );
      always@(posedge CLK or negedge RESET_B) begin
         if(!RESET_B)   Q <= 'd0;
         else           Q <= D;
      end 
   endmodule
   
`endif

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
   (* keep = "true" *) logic dl_11;
   (* keep = "true" *) logic dl_12;
   (* keep = "true" *) logic dl_13;
   (* keep = "true" *) logic dl_14;

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
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_11 (  .A(dl_10),  .Y(dl_11));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_12 (  .A(dl_11),  .Y(dl_12));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_13 (  .A(dl_12),  .Y(dl_13));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_14 (  .A(dl_13),  .Y(dl_14));
   (* keep = "true" *) sky130_fd_sc_hd__inv_1 u_inv_15 (  .A(dl_14),  .Y(o_dl ));  
  
   (* keep = "true" *) sky130_fd_sc_hd__dfrtp_1 u_ff (       
      .CLK     (i_clk   ),
      .D       (o_dl    ),
      .RESET_B (i_rst_n ),
      .Q       (o_data  ) 
   );

endmodule
