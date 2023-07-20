module x_delay_line(
   input    logic          i_clk,
   input    logic          i_rst, 
   output   logic [31:0]   o_data
);
   logic          start_q;
   logic          start_d;
   logic [31:0]   dl;
   logic [31:0]   p0_data;
   logic [31:0]   p1_data;  
   
   assign start_d = ~start_q;

   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)   start_q <= 'd1;
      else        start_q <= start_d;
   end 
  
   assign dl[0] = start_q;
   
  (* keep = "true" *) sky130_fd_sc_hd__inv_2 inv0 (   .A(dl[0]),  .Y(dl[1]));
   
   assign dl[2]  = ~dl[1];
   assign dl[3]  = ~dl[2];
   assign dl[4]  = ~dl[3];
   assign dl[5]  = ~dl[4];
   assign dl[6]  = ~dl[5];
   assign dl[7]  = ~dl[6];
   assign dl[8]  = ~dl[7];
   assign dl[9]  = ~dl[8];
   assign dl[10] = ~dl[9];
   assign dl[11] = ~dl[10];
   assign dl[12] = ~dl[11];
   assign dl[13] = ~dl[12];
   assign dl[14] = ~dl[13];
   assign dl[15] = ~dl[14];
   assign dl[16] = ~dl[15];
   assign dl[17] = ~dl[16];
   assign dl[18] = ~dl[17];
   assign dl[19] = ~dl[18];
   assign dl[20] = ~dl[19];
   assign dl[21] = ~dl[20];
   assign dl[22] = ~dl[21];
   assign dl[23] = ~dl[22];
   assign dl[24] = ~dl[23];
   assign dl[25] = ~dl[24];
   assign dl[26] = ~dl[25];
   assign dl[27] = ~dl[26];
   assign dl[28] = ~dl[27];
   assign dl[29] = ~dl[28];
   assign dl[30] = ~dl[29];
   assign dl[31] = ~dl[30];
   
   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)   p0_data <= 'd0;
      else        p0_data <= dl;
   end   
   
   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)   p1_data <= 'd0;
      else        p1_data <= p0_data;
   end   
    
   assign o_data = p1_data;
  
endmodule
