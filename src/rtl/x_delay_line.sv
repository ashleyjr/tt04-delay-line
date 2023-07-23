module x_delay_line(
   input    logic          i_clk,
   input    logic          i_rst, 
   output   logic [31:0]   o_data
);
   (* keep = "true" *) logic          start_q;
   (* keep = "true" *) logic          start_d;
   (* keep = "true" *) logic [31:0]   dl;
   (* keep = "true" *) logic [31:0]   p0_data;
   (* keep = "true" *) logic [31:0]   p1_data;  
   
   assign start_d = ~start_q;

   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)   start_q <= 'd1;
      else        start_q <= start_d;
   end 
  
   assign dl[0] = start_q;
   
   (* keep = "true" *) x_delay_line_cell u_dl_0    (.i_a(dl[0]),  .o_y(dl[1]));
   (* keep = "true" *) x_delay_line_cell u_dl_1    (.i_a(dl[1]),  .o_y(dl[2]));
   (* keep = "true" *) x_delay_line_cell u_dl_2    (.i_a(dl[2]),  .o_y(dl[3]));
   (* keep = "true" *) x_delay_line_cell u_dl_3    (.i_a(dl[3]),  .o_y(dl[4]));
   (* keep = "true" *) x_delay_line_cell u_dl_4    (.i_a(dl[4]),  .o_y(dl[5]));
   (* keep = "true" *) x_delay_line_cell u_dl_5    (.i_a(dl[5]),  .o_y(dl[6]));
   (* keep = "true" *) x_delay_line_cell u_dl_6    (.i_a(dl[6]),  .o_y(dl[7]));
   (* keep = "true" *) x_delay_line_cell u_dl_7    (.i_a(dl[7]),  .o_y(dl[8]));
   (* keep = "true" *) x_delay_line_cell u_dl_8    (.i_a(dl[8]),  .o_y(dl[9]));
   (* keep = "true" *) x_delay_line_cell u_dl_9    (.i_a(dl[9]),  .o_y(dl[10]));
   (* keep = "true" *) x_delay_line_cell u_dl_10   (.i_a(dl[10]), .o_y(dl[11]));
   (* keep = "true" *) x_delay_line_cell u_dl_11   (.i_a(dl[11]), .o_y(dl[12]));
   (* keep = "true" *) x_delay_line_cell u_dl_12   (.i_a(dl[12]), .o_y(dl[13]));
   (* keep = "true" *) x_delay_line_cell u_dl_13   (.i_a(dl[13]), .o_y(dl[14]));
   (* keep = "true" *) x_delay_line_cell u_dl_14   (.i_a(dl[14]), .o_y(dl[15]));
   (* keep = "true" *) x_delay_line_cell u_dl_15   (.i_a(dl[15]), .o_y(dl[16]));
   (* keep = "true" *) x_delay_line_cell u_dl_16   (.i_a(dl[16]), .o_y(dl[17]));
   (* keep = "true" *) x_delay_line_cell u_dl_17   (.i_a(dl[17]), .o_y(dl[18]));
   (* keep = "true" *) x_delay_line_cell u_dl_18   (.i_a(dl[18]), .o_y(dl[19]));
   (* keep = "true" *) x_delay_line_cell u_dl_19   (.i_a(dl[19]), .o_y(dl[20]));
   (* keep = "true" *) x_delay_line_cell u_dl_20   (.i_a(dl[20]), .o_y(dl[21])); 
   (* keep = "true" *) x_delay_line_cell u_dl_21   (.i_a(dl[21]), .o_y(dl[22]));
   (* keep = "true" *) x_delay_line_cell u_dl_22   (.i_a(dl[22]), .o_y(dl[23]));
   (* keep = "true" *) x_delay_line_cell u_dl_23   (.i_a(dl[23]), .o_y(dl[24]));
   (* keep = "true" *) x_delay_line_cell u_dl_24   (.i_a(dl[24]), .o_y(dl[25]));
   (* keep = "true" *) x_delay_line_cell u_dl_25   (.i_a(dl[25]), .o_y(dl[26]));
   (* keep = "true" *) x_delay_line_cell u_dl_26   (.i_a(dl[26]), .o_y(dl[27]));
   (* keep = "true" *) x_delay_line_cell u_dl_27   (.i_a(dl[27]), .o_y(dl[28]));
   (* keep = "true" *) x_delay_line_cell u_dl_28   (.i_a(dl[28]), .o_y(dl[29]));
   (* keep = "true" *) x_delay_line_cell u_dl_29   (.i_a(dl[29]), .o_y(dl[30]));
   (* keep = "true" *) x_delay_line_cell u_dl_30   (.i_a(dl[30]), .o_y(dl[31]));

   // Resync output
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
