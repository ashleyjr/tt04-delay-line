`ifdef SIMULATION

   // Simulation
   // - Replace the cell with RTL sim models
   // - Wen building will instance sky130 cell

   module sky130_fd_sc_hd__inv_1(
      input    logic A,
      output   logic Y
   );
      localparam p_max = 80;

      logic [p_max-1:0]          d;
      logic [$clog2(p_max)-1:0]  sel;

      assign #1 d[0]  = A; 
      assign #1 d[1]  = d[0]; 
      assign #1 d[2]  = d[1]; 
      assign #1 d[3]  = d[2]; 
      assign #1 d[4]  = d[3]; 
      assign #1 d[5]  = d[4]; 
      assign #1 d[6]  = d[5]; 
      assign #1 d[7]  = d[6]; 
      assign #1 d[8]  = d[7]; 
      assign #1 d[9]  = d[8]; 
      assign #1 d[10] = d[9]; 
      assign #1 d[11] = d[10]; 
      assign #1 d[12] = d[11]; 
      assign #1 d[13] = d[12]; 
      assign #1 d[14] = d[13]; 
      assign #1 d[15] = d[14]; 
      assign #1 d[16] = d[15]; 
      assign #1 d[17] = d[16]; 
      assign #1 d[18] = d[17]; 
      assign #1 d[19] = d[18]; 
      assign #1 d[20] = d[19]; 
      assign #1 d[21] = d[20]; 
      assign #1 d[22] = d[21]; 
      assign #1 d[23] = d[22]; 
      assign #1 d[24] = d[23]; 
      assign #1 d[25] = d[24]; 
      assign #1 d[26] = d[25]; 
      assign #1 d[27] = d[26]; 
      assign #1 d[28] = d[27]; 
      assign #1 d[29] = d[28]; 
      assign #1 d[30] = d[29]; 
      assign #1 d[31] = d[30]; 
      assign #1 d[32] = d[31]; 
      assign #1 d[33] = d[32]; 
      assign #1 d[34] = d[33]; 
      assign #1 d[35] = d[34]; 
      assign #1 d[36] = d[35]; 
      assign #1 d[37] = d[36]; 
      assign #1 d[38] = d[37]; 
      assign #1 d[39] = d[38]; 
      assign #1 d[40] = d[39]; 
      assign #1 d[41] = d[40]; 
      assign #1 d[42] = d[41]; 
      assign #1 d[43] = d[42]; 
      assign #1 d[44] = d[43]; 
      assign #1 d[45] = d[44]; 
      assign #1 d[46] = d[45]; 
      assign #1 d[47] = d[46]; 
      assign #1 d[48] = d[47]; 
      assign #1 d[49] = d[48]; 
      assign #1 d[50] = d[49]; 
      assign #1 d[51] = d[50]; 
      assign #1 d[52] = d[51]; 
      assign #1 d[53] = d[52]; 
      assign #1 d[54] = d[53]; 
      assign #1 d[55] = d[54]; 
      assign #1 d[56] = d[55]; 
      assign #1 d[57] = d[56]; 
      assign #1 d[58] = d[57]; 
      assign #1 d[59] = d[58]; 
      assign #1 d[60] = d[59]; 
      assign #1 d[61] = d[60]; 
      assign #1 d[62] = d[61]; 
      assign #1 d[63] = d[62]; 
      assign #1 d[64] = d[63]; 
      assign #1 d[65] = d[64]; 
      assign #1 d[66] = d[65]; 
      assign #1 d[67] = d[66]; 
      assign #1 d[68] = d[67]; 
      assign #1 d[69] = d[68]; 
      assign #1 d[70] = d[69]; 
      assign #1 d[71] = d[70]; 
      assign #1 d[72] = d[71]; 
      assign #1 d[73] = d[72]; 
      assign #1 d[74] = d[73]; 
      assign #1 d[75] = d[74]; 
      assign #1 d[76] = d[75]; 
      assign #1 d[77] = d[76]; 
      assign #1 d[78] = d[77]; 
      assign #1 d[79] = d[78]; 
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
