module x_delay_line(
   input    logic          i_clk,
   input    logic          i_rst, 
   input    logic          i_start,
   output   logic [31:0]   o_data
);
   (* keep = "true" *) logic           first_q;  
   (* keep = "true" *) logic           start_q;
   (* keep = "true" *) logic           start_d;
   (* keep = "true" *) logic           start_en;
   (* keep = "true" *) logic           dl_0; 
   (* keep = "true" *) logic           dl_1;
   (* keep = "true" *) logic           dl_2; 
   (* keep = "true" *) logic           dl_3; 
   (* keep = "true" *) logic           dl_4; 
   (* keep = "true" *) logic           dl_5; 
   (* keep = "true" *) logic           dl_6; 
   (* keep = "true" *) logic           dl_7; 
   (* keep = "true" *) logic           dl_8; 
   (* keep = "true" *) logic           dl_9;
   (* keep = "true" *) logic           dl_10; 
   (* keep = "true" *) logic           dl_11;
   (* keep = "true" *) logic           dl_12;
   (* keep = "true" *) logic           dl_13;
   (* keep = "true" *) logic           dl_14;
   (* keep = "true" *) logic           dl_15;
   (* keep = "true" *) logic           dl_16;
   (* keep = "true" *) logic           dl_17;
   (* keep = "true" *) logic           dl_18;
   (* keep = "true" *) logic           dl_19;
   (* keep = "true" *) logic           dl_20;
   (* keep = "true" *) logic           dl_21;
   (* keep = "true" *) logic           dl_22;
   (* keep = "true" *) logic           dl_23;
   (* keep = "true" *) logic           dl_24;
   (* keep = "true" *) logic           dl_25;
   (* keep = "true" *) logic           dl_26;
   (* keep = "true" *) logic           dl_27;
   (* keep = "true" *) logic           dl_28;
   (* keep = "true" *) logic           dl_29;
   (* keep = "true" *) logic           dl_30;
   (* keep = "true" *) logic           dl_31;
   (* keep = "true" *) logic [31:0]    p0_data;
   (* keep = "true" *) logic [31:0]    p1_data;   
   (* keep = "true" *) logic [31:0]    p2_data;   

   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)   first_q <= 'd1;
      else        first_q <= 'd0;
   end  
   
   assign start_en = i_start | first_q | start_q;

   assign start_d = ~start_q;

   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         start_q <= 'd0;
      else if(start_en) start_q <= start_d;
   end 
  
   assign dl_0 = start_q;
   
   (* keep = "true" *) x_delay_line_cell u_dl_0    (.i_a(dl_0 ),  .o_y(dl_1   ));
   (* keep = "true" *) x_delay_line_cell u_dl_1    (.i_a(dl_1 ),  .o_y(dl_2   ));
   (* keep = "true" *) x_delay_line_cell u_dl_2    (.i_a(dl_2 ),  .o_y(dl_3   ));
   (* keep = "true" *) x_delay_line_cell u_dl_3    (.i_a(dl_3 ),  .o_y(dl_4   ));
   (* keep = "true" *) x_delay_line_cell u_dl_4    (.i_a(dl_4 ),  .o_y(dl_5   ));
   (* keep = "true" *) x_delay_line_cell u_dl_5    (.i_a(dl_5 ),  .o_y(dl_6   ));
   (* keep = "true" *) x_delay_line_cell u_dl_6    (.i_a(dl_6 ),  .o_y(dl_7   ));
   (* keep = "true" *) x_delay_line_cell u_dl_7    (.i_a(dl_7 ),  .o_y(dl_8   ));
   (* keep = "true" *) x_delay_line_cell u_dl_8    (.i_a(dl_8 ),  .o_y(dl_9   ));
   (* keep = "true" *) x_delay_line_cell u_dl_9    (.i_a(dl_9 ),  .o_y(dl_10  ));
   (* keep = "true" *) x_delay_line_cell u_dl_10   (.i_a(dl_10),  .o_y(dl_11  ));
   (* keep = "true" *) x_delay_line_cell u_dl_11   (.i_a(dl_11),  .o_y(dl_12  ));
   (* keep = "true" *) x_delay_line_cell u_dl_12   (.i_a(dl_12),  .o_y(dl_13  ));
   (* keep = "true" *) x_delay_line_cell u_dl_13   (.i_a(dl_13),  .o_y(dl_14  ));
   (* keep = "true" *) x_delay_line_cell u_dl_14   (.i_a(dl_14),  .o_y(dl_15  ));
   (* keep = "true" *) x_delay_line_cell u_dl_15   (.i_a(dl_15),  .o_y(dl_16  ));
   (* keep = "true" *) x_delay_line_cell u_dl_16   (.i_a(dl_16),  .o_y(dl_17  ));
   (* keep = "true" *) x_delay_line_cell u_dl_17   (.i_a(dl_17),  .o_y(dl_18  ));
   (* keep = "true" *) x_delay_line_cell u_dl_18   (.i_a(dl_18),  .o_y(dl_19  ));
   (* keep = "true" *) x_delay_line_cell u_dl_19   (.i_a(dl_19),  .o_y(dl_20  ));
   (* keep = "true" *) x_delay_line_cell u_dl_20   (.i_a(dl_20),  .o_y(dl_21  )); 
   (* keep = "true" *) x_delay_line_cell u_dl_21   (.i_a(dl_21),  .o_y(dl_22  ));
   (* keep = "true" *) x_delay_line_cell u_dl_22   (.i_a(dl_22),  .o_y(dl_23  ));
   (* keep = "true" *) x_delay_line_cell u_dl_23   (.i_a(dl_23),  .o_y(dl_24  ));
   (* keep = "true" *) x_delay_line_cell u_dl_24   (.i_a(dl_24),  .o_y(dl_25  ));
   (* keep = "true" *) x_delay_line_cell u_dl_25   (.i_a(dl_25),  .o_y(dl_26  ));
   (* keep = "true" *) x_delay_line_cell u_dl_26   (.i_a(dl_26),  .o_y(dl_27  ));
   (* keep = "true" *) x_delay_line_cell u_dl_27   (.i_a(dl_27),  .o_y(dl_28  ));
   (* keep = "true" *) x_delay_line_cell u_dl_28   (.i_a(dl_28),  .o_y(dl_29  ));
   (* keep = "true" *) x_delay_line_cell u_dl_29   (.i_a(dl_29),  .o_y(dl_30  ));
   (* keep = "true" *) x_delay_line_cell u_dl_30   (.i_a(dl_30),  .o_y(dl_31  ));

   // Resync output
   
   assign p0_data = {dl_31, 
                     dl_30,
                     dl_29, 
                     dl_28, 
                     dl_27, 
                     dl_26, 
                     dl_25, 
                     dl_24, 
                     dl_23, 
                     dl_22, 
                     dl_21,  
                     dl_20,
                     dl_19,
                     dl_18,
                     dl_17,
                     dl_16,
                     dl_15,
                     dl_14,
                     dl_13,
                     dl_12,
                     dl_11,
                     dl_10,
                     dl_9,
                     dl_8,
                     dl_7,
                     dl_6,
                     dl_5,
                     dl_4,
                     dl_3,
                     dl_2,
                     dl_1,
                     dl_0};

   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)   p1_data <= 'd0;
      else        p1_data <= p0_data;
   end   
   
   always@(posedge i_clk or posedge i_rst) begin
      if(i_rst)   p2_data <= 'd0;
      else        p2_data <= p1_data;
   end   
    
   assign o_data = p2_data;
  
endmodule
